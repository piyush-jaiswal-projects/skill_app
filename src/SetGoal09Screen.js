import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,Dimensions} from 'react-native';
import BackButton from './component/BackButton';
import PrimaryButton from './component/Button';
import PrimarySkipButton from './component/skipButton';
import styles from './vocabStyleSheet/styles';
import moment from "moment";
import {TrackHistory} from './utill/Network'; 

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class SetGoal09Screen extends React.Component {
  constructor(props){
    super(props);

    this.state={
      isLoading:false,
    }
  }

  clickContinue=()=>{
    var body_data = {
        user_id:global.personalInfo.user_id,
        starttime:moment().format("HH:mm:ss DD-MM-YYYY"),
        endtime:moment().format("HH:mm:ss DD-MM-YYYY"),
        duration:"120",
        questions:"20",
        details:"Placement Test",
        canSkip:"yes",
        canReview:"yes"
    }
    this.loadAPI('1',global.base_url+'getPlacementTest',"POST",body_data);

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
      //alert(JSON.stringify(resp));
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory('take the test',"Click take the test","","","","Lets get stared","Placment Test");
      global.navigation.navigate('PlacementTest',resp)
    }
   else {

     }
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
                  text=''
                />
              </View>
            </View>
          </View>
         </ImageBackground>
         <Text style={[styles.headerTitle,{marginLeft:10,marginTop:-120}]}>{global.TextMessages.PPT_HEADERTEXT_ID}</Text>
         <Text style={[styles.HeaderSubTitle,{marginLeft:10}]} >{global.TextMessages.PPT_SUBHEADERTEXT_ID}</Text>

        <View style={[styles.cornerContainer]}>
        <View style={[styles.horizontalViewWithoutSpaceStyle]}>
          <Image style={styles.ins_icon} source={require('./Images/time_spent_2.png')}></Image>
          <Text style={styles.DefaultText} >{global.TextMessages.PPT_MESSAGE1TEXT1_ID}</Text>
        </View>

        <View style={[styles.horizontalViewWithoutSpaceStyle]}>
          <Image style={styles.ins_icon} source={require('./Images/vector_smart_object_2.png')}></Image>
          <Text style={[styles.DefaultText,{textAlign:"left"}]} >{global.TextMessages.PPT_MESSAGE1TEXT2_ID}</Text>
        </View>

        <View style={[styles.horizontalViewWithoutSpaceStyle]}>
          <Image style={styles.ins_icon} source={require('./Images/vector_smart_object.png')}></Image>
          <Text style={[styles.DefaultText,{textAlign:'left'}]} >{global.TextMessages.PPT_MESSAGE1TEXT3_ID}</Text>
        </View>
        <View style={[{margin:20}]}></View>

        <PrimaryButton
             text={global.TextMessages.PPT_BUTTONTEXT_ID}
             onPress={() =>this.clickContinue()}/>


      </View>
      </ScrollView>

    );
  }
}
export default SetGoal09Screen;
