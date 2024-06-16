import React, { useState } from "react";
import { ScrollView, View, ImageBackground, Image, Platform, StyleSheet, Text, TextInput, TouchableOpacity, Button, Dimensions, FlatList ,Alert} from 'react-native';
import PrimaryButton from './component/Button';

import PrimarySkipButton from './component/skipButton';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';
import DropDownPicker from 'react-native-dropdown-picker';
import StepIndicator from 'react-native-step-indicator';
import moment from "moment";
import {TrackHistory} from './utill/Network'; 

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
let TimeArray = [            
  { label: '1', value: 1 },
  { label: '10', value: 10 },
  { label: '15', value: 15 },
  { label: '30', value: 30 },
  { label: '60', value: 60 },
  { label: '90', value: 90 },
  { label: '120', value: 120 },
  { label: '180', value: 180 }
];

let WordCountArray = [
  { label: '20', value: 20 },
  { label: '30', value: 30 }, 
  { label: '50', value: 50 }, 
  { label: '100', value: 100 },
  { label: '150', value: 150 },
  { label: '200', value: 200 }
];
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
  currentStepLabelColor: '#fe7013'
}

const putTickIndicator = (state)=> {
  return <Image source={require('./Images/currentLevelStep.png')} style={{height:40, width:40}}/>

 }

class GoalSummary extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = {
      destination_level_id:6,
      destination_level:"",
      destination_level_text:"",
      expected_target_date:moment().format("DD-MMM-YYYY"),
      avg_time: 15,
      wordsDay: 50,
      editMode: false,
      isUpdate: true,
      cus_levels:[],
      course_name:"",
      course_id:"",
    };
  }


changeDestination =({item})=>{
  if(this.state.editMode && item.id >global.personalInfo.current_level_id )
    this.setState({destination_level_id:item.id});
}

renderCefr = ({item}) => (

    <View onStartShouldSetResponder={() => this.changeDestination({ item})}>
    {(item.id === global.personalInfo.current_level_id) &&
      <View style={[styles.list_item,{borderColor: "#ffffff",height: 30,marginVertical: 0,marginTop:0,paddingTop:0,labelAlign:'center',justifyContent:'center'}]}>
      <View style={[styles.horizontalViewStyle,{marginTop:0}]}>
      <Text style={[styles.DefaultSubText,{fontSize:14,marginTop:5,height:30,width: '30%'}]}>Current Level</Text>
      <Image style={{width:15,height:15,marginRight:10,marginTop:7}} source={require('./Images/arrT.png')}></Image>
      <Image style={[styles.list_circle,{marginLeft:-3,width:25,height:25,borderRadius:20,resizeMode:'contain'}]} source={require('./Images/currentLevelStep.png')}></Image>
      <Text style={[styles.list_level_title,{color:'#fe7201',marginTop:5,height:40,width: '50%',marginLeft:10}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true}>{item.title}</Text>
      </View>
      </View>
    }

    {(item.id === this.state.destination_level_id) &&
      <View style={[styles.list_item,{borderColor: "#ffffff",height: 30,marginTop:0,marginVertical: 0,paddingTop:0,labelAlign:'center',justifyContent:'center'}]}>
      <View style={[styles.horizontalViewStyle,{marginTop:0}]}>
      <Text style={[styles.DefaultSubText,{fontSize:14,marginTop:5,height:30,width: '30%'}]}>Target</Text>
      
      <Image style={{width:15,height:15,marginRight:10,marginTop:7}} source={require('./Images/arrT.png')}></Image>
      <Image style={[styles.list_circle,{marginLeft:-5,width:25,height:25,borderRadius:20,resizeMode:'contain'}]} source={require('./Images/nila_gola.png')}></Image>
      <Text style={[styles.list_level_title,{marginTop:5,height:30,width: '50%',marginLeft:10}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true}>{item.title}</Text>
      </View>
      </View>
    }

    {(item.id === this.state.cus_levels.length-1 && this.state.destination_level_id !== this.state.cus_levels.length-1 && global.personalInfo.current_level_id !== this.state.cus_levels.length-1 ) &&

      <View style={[styles.list_item,{borderColor: "#ffffff",height: 25,marginTop:0,marginVertical: 0,paddingTop:0,labelAlign:'center',justifyContent:'center'}]}>
      <View style={[styles.horizontalViewStyle,{marginTop:0}]}>
      <Text style={[styles.list_title,{width: '30%'}]}></Text>
      <Image style={{width:15,height:15,marginRight:10}} ></Image>
      <View>
      <View style={{position:"absolute",backgroundColor:"#c5c5c5",width:2,height:40}}></View>
      <Image style={[styles.list_circle,{width:20,height:20,borderRadius:10,borderColor:"#c5c5c5",borderWidth:3,marginLeft:-10}]}></Image>
      </View>
      <Text style={[styles.list_level_title,{marginTop:0,height:20,width: '50%',marginLeft:10}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true}>{item.title}</Text>
      </View>
      </View>
    }

    {(item.id === 0 && this.state.destination_level_id !== 0 && global.personalInfo.current_level_id !== 0 ) &&
      <View style={[styles.list_item,{borderColor: "#ffffff",height: 30,marginTop:5,marginVertical: 0,paddingTop:0,labelAlign:'center',justifyContent:'center'}]}>
      <View style={[styles.horizontalViewStyle,{marginTop:0}]}>
      <Text style={[styles.list_title,{width: '30%'}]}></Text>
      <Image style={{width:15,height:15,marginRight:10}} ></Image>
      <View>
      <View style={{position:"absolute",backgroundColor:"#c5c5c5",width:2,height:30,marginTop:-10}}></View>
      <Image style={[styles.list_circle,{width:20,height:20,borderRadius:10,borderColor:"#c5c5c5",borderWidth:3,marginLeft:-10}]}></Image>
      </View>
      <Text style={[styles.list_level_title,{marginTop:0,height:20,width: '50%',marginLeft:10}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true} >{item.title}</Text>
      </View>
      </View>
    }
    

    {(item.id !== 0 && item.id !== this.state.cus_levels.length-1 && item.id !== this.state.destination_level_id && item.id !== global.personalInfo.current_level_id ) &&
      <View style={[styles.list_item,{borderColor: "#ffffff",height: 30,marginTop:0,marginVertical: 0,paddingTop:0,labelAlign:'center',justifyContent:'center'}]}>
      <View style={[styles.horizontalViewStyle,{marginTop:5}]}>
      <Text style={[styles.list_title,{width: '30%'}]}></Text>
      <Image style={{width:15,height:15,marginRight:10}} ></Image>
      <View>
      <View style={{position:"absolute",backgroundColor:"#c5c5c5",width:2,height:40,marginTop:-10}}></View>
      <Image style={[styles.list_circle,{width:20,height:20,borderRadius:10,borderColor:"#c5c5c5",borderWidth:3,marginLeft:-10}]}></Image>
      </View>
      <Text style={[styles.list_level_title,{marginTop:0,height:20,width: '50%',marginLeft:10}]} numberOfLines={1} minimumFontScale={0.01} adjustsFontSizeToFit = {true} >{item.title}</Text>
      </View>
      </View>
    }
    </View>

);


  toggleImg = ({ item }) => {
    if (this.state.editMode) {
      item.isSelected = !item.isSelected;
      this.setState({ isUpdate: this.state.isUpdate });
    }
  }
  renderItem = ({ item }) => (
    <View style={[styles.centerView, { margin:0,marginBottom: 20 }]}>
      <TouchableOpacity onPress={() => this.toggleImg({ item })}>

        {item.isSelected && <Image source={require('./Images/select.png')}
          style={[styles.list_circle, { width: 25, height: 25, borderRadius: 12.5, marginLeft: 15, marginRight: 15, marginBottom: 5 }]} />}

        {!item.isSelected && <Image source={''}
          style={[styles.list_circle, { width: 25, height: 25, borderRadius: 12.5, marginLeft: 15, marginRight: 15, marginBottom: 5 }]} />}

        <Text style={item.id == 6 || item.id == 7?[styles.DefaultSub_week_Text,{color:"#00a5a4"}]:styles.DefaultSub_week_Text}>{item.title.substring(0,3)}</Text>
      </TouchableOpacity>
    </View>
  );

  editWindowMode = () => {
    TrackHistory("Edit","Click Edit","","","","Goal Summary","");
    global.setG_weekdayArr=[];
    global.setG_weekendArr=[];

    for (let userObject of global.dayArr) {
      if(userObject.isSelected && (userObject.id == '7' || userObject.id == '6'))
      {
        var Obj = {
          title:userObject.title,
          id:userObject.id,
         }
        global.setG_weekendArr.push(Obj);
      }
      else if(userObject.isSelected)
      {
        var Obj = {
          title:userObject.title,
          id:userObject.id,
         }
          global.setG_weekdayArr.push(Obj);
      }
     }

     if(this.state.editMode){
     var body_data = {
      user_id:global.personalInfo.user_id,
      target_level_id:this.state.destination_level_id,
      number_of_words:this.state.wordsDay,
      avg_time:this.state.avg_time,
      weekdays:JSON.stringify(global.setG_weekdayArr),
      weekend:JSON.stringify(global.setG_weekendArr),
      course_id:this.state.course_id, 
     }

     console.log(JSON.stringify(body_data));
     this.loadAPI('2',global.base_url+'setGoalSummary',"POST",body_data);
    }


    this.setState({ editMode: !this.state.editMode });
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
          if(responseText.code == 200){
            var _data = responseText.data;
            console.log(JSON.stringify(responseText));
           
        if(_data.popup == 1){
        Alert.alert(
          _data.message,
          "\n\n\n\n"+global.TextMessages.SUMMY_ALERT_MSG,
          [
            { text: "Continue", onPress: () => this.loadScreen() ,style: 'destructive'}
          ],
          { cancelable: false }
        );
        }
        else
        {
          this.loadScreen();
        }
            
            
          }
        }
        else if(data_type === '3')
        {
          this.upadteScrees(responseText);
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
  upadteScrees=(responseText)=>
  {
    console.log(JSON.stringify(responseText));
    if(responseText.code == 200){
      var resp = responseText.data;


      var weekDaysArr = JSON.parse(resp.weekdays);
      var weekendArr = JSON.parse(resp.weekend);
      //global.personalInfo.current_level_id = resp.current_level_id;
      for(var i= 0;i < global.dayArr.length;i++)
      {
        for(var j= 0;j < weekDaysArr.length;j++)
        {
           if(weekDaysArr[j].id == global.dayArr[i].id )
           global.dayArr[i].isSelected = true;
        }
        for(var k= 0;k < weekendArr.length;k++)
        {
           if(weekendArr[k].id == global.dayArr[i].id )
           global.dayArr[i].isSelected = true;
        }
      }      
      var isExists = false;
      var isWordCountExists = false;
      for(let i=0;i<TimeArray.length;i++){
        var tempObj = TimeArray[i];
        if(tempObj.value==resp.avg_time){
          isExists = true;
          break;
        }
      }
      if(!isExists){
        var tempObj = {"label":"'"+resp.avg_time+"'","value":resp.avg_time};
        TimeArray.push(tempObj);
      }

      for(let i=0;i<WordCountArray.length;i++){
        var tempObj = WordCountArray[i];
        if(tempObj.value==resp.number_of_words){
          isWordCountExists = true;
          break;
        }
      }
      if(!isWordCountExists){
        var tempObj = {"label":"'"+resp.number_of_words+"'","value":resp.number_of_words};
        WordCountArray.push(tempObj);
      }
     
      this.setState({destination_level_id:parseInt(resp.target_level_id)});
      this.setState({wordsDay:parseInt(resp.number_of_words)});
      this.setState({avg_time:parseInt(resp.avg_time)});
      this.setState({expected_target_date:moment(resp.expected_target_date).format("DD-MMM-YYYY")});
      this.setState({course_name:resp.course_name});
      this.setState({course_id:resp.course_id});


      var body_data = {
        app_id:"1"
       }
       this.loadAPI('1',global.base_url+'getLevelList',"POST",body_data);

    
    }
  }
  loadScreen=()=>
  {
    var body_data = {
      user_id:global.personalInfo.user_id
     }
     this.loadAPI('3',global.base_url+'getGoalSummary',"POST",body_data);
  }

  loadLevelList=(responseText)=>{
    console.log(JSON.stringify(responseText));
    if(responseText.code == 200){
      var resp = responseText.data;
      var _levels = [];
      var count = 0;
      for (let userObject of resp.reverse()) {

          if(userObject.cefr_id === global.personalInfo.current_level_id)
          {

            global.personalInfo.current_level_text = userObject.cefrDetails;
            global.personalInfo.current_level_ = userObject.cefrName;


          }
          if(userObject.cefr_id === this.state.destination_level_id)
          {
            this.setState({destination_level_text:userObject.cefrDetails})
            this.setState({destination_level:userObject.cefrName})
          }

          count++;
          var Obj = {
            title :`${userObject.cefrName} ${userObject.cefrDetails}`,
            id: parseInt(userObject.cefr_id),
          }
        _levels.push(Obj);
       }
       this.setState({cus_levels:_levels});  
    }
   else {  // for testing
   }

  }
  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    this.loadScreen();
  }

  

  render() {
    const tempDate = this.state.expected_target_date;
    return (
      <ScrollView style={[styles.mainContainer, { backgroundColor:"#ffffff",width: screenWidth }]}>
        <ImageBackground style={[styles.logo]} source={require('./Images/setGImage07.png')}>
          <View style={styles.topView}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text=''
                />
              </View>
              {!this.state.editMode && <Text onStartShouldSetResponder={()=>this.editWindowMode()}style={[styles.DefaultBoldText,{color:"#ffffff",marginRight:10}]}>{global.TextMessages.SUMY_EDIT_ID}</Text>}
              {this.state.editMode && <Text onStartShouldSetResponder={()=>this.editWindowMode()}style={[styles.DefaultBoldText,{color:"#ffffff",marginRight:10}]}>{global.TextMessages.SUMY_SAVE_ID}</Text>}
            </View>
          </View>
        </ImageBackground>
        <Text style={[styles.headerTitle, { marginLeft: 10, marginTop: -165, }]} >{global.TextMessages.SUMY_TITLE_ID}</Text>
        {!this.state.editMode && <Text style={[styles.headerTitle,{marginLeft:10,marginTop:5}]} >{this.state.course_name}</Text>}
        {this.state.editMode && 
        <View style={[styles.horizontalViewStyle, {justifyContent:'flex-start', ...(Platform.OS !== 'android' && { zIndex: 5 }) }]} onStartShouldSetResponder={()=> global.navigation.navigate("SetGoal01Screen",{parent:"DashBoard"})}>
        <Text style={[styles.headerTitle,{marginLeft:10,marginTop:5}]} >{this.state.course_name}</Text>
        <Image style={[styles.ins_icon, {height:20,width:20, marginLeft:4,marginTop:7 }]} source={require('./Images/editIcon.png')}></Image>
        </View>}

        <View style={styles.cornerContainer}>
          <View style={[styles.centerView, { marginTop:0,marginBottom:0,width: '100%' }]}>
            <FlatList
             style={{width:screenWidth}}
              data={global.dayArr}
              horizontal={true}
              renderItem={this.renderItem}
              keyExtractor={item => item.id}
              extraData={this.state}
            />
          </View>
          {this.state.cus_levels.length?
          <View style={{marginTop:0,height:this.state.cus_levels.length*30}}>
          <FlatList
            data={this.state.cus_levels}
            renderItem={this.renderCefr}
            keyExtractor={item => item.cefr_id}
            extraData={this.state}
          />

          </View>:<View/>
          }

          
          <View style={styles.centerView}>
            <View style={styles.line}></View>
          </View>
          
          <View style={styles.horizontalViewStyle}>

            <View style={styles.twoPart}>
              {
                <Text style={[styles.headerTitle,{color:"#4e4e4e"}]}>{this.state.avg_time}</Text>
              }

              {/* {this.state.editMode &&
                <View style={{ ...(Platform.OS !== 'android' && { zIndex: 5 }) }}>
                  <View style={[styles.horizontalViewStyle, styles.centerView]}>
                    <DropDownPicker

                      dropDownMaxHeight={80}
                      style={[{ borderWidth: 0, borderBottomWidth: 0, width: 100, marginLeft: 30 }]}
                      selectedLabelStyle={[styles.Title]}
                      defaultValue={this.state.avg_time}
                      items={TimeArray}
                      defaultIndex={0}
                      ccontainerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                      itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                      dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
                      labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
                      onChangeItem={item => this.setState({avg_time:item.value})}
                    />
                    <Image style={[styles.ins_icon, {height:20,width:20, marginLeft: 0 }]} source={require('./Images/editIcon.png')}></Image>
                  </View>
                </View>
              } */}

              <Text style={styles.SubTitle}>{global.TextMessages.SUMY_MINDAY_ID}</Text>

            </View>

            <View style={styles.twoPart}>
              {
                <Text style={[styles.headerTitle,{color:"#4e4e4e"}]}>{this.state.wordsDay}</Text>
              }

              {/* {this.state.editMode &&
                <View style={[{ ...(Platform.OS !== 'android' && { zIndex: 3 }) }]}>
                  <View style={[styles.horizontalViewStyle, styles.centerView, { ...(Platform.OS !== 'android' && { zIndex: 5 }) }]}>

                    <DropDownPicker
                      dropDownMaxHeight={80}
                      style={[{ borderWidth: 0, borderBottomWidth: 0, width: 100, marginLeft: 30 }]}
                      selectedLabelStyle={[styles.Title]}
                      defaultValue={this.state.wordsDay}
                      items={WordCountArray}
                      defaultIndex={0}
                      containerStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                      itemStyle={styles.DefaultSubText,{justifyContent: 'flex-start'}}
                      dropDownStyle={[styles.DefaultSubText,{justifyContent: 'flex-start'}]}
                      labelStyle={[styles.DefaultSubText,{textAlign: 'left'}]}
                      onChangeItem={item => this.setState({wordsDay:item.value})}
                    />
                    <Image style={[styles.ins_icon, {height:20,width:20, marginLeft: 0 }]} source={require('./Images/editIcon.png')}></Image>
                  </View>
                </View>
              } */}

              <Text style={styles.SubTitle}>{global.TextMessages.SUMY_WORDDAY_ID}</Text>

            </View>

          </View>


          <View style={styles.centerView}>
            <View style={styles.line}></View>
          </View>

          <View style={styles.onePart}>
            <Text style={styles.SubTitle}>{global.TextMessages.SUMY_TARGET_DATEMSG_ID}</Text>
            <Text style={[styles.headerTitle,{color:"4e4e4e"}]}>{tempDate}</Text>
          </View>


            {!this.state.editMode &&
              <PrimaryButton
                text={global.TextMessages.SUMY_CONTINUE_ID}
                onPress={() => {
                    global.screenInfo.end_time = new Date().getTime();
                    TrackHistory("Continue","Click Continue","","","","Goal Summary","Dashboard"); 
                    global.navigation.navigate('DashBoard')
                  }}
              />
            }

            {this.state.editMode &&
              <PrimaryButton
                text={global.TextMessages.SUMY_SAVE_ID}
                onPress={() => this.editWindowMode()}
              />
            }


          {!this.state.editMode &&
            
              <PrimarySkipButton
                text={global.TextMessages.SUMY_EDITGOAL_ID}
                onPress={() => this.editWindowMode()}
              />
            
          }
        </View>
      </ScrollView>
    );
  }
}
export default GoalSummary;
