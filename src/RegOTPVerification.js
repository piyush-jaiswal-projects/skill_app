import React from 'react';
import { ScrollView, View,PixelRatio, Image, StyleSheet, Text, TouchableOpacity, TextInput,ActivityIndicator,AsyncStorage} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import PrimaryButton from './component/Button';
import OtpInputs from './component/OTPComponent'
import Globalstyles from './vocabStyleSheet/styles';
import BackButton from './component/BackButton';
import OTPInputView from '@twotalltotems/react-native-otp-input'
import {TrackHistory} from './utill/Network'; 


const fontFactor = PixelRatio.getFontScale();
let username = "";
let name = "";
let email = "";
let country_calling_code = "";
class RegOTPVerification extends React.Component {
  constructor(props) {
    super(props);
    this.state={
      isLoading:false
    };

    username = this.props.route.params.username;
    name = this.props.route.params.name;
    email = this.props.route.params.email;
    country_calling_code = this.props.route.params.country_calling_code; 
  }
  state = { otp: '',otpMsg:"" };
  getOtp(otp) {
    console.log(otp);
    this.setState({ otp:otp });
  }

  onVerifyOtp = () => {

    if (typeof (this.state.otp) === 'undefined' ||  this.state.otp === '' || this.state.otp.length != 4) {
      this.setState({ otpMsg: global.TextMessages.OV_VALID_OTP});
    }else{

      if(this.props.route.params.isLogin == 1){
        var body_data = {
           mobile:username,
           otp:this.state.otp,
           email:email,
           
         }
         this.loadAPI('1',global.base_url+'userLogin',"POST",body_data);
      }else{
        var body_data = {
          mobile:username,
           otp:this.state.otp,
           name:name,
           email:email
         }
         console.log(JSON.stringify(body_data));
         this.loadAPI('2',global.base_url+'userRegister',"POST",body_data);

      }

    }
  }
  loadAPI = (data_type,url,method,body_data) => {

  this.setState({ isLoading: true });
  if(method == "GET")
  {
  fetch(url, {
    method: method,
    headers: {
      "Content-Type": "application/json",
      "token":global.token,
      "client_id":global.client_name,
    },
  })
  .then(response => response.json())
    .then(responseText => {
     this.setState({ isLoading:false});
      if(data_type === '1')
      {

      }
      else if(data_type === '2')
      {

      }
      else{
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
        "client_id":global.client_name,
      },
      body:JSON.stringify(body_data),

    })

    .then(response => response.json())
      .then(responseText => {
       this.setState({ isLoading:false});
        if(data_type === '1')
        {
          this.gotoDashboard(responseText);
        }
        else if(data_type === '2')
        {
          this.gotoSetGoal(responseText);
        }
        else if(data_type === '3')
        {
          
        }
        else if(data_type === '4')
        {
          
        }
        else
        {
          alert('unknown api call')
        }
      })
      .catch(error => {
        alert(error);
      });
  }
  };

  gotoDashboard=async(responseText)=>{

    var resp = responseText.data;
    if(responseText.code == 200){
      console.log(JSON.stringify(resp));
      if(resp.type === 'returned' && resp.name.length >0){

        AsyncStorage.setItem('user_id',resp.user_id.toString())
        global.token = resp.token;
        global.personalInfo.user_id = resp.user_id;
        global.personalInfo.user_name = resp.name;
        if(typeof(resp.is_completed_test) !== 'undefined' && resp.is_completed_test === 1){
          global.screenInfo.end_time = new Date().getTime();
            TrackHistory("Verify OTP","Click Verify","","","","OTPVerification","DashBoard");
           global.navigation.navigate('DashBoard');
        }
        else {
          global.screenInfo.end_time = new Date().getTime();
          TrackHistory("Verify OTP","Click Verify","","","","OTPVerification","CourseList");
           global.navigation.navigate('SetGoal01Screen',{parent:"RegOTPVerification"}); 
        }
      }
      else
      {
        
        // global.token = resp.token;
        // global.personalInfo.mobile = this.props.route.params.username;
        // global.personalInfo.user_id = resp.user_id;
        // global.screenInfo.end_time = new Date().getTime();
        // TrackHistory("Verify OTP","Click Verify","","","OTPVerification","SignupScreen");
        // global.navigation.navigate('SignupScreen',{isUpdate:1});
      }
    }
   else {  // for testing
     alert(JSON.stringify(resp.message));

   }

  }

  gotoSetGoal=(responseText)=>{
    //alert(JSON.stringify(responseText))
    if(responseText.code == 200){
      var resp = responseText.data;
      console.log(JSON.stringify(resp));
      AsyncStorage.setItem("user_id",resp.user_id.toString())
      global.token = resp.token;
      global.personalInfo.user_id = resp.user_id;
      global.personalInfo.user_name = resp.name;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("Verify OTP","Click Verify","","","","OTPVerification","CourseList");
      global.navigation.navigate('SetGoal01Screen',{parent:"RegOTPVerification"});
    }
   else {  // for testing
      //alert(JSON.stringify(responseText));
     console.log(JSON.stringify(responseText));
   }

  }

  resendOTP=()=>{

    TrackHistory("Resend OTP","Click Resend","","","","OTPVerification","");
    if(this.props.route.params.isLogin == 1){
      var body_data = {
        mobile:username,
        type:"login",
        email:email,
        country_calling_code:country_calling_code,
       }
       this.loadAPI('3',global.base_url+'generateOtp',"POST",body_data);
    }else{
      var body_data = {
        mobile:username,
        type:"register",
        email:email,
        country_calling_code:country_calling_code,
       }
       this.loadAPI('4',global.base_url+'generateOtp',"POST",body_data);
    }
  }
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }

  render() {
    return (
      <ScrollView style={Globalstyles.mainContainer}>
        <LinearGradient colors={["#f47920", "#d33131"]} style={Globalstyles.topView}>
        <View style={[Globalstyles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
                <View style={[Globalstyles.topView_bottom_TitleArrow,{marginLeft:10}]}>
                  <BackButton
                    text=''
                  />
                </View>
              </View>
        </LinearGradient>
        <Text style={[Globalstyles.headerTitle,{marginLeft:20,marginTop:-120}]} >{global.TextMessages.OV_VARIFICATION_ID}</Text>
        <View style={[Globalstyles.cornerContainer,{marginLeft:10,marginRight:10}]}>
          {/*<Text style={styles.enterTheCodeToVerifyYourAccount}>Enter the code to verify your account </Text>*/}
          {
            country_calling_code == 91 && 
           <View> 
          <Text style={[Globalstyles.DefaultSubText,{textAlign:"left",marginLeft: 20,marginTop: 10,marginBottom: 10,marginRight: 20}]}>{global.TextMessages.OV_MOBILE_SMS_MSG_ID}</Text>
          <View style={{flexDirection:"row",alignItems:"flex-start",alignSelf:"flex-start",marginStart:20}}>
          <Text style={Globalstyles.DefaultText}>{ username.replace(/(.{1,5})$/, function (matched) {return Array(matched.length+1).join("X");})}</Text>
          <Text onStartShouldSetResponder={() => global.navigation.goBack()} style={[Globalstyles.DefaultText,{color:"#f47920",marginLeft:10}]}>{global.TextMessages.OV_CHANGE_ID}</Text>
          </View>
          </View>
          }
          {
            country_calling_code != 91 && 
           <View> 
          <Text style={[Globalstyles.DefaultSubText,{textAlign:"left",marginLeft: 20,marginTop: 10,marginBottom: 10,marginRight: 20}]}>{global.TextMessages.OV_EMAIL_MSG_ID}</Text>
          <View style={{flexDirection:"row",alignItems:"flex-start",alignSelf:"flex-start",marginStart:20}}>
          <Text style={Globalstyles.DefaultText}>{ email.replace(/(.{1,5})$/, function (matched) {return Array(matched.length+1).join("X");})}</Text>
          <Text onStartShouldSetResponder={() => global.navigation.goBack()} style={[Globalstyles.DefaultText,{color:"#f47920",marginLeft:10}]}>{global.TextMessages.OV_CHANGE_ID}</Text>
          </View>
          </View>
          }
          {/* Platform.OS === 'android' &&
             <OtpInputs getOtp={(otp) => this.getOtp(otp)} />
          */}
          {/*Platform.OS === 'ios' && */
          <OTPInputView
              style={[Globalstyles.centerView,{height:60}]}
              pinCount={4}
              editable={true}
              code={this.state.code} //You can supply this prop or not. The component will be used as a controlled / uncontrolled component respectively.
              //onCodeChanged = {code => { this.getOtp({code})}}
              autoFocusOnLoad
              codeInputFieldStyle={{ fontSize:18,fontWeight:'bold',borderWidth: 1, borderRadius: 25, width: 50, height: 50, textAlign: "center", color: "#000000", backgroundColor:"#f6954c", borderColor: "#f6954c"}}
              onCodeFilled = {(code) => {

                this.setState({otp:code})
              }}
          />
          }
          
          <Text style={Globalstyles.errorTextStyle}>{this.state.otpMsg}</Text>

          <PrimaryButton
            text={global.TextMessages.OV_VERIFY_ID}
            onPress={() => this.onVerifyOtp()}
          />

        
        </View>


        
          <TouchableOpacity
            onPress={() => this.resendOTP()}
            underlayColor='#fff'>
            <Text style={Globalstyles.newHereCreateAccount}>{global.TextMessages.OV_RESEND_ID}</Text>
          </TouchableOpacity>
        
        {this.state.isLoading && <ActivityIndicator color={"#f47920"} />}

      {/*  <Text style={styles.resendOtp}>Resend OTP</Text>

        <View style={styles.saparator}>
          <View style={styles.hairline} />
          <Text style={styles.loginButtonBelowText1}>OR</Text>
          <View style={styles.hairline} />
        </View>

        <Text style={styles.resendOtp}>Resend OTP on email</Text>*/}

      </ScrollView>


    );
  }
}
export default RegOTPVerification;
