import React from 'react';
import { ScrollView, PixelRatio, View, ImageBackground, Image, StyleSheet, Text, TextInput, Dimensions, Button, Alert } from 'react-native';
import Slider from '@react-native-community/slider'
import { TouchableOpacity } from 'react-native-gesture-handler'
import PrimaryButton from './component/Button';
import BackButton from './component/Cus_BackButton';
import PrimarySkipButton from './component/skipButton';
import styles from './vocabStyleSheet/styles';
//import {DraggableCalendar} from 'react-native-draggable-calendar';
import CalendarPicker from 'react-native-calendar-picker';
import { TrackHistory } from './utill/Network';
//import {Calendar} from 'react-native-calendars';
import moment from "moment";
const fontFactor = PixelRatio.getFontScale();
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const labels = ["", "", "", "", "", "", ""];
const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];




class SetGoal03Screen extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      sliderValue: 0,
      currentDate: new Date(Date.now()),
      destinationDate: new Date(Date.now()),
      isOpenCalendar: false,
      totalDays: 90,
    };


  }
  onDateChange = (date, type) => {


    this.state.destinationDate = new Date(date);
    const diffInMs = Math.abs(this.state.destinationDate - this.state.currentDate);
    this.setState({ sliderValue: Math.ceil(diffInMs / (1000 * 60 * 60 * 24)) });
    //this.closeCalendar();
    // //function to handle the date change
    // if (type === 'END_DATE' && date) {
    //   alert('END_DATE')
    //   this.state.destinationDate = new Date(date);
    //   const diffInMs = Math.abs(this.state.destinationDate - this.state.currentDate);
    //   this.setState({sliderValue:Math.floor(diffInMs / (1000 * 60 * 60 * 24))});

    // } else if (type === 'START_DATE' && date) {
    //   alert('START_DATE')
    //   this.state.currentDate = new Date(date)
    // }
    // else
    // {
    //   alert("garbage")
    // }
  };
  onSelectionChange = (newSelection) => {
    this.state.currentDate = newSelection[0];
    this.state.destinationDate = newSelection[1];
    const diffInMs = Math.abs(this.state.destinationDate - this.state.currentDate);
    this.setState({ sliderValue: Math.floor(diffInMs / (1000 * 60 * 60 * 24)) });

  };

  onPressContinue = () => {

    if (this.state.sliderValue > 0) {
      global.setG_num_of_days = this.state.sliderValue;
      global.setG_startDate = this.state.currentDate;
      global.setG_endDate = this.state.destinationDate;

      var body_data = {
        user_id: global.personalInfo.user_id,
        course_id: global.courseid,
        datetime: moment().format("HH:mm:ss DD-MM-YYYY"),
        weekdays: "[]",
        weekend: "[]",
        time_and_day: "[]",
        finish_target: global.setG_num_of_days,
        goal_time: JSON.stringify({ "hour": "00", "min": "00" }),
        goal_start_date: new Date(global.setG_startDate).getTime(),
        goal_end_date: new Date(global.setG_endDate).getTime(),
        updated: false

      }
      console.log(JSON.stringify(body_data));
      this.loadAPI('1', global.base_url+'createStudyPlan', "POST", body_data);
    }
    else {
      alert("Please select Exam Date");
    }

  }
  closeCalendar = () => {
    if (this.state.sliderValue > 0) {
      this.setState({ isOpenCalendar: false });
    }
    else {
      alert("Please select atleast one day duration");
    }
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
          if (data_type === '1') {
            this.nextScreen(responseText);
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
          this.setState({ isLoading: false });
          if (data_type === '1') {
            this.nextScreen(responseText);
          }
          else {
            alert('unknown api call')
          }
        })
        .catch(error => {
          alert(error);
        });
    }
  };

  nextScreen = (responseText) => {

    console.log(JSON.stringify(responseText));
    if (responseText.code == 200) {
      var _data = responseText.data;
      if (_data.popup == 1) {
        Alert.alert(
          _data.message,
          "\n\n\n\n" + global.TextMessages.TY_ALERT_MSG,
          [
            { text: "Continue", onPress: () => this.clickNext(), style: 'destructive' }
          ],
          { cancelable: false }
        );
      }
      else {
        this.clickNext();
      }
    }
    else {

    }
    this.setState({ isLoading: false });
  }

  clickNext() {
    global.screenInfo.end_time = new Date().getTime();
    TrackHistory("Continue", "Click Continue", "", "", "", "Step1", "GoalSummary");
    global.navigation.navigate('GoalSummary');
  }
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }

  render() {

    let customI18n = {
      'w': ['', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
      'weekday': ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
      'text': {
        'start': 'Check in',
        'end': 'Check out',
        'date': 'Date',
        'save': 'Confirm',
        'clear': 'Reset'
      },
      'date': 'DD / MM'  // date format
    };
    let color = {
      subColor: '#f0f0f0'
    };

    var cal_today = new Date();
    var cal_dest = new Date();
    cal_dest.setDate(cal_today.getDate() + parseInt(this.totalDays));
    return (
    
        <ScrollView style={[styles.mainContainer, { width: screenWidth }]}>
          <ImageBackground style={[styles.logo, { height: 260, }]} source={require('./Images/setgoal_03.png')}>

            <View style={styles.topView}>
              <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 20 }]}>
                <View style={[styles.topView_bottom_TitleArrow]}>
                  <BackButton
                    text=''
                    onPress={() => {

                      global.screenInfo.end_time = new Date().getTime();
                      TrackHistory("Back", "Click Back", "", "", "", "setgoal_03", "Courselist");
                      global.navigation.navigate('SetGoal01Screen', { parent: "ThanksYouTest" })
                    }}
                  />
                </View>
              </View>
            </View>
          </ImageBackground>
          <Text style={[styles.headerTitle, { marginLeft: 10, marginTop: -190 }]} >{global.TextMessages.TY_HEADER1_ID}</Text>
          <Text style={[styles.stepStyle, { marginLeft: 10, marginTop: 10, marginRight: 10 }]} >{global.TextMessages.TY_SUBHEADER1_ID} {global.personalInfo.score} {global.TextMessages.TY_SUBHEADER2_ID} {global.personalInfo.current_level}</Text>
          <View style={[styles.cornerContainer, { marginTop: 20 }]}>
            <Text style={[styles.Title, { textAlign: "left", color: "#4e4e4e", marginLeft: 10, marginBottom: 25, marginTop: 0 }]}>{global.TextMessages.TY_HEADER2_ID}</Text>
            {/* <View style={styles.horizontalViewStyle}>
         <Text style={[styles.DefaultBoldText,{marginTop:6}]}>Add Days</Text> 
         <View style={styles.roundedRectangle}>
            <Text style={[styles.roundedRectangleText,styles.DefaultBoldText]}>{this.state.sliderValue}</Text>
         </View>
      </View> */}
            {/* <Slider style={styles.roundedRectangle5}
          maximumValue={this.state.totalDays}
          minimumValue={0}
          minimumTrackTintColor="#c12d30"
          maximumTrackTintColor="#dad8ce"
          step={1}
          value={this.state.sliderValue}
          onSlidingComplete={value => this.setState({
            sliderValue: value,
            destinationDate:new Date(Date.now() + ( 3600 * 1000 *value*24)),

          })}
        /> */}
            {/* <View style={styles.messageViewLower}>
          <Image style={[styles.i_ins_logoStyle,{tintColor:"#4e4e4e"}]} source={require('./Images/i_icon.png')}></Image>
          <Text style={styles.messageAndDataRatesMayApplyLower}> Move the slider to set the number of days</Text>
        </View> */}
            {/* <View style={styles.saparator}>
        <View style={styles.hrline} />
        <Text style={styles.DefaultSubText}>OR</Text>
        <View style={styles.hrline} />
        </View> */}

            <View style={[styles.horizontalViewStyle, { marginTop: 0, marginBottom: 20 }]}>
              {/* <View style={[styles.twoPart,styles.roundedRectangle,{width:120,height:50}]}>
        <Text style={[styles.twoPart,styles.DefaultBoldText,{marginTop:-30,textAlign:'center'}]}>Start</Text>
        <View style={[styles.horizontalViewStyle,{marginTop:10,justifyContent: 'flex-start'}]}>
          <Text style={[styles.roundedRectangleText,styles.headerTitle,{color:'#4e4e4e',textAlign:'center',height:50}]}>{this.state.currentDate.getDate()}</Text>
          <Text style={[styles.roundedRectangleText,styles.DefaultText,{paddingLeft:2,paddingTop:4,textAlign:'center',height:50}]}>{monthNames[this.state.currentDate.getMonth()].substring(0, 3).toUpperCase()}</Text>

       </View>
      </View> */}




              <View style={[styles.twoPart, styles.roundedRectangle, { paddinTop: 0, width: 120, height: 50 }]} onStartShouldSetResponder={() => this.setState({ isOpenCalendar: true })}>

                {this.state.sliderValue > 0 ?
                  <View style={[styles.horizontalViewStyle, { marginTop: 5, justifyContent: 'flex-start' }]}>
                    <Text style={[styles.roundedRectangleText, styles.headerTitle, { color: '#4e4e4e', textAlign: 'center', height: 50 }]}>{this.state.destinationDate.getDate()}</Text>
                    <Text style={[styles.roundedRectangleText, styles.DefaultText, { paddingLeft: 2, paddingTop: 4, textAlign: 'center', height: 50 }]}>{monthNames[this.state.destinationDate.getMonth()].substring(0, 3).toUpperCase()}</Text>
                  </View> :
                  <View style={[{ marginTop: 0, justifyContent: 'flex-start' }]}>
                    <View style={[styles.horizontalViewStyle, { justifyContent: 'flex-start' }]}>
                      <Text style={[styles.roundedRectangleText, styles.DefaultSubText, { textAlign: 'left' }]}>{global.TextMessages.TY_SELECT_ID}</Text>
                      <Image style={[styles.i_ins_logoStyle, { marginLeft: 10 }]} source={require('./Images/wodIcon.png')}></Image>
                    </View>
                    <Text style={[styles.roundedRectangleText, styles.DefaultSubText, { paddingLeft: 2, paddingTop: 3, textAlign: 'left', height: 50, marginTop: -5 }]}>{global.TextMessages.TY_EXAMDATE_ID}</Text>
                  </View>
                }
              </View>

              <View style={[styles.roundedRectangle, { borderColor: "#ffffff" }]}>

                <Text style={[{ fontSize: 25, textAlign: 'center' }]}>{this.state.sliderValue}</Text>
                <Text style={[{ fontSize: 15, textAlign: 'center' }]}>{global.TextMessages.TY_DAYS_ID}</Text>

              </View>



            </View>
            <Text style={[styles.DefaultSub_week_Text, { textAlign: "left", color: "#4e4e4e", marginLeft: 10, marginBottom: 10, marginTop: 10 }]} >{global.TextMessages.TY_INS1_ID}</Text>
            <Text style={[styles.DefaultSub_week_Text, { textAlign: "left", color: "#4e4e4e", marginLeft: 10, marginBottom: 10, marginTop: 10 }]} >{global.TextMessages.TY_INS2_ID} </Text>


            <PrimaryButton
              text={global.TextMessages.TY_CONTINUE_ID}
              onPress={() => this.onPressContinue()}
            />




          </View>
          {
          this.state.isOpenCalendar &&
          <View style={{ marginTop:-200,  height: 335, backgroundColor: "#ffffff" }}>
              <View style={{marginLeft: 15, marginRight: 15, height: 290, borderWidth: 1, borderColor: "#ff7200", borderRadius: 10, backgroundColor: "#ffffff" }}>
              <CalendarPicker
                startFromMonday={true}
                height={400}
                //allowRangeSelection={true}
                minDate={cal_today}
                // maxDate={cal_dest}
                weekdays={
                  [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thur',
                    'Fri',
                    'Sat',
                    'Sun'
                  ]}
                months={[
                  'January',
                  'Febraury',
                  'March',
                  'April',
                  'May',
                  'June',
                  'July',
                  'August',
                  'September',
                  'October',
                  'November',
                  'December',
                ]}
                previousTitle="  <"
                nextTitle=">  "
                todayBackgroundColor="#ffffff"
                selectedDayColor="#b1dbff"
                todayTextStyle={{ color: "#ff7200" }}
                selectedDayTextColor="#000000"
                scaleFactor={400}
                textStyle={{
                  color: '#000000',

                }}
                onDateChange={this.onDateChange}
              />
              </View>
              <TouchableOpacity
                style={{ height: 40, marginTop: 10 }}
                onPress={() => this.closeCalendar()}
                underlayColor='#fff'>
                <Text style={[styles.DefaultText, { color: "#ff7200", justifyContent: 'center', textAlign: 'center', alignContent: "center", alignSelf: "center" }]}>{global.TextMessages.TY_DONE_ID}</Text>
              </TouchableOpacity>
            </View>

            /*
                      <View style={{ flex: 1, width: screenWidth, height: screenHeight - 400,backgroundColor:"#ff00ff" }}>

            <View style={{paddingLeft:30,paddingRight:30,paddingTop:30,marginTop:20,height:150,width:screenWidth,backgroundColor:'#ffffff',borderRadius: 25}}>
        <View style={styles.horizontalViewStyle}>
         <View style={[styles.twoPart,styles.roundedRectangle,{width:120,height:50}]}>
        <Text style={[styles.twoPart,styles.DefaultText,{marginTop:-30}]}>Start</Text>
        <View style={[styles.horizontalViewStyle,{marginTop:10,justifyContent: 'flex-start'}]}>
          <Text style={[styles.roundedRectangleText,{fontSize:25/fontFactor,textAlign:'center',height:50}]}>{this.state.currentDate.getDate()}</Text>
          <Text style={[styles.roundedRectangleText,{fontSize:15/fontFactor,paddingLeft:2,paddingTop:8,textAlign:'center',height:50}]}>{monthNames[this.state.currentDate.getMonth()]}</Text>

       </View>
      </View> */}



            {/* <View style={[styles.twoPart,styles.roundedRectangle,{width:120,height:50}]} >
        <Text style={[styles.DefaultText,{marginTop:-30}]}>Target Date</Text>
        <View style={[styles.horizontalViewStyle,{marginTop:10,justifyContent: 'flex-start'}]}>
         <Text style={[styles.roundedRectangleText,{fontSize:25/fontFactor,textAlign:'center',height:50}]}>{this.state.destinationDate.getDate()}</Text>
         <Text style={[styles.roundedRectangleText,{fontSize:15/fontFactor,paddingLeft:2,paddingTop:8,textAlign:'center',height:50}]}>{monthNames[this.state.destinationDate.getMonth()]}</Text>
         </View>
        </View>
        <View>
      <Text style={[{fontSize:25,textAlign:'center'}]}>{this.state.sliderValue}</Text>
      <Text style={[{fontSize:15,textAlign:'center'}]}>Days</Text>
      </View> 
        </View>
        </View>*/}
           
            {/* <DraggableCalendar
         style={{backgroundColor:'#ffffff',marginTop:-20,marginBottom:10,width:screenWidth}}
         onSelectionChange={this.onSelectionChange}
         initialSelectedRange={[this.state.currentDate,this.state.destinationDate]}
         maxDays={this.state.totalDays}
        /> 
         </View>
        */}
         
        
        </ScrollView>
       
     
    );
  }
}
export default SetGoal03Screen;
