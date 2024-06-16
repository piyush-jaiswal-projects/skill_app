import React, { useState } from "react";
import { ScrollView, Platform, View, ImageBackground, Image, StyleSheet, Text, TextInput, TouchableOpacity, Button, ActivityIndicator, Dimensions } from 'react-native';
import StepIndicator from 'react-native-step-indicator';
import BackButton from './component/BackButton';
import PrimaryButton from './component/Button';
import PrimarySkipButton from './component/skipButton';
import styles from './vocabStyleSheet/styles';
import DropDownPicker from 'react-native-dropdown-picker';
import Globalstyles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network'; 

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const labels = ["", "", "", "", "", "", ""];

const EducationErrorMsg = "Please select education";
const EmploymentErrorMsg = "Please select employment";
const LanguagerrorMsg = "Please select language";
const LocationErrorMsg = "Please select location";

class SetGoal08Screen extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      selectedEducation: global.personalInfo.education,
      selectedEmployment: global.personalInfo.employment,
      selectedNativeLang:global.personalInfo.language,
      selectedlocation: global.personalInfo.country,
      isLoading: false,
      educationErrorMsg:'',
      employmentErrorMsg:'',
      languageErrorMsg:'',
      locationErrorMsg:'',
      educationArr:[],
      employmentArr:[],
      languageArr:[],
      cityArr:[],
    };
  }
  clickContinue = () => {
    TrackHistory("Continue","Click Continue","","","","PI2","Goal Summary");
    if(this.state.selectedEducation.length<1){
      this.setState({educationErrorMsg:EducationErrorMsg,employmentErrorMsg:"",languageErrorMsg:"",locationErrorMsg:""})
    }else if(this.state.selectedEmployment.length<1){
      this.setState({employmentErrorMsg:EmploymentErrorMsg,educationErrorMsg:"",languageErrorMsg:"",locationErrorMsg:""})
    }else if(this.state.selectedNativeLang.length<1){
      this.setState({languageErrorMsg:LanguagerrorMsg,employmentErrorMsg:"",educationErrorMsg:"",locationErrorMsg:""})
    }else if(this.state.selectedlocation.length<1){
      this.setState({locationErrorMsg:LocationErrorMsg,employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:""})
    }else{
      this.setState({locationErrorMsg:"",employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:""})
    global.personalInfo.education = this.state.selectedEducation;
    global.personalInfo.employment = this.state.selectedEmployment;
    global.personalInfo.language = this.state.selectedNativeLang;
    global.personalInfo.country =  this.state.selectedlocation;

    var body_data = {
      user_id: global.personalInfo.user_id,
      age: global.personalInfo.age,
      gender: global.personalInfo.gender,
      education: global.personalInfo.education,
      profession: global.personalInfo.employment,
      language: global.personalInfo.language,
      city: global.personalInfo.country,
      
    }
    this.loadAPI('1', 'http://vocab.englishedge.in/setUserProfile', "POST", body_data);
  }


  }
  nextScreen = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("next","Click next","","","","PI2","DashBoard");
      global.navigation.navigate('DashBoard');
    }
    else {

    }
  }

  loadEducation = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      var _arr = new Array();
      for (var i = 0; i < resp.length; i++) {

        _arr.push({label:resp[i].name,value:resp[i].name});
      }

      this.setState({educationArr:_arr});
    }
    else {
    }
  }
  loadEmployment = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      var _arr = new Array();
      for (var i = 0; i < resp.length; i++) {

        _arr.push({label:resp[i].name,value:resp[i].name});
      }

      this.setState({employmentArr:_arr});
    }
    else {
    }
  }
  loadLanguage = (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      var _arr = new Array();
      for (var i = 0; i < resp.length; i++) {

        _arr.push({label:resp[i].name,value:resp[i].name});
      }

      this.setState({languageArr:_arr});
    }
    else {
    }
  }
  loadcity= (responseText) => {
    if (responseText.code == 200) {
      var resp = responseText.data;
      var _arr = new Array();
      for (var i = 0; i < resp.length; i++) {

        _arr.push({label:resp[i].countryName,value:resp[i].countryName});
      }

      this.setState({cityArr:_arr});
    }
    else {
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
            this.nextScreen(responseText);
          }
          else if (data_type === '2') {
            this.loadEducation(responseText);
          }
          else if (data_type === '3') {
            this.loadEmployment(responseText);
          }
          else if (data_type === '4') {
            this.loadLanguage(responseText);
          }
          else if (data_type === '5') {
            this.loadcity(responseText);
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


  componentDidMount() {
    
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    

    var body_data = {
      app_id:"1",
     }
     this.loadAPI('2',global.base_url+'getEducationList',"POST",body_data);
     this.loadAPI('3',global.base_url+'getEmploymentList',"POST",body_data);
     this.loadAPI('4',global.base_url+'getLanguageList',"POST",body_data);
     this.loadAPI('5',global.base_url+'getLocationList',"POST",body_data);
  }

  render() {
    return (
      <ScrollView style={[styles.mainContainer, { width: screenWidth,backgroundColor:"#ffffff" }]}>
        <ImageBackground style={[styles.logo]} source={require('./Images/setGImage07.png')}>
          <View style={styles.topView}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
              <BackButton
                  onPress={() => {
                    
                    global.screenInfo.end_time = new Date().getTime();
                    TrackHistory("Back","Click Back","","","","SetGoal08Screen","DashBoard");
                    global.navigation.navigate('DashBoard')
                  }}
                  text=''
                />
              </View>
              {false && <Text onStartShouldSetResponder={() => {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("Skip","Click Skip","","","","PI2","Goal Summary");
                global.navigation.navigate("GoalSummary");
                }} style={[styles.skip,{marginRight:20}]}>Skip</Text>}
            </View>
          </View>
        </ImageBackground>
        <Text style={[styles.headerTitle, { marginLeft: 10, marginTop: -120, }]} >{global.TextMessages.PROFILE2_HEAD_ID}</Text>
       { <Text style={[styles.HeaderSubTitle, { marginLeft: 10 }]} >{global.TextMessages.PROFILE2_SUBHEAD1_ID}</Text>}

        <View style={styles.cornerContainer}>
          <View style={[{ ...(Platform.OS !== 'android' && { zIndex: 5 }) }]}>
            <Text style={[styles.DefaultText, { marginTop: 20, marginBottom: 10, textAlign: 'left' }]}>{global.TextMessages.PROFILE2_EDUCATION_ID}</Text>
            {this.state.educationArr.length >0 && <DropDownPicker 
              dropDownMaxHeight={300}
              style={{ borderWidth: 0, borderBottomWidth: 1 }}
              containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
              labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
              placeholder="Select"
              placeholderStyle={{ color: "#ff00ff" }}
              items={this.state.educationArr}
              placeholderStyle={{ color: "#c12d30" }}
              defaultValue={this.state.selectedEducation}
              containerStyle={{ height: 50 }}
              onChangeItem={item => this.setState({ selectedEducation: item.value,locationErrorMsg:"",employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:"" })}
            />}
            <Text style={Globalstyles.errorTextStyle}>{this.state.educationErrorMsg}</Text>
          </View>
          <View style={[{ ...(Platform.OS !== 'android' && { zIndex: 4 }) }]}>
            <Text style={[styles.DefaultText, { marginTop: 20, marginBottom: 10, textAlign: 'left' }]}>{global.TextMessages.PROFILE2_EMPLOYEMENT_ID}</Text>
            {this.state.employmentArr.length >0  && <DropDownPicker
              dropDownMaxHeight={300}
              style={{ borderWidth: 0, borderBottomWidth: 1 }}
              containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
              labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
              placeholder="Select"
              items={this.state.employmentArr}
              placeholderStyle={{ color: "#c12d30" }}
              defaultValue={this.state.selectedEmployment}
              onChangeItem={item => this.setState({ selectedEmployment: item.label,locationErrorMsg:"",employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:"" })}
            />}
            <Text style={Globalstyles.errorTextStyle}>{this.state.employmentErrorMsg}</Text>
          </View>
          <View style={[{ ...(Platform.OS !== 'android' && { zIndex: 3 }) }]}>
            <Text style={[styles.DefaultText, { marginTop: 20, marginBottom: 10, textAlign: 'left' }]}>{global.TextMessages.PROFILE2_LANGUAGE_ID}</Text>
            {this.state.languageArr.length >0 && <DropDownPicker
              dropDownMaxHeight={300}
              style={{ borderWidth: 0, borderBottomWidth: 1 }}
              containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
              labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
              placeholder="Select"
              items={this.state.languageArr}
              placeholderStyle={{ color: "#c12d30" }}
              defaultValue={this.state.selectedNativeLang}
              containerStyle={{ height: 50 }}
              onChangeItem={item => this.setState({ selectedNativeLang: item.label,locationErrorMsg:"",employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:"" })}
            />}
            <Text style={Globalstyles.errorTextStyle}>{this.state.languageErrorMsg}</Text>
          </View>
          <View style={[{ ...(Platform.OS !== 'android' && { zIndex: 2 }) }]}>
            <Text style={[styles.DefaultText, { marginTop: 20, marginBottom: 10, textAlign: 'left' }]}>{global.TextMessages.PROFILE2_LOCATION_ID}</Text>
            {this.state.cityArr.length >0 && <DropDownPicker
              dropDownMaxHeight={300}
              style={{ borderWidth: 0, borderBottomWidth: 1 }}
              containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
              dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
              labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
              placeholder="Select"
              items={this.state.cityArr}
              placeholderStyle={{ color: "#c12d30" }}              
              defaultValue={this.state.selectedlocation}
              containerStyle={{ height: 50 }}
              onChangeItem={item => this.setState({ selectedlocation: item.label,locationErrorMsg:"",employmentErrorMsg:"",languageErrorMsg:"",educationErrorMsg:"" })}
            />}
            <Text style={Globalstyles.errorTextStyle}>{this.state.locationErrorMsg}</Text>
          </View>


            <PrimaryButton
              text={global.TextMessages.PROFILE2_CONTINUE_ID}
              onPress={() => this.clickContinue()}
            />
          
          {false && <View style={[styles.centerView, { margin: 0 }]}>
              <Text onStartShouldSetResponder={() => {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("Skip","Click Skip","","","","PI2","Goal Summary");
                global.navigation.navigate("GoalSummary");
              }} style={styles.DefaultText}>Skip</Text>
          </View>}
          {false && <View style={[styles.centerView, { margin: 0, marginBottom: 10 }]}>
            <Text style={styles.DefaultSubText} >Don't worry you can fill later from setting</Text>
          </View>}
        </View>
        {this.state.isLoading && <ActivityIndicator color={"#000000"} />}
      </ScrollView>

    );
  }
}
export default SetGoal08Screen;
