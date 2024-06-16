import React, { useState } from "react";
import {ScrollView,Picker,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,Dimensions} from 'react-native';
import PrimaryButton from './component/Button';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';
import { Dialog } from 'react-native-simple-dialogs';
import StepCounter from './component/StepCounter';
import StepIndicator from 'react-native-step-indicator';
import Modal from 'react-native-modal';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const labels = ["","","","","","",""];
const customlevelStyles = {
  stepIndicatorSize: 25,
  currentStepIndicatorSize:50,
  separatorStrokeWidth: 2,
  currentStepStrokeWidth: 3,
  stepStrokeCurrentColor: '#ffffff',
  stepStrokeWidth: 3,
  stepStrokeFinishedColor: '#aaaaaa',
  stepStrokeUnFinishedColor: '#aaaaaa',
  separatorFinishedColor: '#aaaaaa',
  separatorUnFinishedColor: '#aaaaaa',
  labelAlign:'flex-start',
  stepIndicatorFinishedColor: '#ffffff',
  stepIndicatorUnFinishedColor: '#ffffff',
  stepIndicatorCurrentColor: '#ffffff',
  stepIndicatorLabelFontSize: 13,
  currentStepIndicatorLabelFontSize: 13,
  stepIndicatorLabelCurrentColor: '#ffffff',
  stepIndicatorLabelFinishedColor: '#ffffff',
  stepIndicatorLabelUnFinishedColor: '#aaaaaa',
  labelColor: '#999999',
  labelSize: 13,
  levels :[],
  currentStepLabelColor: '#fe7013'
}


const putTickIndicator = ()=> {
    return <Image source={require('./Images/currentLevelStep.png')} style={{height:40, width:40}}/>
  }
class SetLevelScreen extends React.Component {
  constructor(props){
    super(props);

    //placeObj = {}this.props.route.params.placedObj;
    this.state = {
     currentPosition: 6,
     currentLevelPosition:3,
     isShowcefr :false,
   };
  }
  showPopUp = () => {
    this.setState({isShowcefr:!this.state.isShowcefr});

  };
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
          this.loadLevelList(responseText);
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
  };

  loadLevelList=(responseText)=>{

    if(responseText.code == 200){
      var resp = responseText.data;
      var _levels = [];
      var count = 0;
      for (let userObject of resp.reverse()) {

          if(userObject.cefr_id === global.personalInfo.current_level_id)
          {
            global.personalInfo.current_level_text = userObject.cefrDetails;
            this.setState({currentLevelPosition:count});
          }
          count++;
          var str =  `${userObject.cefrName} ${userObject.cefrDetails}`
        _levels.push(str);
       }
      this.setState({levels:_levels});
    }
   else {  // for testing
   }

  }
  componentDidMount() {
    var body_data = {
      app_id:"1"
     }
     this.loadAPI('1',global.base_url+'getLevelList',"POST",body_data);
  }

  render() {
   return (


    <ScrollView style={[styles.mainContainer,{width:screenWidth}]}>
    <ImageBackground style={[styles.logo]} source={require('./Images/setGoal_09.png')}>
   </ImageBackground>

    <Text style={[styles.headerTitle,{marginLeft:10,marginTop:-160,}]} >Good Job {global.personalInfo.user_name.toUpperCase()}!{"\n"} Let’s start your journey at the {global.personalInfo.current_level_text} level {global.personalInfo.current_level}</Text>
    <TouchableOpacity onPress={() =>this.showPopUp()} underlayColor='#fff'>
       <View style={[styles.messageView,{marginLeft:10}]}>
       <Image style={styles.ilogoStyle} source={require('./Images/cefr_info.png')}></Image>
       <Text style={styles.messageAndDataRatesMayApply}>What is CEFR?</Text>
       </View>
    </TouchableOpacity>



      <View style={styles.cornerContainer}>
      <View style={{height:350}}>
      <StepIndicator
         customStyles={customlevelStyles}
         currentPosition={this.state.currentLevelPosition}
         direction={"vertical"}
         stepCount={6}
         renderStepIndicator={putTickIndicator}
         labels={this.state.levels}
      />
      </View>
      <View style={styles.centerView}>
      <Text style={styles.DefaultText} >That was a good try! Let’s get started from {global.personalInfo.current_level} level</Text>
      </View>

       <PrimaryButton
           text='Continue'
           onPress={() => global.navigation.navigate('GoalSummary')}
         />
      
      <View style={styles.lowerStepView}>
      <StepCounter
      currentPostion={this.state.currentPosition}
      counter={7}
      labels={labels}
       />
      </View>
     </View>
     <Modal isVisible={this.state.isShowcefr}>
       <View style={{ flex: 1 }}>
       </View>
       <View style={[styles.modalViewStyle,{flex: 3}]}>
       <View style={[styles.horizontalViewStyle, {flex:1,justifyContent:'flex-end'}]}>
           <TouchableOpacity
              activeOpacity={1}
              style={[styles.wordblank]} onPress={() =>this.showPopUp()}>
                 <Image style={[styles.modalCloseStyle]} source={require('./Images/popup_close.png')}></Image>
            </TouchableOpacity>

       </View>
       <Text style={[styles.DefaultText,{flex:2,textAlign:'left',marginLeft:5}]}>What is CEFR?</Text>
       <Text style={[styles.DefaultSubText,{flex:5,textAlign:'left',marginLeft:5}]}>The Common European Framework of Reference for Languages (CEFR) is an international standard for describing language ability. It describes language ability on a six-point scale, from A1 for beginners, up to C2 for those who have mastered a language. </Text>
       <Image style={[{flex:10,width:'100%'}]} source={require('./Images/memoryGoal.png')}></Image>

       </View>
       <View style={{ flex: 1 }}>
       </View>
     </Modal>
    </ScrollView>
    );
  }
}
export default SetLevelScreen;
