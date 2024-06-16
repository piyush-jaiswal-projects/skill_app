import React from "react";
import { ScrollView,Platform , View, ImageBackground, Image, Text, ActivityIndicator,Dimensions} from 'react-native';
import PrimaryButton from './component/Button';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';
import DropDownPicker from 'react-native-dropdown-picker';
import CheckBox from 'react-native-check-box'
import moment from "moment";
import {TrackHistory} from './utill/Network'; 

const labels = ["", "", "", "", "", "", ""];
import CircularSlider from './component/CircularSlider'

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class SetGoal06Screen extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      weekdayMins: 15,
      weekendMins: 15,
      selectedHourValue: '10',
      selectedMinValue: '20',
      enableScroll:true,
      startAngle: Math.PI * 10 / 6,
      angleLength: Math.PI * 7 / 6,
      weekdaysVal: 15,
      slider1: 0,
      slider2: 0,
      isLoading:false,
      toggleCheckBox:false
    };
  }

  clickContinue=()=>{

     if(this.state.slider1 > 0 || this.state.slider2 > 0 ){


      var day_timeArr = new Array();

      for (let userObject of global.setG_weekdayArr) {
         var Obj = {
              title:userObject.title,
              id:userObject.id,
              duration:this.state.slider1,
         }
         day_timeArr.push(Obj)
       }

       for (let userObject of global.setG_weekendArr) {
        var Obj = {
             title:userObject.title,
             id:userObject.id,
             duration:this.state.slider2,
        }
        day_timeArr.push(Obj)
      }


       if(this.state.toggleCheckBox )
       {
         global.selectedHourValue = this.state.selectedHourValue;
         global.selectedMinValue = this.state.selectedMinValue;
        var body_data ={
          user_id:global.personalInfo.user_id,
          course_id:global.courseid,
          datetime:moment().format("HH:mm:ss DD-MM-YYYY"),
          weekdays:JSON.stringify(global.setG_weekdayArr),
          weekend:JSON.stringify(global.setG_weekendArr),
          time_and_day:JSON.stringify(day_timeArr),
          finish_target:global.setG_num_of_days,
          goal_time: JSON.stringify({hour:global.selectedHourValue,min:global.selectedMinValue}),
          goal_start_date:new Date(global.setG_startDate).getTime(),
          goal_end_date:new Date(global.setG_endDate).getTime(), 
          updated:false
        }
        console.log(JSON.stringify(body_data));
         this.loadAPI('1',global.base_url+'createStudyPlan',"POST",body_data);
       }
       else
       {
        global.selectedHourValue = 0;
        global.selectedMinValue = 0;
        var body_data ={
          user_id:global.personalInfo.user_id,
          course_id:global.courseid,
          datetime:moment().format("HH:mm:ss DD-MM-YYYY"),
          weekdays:JSON.stringify(global.setG_weekdayArr),
          weekend:JSON.stringify(global.setG_weekendArr),
          time_and_day:JSON.stringify(day_timeArr),
          finish_target:global.setG_num_of_days,
          goal_time:JSON.stringify({"hour":"00","min":"00"}),
          goal_start_date:new Date(global.setG_startDate).getTime(),
          goal_end_date:new Date(global.setG_endDate).getTime(),
          updated:false

        }
        console.log(JSON.stringify(body_data));
        this.loadAPI('1',global.base_url+'createStudyPlan',"POST",body_data);
       }

  }
  else
  {
    alert("Please set duration time");
  }

  }
  nextScreen=(responseText)=>{
    
    console.log(JSON.stringify(responseText));
    if(responseText.code == 200){
      var resp = responseText.data;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("Continue","Click Continue","","","","Step3","PI1");
      global.navigation.navigate('SetGoal07Screen')
    }
   else {
  
     }
    this.setState({ isLoading: false });
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
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }
  
  render() {
    return (

      <ScrollView style={[styles.mainContainer, { width: screenWidth}]} bounces={false} scrollEnabled={this.state.enableScroll}>
        <ImageBackground style={[styles.logo]} source={require('./Images/setGImage06.png')}>
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
        <Text style={[styles.stepStyle,{marginLeft:10,marginTop:-150}]} >Step 3</Text>
        <Text style={[styles.headerTitle,{ marginLeft: 10,marginTop:10 }]} >Plan your schedule</Text>
        <Text style={[styles.HeaderSubTitle,{ marginLeft: 10,marginRight: 10 }]} >Dedicate time as per your convenience. We recommended 15 mins per day.</Text>
        <View style={[styles.cornerContainer,{backgroundColor:"#f5f5f5"}]}>
          <View style={styles.horizontalViewStyle}>
            <View style={styles.twoPart}>
              <View style={[styles.innerRoundBox,{backgroundColor:"#ffffff",alignItems:'center'}]}>
              <Text style={[styles.DefaultBoldSubText,{paddingTop:10,marginLeft:-40,textAlign:"left",alignItems:'center'}]}>On Weekdays</Text>
              <Text style={[styles.HeaderSubTitle,{color:'#4e4e4e',width:'100%',paddingLeft:20,textAlign:"left"}]}>I will practice vocabulary for</Text>
                <View style={{ alignItems: "center",marginTop:5,marginBottom:10, justifyContent: "center"}}>
                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    <Image style={{ width: 140, height: 140 }} source={require('./Images/clock_1.png')} />
                  </View>
                  <CircularSlider width={140} height={140} meterColor='#c12d30' textColor='#000'
                    value={this.state.slider1*6} onValueChange={(value) => this.setState({ slider1: Math.round(value/6) })} />

                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    <Text style={[styles.Title,{color:"#c12d30"}]}>
                      {this.state.slider1}</Text>
                    <Text style={[styles.HeaderSubTitle,{color:"#c12d30"}]}>
                    min/day</Text>
                  </View>

                </View>
              </View>
              </View>

              <View style={styles.twoPart}>
                <View style={[styles.innerRoundBox,{backgroundColor:"#ffffff",alignItems:'center'}]}>
                  <Text style={[styles.DefaultBoldSubText,{paddingTop:10,marginLeft:-40,textAlign:"left"}]}>On Weekend</Text>
                  <Text style={[styles.HeaderSubTitle,{color:'#4e4e4e',width:'100%',paddingLeft:20,textAlign:"left"}]}>I will practice vocabulary for</Text>
                  <View style={{marginTop:5,marginBottom:10, alignItems: "center", justifyContent: "center"}}>
                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    <Image style={{ width: 140, height: 140 }} source={require('./Images/clock_2.png')} />
                  </View>
                  <CircularSlider width={140} height={140} meterColor='#00a5a4' textColor='#000'
                    value={this.state.slider2*6} onValueChange={(value) => this.setState({ slider2: Math.round(value/6) })} />
                  <View style={{ justifyContent: "center", position: 'absolute' }}>
                    <Text style={[styles.Title,{color:"#00a5a4"}]}>
                      {this.state.slider2}</Text>
                    <Text style={[styles.HeaderSubTitle,{color:"#00a5a4"}]}>
                    min/day</Text>
                  </View>

                </View>
                </View>

              </View>
            </View>


            <View style={styles.onePart}>
              <View style={[styles.lowerRoundBox,{backgroundColor:"#ffffff"}]}>
              <View style={{flexDirection:"row"}}>
              <CheckBox
                style={styles.checkbox}
                onClick={() =>this.setState({ toggleCheckBox: !this.state.toggleCheckBox, termsErrorMsg: '' })}
                isChecked={this.state.toggleCheckBox}
                leftText=""
                />
                <Text style={[styles.DefaultBoldSubText,{textAlign:"left",marginLeft:10}]}>Do your prefer any specific time of the day.</Text>

                </View>
                {this.state.toggleCheckBox && <View style={[styles.horizontalViewStyle, { marginTop: 10,width:"100%", marginBottom: 20, ...(Platform.OS!=='android'&&{zIndex: 2}) }]}>
                  <DropDownPicker
                    dropDownMaxHeight={100}
                    containerStyle={{ height: 30 }}
                    style={[styles.DefaultSubText,{justifyContent: 'flex-start',width: screenWidth/2-70}]}
                    containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                    itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                    dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
                    labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
                    zIndex={1000}
                    placeholder="Select"
                    items={[
                      { label: '00', value: '00' },
                      { label: '01', value: '01' },
                      { label: '02', value: '02' },
                      { label: '03', value: '03' },
                      { label: '04', value: '04' },
                      { label: '05', value: '05' },
                      { label: '06', value: '06' },
                      { label: '07', value: '07' },
                      { label: '08', value: '08' },
                      { label: '09', value: '09' },
                      { label: '10', value: '10' },
                      { label: '11', value: '11' },
                      { label: '12', value: '12' },
                      { label: '13', value: '13' },
                      { label: '14', value: '14' },
                      { label: '15', value: '15' },
                      { label: '16', value: '16' },
                      { label: '17', value: '17' },
                      { label: '18', value: '18' },
                      { label: '19', value: '19' },
                      { label: '20', value: '20' },
                      { label: '21', value: '21' },
                      { label: '22', value: '22' },
                      { label: '23', value: '23' }
                    ]}
                    defaultIndex={1}
                    defaultValue={this.state.selectedHourValue}
                    
                    onChangeItem={item => this.setState({selectedHourValue:item.value})}
                  />


                  <DropDownPicker
                    dropDownMaxHeight={100}
                    containerStyle={{ height: 30 }}
                    style={[styles.DefaultSubText,{justifyContent: 'flex-start',width: screenWidth/2-70}]}
                    containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                    itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                    dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
                    labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}

                    placeholder="Select"
                    items={[
                      { label: '00', value: '00' },
                      { label: '01', value: '01' },
                      { label: '02', value: '02' },
                      { label: '03', value: '03' },
                      { label: '04', value: '04' },
                      { label: '05', value: '05' },
                      { label: '06', value: '06' },
                      { label: '07', value: '07' },
                      { label: '08', value: '08' },
                      { label: '09', value: '09' },
                      { label: '10', value: '10' },
                      { label: '11', value: '11' },
                      { label: '12', value: '12' },
                      { label: '13', value: '13' },
                      { label: '14', value: '14' },
                      { label: '15', value: '15' },
                      { label: '16', value: '16' },
                      { label: '17', value: '17' },
                      { label: '18', value: '18' },
                      { label: '19', value: '19' },
                      { label: '20', value: '20' },
                      { label: '21', value: '21' },
                      { label: '22', value: '22' },
                      { label: '23', value: '23' },
                      { label: '24', value: '24' },
                      { label: '25', value: '25' },
                      { label: '26', value: '26' },
                      { label: '27', value: '27' },
                      { label: '28', value: '28' },
                      { label: '29', value: '29' },
                      { label: '30', value: '30' },
                      { label: '31', value: '31' },
                      { label: '32', value: '32' },
                      { label: '33', value: '33' },
                      { label: '34', value: '34' },
                      { label: '35', value: '35' },
                      { label: '36', value: '36' },
                      { label: '37', value: '37' },
                      { label: '38', value: '38' },
                      { label: '39', value: '39' },
                      { label: '40', value: '40' },
                      { label: '41', value: '41' },
                      { label: '42', value: '43' },
                      { label: '43', value: '43' },
                      { label: '44', value: '44' },
                      { label: '45', value: '45' },
                      { label: '46', value: '46' },
                      { label: '47', value: '47' },
                      { label: '48', value: '48' },
                      { label: '49', value: '49' },
                      { label: '50', value: '50' },
                      { label: '51', value: '51' },
                      { label: '52', value: '52' },
                      { label: '53', value: '53' },
                      { label: '54', value: '54' },
                      { label: '55', value: '55' },
                      { label: '56', value: '56' },
                      { label: '57', value: '57' },
                      { label: '58', value: '58' },
                      { label: '59', value: '59' }
                    ]}
                    defaultValue={this.state.selectedMinValue}
                    onChangeItem={item => {item => this.setState({selectedMinValue:item.value})}}
                  />

                </View>}

                {//this.state.toggleCheckBox &&  <Text style={[styles.DefaultSubText]}>We will send a notification to you.</Text>
                }
              </View>
            </View>


              <PrimaryButton
                text='Continue'
                onPress={() =>this.clickContinue()} />

          </View>
          {this.state.isLoading && <ActivityIndicator color={"#000000"} />}

     </ScrollView>

    );
  }
}
export default SetGoal06Screen;
