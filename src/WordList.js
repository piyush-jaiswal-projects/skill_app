import React, { Component } from 'react';
import { SectionList, StyleSheet, PixelRatio, Text, View, Image, Dimensions, TouchableOpacity, ActivityIndicator, ScrollView } from 'react-native';
import { SearchBar } from 'react-native-elements';
import styles from './vocabStyleSheet/styles';
import { LinearGradient } from 'expo-linear-gradient';
import { TrackHistory } from './utill/Network';
import BackButton from './component/BackButton';
import PrimaryButton from './component/Button';
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
const fontFactor = PixelRatio.getFontScale();
let events = [];
let finalArray = [];
let FavWordList = [];
let LearnWordList = [];
let AllWordList = [];
let TodayWordList = [];
let Page = 0;
let Limit = 30;
export default class WordList extends Component {

  events = [];
  finalArray = [];
  FavWordList = [];
  LearnWordList = [];
  AllWordList = [];
  page = 0;
  // create groups containers from names
  constructor(props) {
    super(props);
    global.navigation = this.props.navigation;

  }
  
  state = {
    search: '',
    renderArray: [],
    isLoading: false,
    isAll: true,
    isFav: false,
    isLearn: false,
    isToday: false
  };
  updateSearch = (search) => {
    let RenderArray = [];
    if (search.length > 0) {
      let tempArray = [];
      let SearchData = [];
      if (this.state.isAll) {
        SearchData = AllWordList;
      } else if (this.state.isFav) {
        SearchData = FavWordList;
      } else if (this.state.isLearned) {
        SearchData = LearnWordList;
      } else if (this.state.isToday) {
        SearchData = TodayWordList;
      }

      SearchData.forEach(k => {
        if ((k.word).toLowerCase().indexOf(search.toLowerCase()) >= 0) {
          tempArray.push(k)
        }
      });
      RenderArray.push({ title: search, data: tempArray });
      this.setState({ search: search, renderArray: RenderArray });
    } else {
      if (this.state.isAll) {
        this.getAllWord();
        this.setState({ search: search });
      } else if (this.state.isFav) {
        this.getFavWords();
        this.setState({ search: search });
      } else if (this.state.isLearned) {
        this.getLearnWord();
        this.setState({ search: search });
      } else if (this.state.isToday) {
        this.getTodayWord();
        this.setState({ search: search });
      }
    }


  };

  /*getAllWords = () => {
    this.setState({ renderArray: finalArray, isFav: false, isAll: true, isLearn: false });
  }*/

  renderSeparator = () => {
    return (
      <View
        style={{
          height: 1,
          width: "100%",
          backgroundColor: "#f5f5f5",
          marginStart: 10,
          marginEnd: 10
        }}
      />
    );
  };


  loadAPI = (data_type, url, method, body_data) => {
    console.log(url + " " + JSON.stringify(body_data))
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
          if (responseText.code == 200) {
            console.log(JSON.stringify(responseText));
            if (data_type === '1') {
              TodayWordList = responseText.data;
              //  events.concat(responseText.data).sort((a, b) => a.word < b.word ? -1 : 1)
              if (this.state.isToday) {
                this.loadwordList(responseText.data);
              }
            }
            else if (data_type === '2') {
              AllWordList = AllWordList.concat(responseText.data.words);
              if (this.state.isAll) {
                this.loadwordList(responseText.data.words);
              }
            } else if (data_type === '3') {
              LearnWordList = responseText.data;
              if (this.state.isLearn) {
                this.loadwordList(responseText.data);
              }
            } else if (data_type === '4') {
              FavWordList = responseText.data;
              if (this.state.isFav) {
                this.loadwordList(responseText.data);
              }
            }
            else {
              alert('unknown api call')
            }
          }
        })
        .catch(error => {
          alert(error);
        });
    }
  };

  loadFavWord = () => {
    finalArray = [];
    events = FavWordList.sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(error){}})
    this.RenderWords();
  }

  loadLearnWords = () => {
    finalArray = [];
    events = LearnWordList.sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(error){}})
    this.RenderWords();
  }

  loadTodayWord = () => {
    finalArray = [];
    events = TodayWordList.sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(error){}})
    this.RenderWords();
  }

  loadAllWords = () => {
    finalArray = [];
    events = AllWordList.sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(error){}})
    this.RenderWords();
  }

  loadwordList = (response) => {
    var resp = response;
    finalArray = [];
    events = events.concat(resp).sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(error){}})
    this.RenderWords();
  }


  RenderWords = () => {
    global.WordArray = events;
    const groupNames = Array.from(new Set(events.map(k => k?k.word.toUpperCase().slice(0, 1):"")))
    let groups = {}
    groupNames.forEach(k => {
      if(k!=null){
      groups[k] = []
      }
    })

    // iterate by events and attach every to given group based on its month
    events.forEach(k => {
      if(k!=null){
      const month = k.word.toUpperCase().slice(0, 1)
      groups[month].push(k)
      }
    })

    groupNames.forEach(k => {
      if(k!=null){
      finalArray.push({ title: k, data: groups[k] })
      }
    })
    this.setState({ renderArray: finalArray });

  }

  componentDidMount() {
    //global.WordArray = [];
    FavWordList = [];
  LearnWordList = [];
    this._unsubscribe = navigation.addListener('focus', () => {
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    events = [];
    if (this.props.route.params.source == 'dashboard') {
      this.getAllWord();
    }
    else if (this.props.route.params.parent == 'Favourites') {
      this.getFavWords();
    } else {
      console.log(this.props.route.params.source);
      this.setState({ isLoading: true });
      this.setState({ renderArray: [], isFav: false, isAll: false, isLearn: false, isToday: true });
      var body_data = {
        user_id: global.personalInfo.user_id,
        level: global.personalInfo.current_level_id,
        lastWords: "1"
      }
      this.loadAPI('1', global.base_url+'getWordListForUser', "POST", body_data);
    }
  });
  }

  getFavWords = () => {
    this.setState({ renderArray: [], isFav: true, isAll: false, isLearn: false, isToday: false });
    events = [];
    if (FavWordList.length > 0) {
      this.loadFavWord();
    } else {
      this.setState({ isLoading: true });
      var body_data = {
        user_id: global.personalInfo.user_id,
      }
      this.loadAPI('4', global.base_url+'getFavWord', "POST", body_data);
    }
  };

  getAllWord() {
    events = [];
    this.setState({ renderArray: [], isFav: false, isAll: true, isLearn: false, isToday: false });
    if (AllWordList.length > 0) {
      this.loadAllWords();
    } else {
      if (!this.state.isLoading) {
        console.log(this.props.route.params.source);
        this.setState({ isLoading: true });
        var body_data = {
          page: Page,
          limit: Limit,
        }
        this.loadAPI('2', global.base_url+'getWordList', "POST", body_data);
      }
    }
  }


  getTodayWord() {
    events = [];
    this.setState({ renderArray: [], isFav: false, isAll: false, isLearn: false, isToday: true });
    if (TodayWordList.length > 0) {
      this.loadTodayWord();
    } else {
      this.setState({ isLoading: true });
      var body_data = {
        user_id: global.personalInfo.user_id,
        level: global.personalInfo.current_level_id,
        lastWords: "1"

      }
      this.loadAPI('1', global.base_url+'getWordListForUser', "POST", body_data);
    }
  }

  getLearnWord = () => {
    events = [];
    this.setState({ renderArray: [], isFav: false, isAll: false, isLearn: true, isToday: false });
    if (LearnWordList.length > 0) {
      this.loadLearnWords();
    } else {
      this.setState({ isLoading: true });
      var body_data = {
        user_id: global.personalInfo.user_id,
      }
      this.loadAPI('3', global.base_url+'getLearnedWords', "POST", body_data);
    }
  };



  render() {
    return (
      <View style={[styles.mainContainer, { marginTop: 0, justifyContent: "flex-start", height: screenHeight }]}>
        <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={[styles.topView, { height: 150, paddingTop: 40 }]}>
          <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 10 }]}>
            <View style={[styles.topView_bottom_TitleArrow]}>
              <BackButton
                text={this.props.route.params.source === 'dashboard' ? 'Word List' : (this.props.route.params.source === 'Favourite'?'Favourite':'learn')}
              />

            </View>
            {this.props.route.params.source != 'dashboard' && <View onStartShouldSetResponder={() => { 
              global.screenInfo.end_time = new Date().getTime();
              TrackHistory("CardIcon", "Click", "","","", "WordList", "WordCard");
              global.navigation.navigate("Card_WordList", { wordId: "", title: "Learn", parent: "learn" }); 
               }}>
              <Image style={{ alignSelf: 'flex-end', width: 30, height: 30, position: "relative", marginEnd: 30, paddingStart: 10 }} resizeMode="contain" source={require('./Images/card_icon.png')}></Image>
            </View>}
          </View>
          {/*} <View style={{ flexDirection: "row", justifyContent: "space-between" }}>

            <View style={{ flex: 1, justifyContent: "flex-end", alignItems: "flex-end" }}>
              <Image style={{ alignSelf: 'flex-end', width: 20, height: 20, position: "relative", marginEnd: 30, paddingStart: 10 }} source={require('./Images/search_icon.png')}></Image>
            </View>
          </View>*/}
        </LinearGradient>
        <View style={[styles.cornerContainer, { height: screenHeight - 100, position: "relative", padding: 5, marginTop: -50, marginStart: 10, marginEnd: 10 }]}>
          {this.props.route.params.source == 'dashboard' && <View style={{ borderRadius: 10, marginLeft: 20, marginBottom: 20, marginEnd: 20, height: 30, marginTop: 15, backgroundColor: "#ebebed", flexDirection: "row", justifyContent: "space-evenly" }}>
            <View onStartShouldSetResponder={() => { this.getAllWord(); TrackHistory("AllWord", "Click", "", "","", "WordList", ""); }} style={{ width: "33%", borderRadius: 10, justifyContent: "center", alignItems: "center", backgroundColor: this.state.isAll ? global.colors.WL_SLETD_BGCOLOR : "#ebebed" }}>
              <Text style={{ fontSize: 15 / fontFactor, color: this.state.isAll ? "#ffffff" : "#000000" }}>{global.TextMessages.WL_ALLW_ID}</Text>
            </View>
            <View style={{ backgroundColor: "#999999", width: 1, marginTop: 5, marginBottom: 5 }}></View>
            <View onStartShouldSetResponder={() => { this.getLearnWord(); TrackHistory("Learnt", "Click", "", "","", "WordList", ""); }} style={{ width: "33%", borderRadius: 10, justifyContent: "center", alignItems: "center", backgroundColor: this.state.isLearn ? global.colors.WL_SLETD_BGCOLOR : "#ebebed" }}>
              <Text style={{ fontSize: 15 / fontFactor, color: this.state.isLearn ? "#ffffff" : "#000000" }}>{global.TextMessages.WL_LEARNTW_ID}</Text>
            </View>
            <View style={{ backgroundColor: "#999999", width: 1, marginTop: 5, marginBottom: 5 }}></View>
            <View onStartShouldSetResponder={() => { this.getFavWords(); TrackHistory("Favorites", "Click", "", "","", "WordList", ""); }} style={{ width: "33%", borderRadius: 10, justifyContent: "center", alignItems: "center", backgroundColor: this.state.isFav ? global.colors.WL_SLETD_BGCOLOR : "#ebebed" }}>
              <Text style={{ fontSize: 15 / fontFactor, color: this.state.isFav ? "#ffffff" : "#000000" }}>{global.TextMessages.WL_FAVW_ID}</Text>
            </View>
          </View>}
          {this.props.route.params.source == 'dashboard' && this.state.renderArray.length!=0 && <SearchBar
            placeholder="Type Here..."
            fontSize={15 / fontFactor}
            onChangeText={this.updateSearch}
            value={this.state.search}
            autoCorrect={false}
            lightTheme={true}
            round={true}
          />}
          {(this.props.route.params.source != 'dashboard' && this.props.route.params.parent != 'Favourites' ) && <Text style={[styles.DefaultBoldSubText, { width: "100%", textAlign: "left", margin: 20, marginLeft: 5 }]}>{global.TextMessages.WL_TW_ID}</Text>}
          {(this.props.route.params.parent == 'Favourites') && <Text style={[styles.DefaultBoldSubText, { width: "100%", textAlign: "left", margin: 20, marginLeft: 5 }]}>Words</Text>}
          
          <ScrollView
            onMomentumScrollEnd={() => {
              if (!this.state.isLoading && this.state.isAll && this.props.route.params.source == 'dashboard') {
                Page = Page + 1;
                this.setState({ isLoading: true });
                var body_data = {
                  page: Page,
                  limit: Limit,
                }
                this.loadAPI('2', global.base_url+'getWordList', "POST", body_data);
              }
            }
            }>
            <View style={{ paddingBottom: 50 }}>
              <SectionList
                sections={this.state.renderArray}
                renderItem={({ item }) =>
                  <TouchableOpacity onPress={() => { 
                    global.screenInfo.end_time = new Date().getTime();
                    TrackHistory("Word", "Click", item.id,"","", "WordList", "WordCard"); 
                    global.navigation.navigate("Card_WordList", { wordId: item.id, title: "Learn", parent: this.state.isToday ? "learn" : "wordList" });
                     
                    }}>
                    <View style={{ justifyContent: 'space-between', flexDirection: "row" }}>
                      <Text style={[localstyles.item, { flex: 1 }]}>{item.word.replace(/\\'/g, "'")}</Text>
                      <View style={{ flexDirection: "row", justifyContent: "flex-end", alignItems: "flex-end" }}>
                        <Image style={{ width: 13, height: 13, alignSelf: "center", resizeMode:"stretch"}} source={item.isFavourite ? require('./Images/fillstar.png') : require('./Images/empty_star.png')}></Image>
                        <Text style={[localstyles.item, { alignSelf: "center", color: "#999999", fontSize: 15 / fontFactor }]}>{item.fav_count}</Text>
                      </View>
                    </View>
                  </TouchableOpacity>
                }
                renderSectionHeader={this.props.route.params.source != 'dashboard'?null:({ section }) =>
                  <View>
                    <Text style={localstyles.sectionHeader}>{section.title}</Text>
                  </View>
                }
                ItemSeparatorComponent={this.renderSeparator}
                keyExtractor={(item, index) => index.toString()}
              />
              {this.state.isLoading &&
                <View>
                  <ActivityIndicator style={{ paddingBottom: 100 }} size="large" color={"#d33131"} />
                  <View style={{ height: 100, width: 100, backgroundColor: "ffffff" }} /></View>}


                  {!this.state.isLoading && this.state.isLearn && this.state.renderArray.length==0 &&<View style={{marginStart:15,marginEnd:15,justifyContent:"center",height:screenHeight-300}}>
                    <Text style={[styles.WordTitle,{color:"#dbdbdb",textAlign:"center",marginBottom:40}]}>You haven't learned any word yet.</Text>
                  
                    <PrimaryButton
                    text='Learn Now'
                    onPress={()=>{global.screenInfo.end_time = new Date().getTime();TrackHistory("Word", "Click", "", "","", "WordList", "WordCard"); 
                    global.navigation.navigate("Card_WordList", { wordId: "", title: "Learn", parent:  "learn"});}}
                  />
                  
                  </View>}
                  {!this.state.isLoading && this.state.isFav && this.state.renderArray.length==0 &&<View style={{marginStart:15,marginEnd:15,justifyContent:"center",height:screenHeight-300}}>
                    <Text style={[styles.WordTitle,{color:"#dbdbdb",textAlign:"center",marginBottom:40}]}>You haven't choosen any favorite word yet.</Text>
                  
                  </View>}
            </View>
          </ScrollView>
        </View>
      </View>
    );
  }
}

const localstyles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#ffffff"
  },
  sectionHeader: {
    paddingTop: 2,
    paddingLeft: 10,
    paddingRight: 10,
    paddingBottom: 2,
    fontSize: 18 / fontFactor,
    fontWeight: 'bold',
    color: "#000000",
    backgroundColor: '#f8f8f8',
  },
  item: {
    padding: 10,
    fontSize: 18 / fontFactor,
  }
})
