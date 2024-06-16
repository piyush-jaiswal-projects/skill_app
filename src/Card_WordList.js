import React from 'react';
import { ScrollView, View, ImageBackground, Image, StyleSheet, Text, TextInput, TouchableOpacity, Button, Dimensions ,ActivityIndicator} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import BackButton from './component/BackButton';
import SwipeCards from 'react-native-swipe-cards';
import Card_Word from './Card_Word';
import styles from './vocabStyleSheet/styles';
import CalendarPicker from 'react-native-calendar-picker';
import moment from "moment";
import {TrackHistory} from './utill/Network'; 
import PrimaryButton from './component/Button';
import BorderBtn from './component/borderBtn';


const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);


let wordId = {}
class Card_WordList extends React.Component {
  constructor(props) {
    super(props);
    global.navigation = this.props.navigation;
    wordId = this.props.route.params.wordId;
    this.state = {
      title_name: this.props.route.params.title,
      word_arr: [],
      isShowCaledar: false,
      currentDate: moment().format("DD-MM-YYYY"),
      isLoading:false,

      //selectedDate:new Date(Date.now()).getDay().toString() + "-" + new Date(Date.now()).getMonth().toString() + "-" + new Date(Date.now()).getYear().toString(),

    }
    this.setFavoriteWord=this.setFavoriteWord.bind(this);
    this.removeWord=this.removeWord.bind(this);
    this.isRecordedAudio=this.isRecordedAudio.bind(this);
  }


  loadAPI = (data_type, url, method, body_data) => {
    console.log(url+" "+JSON.stringify(body_data))
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
          console.log(JSON.stringify(responseText));
          this.setState({ isLoading: false });
          if (data_type === '1') {
            this.loadCourseList(responseText);
          }
          else if (data_type === '2') {
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
            this.loadWordOfday(responseText);
          } else if (data_type === '2') {
            this.loadwordList(responseText);
          }else if (data_type === '3') {

            this.loadQuizWord(responseText);
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
  shuffleArray =(array) =>{
    let i = array.length - 1;
    for (; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      const temp = array[i];
      array[i] = array[j];
      array[j] = temp;
    }
    return array;
  }

  loadwordList = (responseText) => {
    console.log(JSON.stringify(responseText));
    if (responseText.code == 200) {
      var resp = responseText.data;
      var events;
      if(global.isWordToggle)
         events = this.shuffleArray(resp);
      else  
        events =  resp;

      //var events = resp.sort((a, b) => a.word < b.word ? -1 : 1)
      if (typeof events != 'undefined' && events.length > 0) {
        global.WordArray = events;
        for (var i = 0; i < global.WordArray.length; i++) {
          if (this.props.route.params.parent == 'learn') {
             global.WordArray[i].word_date = moment(this.state.currentDate.toString(), "DD-MM-YYYY").format("DD MMMM YYYY");
          }
          global.WordArray[i].record = false;
        }
        wordId = global.WordArray[0].id;
        this.updateWord();
      }
    }
  }

  loadQuizWord = (responseText) => {

    if (responseText.code == 200) {
      var resp = responseText.data;
      console.log(JSON.stringify(resp))
        global.WordArray = new Array;
        global.WordArray[0] = resp;
        for (var i = 0; i < global.WordArray.length; i++) {
          global.WordArray[i].record = false;
        }
        wordId = global.WordArray[0].id;
        this.updateWord();
    }
  }


  loadWordOfday = (responseText) => {

    if (responseText.code == 200) {
      var resp = responseText.data;
      var events = resp.sort((a, b) => a.word < b.word ? -1 : 1)
      if (typeof events != 'undefined' && events.length > 0) {
        global.WordArray = events;
        for (var i = 0; i < global.WordArray.length; i++) {

        if (this.props.route.params.parent == 'learn') {
            global.WordArray[i].word_date = moment(this.state.currentDate.toString(), "DD-MM-YYYY").format("DD MMMM YYYY");
        }
          global.WordArray[i].record = false;
        }
        wordId = global.WordArray[0].id;
        this.updateWord();
      }

    }
    else {  // for testing
    }

  }
  componentDidMount() {
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";

    this._unsubscribe = navigation.addListener('focus', () => {
      console.log(this.props.route.params.parent);
      if (this.props.route.params.parent == 'wordList') {
          wordId = this.props.route.params.wordId;
          this.updateWord();
          // do something
      } else if (this.props.route.params.parent == 'learn') {
        if(this.props.route.params.wordId!=""){
          wordId = this.props.route.params.wordId;
          this.updateWord();
        }
        else{
        var body_data = {
          user_id: global.personalInfo.user_id,
          level: global.personalInfo.current_level_id,
          lastWords: "1"
        }
        console.log(JSON.stringify(body_data));
        this.loadAPI('2', global.base_url+'getWordListForUser', "POST", body_data);
      }
      }
      else if (this.props.route.params.parent == 'Favourites') {
        
        var body_data = {
          user_id: global.personalInfo.user_id,
        }
        this.loadAPI('2', global.base_url+'getFavWord', "POST", body_data);
      }else if (this.props.route.params.parent == 'quiz') {
        
        var body_data = {
          user_id: global.personalInfo.user_id,
          word_id: this.props.route.params.wordId
        }
        this.loadAPI('3', global.base_url+'showWord', "POST", body_data);
      }
      else {
        var body_data = {
          user_id: global.personalInfo.user_id,
          date: this.state.currentDate.toString(),
        }
        this.loadAPI('1', global.base_url+'getWordofDay', "POST", body_data);
      }
        // do something
    });
  
  }

  updateWord() {
    var tempArray = JSON.parse(JSON.stringify(global.WordArray));
    var currentIndex = global.WordArray.findIndex(k => k.id == wordId);
    var wordLeft = tempArray.splice(0, currentIndex);
    var finalArray = [];
    if (this.props.route.params.parent == 'learn') {
      finalArray = tempArray;
    }else{
     finalArray = tempArray.concat(wordLeft);
    }
    if (this.props.route.params.parent == 'learn') {
      for (var i = 0; i < finalArray.length; i++) {
         finalArray[i].word_date = moment(this.state.currentDate.toString(), "DD-MM-YYYY").format("DD MMMM YYYY");
          finalArray[i].record = false;
        }  
      }
    
    this.setState({ word_arr: finalArray });
  }

  removeSwipe(word) {
    global.screenInfo.end_time = new Date().getTime();
    TrackHistory("Swipe","Click Swipe",word.id,"","","Word Card","");
    if(this.parant == "quiz" )
    {
      global.navigation.navigate("WordQuestion", {wordId: word.id,parent:"word"})
    } 
  }

  setFavoriteWord(word_id) {
    var tempArray = JSON.parse(JSON.stringify(this.state.word_arr));
    var currentIndex = tempArray.findIndex(k => k.id === word_id);
    var word = tempArray[currentIndex];
    if(word.isFavourite === 1)
      word.isFavourite = 0;
    else
       word.isFavourite = 1;
    var wordLeft = tempArray.splice(0, currentIndex);
    var finalArray = tempArray.concat(wordLeft);
    this.setState({ word_arr: finalArray });
  }
  removeWord(word_id) {
    
    if(this.props.route.params.parent == "quiz" )
    {
      global.navigation.navigate("WordQuestion", {wordId: word_id,parent:"word"})
    }
    else
    {
    var tempArray = JSON.parse(JSON.stringify(this.state.word_arr));
    var currentIndex = tempArray.findIndex(k => k.id === word_id);
    var wordLeft = tempArray.splice(0, currentIndex+1);
    this.setState({ word_arr: tempArray});
    }
  }
  isRecordedAudio(word_id) {
    var tempArray = JSON.parse(JSON.stringify(this.state.word_arr));
    var currentIndex = tempArray.findIndex(k => k.id === word_id);
    var word = tempArray[currentIndex];
    word.record = true;
    var wordLeft = tempArray.splice(0, currentIndex);
    var finalArray = tempArray.concat(wordLeft);
    this.setState({ word_arr: finalArray });


  }
  onDateChange = (date) => {
    this.state.currentDate = date.format('DD-MM-YYYY');

    this.setState({ isShowCaledar: !this.state.isShowCaledar })
    var body_data = {
      user_id: global.personalInfo.user_id,
      date: date.format("DD-MM-YYYY"),

    }
    this.loadAPI('1', global.base_url+'getWordofDay', "POST", body_data);
  }

  openCalendar = () => {
    this.setState({ isShowCaledar: !this.state.isShowCaledar })
  }
  callNextSession=()=>{
    var body_data = {
      user_id: global.personalInfo.user_id,

    }
    this.loadAPI('2', global.base_url+'getExtraWordListForUser', "POST", body_data);
  }
  callRetry=()=>{
    // console.log(this.state.word_arr);
    // var tempArray = global.WordArray;
    if (this.props.route.params.parent === 'learn') 
    {
      var body_data = {
        user_id: global.personalInfo.user_id,
        level: global.personalInfo.current_level_id,
        lastWords: "1"
      }
      console.log(JSON.stringify(body_data));
      this.loadAPI('2', global.base_url+'getWordListForUser', "POST", body_data);



    //   for (var i = 0; i < tempArray.length; i++) {
    //     tempArray[i].word_date = moment(this.state.currentDate.toString(), "DD-MM-YYYY").format("DD MMMM YYYY");
    //     tempArray[i].record = false;
    //     }
    //  this.setState({word_arr: tempArray});  
     
    }
  }

  render() {
   
    return (
      <View style={styles.mainContainer}>
        <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={styles.topView}>
          <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 30 }]}>
            <View style={[styles.topView_bottom_TitleArrow]}>
              <BackButton
                text={this.state.title_name}
              />
            </View>
            {this.props.route.params.parent == 'dashboard' &&
              <View onStartShouldSetResponder={() => this.openCalendar()} style={{ alignItems: "flex-end", width: "30%", justifyContent: "center" }}>
                <Image style={[styles.hamburgIcon, { marginRight: 20 }]} source={require('./Images/calendar_icon.png')} />
              </View>
            }
            {this.props.route.params.parent == 'learn' &&
              <View onStartShouldSetResponder={() =>  {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("","","","","","cardWord test","WordList");
                global.navigation.navigate("WordList",{source:"cardWord"});
                }} style={{ alignItems: "flex-end", width: "30%", justifyContent: "center" }}>
                <Image style={[{width:30,height:21, marginRight: 20,tintColor:"#ffffff" }]} source={require('./Images/wlListIcon.png')} />
              </View>
            }
          </View>


        </LinearGradient>
        {!this.state.isLoading &&  <SwipeCards
          cards={this.state.word_arr}
          parant={this.props.route.params.parent}
          loop={this.props.route.params.parent === 'learn'?false:true}
          renderCard={(cardData) => <Card_Word {...cardData} removeWord={this.removeWord} setFavoriteWord={this.setFavoriteWord} isRecordedAudio={this.isRecordedAudio}    />}
          renderNoMoreCards={() => <ScrollView style={[styles.word, {width:screenWidth-20,height:screenHeight-200,marginTop:-100,background:"#ffffff"}]}>
          <View style={[styles.horizontalViewStyle,{marginTop:10}]}>
            <Text style={[styles.DefaultSubText, { textAlign: 'left', fontWeight: "600", color: "#c5c5c5",marginLeft:20 }]}>{moment().format("DD MMMM YYYY")}</Text>
            
          </View>
          <View style={{alignItems:"center" ,justifyContent: "center" }}>
                <Image style={[styles.hamburgIcon, {height:75,width:75, marginTop: 50,marginBottom: 50}]} source={require('./Images/showMore.png')} />
          </View>
          {/* You have seen today's words.
          {"\n"}{"\n"} */}
          <Text style={[styles.WordTitle, { textAlign:"center",fontWeight: "normal",color: "#4e4e4e",marginLeft:40,marginRight:40 }]}>
           Do you want to see more words?</Text>
          <BorderBtn
              text='Not now'
              onPress={() => this.callRetry()}
          />
          <PrimaryButton
              text='Next Session'
              onPress={() => this.callNextSession()}
            />
          </ScrollView>}
          yupView={() => <View></View>}
          containerStyle={styles.wordblank}
          yupStyle={styles.wordblank}
          nopeStyle={styles.wordblank}
          maybeStyle={styles.wordblank}
          yupTextStyle={styles.wordblank}
          nopTextStyle={styles.wordblank}
          maybeTextStyle={styles.wordblank}
          noView={() => <View></View>}
          maybeView={() => <View></View>}
          handleYup={this.removeSwipe}
          handleNope={this.removeSwipe}
          handleMaybe={this.removeSwipe}
          hasMaybeAction={this.removeSwipe}

        />}
        {this.state.isShowCaledar &&
          <View style={{ backgroundColor: "#ffffff", flex: 1, position: 'absolute', width: screenWidth, height: screenHeight - 100, marginTop: 100 }}>
            <CalendarPicker
              todayBackgroundColor="#ffffff"
              selectedDayColor="#14b3d0"
              onDateChange={this.onDateChange}
            /></View>}
      {this.state.isLoading && <ActivityIndicator size="large" color={"#d33131"} />}
      </View>

    );
  }
}
export default Card_WordList;
