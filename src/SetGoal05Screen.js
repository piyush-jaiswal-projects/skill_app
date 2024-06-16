import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,FlatList,Dimensions} from 'react-native';
import PrimaryButton from './component/Button';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';
import {TrackHistory} from './utill/Network'; 
import moment from "moment";


const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const labels = ["","","","","","",""];

const selectImage = require('./Images/select.png');
const unselectImage = require('./Images/next.png');


class SetGoal05Screen extends React.Component {
  constructor(props){
    super(props);

    this.state = {
     isUpdate:false,
   };

  }
  clickContinue=()=>{
    
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
     
     if(global.setG_weekdayArr.length > 0 || global.setG_weekendArr.length > 0)
     {
        


        var body_data ={
          user_id:global.personalInfo.user_id,
          course_id:global.courseid,
          datetime:moment().format("HH:mm:ss DD-MM-YYYY"),
          weekdays:JSON.stringify(global.setG_weekdayArr),
          weekend:JSON.stringify(global.setG_weekendArr),
          time_and_day:"[]",
          finish_target:global.setG_num_of_days,
          goal_time:JSON.stringify({"hour":"00","min":"00"}),
          goal_start_date:new Date(global.setG_startDate).getTime(),
          goal_end_date:new Date(global.setG_endDate).getTime(),
          updated:false

        }
        console.log(JSON.stringify(body_data));
        this.loadAPI('1',global.base_url+'createStudyPlan',"POST",body_data);


        // global.screenInfo.end_time = new Date().getTime();
        // TrackHistory("Continue","Click Continue","","","Step2","Step3");
        // global.navigation.navigate('SetGoal06Screen');
     }
     else
     {
       alert("Please select any day");
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




  toggleImg =({item})=>{
    if(item.isSelected)
    {
      item.isSelected = false;
    }
    else
    {
      item.isSelected = true;
    }

    this.setState({isUpdate:!this.state.isUpdate});
  }
  renderItem = ({item}) => (
    <TouchableOpacity onPress={()=>this.toggleImg({item})}>
      <View style={[styles.list_item_weekDay,{ height:30,borderStyle: "solid",borderRadius: 0,borderColor: "#f5f5f5",borderBottomWidth:1,borderBottomColor:""}]}>
      <Text style={item.id == 6 || item.id == 7?styles.list_title_weekend:styles.list_title}>{item.title}</Text>
      
      <Image style={[styles.list_circle,{marginTop:-5}]} source={item.isSelected ? selectImage:null}></Image>
      
      </View>
      </TouchableOpacity>
  );

  componentDidMount() {

    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }

  render() {
    return (
      <ScrollView style={[styles.mainContainer,{width:screenWidth}]}>
      <ImageBackground style={[styles.logo]} source={require('./Images/setGImage07.png')}>
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
      <Text style={[styles.stepStyle,{marginLeft:10,marginTop:-165}]} >Step 2</Text>
      <Text style={[styles.headerTitle,{marginLeft:10,marginTop:10}]} >Which days of the week would you like to learn?</Text>
      <Text style={[styles.HeaderSubTitle,{marginLeft:10}]} >Choose days as per your conveniece</Text>
      <View style={styles.cornerContainer}>
      <FlatList
        data={global.dayArr}
        renderItem={this.renderItem}
        keyExtractor={item => item.id.toString()}
        extraData={this.state}
      />

      <PrimaryButton
          text='Continue'
          onPress={() => this.clickContinue()}
        />

      </View>

      </ScrollView>



    );
  }
}
export default SetGoal05Screen;
