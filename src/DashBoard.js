import React from 'react';
import {NativeModules,Share, FlatList,Alert, ScrollView, View, StyleSheet, PixelRatio, Text, Image, TouchableOpacity, Animated, Dimensions, BackHandler,AsyncStorage,Platform } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import BackButton from './component/Cus_BackButton'
import { AnimatedCircularProgress } from 'react-native-circular-progress';
import PrimaryButton from './component/Button';
import g_styles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network';
const fontFactor = PixelRatio.getFontScale();
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

import * as pkg from '../app.json';

const DATA = [
  {
    id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
    date: 'Monday',
    day: '18',
    percentage: '50'
  },
  {
    id: '3ac68afc-c605-48d3-a4f8-fbd91aa97f63',
    date: 'Tuesday',
    day: '19',
    percentage: '30'
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d72',
    date: 'Wednesday',
    day: '20',
    percentage: '90'
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d721',
    date: 'Thruday',
    day: '21',
    percentage: '20'
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d722',
    date: 'Friday',
    day: '22',
    percentage: '70'
  },
];
const Item = ({ title }) => (
  //<TouchableOpacity onPress={() => global.navigation.navigate('SetGoal02Screen')}>
  <View style={[styles.item,{padding:5,paddingTop:5,paddingBottom:5}]}>
    <Text style={styles.dayTextstyle}>{title.day}</Text>
    <Text style={styles.dateTextStyle}>{title.date}</Text>
    <View style={styles.container}>
      <Animated.View
        style={[
          styles.inner, {backgroundColor:global.colors.PRI_BTN_BGCOLOR,width: (title.percentage>100?100:title.percentage) + "%" },
        ]}
      />
    </View>
    <Text style={[styles.dayTextstyle,{marginTop:3}]}>{title.no_of_session+""+(title.no_of_session>1?" "+global.TextMessages.DS_LOWER_SESSIONCARD_SESSIONS_ID:" "+global.TextMessages.DS_LOWER_SESSIONCARD_SESSION_ID)}</Text>
  </View>
  //</TouchableOpacity>
);
const renderItem = ({ item }) => (
  <Item title={item} />
);

class DashBorad extends React.Component {
  constructor(props) {
    super(props);
    global.navigation = this.props.navigation;
    this.state = {
      isShowDrawer: 0,
      total_word: 10,
      completed_word: 5,
      overallLearning: "0",
      total_time: 300,
      time_spent: 10,
      today_total_word: 20,
      today_learned_word: 5,
      today_total_time: 15,
      today_time_spent: 600,
      averageTimeSpent:5,
      setTimeGoal:15,
      learntDayCount:10,
      activeDaysCount:30,
      targetLevel:"C2",
      targetDescription:"Proficency",
      user_level:global.personalInfo.current_level,
      userLevel_description:global.personalInfo.current_level_text,
      day_learn_data: [

      ]

    };
  }


  onShare = async () => {
    try {
      Share.share({
        ...Platform.select({
          ios: {
            message: global.TextMessages.DS_APPSHAREMSG_ID,
            url: 'https://apps.apple.com/us/app/vocab-edge/id1077263799',
          },
          android: {
            message: global.TextMessages.DS_APPSHAREMSG_ID +'\n https://play.google.com/store/apps/details?id=com.liqvid.vocab'
          }
        }),
        title: 'Vocab Edge'
      }, {
        ...Platform.select({
          ios: {
            // iOS only:
          
          },
          android: {
            // Android only:
            dialogTitle: 'Vocab Edge' 
          }
        })
      });
    } catch (error) {
      alert(error.message);
    }
  };


  
  toggleDrawer = () => {
    if (this.state.isShowDrawer === 1)
      this.setState({ isShowDrawer: 0 });
    else
      this.setState({ isShowDrawer: 1 });
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
            if (responseText.code == 200) {
              console.log("getLearningDayWise API ");
              console.log(JSON.stringify(responseText.data))
              this.setState({ day_learn_data: responseText.data.day_learn_percentage,averageTimeSpent:responseText.data.averageDailyTimeSpent,setTimeGoal:responseText.data.SetTimeforDaily,learntDayCount:responseText.data.LearnDays,activeDaysCount:responseText.data.TotalActiveDays })
            }
          } else if (data_type === '2') {
            if (responseText.code == 200) {
              console.log("getOverallLearning API ")
              console.log(JSON.stringify(responseText));
              this.setState({
                total_word: responseText.data.total_learning_word,
                completed_word: responseText.data.learning_word,
                overallLearning: responseText.data.overall_learning,
                total_time: responseText.data.total_session,
                time_spent: responseText.data.session_completed
              })
            }
          } else if (data_type === '3') {
            if (responseText.code == 200) {
              console.log("getTodayLearning API ")
              
              console.log(JSON.stringify(responseText.data))
              this.setState({
                today_total_word: responseText.data.today_total_word,
                today_learned_word: responseText.data.learning_word,
                today_total_time: responseText.data.today_total_time, // average time set by user in Goal summary
                today_time_spent: responseText.data.today_max_time     // spent by user in day 
              })
            }
          }
          else if (data_type === '4') {
            if(responseText.code==200){
              console.log("USer Data"+JSON.stringify(responseText.data));
              global.personalInfo.email_id=responseText.data.email;
              global.personalInfo.user_id=responseText.data.user_id;
              global.personalInfo.age=responseText.data.age;
              global.personalInfo.gender=responseText.data.gender;
              global.personalInfo.education=responseText.data.education!=null?responseText.data.education:"";
              global.personalInfo.employment=responseText.data.profession!=null?responseText.data.profession:"";
              global.personalInfo.language=responseText.data.language!=null?responseText.data.language:"";
              global.personalInfo.lat=responseText.data.latitude;
              global.personalInfo.lng=responseText.data.longitude;
              global.personalInfo.country =responseText.data.city!=null?responseText.data.city:"";
              global.personalInfo.image=responseText.data.profile_pic;
              global.personalInfo.current_level_id=responseText.data.groupid;
              global.personalInfo.target_level_id=responseText.data.target_level_id;
              this.loadAPI('5',global.base_url+'getLevelList',"POST",{app_id:"1"});
              // global.personalInfo.current_level_text=responseText.data.age;
          }
        }
        else if (data_type === '5') {

          if(responseText.code==200){
            var resp = responseText.data;
            var target_Level = "";
            for (let userObject of resp.reverse()) {
                console.log("Level "+userObject.cefr_id);
                if(userObject.cefr_id === global.personalInfo.current_level_id)
                {
                  global.personalInfo.current_level_text = userObject.cefrDetails;
                  global.personalInfo.current_level=userObject.cefrName;                  
                }
                if(userObject.cefr_id == global.personalInfo.target_level_id)
                {
                  console.log(userObject.cefrName + "TargetLevel "+global.personalInfo.target_level_id);
                  target_Level = userObject.cefrName+" "+userObject.cefrDetails;
                }
             }
             this.setState({user_level:global.personalInfo.current_level,userLevel_description:global.personalInfo.current_level_text,targetLevel:target_Level});
        }
      }
      else if (data_type === '6') {

        if(responseText.code==200){
          console.log("userlevels: "+JSON.stringify(responseText));
          var resp = responseText.data;
          global.personalInfo.current_level_id =   resp.current_level_id;
          global.personalInfo.target_level_id =    resp.target_level_id;
          global.personalInfo.current_level_text = resp.current_level_cefrDetails;
          global.personalInfo.current_level =      resp.current_level_cefrName;
          global.personalInfo.target_level_text = resp.target_level_cefrDetails;
          global.personalInfo.target_level =      resp.target_level_cefrName;
          var target_Level = global.personalInfo.target_level+" "+resp.target_level_cefrDetails;
          this.setState({user_level:global.personalInfo.current_level,userLevel_description:global.personalInfo.current_level_text,targetLevel:target_Level});
      }
    }
        })
        .catch(error => {
        });
    }
  };


  onButtonPress = () => {
    BackHandler.removeEventListener('hardwareBackPress', this.handleBackButton);
    // then navigate
    navigate('NewScreen');
  }
  handleBackButton = () => {
    //add your code
    BackHandler.exitApp();
    return true;
};

  componentDidMount() {

    this._unsubscribe = navigation.addListener('focus', () => {
      
      BackHandler.addEventListener('hardwareBackPress', this.handleBackButton);
      global.screenInfo.start_time = new Date().getTime();
      global.screenInfo.end_time = "";
      this.setState({ isShowDrawer: 0 });
      var body_data = {
        user_id: global.personalInfo.user_id,
      }
      if(global.client_name == "liqvid")
       this.loadAPI('4', global.base_url+'getUserDetail', "POST", body_data);     
      else
      this.loadAPI('6', global.base_url+'getUserLevels', "POST", body_data); 
      

       this.loadAPI('1', global.base_url+'getLearningDayWise', "POST", body_data);
       this.loadAPI('2', global.base_url+'getOverallLearning', "POST", body_data);
       this.loadAPI('3', global.base_url+'getTodayLearning', "POST", body_data);

      // do something
    });

    this._unsubscribe = navigation.addListener('blur', () => {
      BackHandler.removeEventListener('hardwareBackPress', this.handleBackButton);
    });
  }

  logOutPress=()=>
  {
    AsyncStorage.clear();
    global.token = "";
    global.token = "";
    global.app_id = "";
    global.language_id = "";
    global.courseid = "";
    global.setG_num_of_days = "";
    global.setG_weekdayArr = [];
    global.setG_weekendArr = [];
    global.personalInfo.user_name = ""
    global.personalInfo.email_id = "";
    global.personalInfo.user_id = '0';
    global.personalInfo.age = '25';
    global.personalInfo.gender = 'male';
    global.personalInfo.education = '';
    global.personalInfo.employment = '';
    global.personalInfo.lat = '';
    global.personalInfo.lng = '';
    global.personalInfo.image = '';
    global.isLoggedout = true;
    global.dayArr=[{id: '1',title: 'Monday',isSelected:false,},{id: '2',title: 'Tuesday',isSelected:false,},{id: '3',title: 'Wednesday',isSelected:false,},{id: '4',title: 'Thrusday',isSelected:false,},{id: '5',title: 'Friday',isSelected:false,},{id: '6',title: 'Saturday',isSelected:false,},{id: '7',title: 'Sunday',isSelected:false,}];
    global.navigation.popToTop();
    global.navigation.navigate('welcomeScreen');
  }


  logout = () => {
    Alert.alert(
      global.TextMessages.DS_LOGOUT_ALERTTITLE_ID,
      global.TextMessages.DS_LOGOUT_ALERTMSG_ID,
      [
        {
          text: global.TextMessages.DS_LOGOUT_ALERT_OK_ID,
          onPress: () => this.logOutPress()
        },
        {
          text: global.TextMessages.DS_LOGOUT_ALERT_CANCEL_ID,
          onPress: () => console.log('Cancel Pressed'),
          style: 'cancel'
        },
      ],
      { cancelable: false }
    );
  };

  onPress = () => {
    global.screenInfo.end_time = new Date().getTime();
    global.navigation.navigate("TodaySession");
    TrackHistory("ContinueLearning","Click","","","","Dashboard","TodaySession");
  }

  onAnimate = () => {
    this.anim.addListener(({ value }) => {
      this.setState({ progressStatus: parseInt(value, 10) });
    });
    Animated.timing(this.anim, {
      toValue: 100,
      duration: 50000,
      useNativeDriver: true,
    }).start();
  }


  render() {
    return (
      <View style={styles.mainContainer}>
        <ScrollView>
          <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={styles.topView}>
          
            <View style={[{ flex: 1, flexDirection: 'row' }]}>
              <View style={[styles.upperBand, { width: "80%", alignItems: "flex-start",flexDirection:"column" }]}>
              { global.client_name != "liqvid" ?
                <View>
                <View style={{flexDirection:"row"}}>
                  <View style={{marginTop:30}}>
                 <BackButton
                    text=''
                    onPress={() => {
                      if(Platform.OS == 'android'){
                        this.handleBackButton();
                      
                      }else{
                        let DismissViewControllerManager = NativeModules.DismissViewControllerManager;
                      DismissViewControllerManager.goBack();
                      }
                    }}
                    />
                    </View>
                <Text style={[g_styles.DefaultText,{color:"#ffffff",marginTop:25,fontWeight:"bold"}]}>
                  {this.state.user_level}
                </Text>
                <Text style={[g_styles.DefaultText,{color:"#ffffff",marginTop:25}]}>
                   {" "+this.state.userLevel_description}
                </Text>
                </View>
                <Text style={[g_styles.list_title_Description,{color:"#ffffff",marginTop:0,marginLeft:50}]}>
                  {global.TextMessages.DS_TAGET_ID+" "+this.state.targetLevel}
                </Text>
                </View>:
                 <View>
                <View style={{flexDirection:"row"}}>
                
                <Text style={[g_styles.DefaultText,{color:"#ffffff",marginTop:25,fontWeight:"bold"}]}>
                  {this.state.user_level}
                </Text>
                <Text style={[g_styles.DefaultText,{color:"#ffffff",marginTop:25}]}>
                   {" "+this.state.userLevel_description}
                </Text>
                </View> 
                <Text style={[g_styles.list_title_Description,{color:"#ffffff",marginTop:0}]}>
                {global.TextMessages.DS_TAGET_ID+" "+this.state.targetLevel}
              </Text>
              </View> 
              }
                
              </View>
              
              <View onStartShouldSetResponder={() => this.toggleDrawer()} style={{ alignItems: "flex-end", width: "20%", justifyContent: "center" }}>
                <Image style={[g_styles.hamburgIcon, { marginTop: 30, marginRight: 20 }]} source={require('./Images/hamburg.png')} />
              </View>
            </View>



            <View style={styles.sliderView}>
              <View style={{flex: 1, justifyContent: "flex-start", alignItems: "flex-end", width: "30%", flexDirection: "column-reverse", paddingEnd: 10 }}>
                <Text style={[styles.wordsLearned]}>
                  {global.TextMessages.DS_WORDLEARNT_TEXT_ID}
                        </Text>
                <View style={{ flexDirection: "row", justifyContent: "center", alignItems: "center" }}>
                  <Image style={[styles.ins_icon, {width: 22, height: 28 }]} source={require('./Images/book_yellow.png')}></Image>
                  <View style={{ flexDirection: "column" }}>
                    <Text style={styles.layer}>
                      {this.state.completed_word}
                    </Text>
                    <Text style={styles.of300}>
                      of {this.state.total_word}
                    </Text>
                  </View>
                </View>
              </View>
              <View style={{ alignItems: "center", justifyContent: "center", width: "40%" }}>
                {true && <AnimatedCircularProgress
                  size={125}
                  width={8}
                  fill={this.state.overallLearning}
                  tintColor={global.colors.OVERALL_CIR_FILLCOLOR}
                  rotation={0}
                  onAnimationComplete={() => console.log('')}
                  backgroundColor={global.colors.OVERALL_CIR_BGCOLOR}
                  style={{ justifyContent: "center" }}
                />}

               {false && <AnimatedCircularProgress
                  size={150}
                  width={8}
                  fill={this.state.overallLearning+"%"}
                  tintColor={global.colors.OVERALL_CIR_FILLCOLOR} 
                  rotation={0}
                  onAnimationComplete={() => console.log('')}
                  backgroundColor={global.colors.OVERALL_CIR_BGCOLOR}
                  style={{ justifyContent: "center", position: 'absolute' }}
                />}

                <View style={{ justifyContent: "center", position: 'absolute' }}>
                  <Text style={styles.completionPercentValue}>
                    {this.state.overallLearning+"%"}
                  </Text>
                  <Text style={styles.ofOverallLearning}>
                  {global.TextMessages.DS_OVERALL_LEARNING_TEXT_ID}
                                    </Text>
                </View>

              </View>

              <View style={{ flex: 1, justifyContent: "flex-end", width: "30%", paddingEnd: 10 }}>
                <View style={{ flex: 1, justifyContent: "flex-start", alignItems: "flex-end", width: 100, flexDirection: "column-reverse" }}>
                  <Text style={[styles.wordsLearned,{width:150,textAlign:'right'}]}>
                  {global.TextMessages.DS_UPPER_SESSIONS_TEXT_ID}
                                </Text>
                  <View style={{ flexDirection: "row", justifyContent: "center", alignItems: "center" }}>
                    <Image style={[styles.ins_icon, { width: 24, height: 28 }]} source={require('./Images/session_icon.png')}></Image>
                    <View style={{ flexDirection: "column" }}>
                      <Text style={styles.layer}>
                        {this.state.time_spent}
                      </Text>
                      <Text style={styles.of300}>
                        of {this.state.total_time}
                      </Text>
                    </View>
                  </View>
                </View>
              </View>
            </View>

          </LinearGradient>

          <View style={{ flexDirection: "row", alignItems: "center", justifyContent: "space-between", paddingStart: 10, paddingEnd: 10 }}>
            <View style={{ height: 240, width: '49%', marginTop: -120, flexDirection: 'column', justifyContent: "space-between" }}>
              <Text style={styles.todaysLearning}>
              {global.TextMessages.DS_TODAYLEARNING_ID}
                            </Text>
              <View style={[{ backgroundColor: "#ffffff", borderRadius: 25, flex: 1, width: "100%", flexDirection: 'column', marginTop: 10 }, styles.shadowStyel]}>
                <View style={{ flexDirection: "row", width: "100%", padding: 20, justifyContent: "flex-end" }}>
                  <Text style={[styles.words, {textAlign:'left',width: "70%" }]}>
                  {global.TextMessages.DS_WORDS_ID}</Text>
                  <Image style={[styles.image_right, { width: 18, height: 23, alignSelf: "flex-end", marginRight: 0 }]} source={require('./Images/book_black.png')}></Image>
                </View>
                <View style={{ alignItems: "center", justifyContent: "center", flex: 1 }}>
                  <AnimatedCircularProgress
                    size={120}
                    width={8}
                    fill={this.state.today_learned_word * 100 / this.state.today_total_word}
                    tintColor={global.colors.TS_CIR_FILLCOLOR}
                    rotation={0}
                    onAnimationComplete={() => console.log('')}
                    backgroundColor="#eeeeee"
                    style={{ justifyContent: "center" }}
                  />
                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    <Text style={[styles.wordsCountValue,{color: global.colors.WORDS_NUMBER,marginTop:-10}]}>
                      {this.state.today_learned_word}
                    </Text>
                    <Text style={styles.smalltext}>
                      of {this.state.today_total_word} words
                                            </Text>
                  </View>

                </View>
              </View>
            </View>
            <View style={[{ backgroundColor: "#ffffff", borderRadius: 25, height: 240, width: "49%", marginTop: -120, flexDirection: "column", padding: 20 }, styles.shadowStyel]}>
              <View style={{ flexDirection: "row", width: "100%" }}>
                <Text style={[styles.words, { width: "60%" }]}>
                {global.TextMessages.DS_TIMESPENT_ID}
                                    </Text>
                <Image style={[styles.image_right, { marginRight: 0 ,resizeMode:'contain'}]} source={require('./Images/time_spent_2.png')}></Image>
              </View>
              <View style={{ alignItems: 'center', justifyContent: 'center', flex: 1, marginTop: 30 }}>
                <AnimatedCircularProgress
                  size={150}
                  width={8}
                  arcSweepAngle={180}
                  fill={Math.floor(this.state.today_time_spent) * 100 / this.state.today_total_time}
                  tintColor="#00a5a4"
                  rotation={-90}
                  onAnimationComplete={() => console.log('')}
                  backgroundColor="#eeeeee"
                  style={{ justifyContent: "center" }}
                />

                <View style={{ justifyContent: "center", position: 'relative', marginTop: -125 }}>
                  <Text style={[styles.wordsCountValue,{color: global.colors.WORDS_NUMBER,marginTop: 10}]}>
                    {Math.floor(this.state.today_time_spent / 60) + ":" + (this.state.today_time_spent - (Math.floor(this.state.today_time_spent / 60) * 60))}
                  </Text>
                  <Text style={[styles.smalltext,{marginLeft:8,marginEnd:8}]}>
                    of your {this.state.today_total_time/ 60}-min daily goal
                                            </Text>
                </View>

              </View>
            </View>

          </View>

            <PrimaryButton
              text={global.TextMessages.DS_CONT_LEARNING_ID}
              onPress={this.onPress}
            />
          

          {/*<View style={[styles.reviewView, styles.shadowStyel]}>

            <Text style={styles.letsReiterate}>
              Let's Reiterate
                    </Text>
            <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
            <View style={{ flexDirection: "row", width: "100%", justifyContent: "space-between" }}>
              <Text style={{ marginStart: 20, marginTop: 10, flex: 1, fontSize: 15 / fontFactor }}>
                Let us now reinforce some of the words
                you missed you missed and need some
                additional practice on.
                        </Text>
              <Image style={{ marginLeft: 30, alignSelf: 'flex-end', marginRight: 10, marginTop: 10, width: 50, height: 50, position: "relative" }} source={require('./Images/reiterate.png')}></Image>
            </View>

            <TouchableOpacity
              style={styles.roundedRectangle6}
              onPress={this.onPress}
              underlayColor='#fff'>
              <Text style={styles.reviewNow}>Review Now</Text>
            </TouchableOpacity>
          </View>*/}
          <View style={[styles.reviewView, styles.shadowStyel, { borderRadius: 15, marginBottom: 20,marginTop:15 }]}>

            <View style={{flexDirection:"row",padding:0}}>
            <Text style={[styles.letsReiterate,{flex:1,paddingStart:0,marginTop:10,marginBottom:10}]}>
            {global.TextMessages.DS_LOWER_SESSIONCARD_TITLE_ID}
                </Text>
               {false && <Text style={[styles.letsReiterate,{flex:1,textAlign:"right",color:"#fe7201",fontWeight:"bold",marginTop:10,marginBottom:10}]}>
              {this.state.averageTimeSpent}/{this.state.setTimeGoal} min so far
                </Text>}
                </View>
            <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
            <View style={{ flex: 1, marginBottom: 5 }}>
              <FlatList
                data={this.state.day_learn_data}
                horizontal={true}
                renderItem={renderItem}
                keyExtractor={item => item.date.toString()}
              />
            <Text style={[styles.letsReiterate,{color:"#4e4e4e",marginBottom:10,paddingLeft:0,}]}>{this.state.time_spent} {global.TextMessages.DS_LOWER_SESSIONCARD_BOTMSG1_ID} {this.state.activeDaysCount} {global.TextMessages.DS_LOWER_SESSIONCARD_BOTMSG2_ID}
            </Text>
            </View>
          </View>
        </ScrollView>
        {this.state.isShowDrawer === 1 &&
          <View style={{ height: "100%", width: screenWidth, position: "absolute" }}>
            <View style={[g_styles.horizontalViewStyle, { justifyContent: 'flex-end' }]}>
              <TouchableOpacity onPress={() => this.toggleDrawer()} >
                <View style={{ width: (screenWidth / 4), backgroundColor: "#000", height: "100%" }} opacity={0.5}></View>
              </TouchableOpacity>

              <View style={{ width: 3 * (screenWidth / 4), backgroundColor: "#fff", height: screenHeight }}>
                <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={[g_styles.topView, { height: 170,width:3 * (screenWidth / 4) }]}>
                  <View style={[g_styles.horizontalViewStyle, { justifyContent: 'flex-end' }]}>
                    <TouchableOpacity onPress={() => this.toggleDrawer()} underlayColor='#fff'>
                      <Image style={[g_styles.list_rightArrow, { marginRight: 20, marginTop: 20 }]} source={require('./Images/menuright.png')} />
                    </TouchableOpacity>
                  </View>
                  <View style={[g_styles.topView_bottom_TitleArrow]}>
                    <View style={[g_styles.horizontalViewStyle, { marginTop: 30,flex:2 }]}>
                      <Image style={[g_styles.drawer_menuImage]} source={global.personalInfo.image && global.personalInfo.image != '' ? { uri: global.personalInfo.image } : require('./Images/d_image.png')} />
                      <View style={{ marginTop: 20, marginLeft: 10,marginRight: 10,flex:2 }}>
                        <Text style={[g_styles.DefaultText, { textAlign: 'left', color: "#ffffff" }]}>{global.personalInfo.user_name.toUpperCase()}</Text>
                        <Text style={[g_styles.DefaultSubText, { textAlign: 'left', color: "#ffffff"}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true}>{global.personalInfo.email_id}</Text>
                      </View>
                    </View>
                  </View>
                </LinearGradient>
                <ScrollView>
                  <TouchableOpacity onPress={() => {global.navigation.navigate("MyPerformance");global.screenInfo.end_time = new Date().getTime();TrackHistory("Performance","Click","","","","Dashboard","MyPerformance");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/myp.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_MYPER_ID}</Text>
                    </View>
                  </TouchableOpacity>

                  <TouchableOpacity onPress={() => {global.navigation.navigate("Card_WordList", { wordId: "", title: "Learn", parent:"learn" });global.screenInfo.end_time = new Date().getTime();TrackHistory("Learn","Click","","","","Dashboard","WordCard");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image  style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/learn.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_LEARN_ID}</Text>
                    </View>
                  </TouchableOpacity>

                  <TouchableOpacity onPress={() => {global.navigation.navigate("WordQuestion", { wordId: -1,parent:"review" });global.screenInfo.end_time = new Date().getTime();TrackHistory("Review","Click","","","","Dashboard","Quiz");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image  style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/reviewIcon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_REVIEW_ID}</Text>
                    </View>
                  </TouchableOpacity>

                  

                  {false && <TouchableOpacity onPress={() => {global.navigation.navigate("Card_WordList", { wordId: "", title: "Word of the day", parent: "dashboard" });global.screenInfo.end_time = new Date().getTime();TrackHistory("WordOfDay","Click","","","","Dashboard","WordCard");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image  style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/wodIcon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_WOD_ID}</Text>
                    </View>
                  </TouchableOpacity>}

                  <TouchableOpacity onPress={() => {global.navigation.navigate("WordList",{source:"dashboard"});global.screenInfo.end_time = new Date().getTime();TrackHistory("WordList","Click","","","","Dashboard","WordList");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/wListIcon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_WORDLIST_ID}</Text>
                    </View>
                  </TouchableOpacity>

                  <TouchableOpacity onPress={() => {global.navigation.navigate("WordList",{source:"Favourite",parent: "Favourites",title: "Favourites", });global.screenInfo.end_time = new Date().getTime();TrackHistory("Favourites","Click","","","","Dashboard","WordCard");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage,{tintColor:global.colors.DRAWER_MENU_ICON_CLR}]} source={require('./Images/favIcon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_FAV_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  { global.client_name == 'liqvid' && 
                  <TouchableOpacity onPress={() => {global.navigation.navigate("GoalSummary",{parent:"DashBoard"});global.screenInfo.end_time = new Date().getTime();TrackHistory("GoalSetting","Click","","","","Dashboard","CourseList");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/settingsIcon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_GOALSETTING_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 
                  <TouchableOpacity onPress={() => {global.navigation.navigate("SetGoal07Screen");global.screenInfo.end_time = new Date().getTime();TrackHistory("ProfileSettings","Click","","","","Dashboard","Quiz");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/profile_icon.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_PROSETTING_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 
                  

                  <TouchableOpacity onPress={() => {this.onShare();global.screenInfo.end_time = new Date().getTime();TrackHistory("Share","Click","","","","Dashboard","");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} resizeMode="contain" source={require('./Images/share.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_SHARE_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 

                  <TouchableOpacity onPress={() => {global.navigation.navigate("FAQ");global.screenInfo.end_time = new Date().getTime();TrackHistory("FAQ","Click","","","","Dashboard","FAQ");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/faq.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_FAQ_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 

                  <TouchableOpacity onPress={() => {global.navigation.navigate("about_us");global.screenInfo.end_time = new Date().getTime();TrackHistory("AboutUs","Click","","","","Dashboard","AboutUS");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/i.jpg')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_ABOUTUS_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 

                  <TouchableOpacity onPress={() => {global.navigation.navigate("feedback"); global.screenInfo.end_time = new Date().getTime();TrackHistory("HelpDesk","Click","","","","Dashboard","HelpDesk");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/helpdesk.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_HELPDESK_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 

                  <TouchableOpacity onPress={() => {this.logout();global.screenInfo.end_time = new Date().getTime();TrackHistory("LogOut","Click","","","","Dashboard","");}} underlayColor='#fff'>
                    <View style={[g_styles.horizontalViewStyle, { justifyContent: "flex-start", height: 70, backgroundColor: "#ffffff" }]}>
                      <Image style={[g_styles.menuItemImage]} source={require('./Images/logout.png')} />
                      <Text style={[g_styles.DefaultText, { marginLeft: 20, marginTop: 25, textAlign: 'left' }]}>{global.TextMessages.DS_DRAWER_MENU_LOGOUT_ID}</Text>
                    </View>
                  </TouchableOpacity>
                  }
                  { global.client_name == 'liqvid' && 
                   <Text style={[g_styles.DefaultSub_week_Text,{paddingLeft:0,marginTop:10,marginBottom:10,alignSelf:"center",textAlign:"center"}]}>{global.TextMessages.DS_DRAWER_MENU_APPVER_ID}{pkg.expo.version} BV:{Platform.OS == 'ios' && pkg.expo.ios.buildNumber}{Platform.OS == 'android' && pkg.expo.android.versionCode}</Text>
                 }
                </ScrollView>
              </View>
            </View>
          </View>}
      </View>
    );
  }
}
const styles = StyleSheet.create({
  mainContainer: {
    flex: 1,
    flexDirection: "column",
    width: '100%',
    height: '100%',
    backgroundColor: "#f5f5f5",
    textAlign: "center",
  },
  shadowStyel: {
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 15,
    shadowColor: '#000000'
  },
  topView: {
    backgroundColor: '#fe7201',
    width: '100%',
    paddingBottom: 160,
    flexWrap: 'wrap',
  },
  upperBand: {
    flexDirection: 'row',
    padding: 20,
    width: '100%',
  },
  headderText: {
    fontSize: 15.5 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0.47,
    marginTop: 20,
    textAlign: "left",
    color: "#ffffff",
    justifyContent: "flex-start"
  },
  sliderView: {
    width: "100%",
    paddingStart: 20,
    paddingEnd: 20,
    marginTop: 5,
    flexDirection: "row",
    justifyContent: "space-between"
  },

  completionPercentValue: {
    fontSize: 35.5 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ffffff"
  },
  wordsCountValue: {
    fontSize: 30 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    
  },
  ofOverallLearning: {
    fontSize: 9 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ffffff"
  },
  wordsLearned: {
    fontSize: 11 / fontFactor,
    fontWeight: "300",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff"
  },
  ins_icon: {
    marginLeft: 30,
    marginRight: 10,
    position: 'relative',
    width: 20,
    height: 20,
  },
  image_right: {
    marginLeft: 30,
    marginRight: 10,
    position: 'relative',
    width: 24,
    height: 28,
  },
  layer: {
    fontSize: 18 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff"
  },
  of300: {
    fontSize: 13.5 / fontFactor,
    fontWeight: "300",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff"
  },
  smalltext: {
    fontSize: 12 / fontFactor,
    fontWeight: "300",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#000000"
  },

  todaysLearning: {
    width: "100%",
    textAlign: 'right',
    paddingEnd: 20,
    fontSize: 15.5 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    color: "#ffffff"
  },
  words: {
    fontSize: 13.5 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#4e4e4e",
    flexWrap: "wrap",
    textAlign: 'left'
  },
  largeProgressText: {
    fontSize: 31 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#fe7201"
  },
  letsReiterate: {

    fontSize: 13.5 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#4e4e4e",
    width: "100%",
    margin: 20,
    paddingStart: 20
  },
  roundedRectangle6: {
    width: "60%",
    height: 40,
    margin: 20,
    borderRadius: 19,
    backgroundColor: "#ffffff",
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#fe7201",
    justifyContent: 'center'
  },
  reviewNow: {
    fontSize: 13.5 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#fe7201"
  },
  reviewView: {
    flexDirection: "column",
    flexWrap: "nowrap",
    marginStart: 20,
    marginEnd: 20,
    marginTop: 20,
    backgroundColor: "#ffffff",
    justifyContent: "center",
    alignItems: "center"
  },
  item: {
    flex: 1,
    width: 80,
    flexDirection: 'column',
    backgroundColor: "#ffffff",
    padding: 15,
    marginEnd: 5,
    marginTop: 15,
    marginStart: 5,
    marginBottom: 10,
    borderRadius: 5,
    borderWidth: 1,
    borderColor: "#f5f5f5",
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 5,
    shadowColor: '#000000'

  },
  dayTextstyle: {
    fontSize: 9 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e"
  },
  dateTextStyle: {
    fontSize: 22 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e"
  },
  container: {
    flex: 1,
    height: 3,
    borderColor: "#ffffff",
    backgroundColor:"#eeeeee",
    marginTop: 10,
    justifyContent: "center",
  },
  inner: {
    width: "100%",
    height: 3,
    borderRadius: 15,
  },

})

export default DashBorad;
