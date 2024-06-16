import React from 'react';
import {View,ScrollView,PixelRatio,Image,StyleSheet,Text,TouchableOpacity,Dimensions} from 'react-native';
import {LinearGradient} from 'expo-linear-gradient';
import PrimaryButton from './component/Button';
import Globalstyles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network';


const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const fontFactor = PixelRatio.getFontScale();
class welcomeScreen extends React.Component {
  constructor(props){
      super(props);

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
        else
        {
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
          "token":global.token,
          "client_id":global.client_name,
        },
        body:JSON.stringify(body_data),

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
    };

    componentDidMount() {

      global.screenInfo.start_time = new Date().getTime();
      global.screenInfo.end_time = "";
      var body_data1 = {
        app_id:'1',
        lang_id:'1'
       }
      this.loadAPI('1',global.base_url+'getIntro',"POST",body_data1);
    }

  render() {
    return (

      <ScrollView style={Globalstyles.mainContainer}>
        <LinearGradient colors={["#f47920", "#d33131"]} style={[Globalstyles.topView,{height:300}]}>
          <View style={[Globalstyles.horizontalViewStyle,{ marginTop:20 }]}>
            <Image style={[Globalstyles.centerLogo,{paddingLeft:-20,width:80,marginLeft:0,justifyContent:"flex-start"}]} resizeMode="contain" source={require('./Images/logo.png')}></Image>
            <Text style={[Globalstyles.headerTitle,{marginTop:5,marginLeft:75,textAlign:"left"}]}>{global.TextMessages.WL_APPNAME_ID} <Text style={[styles.DefaultSubText,{color: "#ffffff",fontSize:14/fontFactor,fontWeight:"normal"}]}></Text></Text>
          </View>
      </LinearGradient>
      
      <View style={[Globalstyles.cornerContainer,{ padding:20,flex: 1, marginBottom:5,marginLeft: 10, marginRight: 10 ,marginTop:-200}]}>
           <View style={styles.secondInsView}>
              <View style={styles.firstComponantView}>
                <Image style={styles.secondImgView} source={require('./Images/layer_30.png')} resizeMode="contain"></Image>
              </View>
              <View style={styles.SecondComponantView}>
                  <Text style={Globalstyles.welcome_learn}>{global.TextMessages.WL_PRACTICE1_ID} </Text>
                  <Text style={Globalstyles.welcome_learn_desc}>{global.TextMessages.WL_VALUE1_ID}</Text>
              </View>
           </View>
           <View style={styles.secondInsView}>
              <View style={styles.SecondComponantView}>
                  <Text style={Globalstyles.welcome_learn}>{global.TextMessages.WL_PRACTICE2_ID} </Text>
                  <Text style={Globalstyles.welcome_learn_desc}>{global.TextMessages.WL_VALUE2_ID}</Text>
              </View>
              <View style={[styles.firstComponantView]}>
                <Image style={styles.secondImgView} source={require('./Images/layer_33.png')} resizeMode="contain"></Image>
              </View>
           </View>
           <View style={styles.secondInsView}>
              <View style={styles.firstComponantView}>
                <Image style={styles.secondImgView} source={require('./Images/layer_29.png')} resizeMode="contain"></Image>
              </View>
              <View style={styles.SecondComponantView}>
                  <Text style={Globalstyles.welcome_learn}>{global.TextMessages.WL_PRACTICE3_ID} </Text>
                  <Text style={Globalstyles.welcome_learn_desc}>{global.TextMessages.WL_VALUE3_ID}</Text>
              </View>
           </View>
       </View>


      <PrimaryButton
        text={global.TextMessages.WL_CREATEACC_ID}
        onPress={() => {
                        global.screenInfo.end_time = new Date().getTime();
                        TrackHistory("Create Account","Click Started","","","","WelcomeScreen","SignupScreen");
                        global.navigation.navigate('SignupScreen',{isUpdate:0})
                      }}

      />

      <View style={[Globalstyles.centerView, { marginTop: 10, marginBottom: 50 }]}>
          <TouchableOpacity
            onPress={() => {
              global.screenInfo.end_time = new Date().getTime();
              TrackHistory("SignIn","Click SignIn","","","","WelcomeScreen","SignScreen");
              global.navigation.navigate('SigninScreen')
            }}
            underlayColor='#fff'>
            <Text style={Globalstyles.DefaultText}>{global.TextMessages.WL_LOGINTEXT1_ID} <Text style={[styles.DefaultText,{color: "#ff7200"}]}>{global.TextMessages.WL_LOGINTEXT2_ID}</Text></Text>
          </TouchableOpacity>
      </View>

    <Text style={[Globalstyles.DefaultSubText,{textAlign:"center",marginBottom:0}]}>{global.TextMessages.WL_POWEREDBY_ID}</Text>

      </ScrollView>

    );
  }
}

const styles = StyleSheet.create({

 secondInsView:{
   alignItems: 'center',
   width:'100%',
   flexWrap: 'wrap',
   flex:1,
   flexDirection: 'row',

 },

 firstComponantView:{
      width: '50%',
      flexWrap:'wrap',

  },
  SecondComponantView:{
      width: '50%',
  },
 secondImgView:{
   marginTop:0,
   marginLeft:5,
   position:'relative',
   width:'80%',
   height:150,

 }
});

export default welcomeScreen;
