import React from "react";
import {ScrollView,PixelRatio, View, Image, StyleSheet, Text, TouchableOpacity,Dimensions,TextInput,ActivityIndicator,AsyncStorage} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import PrimaryButton from './component/Button';
import BackButton from './component/BackButton';
import CheckBox from 'react-native-check-box'
import {TrackHistory} from './utill/Network'; 
import CountryPicker from 'react-native-country-picker-modal';
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view'

import PasswordTextWithShowHideIcon from './component/PasswordTextWithShowHideIcon';
import Globalstyles from './vocabStyleSheet/styles';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const fontFactor = PixelRatio.getFontScale();
let nameErrorMsg = "Name can not be empty";
let namespecialErrorMsg = "Special Character not allowed";
let mobileErrorMsg = "Mobile Number can not be empty";
let mobileEValidrrorMsg = "Mobile Number is not valid";
let emailEmptyMsg = "Email Address can not be empty";
let validemailErrorMsg = "Email Address is not valid";
let passwordErrorMsg = "Password can not be empty";
let confirmpasswordErrorMsg = "Confirm Password can not be empty";
let passwordMatchMsg = "Password & Confirm Password does not match";
let passwordValidMsg = "Password must have minimum 6 characters";
let TermsAcceptMsg = "Please accept Terma and Condition";

class SignupScreen extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      toggleCheckBox: global.toggleCheckBox,
      name: '',
      mobieNumber: '',
      password: '',
      confirmPassword: '',
      email: '',
      isShow: false,
      isShowConf: false,
      nameErrormsg: '',
      mobileErrorMsg: '',
      emailErrorMsg: '',
      passwordErrorMSg: '',
      confirmErrorMsg: '',
      termsErrorMsg: '',
      isLoading:false,

      cca2: 'IN',
      selCountery:null,
      country_name:"India",
      country_flag:"",
      country_code:"IN",
      calling_code:"91",
      otpMsg:"We will send an OTP to your mobile or email to validate.",

    };
     nameErrorMsg = global.TextMessages.SU_NAMEERROR_ID;
 namespecialErrorMsg = global.TextMessages.SU_SPECIAL_ID;
 mobileErrorMsg = global.TextMessages.SU_MOBILEEMPTY_ID;
 mobileEValidrrorMsg = global.TextMessages.SU_MOBILEVALID_ID;
 emailEmptyMsg = global.TextMessages.SU_EMAILEMPTY_ID;
 validemailErrorMsg = global.TextMessages.SU_EMAILVALID_ID;
 passwordErrorMsg = "Password can not be empty";
 confirmpasswordErrorMsg = "Confirm Password can not be empty";
 passwordMatchMsg = "Password & Confirm Password does not match";
 passwordValidMsg = "Password must have minimum 6 characters";
 TermsAcceptMsg = global.TextMessages.SU_ACCETERMSCONDITION_ID;
    
  }
  

  showHidePassword = () => {
    this.setState({ isShow: !this.state.isShow });
  }

  showHideConfPassword = () => {
    this.setState({ isShowConf: !this.state.isShowConf });
  }

  onSignup() {
    console.log("isUpdate"+this.props.route.params.isUpdate);
    if(this.props.route.params.isUpdate == 0)
    {
    
    if(this.state.calling_code == 91)
    { 
    var Mobilepattern = /^[0-9\b]+$/;
    var Emailpattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$/;
    var namePattern = /[^ 0-9a-zA-Z]/;
    if (this.state.name === '' || this.state.name.length < 1) {
      this.setState({ nameErrormsg: nameErrorMsg });
    }else if(namePattern.test(this.state.name)){
      this.setState({ nameErrormsg: namespecialErrorMsg });
    }else if (this.state.mobieNumber === '' || this.state.mobieNumber.length < 1) {
      this.setState({ mobileErrorMsg: mobileErrorMsg });
    } else if (isNaN(this.state.mobieNumber) || this.state.mobieNumber.length < 10) {
      this.setState({ mobileErrorMsg: mobileEValidrrorMsg });
    } else if (this.state.email.length > 0 && !Emailpattern.test(this.state.email)) {
      this.setState({ emailErrorMsg: validemailErrorMsg });
    }/* else if (this.state.password === '' || this.state.password.length < 1) {
      this.setState({ passwordErrorMSg: passwordErrorMsg });
    } else if (this.state.password.length < 6) {
      this.setState({ passwordErrorMSg: passwordValidMsg });
    } else if (this.state.confirmPassword === '' || this.state.confirmPassword.length < 1) {
      this.setState({ confirmpasswordErrorMsg: confirmpasswordErrorMsg });
    } else if (this.state.confirmPassword.length < 6) {
      this.setState({ confirmpasswordErrorMsg: passwordValidMsg });
    } else if (this.state.confirmPassword != this.state.password) {
      this.setState({ confirmpasswordErrorMsg: passwordMatchMsg });
    } */else if (!this.state.toggleCheckBox) {
      this.setState({ termsErrorMsg: TermsAcceptMsg });
    } else {
      var body_data = {
        mobile:this.state.mobieNumber,
        type:"register",
        email:this.state.email,
        country_calling_code:this.state.calling_code,
       }
       //alert(JSON.stringify(body_data));
       this.loadAPI('1',global.base_url+'generateOtp',"POST",body_data);
    }
  }
  else
  {
    var Mobilepattern = /^[0-9\b]+$/;
    var Emailpattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$/;
    var namePattern = /[^ 0-9a-zA-Z]/;
    if (this.state.name === '' || this.state.name.length < 1) {
      this.setState({ nameErrormsg: nameErrorMsg });
    }else if(namePattern.test(this.state.name)){
      this.setState({ nameErrormsg: namespecialErrorMsg });
    }else if (this.state.email === '' || this.state.email.length < 1) {
      this.setState({ emailErrorMsg: emailEmptyMsg });
    } else if (!Emailpattern.test(this.state.email)) {
      this.setState({ emailErrorMsg: validemailErrorMsg });
    }else if (this.state.mobieNumber.length > 0 && (isNaN(this.state.mobieNumber) || this.state.mobieNumber.length < 10)) {
      this.setState({ mobileErrorMsg: mobileEValidrrorMsg });
    } /* else if (this.state.password === '' || this.state.password.length < 1) {
      this.setState({ passwordErrorMSg: passwordErrorMsg });
    } else if (this.state.password.length < 6) {
      this.setState({ passwordErrorMSg: passwordValidMsg });
    } else if (this.state.confirmPassword === '' || this.state.confirmPassword.length < 1) {
      this.setState({ confirmpasswordErrorMsg: confirmpasswordErrorMsg });
    } else if (this.state.confirmPassword.length < 6) {
      this.setState({ confirmpasswordErrorMsg: passwordValidMsg });
    } else if (this.state.confirmPassword != this.state.password) {
      this.setState({ confirmpasswordErrorMsg: passwordMatchMsg });
    } */else if (!this.state.toggleCheckBox) {
      this.setState({ termsErrorMsg: TermsAcceptMsg });
    } else {
      var body_data = {
        mobile:this.state.mobieNumber,
        type:"register",
        email:this.state.email,
        country_calling_code:this.state.calling_code,
       }
       //alert(JSON.stringify(body_data));
       this.loadAPI('1',global.base_url+'generateOtp',"POST",body_data);
    }
  }

  }
  else
  {
    var Mobilepattern = /^[0-9\b]+$/;
    var Emailpattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$/;
    var namePattern = /[^ 0-9a-zA-Z]/;
    if (this.state.name === '' || this.state.name.length < 1) {
      this.setState({ nameErrormsg: nameErrorMsg });
    }else if(namePattern.test(this.state.name)){
      this.setState({ nameErrormsg: namespecialErrorMsg });
    }else if (this.state.mobieNumber === '' || this.state.mobieNumber.length < 1) {
      this.setState({ mobileErrorMsg: mobileErrorMsg });
    } else if (isNaN(this.state.mobieNumber) || this.state.mobieNumber.length < 10) {
      this.setState({ mobileErrorMsg: mobileEValidrrorMsg });
    } else if (this.state.email === '' || this.state.email.length < 1) {
      this.setState({ emailErrorMsg: emailEmptyMsg });
    } else if (!Emailpattern.test(this.state.email)) {
      this.setState({ emailErrorMsg: validemailErrorMsg });
    }/* else if (this.state.password === '' || this.state.password.length < 1) {
      this.setState({ passwordErrorMSg: passwordErrorMsg });
    } else if (this.state.password.length < 6) {
      this.setState({ passwordErrorMSg: passwordValidMsg });
    } else if (this.state.confirmPassword === '' || this.state.confirmPassword.length < 1) {
      this.setState({ confirmpasswordErrorMsg: confirmpasswordErrorMsg });
    } else if (this.state.confirmPassword.length < 6) {
      this.setState({ confirmpasswordErrorMsg: passwordValidMsg });
    } else if (this.state.confirmPassword != this.state.password) {
      this.setState({ confirmpasswordErrorMsg: passwordMatchMsg });
    } */else if (!this.state.toggleCheckBox) {
      this.setState({ termsErrorMsg: TermsAcceptMsg });
    } else {
    var body_data = {
      name:this.state.name,
      email:this.state.email,
      user_id:global.personalInfo.user_id
     }
     this.loadAPI('2',global.base_url+'userUpdate',"POST",body_data);
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
        this.loadCourseList(responseText);
      }
      else if(data_type === '2')
      {
        this.nextScreen(responseText);
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
       console.log("RegisterResponse"+JSON.stringify(responseText))
        if(data_type === '1')
        {
          this.nextScreen(responseText);
        }
        else if(data_type === '2')
        {
          this.GoToGoalSetup(responseText);
        }
        else{
          alert('unknown api call')
        }
      })
      .catch(error => {
        alert(error);
      });
  }
  };

  nextScreen=(responseText)=>{
    if(responseText.code == 200){
      var resp = responseText.data;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("Create Account","Click Create Account","","","","SignupScreen","OTPVerification");
      global.navigation.navigate('RegOTPVerification',{username:this.state.mobieNumber,email:this.state.email,name:this.state.name,isLogin:0,country_calling_code:this.state.calling_code});
    }
   else {  // for testing
    var resp = responseText.data;
     alert(JSON.stringify(resp.message));
   }

  }

  GoToGoalSetup=(responseText)=>{
    if(responseText.code == 200){
      var resp = responseText.data;
      console.log(JSON.stringify(resp));
      AsyncStorage.setItem('user_id',resp.user_id.toString())
      global.personalInfo.username = this.state.name;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("Update Account","Click Update Account","","","","SignupScreen","CourseList");
      global.navigation.navigate('SetGoal01Screen',{parent:"RegOTPVerification"});  
    }
   else {  // for testing
     alert(JSON.stringify(responseText));
   }

  }

  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }



  render() {
    var btnName='';
    if(this.props.route.params.isUpdate == 0)
    {
      btnName = "Create Account";
    }
    else
    {
      btnName = "Update Account";
    }
    
    if(global.personalInfo.mobile.length>3)
    {
      this.state.mobieNumber = global.personalInfo.mobile;
    }

    return (
      <KeyboardAwareScrollView>
      <ScrollView style={Globalstyles.mainContainer}>
        <LinearGradient colors={["#f47920", "#d33131"]} style={[Globalstyles.topView,{height:250}]}>
        
        <View style={[Globalstyles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30}]}>
          <View style={[Globalstyles.topView_bottom_TitleArrow,{marginLeft:10}]}>
            <BackButton
             text=''
            />
          </View>
          </View>
        </LinearGradient>

        <Text style={[Globalstyles.headerTitle,{marginLeft:20,marginTop:-160}]}>{global.TextMessages.SI_CREATEACC_ID}</Text>
    <Text style={[Globalstyles.HeaderSubTitle,{marginLeft:20}]}>{this.state.otpMsg}</Text>
    
        <View style={[Globalstyles.cornerContainer,{marginLeft:10,marginRight:10}]}>

        <View style= {[Globalstyles.signup_textfieldStyle,{marginBottom:20,paddingLeft:10,paddingTop:0}]}>
        <CountryPicker
         containerButtonStyle={[Globalstyles.DefaultBoldText,{height:40,padding:0}]}
          countryCode={this.state.country_code}
          withCountryNameButton
          withAlphaFilter
          withEmoji
          onSelect={(val) => {
            this.setState({selCountery: val,
                          country_name: val.name,
                          country_flag:val.flag,
                          country_code:val.cca2,
                          calling_code:val.callingCode[0],
                         })}}
        />
        </View>

          <Text style={Globalstyles.textField_titleStyle}>{global.TextMessages.SU_FULLNAME_ID}</Text>
          <TextInput
            style={Globalstyles.signup_textfieldStyle}
            onChangeText={(name) => { this.setState({ name: name }); name.length > 0 ? this.setState({ nameErrormsg: "" }) : this.setState({ nameErrormsg: nameErrorMsg }) }}
            placeholder=""
            defaultValue={this.state.name}
          />
          <Text style={Globalstyles.errorTextStyle}>{this.state.nameErrormsg}</Text>



          {
           
           this.state.calling_code == 91 && 
           <View> 
          <Text style={Globalstyles.textField_titleStyle}>{global.TextMessages.SU_MOBILE_ID}</Text>
        
          <TextInput
            style={Globalstyles.signup_textfieldStyle}
            placeholder=""
            editable={this.props.route.params.isUpdate==0?true:false}
            defaultValue={this.state.mobieNumber}
            onChangeText={(mno) => { this.setState({ mobieNumber: mno }); mno.length > 0 ? this.setState({ mobileErrorMsg: "" }) : this.setState({ mobileErrorMsg: mobileErrorMsg }) }}
          />
          <Text style={Globalstyles.errorTextStyle}>{this.state.mobileErrorMsg}</Text>
          <Text style={Globalstyles.textField_titleStyle}>{global.TextMessages.SU_EMAILOPTIONAL_ID}</Text>
          <TextInput
            style={Globalstyles.signup_textfieldStyle}
            onChangeText={(email) => { this.setState({ email: email }); }}
            placeholder=""
            defaultValue={this.state.email} />
          <Text style={Globalstyles.errorTextStyle}>{this.state.emailErrorMsg}</Text>
          </View> 
          }

          {
             
           this.state.calling_code != 91 && 
           <View> 
           <Text style={Globalstyles.textField_titleStyle}>{global.TextMessages.SU_EMAIL_ID}</Text>
            <TextInput
            style={Globalstyles.signup_textfieldStyle}
            onChangeText={(email) => { this.setState({ email: email }); email.length > 0 ? this.setState({ emailErrorMsg: "" }) : this.setState({ emailErrorMsg: emailEmptyMsg }) }}
            placeholder=""
            defaultValue={this.state.email} />
            <Text style={Globalstyles.errorTextStyle}>{this.state.emailErrorMsg}</Text>


          <Text style={Globalstyles.textField_titleStyle}>{global.TextMessages.SU_MOBILE_OPTIONAL_ID}</Text>
        
          <TextInput
            style={Globalstyles.signup_textfieldStyle}
            placeholder=""
            editable={this.props.route.params.isUpdate==0?true:false}
            defaultValue={this.state.mobieNumber}
            onChangeText={(mno) => { this.setState({ mobieNumber: mno });}}
          />
          <Text style={Globalstyles.errorTextStyle}>{this.state.mobileErrorMsg}</Text>
          
          </View> 
          }

         {/* <Text style={styles.textField_titleStyle}>Password</Text>

          <PasswordTextWithShowHideIcon
            text={this.state.password}
            isShow={this.state.isShow}
            style={Globalstyles.textField_titleStyle}
            onPress={this.showHidePassword}
            onChange={(value) => { this.setState({ password: value }); value.length > 0 ? this.setState({ passwordErrorMSg: "" }) : this.setState({ passwordErrorMSg: passwordErrorMsg }) }}
            state={this.state}
            placeholder=""
          />
          <Text style={Globalstyles.errorTextStyle}>{this.state.passwordErrorMSg}</Text>
          <Text style={styles.textField_titleStyle}>Confirm password</Text>

          <PasswordTextWithShowHideIcon
            text={this.state.confirmPassword}
            isShow={this.state.isShowConf}
            style={Globalstyles.textField_titleStyle}
            onPress={this.showHideConfPassword}
            onChange={(value) => { this.setState({ confirmPassword: value }); value.length > 0 ? this.setState({ confirmpasswordErrorMsg: "" }) : this.setState({ confirmpasswordErrorMsg: confirmpasswordErrorMsg }) }}
            state={this.state}
            placeholder=""
          />
          <Text style={Globalstyles.errorTextStyle}>{this.state.confirmpasswordErrorMsg}</Text>*/}

          <View style={[styles.termsViewStyle, { marginTop: 10 }]}>
          <CheckBox
            style={styles.checkbox}
            onClick={() =>this.setState({ toggleCheckBox: !this.state.toggleCheckBox, termsErrorMsg: '' })}
            isChecked={this.state.toggleCheckBox}
            leftText=""
            />

            <TouchableOpacity
              onPress={() => {TrackHistory("Click Terms & Condition","Click TermsCondition","","","","SignupScreen","TermsCondition");
              global.navigation.navigate('TermsCondition',{parent:"Register"}); }}
              underlayColor='#fff'>
              <Text style={[Globalstyles.DefaultSubText,{ justifyContent: "center", alignItems: "center",paddingTop:3 }]}>{global.TextMessages.SU_IAGREE_ID} <Text style={Globalstyles.termsandCondition}>{global.TextMessages.SU_TERMSCONDITION_ID}</Text></Text>
            </TouchableOpacity>
          </View>
          <Text style={Globalstyles.errorTextStyle}>{this.state.termsErrorMsg}</Text>
        </View>


          <PrimaryButton
            text = {btnName}
            onPress={() => this.onSignup()}
          />
        { <View style={[Globalstyles.centerView,{marginTop:15,justifyContent: "center"}]}>
          <TouchableOpacity
            onPress={() => global.navigation.navigate("SigninScreen")}
            underlayColor='#fff'>
            <Text style={Globalstyles.DefaultText}>{global.TextMessages.SU_ALRHAVE_ID} <Text style={[Globalstyles.DefaultText,{color: "#ff7200"}]}>{global.TextMessages.SU_LOGINHERE_ID}</Text></Text>
          </TouchableOpacity>
        </View>}
        
          {this.state.isLoading && <ActivityIndicator color={"#f47920"} />}

      </ScrollView>
      </KeyboardAwareScrollView>


    );
  }
}

const styles = StyleSheet.create({
  
  checkbox: {
    alignSelf: "center",
    height: 20,
    width: 20,
    marginEnd: 10
  },
   
  signupViewStyle: {
    marginLeft: 10,
    marginBottom: 10,
    marginRight: 10,
    width: '100%',
    height: 40,
    alignItems: 'center',

  },


  termsViewStyle: {
    marginLeft: 10,
    marginBottom: 10,
    marginTop: -10,
    marginRight: 10,
    width: '100%',
    flexWrap: "wrap",
    flexDirection: "row",
  },
});

export default SignupScreen;
