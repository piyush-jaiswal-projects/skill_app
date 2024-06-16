import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,Dimensions} from 'react-native';
import BackButton from './component/Cus_BackButton';
import PrimaryButton from './component/Button';
import PrimarySkipButton from './component/skipButton';
import styles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network'; 

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class ThankYouTest extends React.Component {
  constructor(props){
    super(props);

    this.state={
      isLoading:false,
    }
  }

  clickContinue=()=>{
    global.screenInfo.end_time = new Date().getTime();
    TrackHistory("Continue","Click Continue","","","","ThankYouTest","Step1");
      global.navigation.navigate('SetGoal03Screen')

  }
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }
  render() {
    return (
      <ScrollView style={[styles.mainContainer,{width:screenWidth}]}>
        <ImageBackground style={[styles.logo]} source={require('./Images/setGoal_09.png')}>
        <View style={styles.topView}>
        <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  onPress={() => {
                    
                    global.screenInfo.end_time = new Date().getTime();
                    TrackHistory("Back","Click Back","","","","ThankYouTest","Courselist");
                    global.navigation.navigate('SetGoal01Screen',{parent:"ThanksYouTest"})
                  }}
                  text=''
                />
              </View>
            </View>
          </View>
         </ImageBackground>
         <Text style={[styles.headerTitle,{marginLeft:10,marginTop:-120,}]} >Thank you for taking
the test. </Text>
      <View style={[styles.cornerContainer,{flex:1,flexDirection:'column',marginTop:30}]}>
      <View style={{marginTop:30,marginRight:30,marginLeft:30}}>
        <Image style={[styles.medium_ins_icon,{flex:10}]} source={require('./Images/personalize_icon.png')}></Image>
        <View style={{marginTop:10}}></View>
        <Text style={[styles.Title,{textAlign:'left',color:"#4e4e4e",flex:10}]} >Now let us help create a personalised learning path for you in few steps - will take 2-3 minutes.</Text>
       <View style={{marginTop:100}}></View>
       </View>

       <View style={[{flex:3}]}>
       <PrimaryButton
            text='Continue'
            onPress={() =>this.clickContinue()}/>
      </View>

      </View>
      </ScrollView>

    );
  }
}
export default ThankYouTest;
