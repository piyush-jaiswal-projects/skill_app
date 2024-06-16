import React, { Component } from 'react';
import {ScrollView, Text, View, StyleSheet, Image, Animated, TouchableOpacity, Dimensions, PixelRatio,ActivityIndicator,Alert} from 'react-native';
import QuizBody from './Quiz_Body';
import styles from './vocabStyleSheet/styles';
import { AnimatedCircularProgress } from 'react-native-circular-progress';
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
import {TrackHistory} from './utill/Network'; 
let ComplPercentage = 0;
const fontFactor = PixelRatio.getFontScale();
let that = "";
let Timer = "";
export default class PlacementTest extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoading : false,
      testObj: this.props.route.params,
      totalDuration: this.props.route.params.time,
      remaingTime:this.props.route.params.time,
      remainingMin:this.props.route.params.time/60,
      remainingSec:this.props.route.params.time%60,
      currentQC: 0,
      QuestionData: [
        {
          question: "Hello  of India?",
          options: [
            {
              label: 'New Delhi ',
              id: "1",
              isCorrect: 1
            },
            {
              label: 'Mumbai',
              id: "2",
              isCorrect: 0
            },
            {
              label: 'Benguluru',
              id: "3",
              isCorrect: 0
            },
            {
              label: 'Chennai',
              id: "4",
              isCorrect: 0
            }
          ]
        },
        {
          question: "Our sir teaches Mathematics . . . . . . English.",
          options: [
            {
              label: 'across',
              id: "1",
              isCorrect: 0
            },
            {
              label: 'besides',
              id: "2",
              isCorrect: 1
            },
            {
              label: 'beside',
              id: "3",
              isCorrect: 0
            },
            {
              label: 'both',
              id: "4",
              isCorrect: 0
            }
          ]
        },

      ]
    }
  }

  changeQuestion = (SelectedOptionId, QuestionId) => {
    this.saveUserResponse(0, QuestionId, SelectedOptionId);
    let updatedCount = this.state.currentQC + 1;
    if (updatedCount < this.state.QuestionData.length) {
      this.setState({ currentQC: updatedCount });
      this._b.updateQuestion(this.state.QuestionData[updatedCount]);
    } else {
      var body_data = {
        user_id: global.personalInfo.user_id,
        test_id: this.state.testObj.testId,
        force_close:0,
      }
      this.loadAPI('2', global.base_url+'getPlacementTestStatus', "POST", body_data);
    }
  }

  loadAPI = (data_type, url, method, body_data) => {
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
            this.renderQuestionArr(responseText);
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
            this.renderQuestionArr(responseText);
          }
          else if (data_type === '2') {
            this.nextScreen(responseText);
          } else if (data_type === '3') {
            console.log("1Response"+JSON.stringify(responseText));
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

  renderQuestionArr = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      this.setState({ QuestionData: resp.questions });
      this._b.updateQuestion(this.state.QuestionData[0]);
    }
    else {

    }
  }

  _countdown(){
    var timer = function () {
      var time = that.state.remaingTime - 1;
      if(time>=0){
      that.setState({remaingTime: time});
      }
      if (time > 0) {
        Timer = setTimeout(timer, 1000);
      } else {
        Alert.alert(
          global.TextMessages.PT_TIMEOUT_TITLE_ID,
          global.TextMessages.PT_TIMEOUT_SUBTITLE_ID,
          [
            { text: global.TextMessages.PT_TIMEOUT_BUTTON_ID, onPress: () => that.submitQues() }
          ],
          { cancelable: false }
        );
      }
    };
    Timer = setTimeout(timer.bind(this), 1000);
  }


  submitQues=()=>{
    var body_data = {
      user_id: global.personalInfo.user_id,
      test_id: this.state.testObj.testId,
      force_close:1,   //   0 optional // 1 force close
    }
    this.loadAPI('2', global.base_url+'getPlacementTestStatus', "POST", body_data);

  }

  nextScreen = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      console.log(JSON.stringify(responseText));
      if(resp.next_call === 1)
      {
        this.state.currentQC =0;
        var body_data = {
          user_id: global.personalInfo.user_id,
          test_id: this.state.testObj.testId,
          level:resp.group,

        }
        this.setState({ isLoading: true });
        this.loadAPI('1', global.base_url+'getTestQuestions', "POST", body_data);
      }
      else
      {
        clearTimeout(Timer);
        global.personalInfo.current_level = resp.group;
        global.personalInfo.current_level_id = resp.groupId;
        global.personalInfo.score = resp.score;
        global.screenInfo.end_time = new Date().getTime();
        TrackHistory("","","","","","Placement test","ThankYouTest");
        global.navigation.navigate('SetGoal03Screen')
      }
    }
    else {

    }
  }
  componentDidMount() {
   global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
      
    
    console.log(JSON.stringify(this.props.route.params));
    if(this.props.route.params.time && this.props.route.params.time>0){
      this._countdown();
    }
    var body_data = {
      user_id: global.personalInfo.user_id,
      test_id: this.state.testObj.testId,
      level:"",
    }
    this.setState({ isLoading: true });
    this.loadAPI('1', global.base_url+'getTestQuestions', "POST", body_data);
  }

  saveUserResponse(word_id, question_id, option_id) {
    var body_data = {
      user_id: global.personalInfo.user_id,
      word_id: 0,
      question_id: question_id,
      option_id: option_id,
      test_id: this.state.testObj.testId

    }
    this.loadAPI('3', global.base_url+'saveResponse', "POST", body_data);
  }

  render() {
    that = this;
    ComplPercentage = (this.state.currentQC + 1) * 100 / (this.state.QuestionData.length);
    return (
      <View style={{ backgroundColor: "#ffffff", height: "100%", paddingTop: 30 }}>
        <View style={{ overflow: 'hidden', paddingBottom: 0 }}>
          <View
            style={{
              backgroundColor: '#fff',
              height: 60,
              shadowColor: '#000',
              shadowOffset: { width: 1, height: 6 },
              shadowOpacity: 0.0,
              shadowRadius: 3,
              elevation: 0,
            }}
          >

            <View style={{ flexDirection: "row", justifyContent: "flex-start", alignItems: 'center', height: 60 }}>
              <TouchableOpacity style={[styles.horizontalViewStyle, { alignItems: "center" }]} onPress={() => global.navigation.goBack()}>
                <Image style={{ position: 'absolute', width: 30, height: 20, marginStart: 10, tintColor: "#000000" }} source={require('./Images/back.png')}></Image>
                <Text style={[styles.headerBackTitle, { color: "#fe7201",paddingLeft:20}]}>
                {global.TextMessages.PT_TITLE_ID}
                </Text>
              </TouchableOpacity>
              {(this.props.route.params.time && this.props.route.params.time) && <View style={{ alignItems: "flex-end", justifyContent: "flex-end", flex: 1,marginEnd:15 }}>
                <View style={{ alignItems: "center", justifyContent: "center" }}>
                  <AnimatedCircularProgress
                    size={50}
                    width={4}
                    fill={Math.floor(this.state.remaingTime*100/this.state.totalDuration)}
                    tintColor="#e96026"
                    rotation={0}
                    onAnimationComplete={() => console.log('')}
                    backgroundColor="#eeeeee"
                    style={{ justifyContent: "center" }}
                  />
                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    
                    <Text style={(Math.floor(this.state.remaingTime/60) == 0 && Math.floor(this.state.remaingTime%60)< 30)  ? styles.DefaultSub_week_Text_Alert:styles.DefaultSub_week_Text}>
                      {Math.floor(this.state.remaingTime/60)}:{Math.floor(this.state.remaingTime%60)}
                    </Text>
                  </View>
                </View>
              </View>}
            </View>
          </View>
        </View>
        <View style={{backgroundColor:"#eeeeee",width:"100%",height:1}}></View>
        <ScrollView>
        {/*!this.state.isLoading &&<View style={{ marginLeft: 20,marginTop:10, flexDirection: "row", height: 20, width: screenWidth - 40, justifyContent: "center", alignItems: 'center' }}>
          <View style={Localstyles.progressContainer}>
            <Animated.View
              style={[
                Localstyles.inner, { width: ComplPercentage + "%" },
              ]}
            />
          </View>
          <Text style={{fontSize:12/fontFactor, alignItems: "center", justifyContent: "center", width: "10%", textAlign: "center" }}>{this.state.currentQC + 1}/{this.state.QuestionData.length}</Text>
            </View>*/}
        {!this.state.isLoading && <QuizBody ref={ref => (this._b = ref)} Question={this.state.QuestionData[this.state.currentQC]} isShowFeedback={false} changeQuestion={this.changeQuestion} />}
        {!this.state.isLoading &&<View onStartShouldSetResponder={() => {TrackHistory("I dont Know","Click I dont Know","","","","Placment Test","ThankYouTest"); this.changeQuestion(-1, this.state.QuestionData[this.state.currentQC].qId ? this.state.QuestionData[this.state.currentQC].qId : this.state.QuestionData[this.state.currentQC].qid)}} style={[styles.horizontalViewStyle, { marginBottom: 40, height: 50, width: "100%", justifyContent: 'center', alignItems: "center" }]}>
          <Text style={{ fontSize: 15 / fontFactor, fontWeight: "normal" }}>{global.TextMessages.PT_IDONTKNOW_ID}</Text>
        </View>}
        {this.state.isLoading && <ActivityIndicator size="large" color={"#d33131"} />}
        </ScrollView>
      </View>
    )
  }
}

const Localstyles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
    marginEnd: 20,
    marginStart: 20,
    backgroundColor: "#ffffff"
  },
  valueText: {
    fontSize: 18,
    marginBottom: 50,
  },
  progressContainer: {
    height: 5,
    width: "90%",
    borderColor: "#ffffff",
    backgroundColor: "#edebe1",
    justifyContent: "center",
    alignSelf: "center",
  },
  inner: {
    width: "100%",
    height: 3,
    borderRadius: 15,
    backgroundColor: "#63c033",
  },
  chooseTheCorrectStyle: {
    fontSize: 13.3,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#fe7201"
  }
});
