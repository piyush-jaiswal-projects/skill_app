
import React from 'react';
import { Alert, View, StyleSheet, Platform, NativeModules, BackHandler } from 'react-native';
import AnimatedLoader from "react-native-animated-loader";
import * as Location from 'expo-location';
import * as Permissions from 'expo-permissions';


class AppFlow extends React.Component {
  constructor(props) {
    super(props);
    this.state = { visible: false };
    console.log("Native Parameters : " + JSON.stringify(this.props));
    global.navigation = this.props.navigation;
    global.sdk_license = this.props["route"].params.sdk_license;
    global.base_url = this.props["route"].params.sdk_url;
    global.course_code = this.props["route"].params.course_code;
    global.client_name = this.props["route"].params.client_name;
    global.theme = this.props["route"].params.theme;
    global.TextMessages = "";
    global.colors = "",
      global.isLoggedout = false;
    global.knowWordAlertCount = 0;
    global.toggleCheckBox = false;
    global.screenInfo = {
      start_time: "",
      end_time: "",
    };
    global.token = "";
    global.app_id = "";
    global.language_id = "";
    global.courseid = "";
    global.setG_num_of_days = "";
    global.setG_startDate = "";
    global.setG_endDate = "";
    global.setG_weekdayArr = [];
    global.setG_weekendArr = [];
    global.WordArray = [];
    global.isWordToggle = true;
    global.personalInfo = {
      score: 0,
      user_name: "",
      email_id: "",
      mobile: "",
      image: "",
      user_id: '',
      age: '0',
      gender: 'm',
      education: "",
      language: "",
      country: "",
      employment: "",
      lat: '',
      lng: '',
      city: 'Delhi',
      country: 'India',
      country_code: 'IN',
      calling_code: '91',
      current_level_id: "",
      current_level: "",
      current_level_text: "",
      target_level_id: "5",
      target_level: "",
      target_level_text: "",

    };
    global.dayArr = [
      {
        id: '1',
        title: 'Monday',
        isSelected: true,
      },
      {
        id: '2',
        title: 'Tuesday',
        isSelected: true,
      },
      {
        id: '3',
        title: 'Wednesday',
        isSelected: true,
      },
      {
        id: '4',
        title: 'Thursday',
        isSelected: true,
      },
      {
        id: '5',
        title: 'Friday',
        isSelected: true,
      },
      {
        id: '6',
        title: 'Saturday',
        isSelected: true,
      },
      {
        id: '7',
        title: 'Sunday',
        isSelected: true,
      }
    ];

  }

  handleBackButton = () => {
    //add your code
    BackHandler.exitApp();
    return true;
  };

  loadAPI = (data_type, url, method, body_data) => {
    if (method == "POST") {
      console.log("request" + JSON.stringify(body_data));
      fetch(url, {
        method: method,
        headers: {
          "Content-Type": "application/json",
          "token": global.token,
          "client_id": global.client_name,
          "sdk_license": global.sdk_license,
        },
        body: JSON.stringify(body_data),

      })
        .then(response => response.json())
        .then(responseText => {
          console.log("respose" + JSON.stringify(responseText));
          if (data_type === '1') {
            var resp = responseText.data;
            if (responseText.code != 200) {
              this.setState({ visible: false });
              Alert.alert(
                "",
                "Something went wrong please try again later.",
                [
                  {
                    text: "OK", onPress: () => {
                      if (Platform.OS == 'android') {
                        this.handleBackButton();

                      } else {
                        let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                        DismissViewControllerManager.goBack();
                      }
                    }
                  }
                ],
                { cancelable: false }
              );
            }
            else {
              global.TextMessages = responseText.data;
              if (global.client_name == 'wiley' || global.client_name == 'scholar') {
                var body_data = {
                  user_id: this.props["route"].params.user_id,
                  app_version: '01',
                  client_id: global.client_name,
                  license_key: global.sdk_license,
                }
                console.log("Request new User" +JSON.stringify(body_data));
                this.loadAPI('2', global.base_url + 'gettoken', "POST", body_data);
              }
              else {
                this.setState({ visible: false });
                global.navigation.navigate('SplashScreen');
              }
            }
          }
          else if (data_type === '3') {
            var resp = responseText.data;
            console.log(resp);
            if (responseText.code != 200) {
              this.setState({ visible: false });
              Alert.alert(
                "",
                "Something went wrong please try again later.",
                [
                  {
                    text: "OK", onPress: () => {
                      if (Platform.OS == 'android') {
                        this.handleBackButton();

                      } else {
                        let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                        DismissViewControllerManager.goBack();
                      }
                    }
                  }
                ],
                { cancelable: false }
              );
            }
            else {
              this.setState({ visible: false });
              var body_data = {
                user_id: this.props["route"].params.user_id,
                app_version: '01',
                client_id: global.client_name,
                license_key: global.sdk_license,
              }
             
              this.loadAPI('2', global.base_url + 'gettoken', "POST", body_data);
            }
          }
          else if (data_type === '2') {
            var resp = responseText.data;
            if (responseText.code != 200) {
              this.setState({ visible: false });
              Alert.alert(
                "",
                "Something went wrong please try again later.",
                [
                  {
                    text: "OK", onPress: () => {
                      if (Platform.OS == 'android') {
                        this.handleBackButton();

                      } else {
                        let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                        DismissViewControllerManager.goBack();
                      }
                    }
                  }
                ],
                { cancelable: false }
              );

            }
            else {
              this.setState({ visible: false });
              var resp = responseText.data;
              if (resp.ErrCode != null && typeof (resp.ErrCode) != 'undefined' && resp.ErrCode == "ERR_VALID" || resp.ErrCode == "ERR_NON_AUTH") {
                Alert.alert(
                  "",
                  resp.message,
                  [
                    {
                      text: "OK", onPress: () => {
                        if (Platform.OS == 'android') {
                          this.handleBackButton();

                        } else {
                          let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                          DismissViewControllerManager.goBack();
                        }
                      }
                    }
                  ],
                  { cancelable: false }
                );
              }
              else if (resp.ErrCode != null && typeof (resp.ErrCode) != 'undefined' && resp.ErrCode == "ERR_NOT_EXIST") {
                
                var body_data = {
                  client_id: global.client_name,
                  license_key: global.sdk_license,
                  user_id: this.props["route"].params.user_id,
                  first_name: this.props["route"].params.user_name,
                  course_code:this.props["route"].params.course_code,
                  last_name: '',
                  gender: '',
                  age: '',
                  education: '',
                  employment: '',
                  nationality: '',
                  state: '',
                  city: '',

                }
                this.loadAPI('3', global.base_url + 'userslientregister', "POST", body_data);
              }
              else {
                this.setState({ visible: false });
                global.token = resp.token;
                global.personalInfo.user_id = resp.user_id;
                global.navigation.navigate('DashBoard');
              }


            }
          }
        })
        .catch(error => {
          Alert.alert(
            "",
            "Something went wrong please try again later.",
            [
              {
                text: "OK", onPress: () => {
                  if (Platform.OS == 'android') {
                    this.handleBackButton();

                  } else {
                    let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                    DismissViewControllerManager.goBack();
                  }
                }
              }
            ],
            { cancelable: false }
          );
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
    this.getLocationAsync();
    if (global.client_name == 'wiley' || global.client_name == 'scholar') {
      global.personalInfo.user_name = this.props["route"].params.user_name;
      global.personalInfo.email_id = this.props["route"].params.email_id;
      global.personalInfo.mobile = this.props["route"].params.mobile;
      global.personalInfo.image = this.props["route"].params.image;
      global.base_url = this.props["route"].params.sdk_url;
      this.setState({ visible: true });     
      console.log("Current Server URL :====> " + global.base_url);
      if (global.theme == 'wiley') {
        global.colors = {
          DS_LINEAR_START: "#f47920",//#f47920
          DS_LINEAR_END: "#d33131",//#d33131
          PRI_BTN_BGCOLOR: "#ff7200",//#ff7200
          OVERALL_CIR_BGCOLOR: "#c94620",//"#c94620"
          OVERALL_CIR_FILLCOLOR: "#fdcd19",//#fdcd19"
          WORDS_NUMBER: "#fe7201",// "#fe7201"
          WORDS_CIR_FILLCOLOR: "#e96026",//#e96026"
          TS_CIR_FILLCOLOR: "#ed6924",//#ed6924"
          QB_CHOSE_TEXTCOLOR: "#fe7201",//#fe7201
          WL_SLETD_BGCOLOR: "#00b8d4",//#00b8d4
          DRAWER_MENU_ICON_CLR: "#f47920",//#00b8d4
        }
      } else {
        global.colors = {
          DS_LINEAR_START: "#214a82",//#f47920
          DS_LINEAR_END: "#1e4478",//#d33131
          PRI_BTN_BGCOLOR: "#cd2443",//#ff7200
          OVERALL_CIR_BGCOLOR: "#1e3e6b",//"#c94620"
          OVERALL_CIR_FILLCOLOR: "#fdcd19",//#fdcd19"
          WORDS_NUMBER: "#cd2443",// "#fe7201"
          WORDS_CIR_FILLCOLOR: "#cd2443",//#e96026"
          TS_CIR_FILLCOLOR: "#cd2443",//#ed6924"
          QB_CHOSE_TEXTCOLOR: "#cd2443",//#fe7201
          WL_SLETD_BGCOLOR: "#00b8d4",//#00b8d4
          DRAWER_MENU_ICON_CLR: "#214a82",//#00b8d4
        }
      }
    }
    else {
      global.base_url = "https://vocab.englishedge.in/";
      console.log("Current Server URL :====> " + global.base_url);
      global.colors = {
        DS_LINEAR_START: "#f47920",//#f47920
        DS_LINEAR_END: "#d33131",//#d33131
        PRI_BTN_BGCOLOR: "#ff7200",//#ff7200
        OVERALL_CIR_BGCOLOR: "#c94620",//"#c94620"
        OVERALL_CIR_FILLCOLOR: "#fdcd19",//#fdcd19"
        WORDS_NUMBER: "#fe7201",// "#fe7201"
        WORDS_CIR_FILLCOLOR: "#e96026",//#e96026"
        TS_CIR_FILLCOLOR: "#ed6924",//#ed6924"
        QB_CHOSE_TEXTCOLOR: "#fe7201",//#fe7201
        WL_SLETD_BGCOLOR: "#00b8d4",//#00b8d4
        DRAWER_MENU_ICON_CLR: "#f47920",//#00b8d4
      }
    }
    var body_data = {
      app_id: '1'
    }
    this.loadAPI('1', global.base_url + 'getMessages', "POST", body_data);

  }
  render() {
    const { visible } = this.state;
    return (
      <View>
        <AnimatedLoader
          visible={visible}
          overlayColor={global.colors.DS_LINEAR_START}
          source={require("./Images/loader.json")}
          animationStyle={styles.lottie}
          speed={1}
        >
        </AnimatedLoader>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  lottie: {
    width: 500,
    height: 200
  }
});
export default AppFlow;
