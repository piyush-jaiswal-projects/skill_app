import React , { useState } from 'react';
import { ScrollView, View,PixelRatio, Image,Text, TextInput,Dimensions,Button,StatusBarIOS,ActivityIndicator} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { TouchableOpacity } from 'react-native-gesture-handler'
import PrimaryButton from './component/Button';
import BackButton from './component/BackButton';
import PrimarySkipButton from './component/skipButton';
import PasswordTextWithShowHideIcon from './component/PasswordTextWithShowHideIcon';
import CountryPicker from 'react-native-country-picker-modal';
import styles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network'; 
const fontFactor = PixelRatio.getFontScale();
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
let usernameErrorMsg = "";
let usernameValidMsg = "";
let emailErrorMsg = "";
let emailValidMsg = "";

class SigninScreen extends React.Component {


  constructor(props) {
    super(props);

    this.state = {
      username: '',
      email:'',
      password: '',
      isShow: false,
      usernameMsg: '',
      passwordMsg: '',
      cca2: 'IN',
      selCountery:null,
      country_name:"India",
      country_flag:"",
      country_code:"IN",
      calling_code:"91",
      isLoading:false,
    };

    usernameErrorMsg = global.TextMessages.SI_USERNAMEERRORMSG_ID;
    usernameValidMsg = global.TextMessages.SI_USERNAMEVALIDMSG_ID;
    emailErrorMsg = global.TextMessages.SI_EMAILERRORMSG_ID;
    emailValidMsg = global.TextMessages.SI_EMAILVALIDMSG_ID;


  }
  onSignInPress = () => {
    var Emailpattern = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;

    if (this.state.calling_code == 91 && (this.state.username === '' || this.state.username.length < 1)) {
      this.setState({ usernameMsg: usernameErrorMsg });
    } else if (this.state.calling_code == 91 && (isNaN(this.state.username)?!Emailpattern.test(this.state.username):this.state.username.length<10)) {
      this.setState({ usernameMsg: usernameValidMsg });
    }else if (this.state.calling_code != 91 && (this.state.email === '' || this.state.email.length < 1)) {
      this.setState({ usernameMsg: emailErrorMsg });
    }else if (this.state.calling_code != 91 && (isNaN(this.state.email)?!Emailpattern.test(this.state.email):this.state.email.length<10)) {
      this.setState({ usernameMsg: emailValidMsg });
    }else{
        var body_data = {
          mobile:this.state.username,
          type:"login",
          email:this.state.email,
          country_calling_code:this.state.calling_code,
         }
         //alert(JSON.stringify(body_data));
         this.loadAPI('1',global.base_url+'generateOtp',"POST",body_data);
      //
    }




  /*  if (this.state.username === '' || this.state.username.length < 1) {
      this.setState({ usernameMsg: usernameErrorMsg });
    } else if (this.state.password === '' || this.state.password.length < 1) {
      this.setState({ passwordMsg: passwordErrorMsg });
    } else {
      alert(this.state.calling_code);
      global.navigation.navigate('DashBoard');

    }*/
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
        if(data_type === '1')
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
  };

  nextScreen=(responseText)=>{
    if(responseText.code == 200){
      var resp = responseText.data;
      console.log(JSON.stringify(resp));
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("Get OTP","Click Get OTP","","","","SignScreen","OTPVerification");
      global.navigation.navigate('RegOTPVerification',{email:this.state.email,username:this.state.username,name:"",isLogin:1,country_calling_code:this.state.calling_code});
    }
   else {  // for testing
    var resp = responseText.data;
     alert(resp.message);
   }

  }





  showHidePassword = () => {
    this.setState({ isShow: !this.state.isShow });
  }

  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }

  render() {
    return (
      <ScrollView style={styles.mainContainer}>

        <LinearGradient colors={["#f47920", "#d33131"]} style={[styles.topView,{height:250}]}>
        <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30}]}>
          <View style={[styles.topView_bottom_TitleArrow,{marginLeft:10}]}>
            <BackButton
             text=''
            />
          </View>
          </View>
      </LinearGradient>

        <Text style={[styles.headerTitle, { marginLeft:20,marginTop:-140 }]} >{global.TextMessages.SI_HEADERMSG_ID}</Text>
        <View style={[styles.cornerContainer, { flex: 1, marginLeft: 10, marginRight: 10 }]}>
        <View style= {[styles.textfieldStyle,{paddingLeft:15,paddingTop:0}]}>
        <CountryPicker
         containerButtonStyle={[styles.DefaultBoldText,{height:40,padding:0}]}
          countryCode={this.state.country_code}
          withCountryNameButton
          withAlphaFilter
          withEmoji
          onSelect={(val) => {this.setState({selCountery: val,country_name: val.name,country_flag:val.flag,country_code:val.cca2,calling_code:val.callingCode[0]})}}
        />
        </View>
        {
          this.state.calling_code == 91 && 
          <View>
            <View style={[styles.horizontalViewStyle,styles.textfieldStyle,{justifyContent:"flex-start",padding:0,alignItems:'center'}]}>
            <Text style={[styles.DefaultBoldText,{marginLeft:10,marginRight:10}]}>+{this.state.calling_code}</Text>
            <TextInput style={[styles.DefaultBoldText,{textAlign:"left",flex:1}]} defaultValue={this.state.username} placeholder={global.TextMessages.SI_MOBILEPLACEHOLDER_ID} onChangeText={(username) => { this.setState({ username: username }); username.length > 0 ? this.setState({ usernameMsg: "" }) : this.setState({ usernameMsg: usernameErrorMsg }) }}></TextInput>
            </View>
         </View>

        }

        {
          this.state.calling_code != 91 && 
          <View>
            <View style={[styles.horizontalViewStyle,styles.textfieldStyle,{justifyContent:"center",padding:0,alignItems:'center'}]}>
            <TextInput style={[styles.DefaultBoldText,{marginLeft:10,textAlign:"left",flex:1}]} defaultValue={this.state.email} placeholder={global.TextMessages.SI_EMAILPLACEHOLDER_ID} onChangeText={(email) => { this.setState({ email: email }); email.length > 0 ? this.setState({ usernameMsg: "" }) : this.setState({ usernameMsg: emailErrorMsg }) }}></TextInput>
            </View>
         </View>

        }
        <Text style={styles.errorTextStyle}>{this.state.usernameMsg}</Text>


          <PrimaryButton
              text='Get OTP'
              onPress={() => this.onSignInPress()}
            />
          <View style={[styles.messageView, { justifyContent: 'flex-start', marginLeft: 30, marginTop: 10, marginBottom: 0, marginRight: 10, width: '90%' }]}>
            <Image style={styles.ilogoStyle} source={require('./Images/i.jpg')}></Image>
            <Text style={[styles.messageAndDataRatesMayApply, { color: "#4e4e4e" }]}>{global.TextMessages.SI_DATARATES_ID}</Text>
          </View>

        </View>


        {<View style={[styles.centerView, { marginTop: 10, marginBottom: 50 }]}>
          <TouchableOpacity
            onPress={() => {
              global.screenInfo.end_time = new Date().getTime();
              TrackHistory("Create Account","Click Create Account","","","","SignScreen","SignupScreen");
              global.navigation.navigate('SignupScreen',{isUpdate:0})
            }}
            underlayColor='#fff'>
            <Text style={styles.DefaultText}>{global.TextMessages.SI_NEWHERE_ID} <Text style={[styles.DefaultText,{color: "#ff7200"}]}>{global.TextMessages.SI_CREATEACC_ID}</Text></Text>
          </TouchableOpacity>
          </View>
        }

        
        <Text style={[styles.DefaultSubText,{padding:0,bottom:30,textAlign:"center",color:'#4e4e4e'}]}>{global.TextMessages.SI_BYPROCESSDING_ID}  
        <TouchableOpacity style={{paddingTop:10}} onPress={() => {global.navigation.navigate('ViewTermsCondition',{parent:"Register"})}} >
        <Text  style={[styles.newHereCreateAccount]}> {global.TextMessages.SI_TERSCONDI_ID}<Text style={{color:"#4e4e4e"}}>{global.TextMessages.SI_AND_ID}</Text></Text>
        </TouchableOpacity>
        
        <TouchableOpacity style={{padding:0}} onPress={() => { global.navigation.navigate('privacy',{parent:"Register"})}} >
        <Text style={styles.newHereCreateAccount}> {global.TextMessages.SI_PRIVACYPOLICY_ID}</Text>
        </TouchableOpacity>
        </Text>
        {this.state.isLoading && <ActivityIndicator color={"#f47920"} />}
      </ScrollView>

    );
  }
}
export default SigninScreen;
