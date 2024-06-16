import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,FlatList,ActivityIndicator,Dimensions, Alert} from 'react-native';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';
import Modal from "react-native-modal";
import moment from "moment";
import {TrackHistory} from './utill/Network'; 
const labels = ["","","","","","",""];

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class SetGoal01Screen extends React.Component {

  constructor(props){
    super(props);

    this.state = {
        selectCourseMaterialId:'',
        selectCourseMaterialName:'',
        isLoading:true,
        courseMaterialArr:[],
        isShowcefr :false,
        ins_title:"",
        ins_dec:"",
        ins_img:"",
    }
  }
  renderItem = ({item}) => (
    <TouchableOpacity onPress={()=>this.clickItem({item})}>
      <View style={[styles.list_item_dynamic,{alignItems:'center'}]}>
      <View style={styles.list_title}>
      <View style={[styles.horizontalViewStyle,{justifyContent: 'flex-start',}]}>
      <Text style={styles.DefaultText}>{item.course}</Text>
      {item.is_show_info == 1 &&
      <TouchableOpacity onPress={()=>this.showPopUp1({item})}>
      <Image style={[styles.ins_icon,{marginLeft:5,marginTop:3,height:15,width:15}]} source={require('./Images/i.jpg') }></Image>
      </TouchableOpacity>
      }
      </View>
      {(item.course_description != null &&  item.course_description)?
        <Text style={[styles.DefaultSubText,{textAlign:"left"}]}>{item.course_description}</Text>:<View></View>
      }
      </View>

      <Image style={[styles.list_rightArrow]} source={require('./Images/next.png') }></Image>
      </View>
    </TouchableOpacity>
  );

  nextScreen=(responseText)=>{
    if(responseText.code == 200){
      var resp = responseText.data;
      global.screenInfo.end_time = new Date().getTime();
      TrackHistory("","","","","","CourseList","Lets get stared");
      global.navigation.navigate('SetGoal09Screen');
    }
   else
   {
   }
    this.setState({ isLoading: false });
  }

  showPopUp1 =({item})=>{
    TrackHistory(item.course,"Click Course InfoCourse","","","","","CourseList","Lets get stared");

    this.setState({ins_dec:item.info_description});
    this.setState({ins_title:item.info_title});
    this.setState({ins_img:item.info_image_url});
    this.setState({isShowcefr:!this.state.isShowcefr});


  }
  showPopUp =()=>{
      this.setState({isShowcefr:!this.state.isShowcefr});
  }

  clickItem =({item})=>{
    if(item.isActive === 1){
    global.courseid=item.course_id;
    TrackHistory(item.course,"Click Course","","","","","CourseList","Let's get stared");
     var body_data =
     {
         user_id:global.personalInfo.user_id,
         course_id:item.course_id,
         date_time:moment().format("DD-MM-YYYY"),
         payment_status:'completed',
         expiry:moment().format("YYYY"),
     }
     this.loadAPI('2',global.base_url+'setUserCourse',"POST",body_data);
    }
    else
    {
       
    }
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
  };

  loadCourseList=(responseText)=>{

    if(responseText.code == 200){
      var resp = responseText.data;
      console.log(JSON.stringify(resp));
      this.setState({courseMaterialArr:resp});
    }
   else {  // for testing
   }

  }

  componentDidMount() {
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";

    var body_data = {
     }
     this.loadAPI('1',global.base_url+'getCourse',"GET",body_data);
  }


  render() {

    const title_desc =  this.state.ins_dec;
    const title_text = this.state.ins_title;
    const title_img = this.state.ins_img;

    return (
      <ScrollView style={[styles.mainContainer,{width:screenWidth}]}>
      <ImageBackground style={[styles.logo]} source={require('./Images/step_1.png')}>
      
      </ImageBackground>

      <Text style={[styles.headerTitle,{marginLeft:10,marginTop:-120}]} >{global.TextMessages.OV_COURSE_TEXT_ID}</Text>
      {/*<Text style={[styles.HeaderSubTitle,{marginLeft:10}]} >Lets help you set your goal to learn faster</Text>*/}
      <View style={styles.cornerContainer}>
      <FlatList
        data={this.state.courseMaterialArr}
        renderItem={this.renderItem}
        keyExtractor={item => item.course_id.toString()}
      />
      </View>
      {this.state.isLoading && <ActivityIndicator color={"#000000"} />}

      <Modal animationType="fade"  isVisible={this.state.isShowcefr}>
        <View style={{flex: 1}}>
        </View>
        <View style={[styles.modalViewStyle,{flex: 3}]}>
        <View style={[styles.horizontalViewStyle, {marginTop:-10,justifyContent:'flex-end'}]}>
            <TouchableOpacity
               activeOpacity={1}
               style={[styles.wordblank]} onPress={() =>this.showPopUp()}>
                  <Image style={[styles.modalCloseStyle]} source={require('./Images/popup_close.png')}></Image>
             </TouchableOpacity>

        </View>
        <Text style={[styles.DefaultText,{textAlign:'left',marginLeft:5,marginBottom:10}]}>{title_text}</Text>
        <Text style={[styles.DefaultSubText,{textAlign:'left',marginLeft:5}]}>{title_desc}</Text>
        <Image style={[{flex:10,marginTop:5,width:'100%'}]} resizeMode="contain" source={{uri:title_img}}></Image>
        </View>
        <View style={{ flex: 1 }}>
        </View>
      </Modal>
     </ScrollView>


    );
  }
}

export default SetGoal01Screen;
