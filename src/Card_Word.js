import React, { Component } from 'react';
import { StyleSheet, Text, View, Image, Dimensions } from 'react-native';
import { TouchableOpacity } from 'react-native-gesture-handler'
import CardFlip from 'react-native-card-flip';
import * as Speech from 'expo-speech';
import styles from './vocabStyleSheet/styles';
import { Audio, AVPlaybackStatus } from "expo-av";
import * as FileSystem from "expo-file-system";
import * as Permissions from "expo-permissions";
import mime from "mime";
import {TrackHistory} from './utill/Network'; 
import { Alert } from 'react-native';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
const recording = new Audio.Recording();



class Card_Word extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isUserRecording: false,
      //isRecorded:false,
      recordImage: require('./Images/record.png'),
      showMeaningValue: 1,
      isFav: 0,
      haveRecordingPermissions: false,
      isLoading: false,
      isPlaybackAllowed: false,
      muted: false,
      soundPosition: null,
      soundDuration: null,
      recordingDuration: null,
      shouldPlay: false,
      isPlaying: false,
      isRecording: false,
      fontLoaded: false,
      shouldCorrectPitch: true,
      volume: 1.0,
      rate: 1.0,
      recordingInfo: {},

    }
    this.recording = null;
    this.sound = null;
    this.isSeeking = false;
    this.shouldPlayAtEndOfSeek = false;
    this.recordingSettings = Audio.RECORDING_OPTIONS_PRESET_HIGH_QUALITY;

  }
  componentDidMount() {

    this._askForPermissions();
    
    
  }

  _askForPermissions = () => {
    const response = Permissions.askAsync(Permissions.AUDIO_RECORDING);
    this.setState({
      haveRecordingPermissions: response.status === "granted",
    });
  };



  _updateScreenForSoundStatus = (status: AVPlaybackStatus) => {
    if (status.isLoaded) {
      this.setState({
        soundDuration: status.durationMillis ?? null,
        soundPosition: status.positionMillis,
        shouldPlay: status.shouldPlay,
        isPlaying: status.isPlaying,
        rate: status.rate,
        muted: status.isMuted,
        volume: status.volume,
        shouldCorrectPitch: status.shouldCorrectPitch,
        isPlaybackAllowed: true,
      });
    } else {
      this.setState({
        soundDuration: null,
        soundPosition: null,
        isPlaybackAllowed: false,
      });
      if (status.error) {
      }
    }
  };

  _updateScreenForRecordingStatus = (status: Audio.RecordingStatus) => {
    if (status.canRecord) {
      this.setState({
        isRecording: status.isRecording,
        recordingDuration: status.durationMillis,
      });
    } else if (status.isDoneRecording) {
      this.setState({
        isRecording: false,
        recordingDuration: status.durationMillis,
      });
      if (!this.state.isLoading) {
        this._stopRecordingAndEnablePlayback();
      }
    }
  };

  async _stopPlaybackAndBeginRecording() {
    this.setState({
      isLoading: true,
    });
    if (this.sound !== null) {
      await this.sound.unloadAsync();
      this.sound.setOnPlaybackStatusUpdate(null);
      this.sound = null;
    }
    await Audio.setAudioModeAsync({
      allowsRecordingIOS: true,
      interruptionModeIOS: Audio.INTERRUPTION_MODE_IOS_DO_NOT_MIX,
      playsInSilentModeIOS: true,
      shouldDuckAndroid: true,
      interruptionModeAndroid: Audio.INTERRUPTION_MODE_ANDROID_DO_NOT_MIX,
      playThroughEarpieceAndroid: false,
      staysActiveInBackground: true,
    });
    if (this.recording !== null) {
      this.recording.setOnRecordingStatusUpdate(null);
      this.recording = null;
    }

    const recording = new Audio.Recording();
    await recording.prepareToRecordAsync(this.recordingSettings);
    recording.setOnRecordingStatusUpdate(this._updateScreenForRecordingStatus);

    this.recording = recording;
    await this.recording.startAsync(); // Will call this._updateScreenForRecordingStatus to update the screen.
    this.setState({
      isLoading: false,
    });
  }

  async _stopRecordingAndEnablePlayback() {
    this.setState({
      isLoading: true,
    });
    if (!this.recording) {
      return;
    }
    try {
      await this.recording.stopAndUnloadAsync();
    } catch (error) {
      // Do nothing -- we are already unloaded.
    }
    const info = await FileSystem.getInfoAsync(this.recording.getURI() || "");
    console.log("Hello"+JSON.stringify(info));
    this.setState({ recordingInfo: info });
    this.uploadrecording();
    await Audio.setAudioModeAsync({
      allowsRecordingIOS: false,
      interruptionModeIOS: Audio.INTERRUPTION_MODE_IOS_DO_NOT_MIX,
      playsInSilentModeIOS: true,
      shouldDuckAndroid: true,
      interruptionModeAndroid: Audio.INTERRUPTION_MODE_ANDROID_DO_NOT_MIX,
      playThroughEarpieceAndroid: false,
      staysActiveInBackground: true,
    });
    const { sound, status } = await this.recording.createNewLoadedSoundAsync(
      {
        isLooping: false,
        isMuted: this.state.muted,
        volume: this.state.volume,
        rate: this.state.rate,
        shouldCorrectPitch: this.state.shouldCorrectPitch,
        androidImplementation: 'MediaPlayer'
      },
      this._updateScreenForSoundStatus
    );
    this.sound = sound;
    this.props.isRecordedAudio(this.props.id);

    this.setState({
      isLoading: false,
    });

  }

  _onRecordPressed = () => {
    if (this.state.isRecording) {
      this._stopRecordingAndEnablePlayback();
    } else {
      this._stopPlaybackAndBeginRecording();
    }
  };

  _onPlayPausePressed = () => {
    if (this.sound != null) {
      if (this.state.isPlaying) {
        this.sound.pauseAsync();
      } else {
        this.sound.playAsync();

      }
    }
  };

  _onStopPressed = () => {
    if (this.sound != null) {
      this.sound.stopAsync();
    }
  };

  _onMutePressed = () => {
    if (this.sound != null) {
      this.sound.setIsMutedAsync(!this.state.muted);
    }
  };

  _onVolumeSliderValueChange = (value: number) => {
    if (this.sound != null) {
      this.sound.setVolumeAsync(value);
    }
  };

  _trySetRate = async (rate: number, shouldCorrectPitch: boolean) => {
    if (this.sound != null) {
      try {
        await this.sound.setRateAsync(rate, shouldCorrectPitch);
      } catch (error) {
        // Rate changing could not be performed, possibly because the client's Android API is too old.
      }
    }
  };

  _onRateSliderSlidingComplete = async (value: number) => {
    this._trySetRate(value * RATE_SCALE, this.state.shouldCorrectPitch);
  };

  _onPitchCorrectionPressed = () => {
    this._trySetRate(this.state.rate, !this.state.shouldCorrectPitch);
  };

  _onSeekSliderValueChange = (value: number) => {
    if (this.sound != null && !this.isSeeking) {
      this.isSeeking = true;
      this.shouldPlayAtEndOfSeek = this.state.shouldPlay;
      this.sound.pauseAsync();
    }
  };

  _onSeekSliderSlidingComplete = async (value: number) => {
    if (this.sound != null) {
      this.isSeeking = false;
      const seekPosition = value * (this.state.soundDuration || 0);
      if (this.shouldPlayAtEndOfSeek) {
        this.sound.playFromPositionAsync(seekPosition);
      } else {
        this.sound.setPositionAsync(seekPosition);
      }
    }
  };

  _getSeekSliderPosition() {
    if (
      this.sound != null &&
      this.state.soundPosition != null &&
      this.state.soundDuration != null
    ) {
      return this.state.soundPosition / this.state.soundDuration;
    }
    return 0;
  }

  _getMMSSFromMillis(millis: number) {
    const totalSeconds = millis / 1000;
    const seconds = Math.floor(totalSeconds % 60);
    const minutes = Math.floor(totalSeconds / 60);

    const padWithZero = (number: number) => {
      const string = number.toString();
      if (number < 10) {
        return "0" + string;
      }
      return string;
    };
    return padWithZero(minutes) + ":" + padWithZero(seconds);
  }

  _getPlaybackTimestamp() {
    if (
      this.sound != null &&
      this.state.soundPosition != null &&
      this.state.soundDuration != null
    ) {
      return `${this._getMMSSFromMillis(
        this.state.soundPosition
      )} / ${this._getMMSSFromMillis(this.state.soundDuration)}`;
    }
    return "";
  }

  _getRecordingTimestamp() {
    if (this.state.recordingDuration != null) {
      return `${this._getMMSSFromMillis(this.state.recordingDuration)}`;
    }
    return `${this._getMMSSFromMillis(0)}`;
  }


  uploadrecording = async () => {
    const data = new FormData();
    const filePath = "file:///" + this.state.recordingInfo.uri.split("file:/").join("");
    data.append('user_id', global.personalInfo.user_id);
    data.append('word_id', this.props.id);
    data.append('record_file', { uri: filePath, name: filePath.split("/").pop(), type: mime.getType(filePath) });
    fetch(global.base_url+'saveUserRecording', {
      method: "POST",
      headers: {
        'Content-Type': 'multipart/form-data; ',
        'Accept': "application/json",
        "token": global.token,
      },
      body: data,
    })

      .then(response => response.json())
      .then(responseText => {
      })
      .catch(error => {
        alert(error);
      });
  };

  firstView = () => {
    this.setState({ showMeaningValue: 1 });
  }
  secondView = () => {
    this.setState({ showMeaningValue: 2 });
  }
  thirdView = () => {
    this.setState({ showMeaningValue: 3 });
  }
  strtStopRecordong = () => {
    if (!this.state.isUserRecording) {
      this.setState({ isUserRecording: !this.state.isUserRecording });
      this.setState({ recordImage: require('./Images/recording.png') });
      this._onRecordPressed();
    }
    else {
      this.setState({ isUserRecording: !this.state.isUserRecording });
      this.setState({ recordImage: require('./Images/record.png') });
      this._onRecordPressed();
    }
  }

  loadAPI = (data_type, url, method, body_data) => {

    this.setState({ isLoading: true });
    if (method == "GET") {
      fetch(url, {
        method: method,
        headers: {
          "Content-Type": "application/json",
          "token": global.token,
          "client_id":global.client_name,
        },
      })
        .then(response => response.json())
        .then(responseText => {
          this.setState({ isLoading: false });
          if (data_type === '1') {
            this.loadCourseList(responseText);
          }
          else if (data_type === '2') {
            this.nextScreen(responseText);
          }
          else {
            alert('unknown api call')
          }
        })
        .catch(error => {
          alert(error);
        });
    }
    else {
      fetch(url, {
        method: method,
        headers: {
          "Content-Type": "application/json",
          "token": global.token,
          "client_id":global.client_name,
        },
        body: JSON.stringify(body_data),
      })

        .then(response => response.json())
        .then(responseText => {
          this.setState({ isLoading: false });
          if (data_type === '1') {
            this.setFavWord(responseText);
          }else if (data_type === '2') {
            if (responseText.code == 200) {
              // global.knowWordAlertCount = global.knowWordAlertCount+1;
              // if(global.knowWordAlertCount<3){
              // alert("Word successfully added to learnt list.")
              // }
              this.props.removeWord(this.props.id);

            }
           // this.setFavWord(responseText);
          }
          else {
            alert('unknown api call')
          }
        })
        .catch(error => {
          alert(error);
        });
    }
  };

  setFavWord = (responseText) => {

    if (responseText.code == 200) {
      var resp = responseText.data;
      this.props.setFavoriteWord(this.props.id);

    }
  }
  setFavApi = () => {
    TrackHistory("fav","Click fav",this.props.id,"","","Word Card","");
    var body_data = {
      user_id: global.personalInfo.user_id,
      word_id: this.props.id

    }
    this.loadAPI('1', global.base_url+'setFavWord', "POST", body_data);
  }

  setWordLearnedApi = () => {
    Alert.alert(
      global.TextMessages.CW_ALERTMSG_ID,
      "\n",
      [
        {
          text: global.TextMessages.CW_ALERT_CANCEL_ID,
          onPress: () => console.log("Cancel Pressed")
        },
        { text: global.TextMessages.CW_ALERT_OK_ID, onPress: () => this.setLearnApi(),style: "cancel" }
      ],
      { cancelable: false }
    ); 
  }

  setLearnApi=()=>{
    var body_data = {
      user_id: global.personalInfo.user_id,
      word_id: this.props.id

    }
    console.log("Request"+JSON.stringify(body_data));
    this.loadAPI('2', global.base_url+'setLernedWord', "POST", body_data);
  }



  async endExpert() {
    TrackHistory("Listen","Click Listen",this.props.id,"","","Word Card","");
    const { sound } = await Audio.Sound.create(
      {
        uri: this.state.recordingInfo.uri,
        shouldPlay: true,
        isLooping: false,
        didJustFinish: true,
      },
      {
        androidImplementation:'MediaPlayer'
      }
    );
    this.sound = sound;
    this.sound.playAsync();

  }
  playCompare = () => {
    TrackHistory("Compare","Click Compare",this.props.id,"","","Word Card","");
    Speech.speak(this.props.word, { pitch: 1.0, rate: 1.0, language: 'en', onDone: () => this.endExpert() });
  }

  render() {
    //alert(JSON.stringify(this.props));
    global.screenInfo.start_time = new Date().getTime();
    var dotCounter = this.props.word_extra && this.props.word_extra.usageData ? this.props.word_extra.usageData.length : 0;
    return (
      <View style={styles.word, { marginTop: -110 }}>
        <CardFlip duration={1000} flipDirection={'y'} style={[{ flex: 1, width: screenWidth - 20, height: screenHeight - 200 }]} ref={card => (this.card = card)}>
          <View style={[styles.word, { flex: 1 }]}>
              <View style={[styles.horizontalViewStyle, { flex: 1,alignItems:"center",}]}>
              <Text style={[styles.DefaultSubText, { textAlign: 'left', fontWeight: "600", color: "#c5c5c5",marginLeft:20 }]}>{this.props.word_date}</Text>
              <View style={[styles.horizontalViewStyle, { alignItems:"center",justifyContent:"flex-end"}]}>
              <Image style={[styles.card_ilogoStyle,{margin:0,tintColor:"#00aaac"}]} ></Image>
                <TouchableOpacity
                  activeOpacity={1}
                  onPress={() => this.setFavApi()}>
                  {this.props.isFavourite === 1 ? <Image style={[styles.card_ilogoStyle]} source={require('./Images/fillstar.png')}></Image> : <Image style={[styles.card_ilogoStyle]} source={require('./Images/word_star.png')}></Image>}
                </TouchableOpacity>  
              </View>  
              </View>
            
            <View style={[styles.horizontalViewStyle, {flex:2,alignItems: 'center'}]}>
              <View style={{flex:20,paddingLeft:20,paddingRight:20}} >
                <Text style={[styles.WordTitle]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true}>{this.props.word}</Text>
              </View>
              

            </View>

            <View style={{ flex: 1 }}>
            <View style={[styles.horizontalViewStyle, {alignItems: 'flex-start',alignItems:"center",justifyContent:"center"}]}>
              <View style={{paddingLeft:20,paddingRight:20}} >
              <Text style={[styles.DefaultText, { color:"#727272",textAlign: 'left'}]}>{this.props.pronunciation}</Text>
              </View>
              <View style={{flex:5}} onStartShouldSetResponder={() => {TrackHistory("Expert","Click Expert",this.props.id,"","","Word Card",""); Speech.speak(this.props.word, { pitch: 1.0, rate: 1.0, language: 'en' })}}>
                <Image style={[styles.cardaudio_ilogoStyle, {width: 30, height: 30 }]} source={require('./Images/expert_audio.png')}></Image>
              </View>
            </View>
            </View>
            <View style={{flex: 8 }}>
            
            <Text style={[styles.DefaultDefinitionText, { textAlign: 'left', marginLeft: 20, marginRight: 20, marginTop: 10 }]}>{this.props.definition}</Text>
            {this.props.synonym !== "" && <Text style={[styles.DefaultText, {fontStyle: 'italic', color:"#727272",textAlign: 'left', marginLeft: 20, marginRight: 20, marginTop: 15 }]}>{global.TextMessages.CW_SYNONYM_ID}: {this.props.synonym}</Text>}
            {(this.props.antonym !== "") && <Text style={[styles.DefaultText, {fontStyle: 'italic',color:"#727272", textAlign: 'left', marginLeft: 20, marginRight: 20, marginTop: 10 }]}>{global.TextMessages.CW_ANTONYM_ID}: {this.props.antonym}</Text>} 
              {/*<View style={[{flexDirection:'row',fleax:1}]}>
                <View style={{justifyContent:'flex-start',flex: 25 }}>
                  {this.state.showMeaningValue == 1 && this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[0] ?
                    <View>
                      <Text style={[styles.DefaultText, { textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[0].meaning && typeof(this.props.word_extra.usageData[0].meaning) !== 'undefined' ? this.props.word_extra.usageData[0].meaning : ""}</Text>
                      <Text style={[styles.DefaultText, { fontStyle: 'italic', textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[0].usage[0] && typeof(this.props.word_extra.usageData[0].usage[0]) !== 'undefined' ? this.props.word_extra.usageData[0].usage[0] : ""}</Text>
                    </View> : <View></View>
                  }
                  {this.state.showMeaningValue == 2 && this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[1]?
                    <View>
                      <Text style={[styles.DefaultText, { textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[1].meaning && typeof(this.props.word_extra.usageData[1].meaning) !== 'undefined' ? this.props.word_extra.usageData[1].meaning : ""}</Text>
                      <Text style={[styles.DefaultText, { fontStyle: 'italic', textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[1].usage[0] && typeof(this.props.word_extra.usageData[1].usage[0]) !== 'undefined' ? this.props.word_extra.usageData[1].usage[0] : ""}</Text>
                    </View> : <View></View>
                  }
                  {this.state.showMeaningValue == 3 && this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[2] ?
                    <View>
                      <Text style={[styles.DefaultText, { textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[2].meaning && typeof(this.props.word_extra.usageData[2].meaning) !== 'undefined' ? this.props.word_extra.usageData[2].meaning : ""}</Text>
                      <Text style={[styles.DefaultText, { fontStyle: 'italic', textAlign: 'left', padding: 20 }]}>{this.props.word_extra && this.props.word_extra.usageData && this.props.word_extra.usageData[2].usage[0] && typeof(this.props.word_extra.usageData[2].usage[0]) !== 'undefined' ? this.props.word_extra.usageData[2].usage[0] : ""}</Text>
                    </View> : <View></View>
                  }

                </View>
                <View style={{flex: 3,height:'100%',maxHeight:'100%',minHeight:'100%'}}>
                  <View style={{flexDirection: 'column',justifyContent:'center', alignItems: 'center',flex:1}}>
                  {dotCounter > 0 ?
                    <TouchableOpacity

                      activeOpacity={1}
                      style={[styles.wordblank, {padding: 0 }]} onPress={() => this.firstView()}>
                      <View style={[styles.ilogoStyle, { backgroundColor: this.state.showMeaningValue == 1 ? "#eb6624" : "#e6e6e6", borderRadius: 11, padding: 10,margin:10 }]}></View>
                    </TouchableOpacity> : <View></View>
                  }

                  {dotCounter > 1 ?
                    <TouchableOpacity

                      activeOpacity={1}
                      style={[styles.wordblank, {padding: 0 }]} onPress={() => this.secondView()}>
                      <View style={[styles.ilogoStyle, { backgroundColor: this.state.showMeaningValue == 2 ? "#eb6624" : "#e6e6e6", borderRadius: 11, padding: 10,margin:10 }]}></View>
                    </TouchableOpacity> : <View></View>
                  }

                  {dotCounter > 2 ?
                    <TouchableOpacity
                      activeOpacity={1}
                      style={[styles.wordblank, {padding: 0 }]} onPress={() => this.thirdView()}>
                      <View style={[styles.ilogoStyle, { backgroundColor: this.state.showMeaningValue == 3 ? "#eb6624" : "#e6e6e6", borderRadius: 11, padding: 10,margin:10}]}></View>
                    </TouchableOpacity> : <View></View>
                  }
                  </View>

                </View>
              </View>*/}
            </View>
            

            <View style={[styles.horizontalViewStyle, { flex: 3 }]}>

              <View style={[styles.fivePart]}>
              </View>

              <View style={[styles.fivePart]}>
                <View style={[styles.wordRoundBox]}>
                  <Image source={this.state.recordImage} style={{ width: 60, height: 60, borderRadius: 30 }} onStartShouldSetResponder={() => {TrackHistory("Record","Click Record",this.props.id,"","","Word Card","");this.strtStopRecordong()}} />
                  <Text style={styles.DefaultSubText}>{global.TextMessages.CW_RECORD_ID}</Text>
                </View>
              </View>

              <View style={styles.fivePart}>
                <View style={[styles.wordRoundBox]}>
                  {this.props.record &&
                    <Image source={require('./Images/listen.png')} style={{ width: 60, height: 60, borderRadius: 30 }} onStartShouldSetResponder={() => this.endExpert()} />
                  }
                  {!this.props.record &&
                    <Image source={require('./Images/listen.png')} style={{ width: 60, height: 60, borderRadius: 30 }} opacity={0.3} />
                  }
                  <Text style={styles.DefaultSubText}>{global.TextMessages.CW_LISTEN_ID}</Text>
                </View>
              </View>

              <View style={styles.fivePart}>
                <View style={[styles.wordRoundBox]}>
                  {this.props.record && <Image source={require('./Images/compare.png')} style={{ width: 60, height: 60, borderRadius: 30 }} onStartShouldSetResponder={() => this.playCompare()} />}
                  {!this.props.record && <Image source={require('./Images/compare.png')} style={{ width: 60, height: 60, borderRadius: 30 }} opacity={0.3} />}
                  <Text style={styles.DefaultSubText}>{global.TextMessages.CW_COMPARE_ID}</Text>
                </View>
              </View>
              <View style={[styles.fivePart]}>
              </View>

            </View>
            <View onStartShouldSetResponder={() => {TrackHistory("already knew","Click already knew",this.props.id,"","","Word Card","");this.setWordLearnedApi(); }} style={[styles.horizontalViewStyle, { width: "100%", justifyContent: 'center', alignItems: "flex-end" }]} style={{ backgroundColor:"#f4faee",flex: 1,alignItems:"center",justifyContent:'center'}}>
              <View>
                <View style={[styles.horizontalViewStyle]}>
                  <Text style={[styles.DefaultSubText, { marginRight:4, marginTop:2 }]}>{global.TextMessages.CW_IKTW_ID}</Text>
                  <Image style={[styles.card_ilogoStyle, { margin: 4,marginTop: 0 }]} source={require('./Images/knewWord.png')}></Image>
                </View>
              </View>
            </View>
            <View style={{ flex: 1,alignItems:"center",justifyContent:'center' }}>
              <View onStartShouldSetResponder={() => {TrackHistory("Flip","Click Flip",this.props.id,"","","Word Card",""); global.navigation.navigate("WordQuestion", { wordId: this.props.id,parent:"word" })}} style={[styles.horizontalViewStyle, { width: "100%", justifyContent: 'center', alignItems: "flex-end" }]}>
                <View style={[styles.horizontalViewStyle]}>
                  <Text style={[styles.DefaultSubText, { margin: 4, marginTop: 0 }]}>{global.TextMessages.CW_TTPTW_ID}</Text>
                  <Image style={[styles.card_ilogoStyle, { margin: 4, marginTop: 0 }]} source={require('./Images/flip.png')}></Image>
                </View>
              </View>
            </View>

          </View>


          <View style={[styles.word, { flex: 1 }]}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'flex-end' }]}>
              <TouchableOpacity
                activeOpacity={1}
                style={[styles.wordblank, { flex: 1, width: screenWidth - 40, height: screenHeight - 200 }]} onPress={() => this.card.flip()}>
                <Image style={[styles.card_ilogoStyle]} source={require('./Images/flip.png')}></Image>
              </TouchableOpacity>

            </View>
          </View>
        </CardFlip>
      </View>
    )
  }
}
export default Card_Word
