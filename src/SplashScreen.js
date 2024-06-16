
import React from 'react';
import { View, ImageBackground, Image, Dimensions, Text, AsyncStorage, Platform } from 'react-native';
import styles from './vocabStyleSheet/styles';
import Constants from 'expo-constants';
import * as Location from 'expo-location';
import * as Permissions from 'expo-permissions';
import { TrackHistory } from './utill/Network';


//import storageObj from './storage/storage';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class SplashScreen extends React.Component {
  constructor(props) {
    super(props);
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
          if (data_type === '1') {
          }
          else if (data_type === '2') {
            var resp = responseText.data;
            console.log(responseText);
            if (responseText.code != 200) {
            }
            else {
            }
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
          if (data_type === '1') {
            console.log(responseText);
            var resp = responseText.data;
            if (typeof resp.token == 'undefined' || responseText.code != 200) {
              setTimeout(function () {
                {
                  global.screenInfo.end_time = new Date().getTime();
                  TrackHistory("", "AutoNavigate", "", "", "", "SplashScreen", "WelcomeScreen");
                  global.navigation.navigate('welcomeScreen');
                }
              }, 4000);

            }
            else {
              setTimeout(function () {
                global.token = resp.token;
                global.personalInfo.user_id = resp.user_id;
                global.personalInfo.user_name = resp.name;
                if (typeof (resp.is_completed_test) !== 'undefined' && resp.is_completed_test === 1) {
                  global.screenInfo.end_time = new Date().getTime();
                  TrackHistory("", "AutoNavigate", "", "", "", "SplashScreen", "DashBoard");
                  global.navigation.navigate('DashBoard');
                }
                else {
                  global.screenInfo.end_time = new Date().getTime();
                  TrackHistory("", "AutoNavigate", "", "", "", "SplashScreen", "SetGoal");
                  global.navigation.navigate('SetGoal01Screen', { parent: "RegOTPVerification" });
                }

              }, 4000);
              // var body_data = {
              // }
              // this.loadAPI('2', global.base_url+'getAppConfig?app_id=1', "GET", body_data);
            }
          }
          // else if (data_type === '2') {
          //   console.log(responseText);
          //   var resp = responseText.data;
          //   if (responseText.code != 200) {
          //   }
          //   else {
          //   }
          // }
          // else if (data_type === '3'){
          //   var resp = responseText.data;
          //   if (responseText.code != 200) {
          //     alert("We are facing some issue. Please try again after some time.");
          //   }
          //   else {
          //     global.TextMessages =  responseText.data;
          //     console.log(global.TextMessages);
          //     var body_data1 = {
          //       app_id: '1'
          //     }
          //     this.loadAPI('2', global.base_url+'getSplash', "POST", body_data1);
          //     var body_data = {
          //       user_id: global.personalInfo.user_id,
          //       app_version: '1'
          //     }
          //     this.loadAPI('1', global.base_url+'gettoken', "POST", body_data);
          //   }
          // }
          else {
            alert('unknown api call')
          }
        })
        .catch(error => {
          alert(error);
        });
    }
  };
  getLocationAsync = async () => {

    let { status } = await Permissions.askAsync(Permissions.LOCATION);
    if (status !== 'granted') {
      this.setState({
        errorMessage: 'Permission to access location was denied',
      });
    }
    else {
      let location = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.Low });
      console.log(JSON.stringify(location));
      const { latitude, longitude } = location.coords
      global.personalInfo.latitude = latitude;
      global.personalInfo.longitude = longitude;
      this.getGeocodeAsync({ latitude, longitude })
    }
  };

  getGeocodeAsync = async (location) => {
    let geocode = await Location.reverseGeocodeAsync(location)
    console.log(JSON.stringify(geocode));
    global.country_code = geocode[0].isoCountryCode;
    global.personalInfo.city = geocode[0].city;
    global.personalInfo.country = geocode[0].country;
  }
  componentDidMount() {
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    this.getLocationAsync();
    AsyncStorage.getItem('user_id').then((value) => {
      if (value === null)
        global.personalInfo.user_id = 0
      else
        global.personalInfo.user_id = value;
  
      //var body_data = {
      //  app_id: '1'
      //}
      //this.loadAPI('3', global.base_url+'getMessages', "POST", body_data);
      // var body_data1 = {
      //   app_id: '1'
      // }
      // this.loadAPI('2', global.base_url+'getSplash', "POST", body_data1);
      var body_data = {
        user_id: global.personalInfo.user_id,
        app_version: '1',
        client_id:"",
        licence_key:""
      }
      this.loadAPI('1', global.base_url+'gettoken', "POST", body_data);

    });
  }
  render() {

    return (
      <View style={styles.spalsh}>
        <ImageBackground style={[styles.splash_logo, { flex: 1, width: screenWidth, height: screenHeight }]} source={require('./Images/group_1.jpg')}>
          <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', paddingTop: 40 }}>
            <Image style={{ width: 109, height: 90 }} source={require('./Images/vocab_logo.png')} resizeMethod="auto" />
            <Text style={[styles.DefaultText, { textAlign: "center", color: "#ffffff", paddingTop: 5, paddingRight: 20 }]}>Vocab Edge</Text>
            <Text style={[styles.DefaulSubtText, { textAlign: "center", color: "#ffffff", paddingTop: 5, paddingRight: 20 }]}></Text>
            <Text style={[styles.DefaulSubtText, { textAlign: "center", color: "#ffffff", bottom: 30, position: 'absolute' }]}>Powered by LIQVID</Text>
          </View>
        </ImageBackground>
      </View>
    );
  }
}
export default SplashScreen;
