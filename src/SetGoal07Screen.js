import React, { useState } from "react";
import { ScrollView, PixelRatio, View, ImageBackground, Image, StyleSheet, Text, TextInput, TouchableOpacity, Button, FlatList, Dimensions } from 'react-native';
import BackButton from './component/BackButton';
import PrimaryButton from './component/Button';
import PrimarySkipButton from './component/skipButton';
import styles from './vocabStyleSheet/styles';
import RNListSlider from 'react-native-list-slider';
import {TrackHistory} from './utill/Network'; 
const fontFactor = PixelRatio.getFontScale();

const labels = ["", "", "", "", "", "", ""];

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
const ageErrorMsg = "Please select Age.";
const genderErrorMsg = "Please select Gender";

class SetGoal07Screen extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      age: 0,
      selectedGender: -1,   // 0 male  1 female 2 other
      AgeErrorMsg:"",
      GenderErrorMsg:""

    };
  }


  clickContinue = () => {

    if(this.state.selectedGender<0){
      this.setState({GenderErrorMsg:genderErrorMsg});
    }else if(this.state.age<1){
      this.setState({AgeErrorMsg:ageErrorMsg});
    }else{
      if (this.state.selectedGender == 0)
        global.personalInfo.gender = 'male';
      else if (this.state.selectedGender == 1)
        global.personalInfo.gender = 'female';
      else
        global.personalInfo.gender = 'other';

      global.personalInfo.age = this.state.age;

      var body_data = {
        user_id: global.personalInfo.user_id,
        age: global.personalInfo.age,
        gender: global.personalInfo.gender,  
      }
      this.loadAPI('1', 'http://vocab.englishedge.in/setUserProfile', "POST", body_data);
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
            if (responseText.code == 200) {
              global.screenInfo.end_time = new Date().getTime();
              TrackHistory("Continue","Click Continue","","","","PI1","PI2");
              global.navigation.navigate('SetGoal08Screen');
            }
          }else {
            alert('unknown api call')
          }
        })
        .catch(error => {
          alert(error);
        });
    }
  };

  selectOther = () => {
    this.setState({ selectedGender: 2,GenderErrorMsg:"" });
    this.refs['otherRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f47920" } });
    this.refs['femaleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });
    this.refs['maleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });


  }

  onValueChanged = (value) => {
    if(value >0)
    this.setState({ age:value,AgeErrorMsg:"" });
    //console.log("Value"+value);
  }

  selectfemale = () => {
    this.setState({ selectedGender: 1,GenderErrorMsg:"" });
    this.refs['otherRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });
    this.refs['femaleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f47920" } });
    this.refs['maleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });

  }
  selectmale = () => {
    this.setState({ selectedGender: 0,GenderErrorMsg:"" });
    this.refs['otherRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });
    this.refs['femaleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f5f5f5" } });
    this.refs['maleRef'].setNativeProps({ style: { borderWidth: 3, borderColor: "#f47920" } });
  }

  renderItem = ({ item }) => (
    <View style={[styles.list_item_Line, { flexDirection: 'column', alignItems: 'center' }]}>
      <View style={styles.list_item_Line_1}></View>
      <Text style={[styles.list_title, { textAlign: 'center', width: 30 }]}>{item.title}</Text>
    </View>
  );
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    if(global.personalInfo.gender==='male'){
      this.selectmale();
    }else if(global.personalInfo.gender==='female'){
      this.selectfemale();
    }else if(global.personalInfo.gender==='other'){
      this.selectOther();
    }
    this.setState({age:global.personalInfo.age});

  }
  

  render() {
    return (

      <ScrollView style={[styles.mainContainer, { width: screenWidth,backgroundColor:"#ffffff" }]}>
        <ImageBackground style={[styles.logo]} source={require('./Images/setGImage07.png')}>
          <View style={styles.topView}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text=''
                />

              </View>
              {false && <Text onStartShouldSetResponder={() => {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("Skip","Click Skip","","","","PI1","PI2");
                global.navigation.navigate("SetGoal08Screen");
                }} style={[styles.skip,{marginRight:20}]}>Skip</Text>}
            </View>
          </View>
        </ImageBackground>



        <Text style={[styles.headerTitle, { marginLeft: 10, marginTop: -140, }]} >{global.TextMessages.PROFILE1_HEAD_ID}</Text>
        {<Text style={[styles.HeaderSubTitle, { marginLeft: 10 }]} >{global.TextMessages.PROFILE1_SUBHEAD1_ID}</Text>}
        <View style={styles.cornerContainer}>

          <Text style={[styles.Title,{textAlign:"left",fontSize:18/fontFactor,marginBottom: 20}]}>{global.TextMessages.PROFILE1_INS_ID}</Text>
          <View style={styles.horizontalViewStyle}>
            <View style={styles.threePart}>
              <View style={[styles.innerRoundBox, { width: '100%',padding:0, backgroundColor: '#ffffff' }]}>

                <TouchableOpacity onPress={() => this.selectmale()}>
                  <Image ref='maleRef' source={require('./Images/male.png')}
                    style={{ marginBottom: 5, width: 100, height: 100, borderRadius: 50, borderWidth: 3, borderColor: "#f5f5f5" }}
                  />
                </TouchableOpacity>
                <Text style={styles.SubTitle}>{global.TextMessages.PROFILE1_MALE_ID}</Text>
              </View>
            </View>
            <View style={styles.threePart}>
              <View style={[styles.innerRoundBox, { width: '100%',padding:0, backgroundColor: '#ffffff' }]}>
                <TouchableOpacity onPress={() => this.selectfemale()}>
                  <Image ref='femaleRef' source={require('./Images/female.png')}
                    style={{ marginBottom: 5, width: 100, height: 100, borderRadius: 50, borderWidth: 3, borderColor: "#f5f5f5" }}
                  />
                </TouchableOpacity>
                <Text style={styles.SubTitle}>{global.TextMessages.PROFILE1_FEMALE_ID}</Text>
              </View>
            </View>
            <View style={styles.threePart}>
              <View style={[styles.innerRoundBox, { width: '100%',padding:0, backgroundColor: '#ffffff' }]}>
                <TouchableOpacity onPress={() => this.selectOther()}>
                  <Image ref='otherRef' source={require('./Images/other.png')}
                    style={{ marginBottom: 5, width: 100, height: 100, borderRadius: 50 }}
                  />
                </TouchableOpacity>
                <Text style={styles.SubTitle}>{global.TextMessages.PROFILE1_OTHER_ID}</Text>
              </View>
            </View>
          </View>
          <Text style={styles.errorTextStyle}>{this.state.GenderErrorMsg}</Text>
          <View style={[styles.centerView,{marginTop:10}]}>
            <Text style={[styles.DefaultText,{fontSize:18/fontFactor}]}>{global.TextMessages.PROFILE1_AGE_ID}</Text>
          </View>
          <View style={[styles.centerView, { padding:0,margin:0,marginTop:-15, width: '100%' }]}>
            {/*<FlatList
          data={this.state.ageArr}
          horizontal={true}
          renderItem={this.renderItem}
          keyExtractor={item => item.id}
          extraData={this.state}
        />*/}
            <View style={{flexDirection:"row",flex:4}}>
            <View style={{flexDirection:"row",flex:1}}>
            </View>
            <View style={{flexDirection:"row",flex:2,alignItems:"center",justifyContent:'center'}}>
            <Text style={[styles.AgeStyle,{textAlign:"center"}]}>{this.state.age}</Text>
            </View>
            <View style={{flexDirection:"row",flex:1,alignItems:"flex-end"}}>
            <Text style={[styles.letsReiterate,{marginRight:0,marginBottom:0}]}>{global.TextMessages.PROFILE1_YEAROLD_ID}</Text>
            </View>
            </View>
            <RNListSlider
              value={this.state.age}
              onValueChange={this.onValueChanged}
              multiplicity={1}
              initialPositionValue={0}
              maximumValue={100}
              scrollEnabled={true}
              arrayLength={100}
            />
          </View>
          <Text style={styles.errorTextStyle}>{this.state.AgeErrorMsg}</Text>
          <View style={[{ margin: 0, marginTop: 30 }]}>
            <PrimaryButton
              text={global.TextMessages.PROFILE1_CONTINUE_ID}
              onPress={() => this.clickContinue()}
            />
          </View>
          {false && <View style={[styles.centerView, { margin: 0,marginTop:10,marginBottom: 10 }]}>
              <Text onStartShouldSetResponder={() => {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("Skip","Click Skip","","","","PI1","PI2"); 
                global.navigation.navigate("SetGoal08Screen");
                }} style={styles.DefaultText}>Skip</Text>
          </View>}
          {false && <View style={[styles.centerView, { margin: 0, marginBottom: 10 }]}>
            <Text style={styles.DefaultSubText} >Don't worry you can fill later from setting</Text>
          </View>}
        </View>
      </ScrollView>

    );
  }
}

export default SetGoal07Screen;
