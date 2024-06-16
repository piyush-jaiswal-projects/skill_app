import React from 'react'
import { View,Alert, Dimensions, FlatList, Animated, Text, Image ,TouchableOpacity,ActivityIndicator} from 'react-native'
import styles from './vocabStyleSheet/styles';
import PrimaryButton from './component/Button';
import {TrackHistory} from './utill/Network';
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
let events = [];
let finalArray = [];
let FavWordList = [];
let LearnWordList = [];
export default class Review extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            eassyProgress: 30,
            mediumProgress: 40,
            renderArray: [],
            difficultProgress: 60,
            wordList: [
                {
                    id: '1',
                    word: 'Monday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '2',
                    word: 'Tuesday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '3',
                    word: 'Wednesday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '4',
                    word: 'Thrusday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '5',
                    word: 'Friday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '6',
                    word: 'Saturday',
                    isLiked: false,
                    strength: 'Easy'
                },
                {
                    id: '7',
                    word: 'Sunday',
                    isLiked: false,
                    strength: 'Easy'
                },
            ],
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
                this.loadwordList(responseText);
              }
              else if (data_type === '2') {
                this.setState({ isLoading: true });
        var body_data = {
          user_id: global.personalInfo.user_id,
        }
        this.loadAPI('1', global.base_url+'getLearnedWords', "POST", body_data);
                //this.nextScreen(responseText);
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
      loadwordList = (responseText) => {
        if (responseText.code == 200) {
          var resp = responseText.data;
          finalArray = [];
          events = resp.sort((a, b) => {try{a.word < b.word ? -1 : 1}catch(e){}})
          global.WordArray = events;
          finalArray = events;
          this.getLearnWord();
        }else {  // for testing
        }

      }


      getFavWords = () => {
        FavWordList = [];
        events.forEach(k => {
          if (k.isFavourite==1) {
            FavWordList.push(k)
          }
        });
        this.setState({renderArray:FavWordList,isFav:true,isAll:false,isLearn:false});
    };

    getLearnWord = () => {
       LearnWordList = [];
        events.forEach(k => {
          //if (k.isLearned==1) {
            if(k!=null){
            LearnWordList.push(k)
            }
         // }
        });
        this.setState({renderArray:LearnWordList,isFav:false,isAll:false,isLearn:true});
    };

    RemoveWordAlert = (wordId) =>{
        Alert.alert(
          global.TextMessages.MYP_ALERTMSG_ID,
          '\n',
          [
            {
              text:global.TextMessages.MYP_ALERT_CANCEL_ID,
              onPress: () => console.log('Cancel Pressed')
            },
            {
              text:global.TextMessages.MYP_ALERT_OK_ID,
              onPress: () => this.removeWordLearnedApi(wordId),
              style: 'cancel'
            },
          ],
          { cancelable: false }
        );
      };
    

    removeWordLearnedApi = (wordId) => {
      var body_data = {
        user_id: global.personalInfo.user_id,
        word_id: wordId
  
      }
      this.loadAPI('2', global.base_url+'removeLernedWord', "POST", body_data);
    }

    componentDidMount() {
        global.screenInfo.start_time = new Date().getTime();
          global.screenInfo.end_time = "";
          
        this.setState({ isLoading: true });
        var body_data = {
          user_id: global.personalInfo.user_id,
        }
        this.loadAPI('1', global.base_url+'getLearnedWords', "POST", body_data);
      }
      
    render() {
        return (<View style={{ marginEnd: 15, marginStart: 15, marginBottom: 20, marginTop: 0 }}>
          {/*  <View style={[styles.reviewView, styles.shadowStyel, { marginEnd: 0, marginStart: 0, marginBottom: 20, borderRadius: 15, backgroundColor: "#ffffff" }]}>

                <Text style={styles.letsReiterate}>
                    Your Vocabulary
                     </Text>
                <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
                <View style={{ marginBottom: 15, width: "100%", padding: 10 }}>

                    <View style={{ flexDirection: "row", width: "100%", alignItems: 'center', justifyContent: 'center' }}>
                        <View style={[styles.container, { backgroundColor: "#d6ecf4", height: 30, borderRadius: 5, marginTop: 0 }]}>
                            <Animated.View
                                style={[
                                    styles.inner, { height: 30, borderRadius: 5, width: this.state.eassyProgress + "%", backgroundColor: "#00799e" },
                                ]}
                            />
                        </View>
                        <View style={{ width: 50, alignItems: "flex-start", marginStart: 5 }}>
                            <Text style={{ fontWeight: "bold" }}>15</Text>
                            <Text style={[styles.xsWordStyle, { marginTop: -5 }]} >easy words</Text>
                        </View>

                    </View>
                    <View style={{ flexDirection: "row", width: "100%", marginTop: 20, alignItems: 'center', justifyContent: 'center' }}>
                        <View style={[styles.container, { backgroundColor: "#cdf0ef", height: 30, borderRadius: 5, marginTop: 0 }]}>
                            <Animated.View
                                style={[
                                    styles.inner, { height: 30, borderRadius: 5, width: this.state.mediumProgress + "%", backgroundColor: "#00a7a5" },
                                ]}
                            />
                        </View>
                        <View style={{ width: 50, alignItems: "flex-start", marginStart: 5 }}>
                            <Text style={{ fontWeight: "bold" }}>15</Text>
                            <Text style={[styles.xsWordStyle, { marginTop: -5 }]} >medium words</Text>
                        </View>

                    </View>
                    <View style={{ flexDirection: "row", width: "100%", marginTop: 20, alignItems: 'center', justifyContent: 'center' }}>
                        <View style={[styles.container, { backgroundColor: "#f1f9ed", height: 30, borderRadius: 5, marginTop: 0 }]}>
                            <Animated.View
                                style={[
                                    styles.inner, { height: 30, borderRadius: 5, width: this.state.difficultProgress + "%", backgroundColor: "#72c643" },
                                ]}
                            />
                        </View>
                        <View style={{ width: 50, alignItems: "flex-start", marginStart: 5 }}>
                            <Text style={{ fontWeight: "bold" }}>15</Text>
                            <Text style={[styles.xsWordStyle, { marginTop: -5 }]} >difficult words</Text>
                        </View>

                    </View>
                </View>
            </View>*/}

            <View style={[styles.reviewView, styles.shadowStyel, { marginEnd: 0, marginStart: 0, marginBottom: 20, borderRadius: 15, backgroundColor: "#ffffff" }]}>
                <Text style={[styles.letsReiterate,{marginStart:0}]}>{global.TextMessages.MYP_LEARNTWORD_ID}</Text>
                <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
                {/*<View style={{ width: "100%", padding: 10, height: 40, flexDirection: "row" }}>
                    <Text style={[{ width: "50%", fontWeight: 'bold', textAlign: 'left', paddingLeft: 10 }]}>Words</Text>
                   } <Text style={[{ width: "50%", fontWeight: 'bold', textAlign: 'left', paddingLeft: 5 }]}>Words Strength</Text>
                </View>*/}
                <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
                {!this.state.isLoading && this.state.renderArray.length==0 && 
                <View style={{marginStart:15,marginEnd:15,justifyContent:"center",height:screenHeight-500}}>
                    <Text style={[styles.WordTitle,{color:"#dbdbdb",textAlign:"center",marginBottom:40}]}>{global.TextMessages.MYP_NOWORDMSG_ID}</Text></View>}
                <FlatList
                    data={this.state.renderArray}
                    style={{ width: "100%" }}
                    renderItem={({ item }) =>
                        <View style={{ width: "100%", padding: 10, height: 40, justifyContent: 'space-between', alignItems: "center", flexDirection: "row" }}>
                            <Text style={[styles.DefaultText,{ width: "50%", textAlign: 'left', paddingLeft: 10 }]}>{item.word}</Text>
                            {/*<Text style={[{ width: "30%", textAlign: 'left', paddingLeft: 5 }]}>{item.strength}</Text>*/}
                            <View style={{ flexDirection: 'row',marginRight:10 }}>
                                <Image style={{ width: 15, height: 15 }} source={item.isFavourite ? require('./Images/fillstar.png') : require('./Images/empty_star.png')}></Image>
                                <Image style={{ width: 15, height: 15,marginLeft:10,resizeMode:"contain" }} onStartShouldSetResponder={() => {this.RemoveWordAlert(item.id)}} source={require('./Images/bin.png')}></Image>
                            </View>

                        </View>
                    }
                    keyExtractor={item => item.id.toString()}
                    extraData={this.state}
                />

                    <PrimaryButton
                        text={global.TextMessages.MYP_KEEPLEARN_ID}
                        onPress = {() => {global.navigation.navigate("Card_WordList", { wordId: "", title: "Learn", parent:"learn" });TrackHistory("KeepLearning","Click","","","","MyPerformance","WordCard");}}
                    />

            </View>
            {this.state.isLoading && <ActivityIndicator size="large" color={"#d33131"} />}
        </View>
        );
    }
}
