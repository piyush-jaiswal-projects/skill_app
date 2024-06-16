import React from 'react';
import { ScrollView, View,PixelRatio, StyleSheet, Text, Image, TouchableOpacity,ActivityIndicator,BackHandler } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { AnimatedCircularProgress } from 'react-native-circular-progress';
import styles from './vocabStyleSheet/styles';
import BackButton from './component/BackButton';
import {TrackHistory} from './utill/Network';

const fontFactor = PixelRatio.getFontScale();

class TodaySession extends React.Component {
    constructor(props) {
        super(props);
        global.navigation = this.props.navigation;
        this.state={
            wordPractice:0,
            totalWord:20,
            totalQuestion:10,
            totalAnswered:0,
            isLoading: false,
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
              console.log(JSON.stringify(responseText));
              this.setState({ isLoading: false });
              if (data_type === '1') {
                if (responseText.code == 200) {
                  this.setState({ wordPractice: responseText.data.view_word,
                    totalWord:responseText.data.total_word,
                    totalQuestion:responseText.data.total_question,
                    totalAnswered:responseText.data.attempted_question})
                }
              } 
            })
            .catch(error => {
              this.setState({ isLoading: false });
              alert("There is some problem. Please try again after some time.");
            });
        }
      };
      componentWillMount()
      {
        this._unsubscribe = navigation.addListener('focus', () => {
          //alert("Amir")
          global.screenInfo.start_time = new Date().getTime();
          global.screenInfo.end_time = "";
            var body_data = {
              user_id: global.personalInfo.user_id,
            }
            console.log(JSON.stringify(body_data));
             this.loadAPI('1', global.base_url+'getWordQuestionSummary', "POST", body_data);
          });
      }
      componentDidMount() {
        //alert("hello")
        
      }
    



    render() {
        return (
            <ScrollView style={styles.mainContainer}>
                <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={[styles.topView,{height:250}]}>

        <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text={global.TextMessages.TDS_TITLE_ID}
                />
              </View>
            </View>
                </LinearGradient>
                <View >
                    <TouchableOpacity style={[styles.shadowStyel,{ marginTop: -140, height: 240,borderRadius: 10, position: 'relative', backgroundColor: '#ffffff', marginStart: 20, marginEnd: 20, flexDirection: 'row', justifyContent: "space-between" }]} onPress={() => {global.navigation.navigate("Card_WordList", { wordId: "", title: "Learn", parent:"learn" });global.screenInfo.end_time = new Date().getTime();TrackHistory("Vocabulary","Click","","","","TodaySession","WordCard");}}>
                        <View style={{ flexDirection: "column", justifyContent: "center", alignItems: "center", marginStart: 15, width: "20%" }}>
                            <View style={{ alignItems: "center", justifyContent: "center" }}>
                                <AnimatedCircularProgress
                                    size={80}
                                    width={8}
                                    fill={Math.round(this.state.wordPractice*100/this.state.totalWord)}
                                    tintColor={global.colors.TS_CIR_FILLCOLOR}
                                    rotation={0}
                                    onAnimationComplete={() => console.log('onAnimationComplete')}
                                    backgroundColor="#eeeeee"
                                    style={{ justifyContent: "center" }} />
                                <Image style={{ width: 55, height: 55, justifyContent: "center", position: 'absolute' }} source={require('./Images/icon.png')}></Image>
                            </View>
                            <View style={{ flexDirection: "row", alignItems:"baseline", marginTop: 10 }}>
                                <Text style={{fontSize:17/fontFactor,fontWeight:"bold"}}>{this.state.wordPractice}</Text>
                                <Text style={{fontSize:13/fontFactor}}>/{this.state.totalWord}</Text>
                            </View>
                            <Text style={[styles.HeaderSubTitle,{color:"#4e4e4e",marginTop:-3}]}>{global.TextMessages.TDS_WORD_ID}</Text>
                        </View>

                        <View style={{ flexDirection: "column", alignItems: "flex-start", justifyContent: "center", width: "50%", paddingStart: 15 }}>
                            <Text style={[styles.headerTitle,{color:"#4e4e4e"}]}>{global.TextMessages.TDS_VOCABULARY_ID}</Text>
                            <Text style={[styles.DefaultSubText, {textAlign:"left", marginTop: 10 }]}>{global.TextMessages.TDS_VOCABULARY_DSC_ID} </Text>
                        </View>
                        <View style={{ flexDirection: "column", alignItems: "center", justifyContent: "center", width: "20%" }}>
                            <Image style={{ width: 30, height: 20, justifyContent: "center", position: 'absolute' }} source={require('./Images/next.png')}></Image>

                        </View>

                    </TouchableOpacity>
                </View>

                <View onStartShouldSetResponder={() => {global.navigation.navigate("WordQuestion", { wordId: -1,parent:"review" });global.screenInfo.end_time = new Date().getTime();TrackHistory("Review","Click","","","","TodaySession","Quiz");}} style={[styles.shadowStyel,{ marginTop: 20, height: 240,borderRadius: 10, position: 'relative', backgroundColor: '#ffffff', marginStart: 20, marginEnd: 20, flexDirection: 'row', justifyContent: "space-between", marginBottom: 20 }]}>
                    <View style={{ flexDirection: "column", justifyContent: "center",alignItems:"center", marginStart: 15, width: "20%" }}>
                        <View style={{ alignItems: "center", justifyContent: "center" }}>
                            <AnimatedCircularProgress
                                size={80}
                                width={8}
                                fill={Math.round(this.state.totalAnswered*100/this.state.totalQuestion)}
                                tintColor={global.colors.TS_CIR_FILLCOLOR}
                                rotation={0}
                                onAnimationComplete={() => console.log('onAnimationComplete')}
                                backgroundColor="#eeeeee"
                                style={{ justifyContent: "center" }} />
                            <Image style={{ width: 55, height: 55, justifyContent: "center", position: 'absolute' }} source={require('./Images/icon_2.png')}></Image>
                        </View>
                        <View style={{ flexDirection: "row", justifyContent: "center",alignItems:"baseline", marginTop: 10 }}>
                        <Text style={{fontSize:17/fontFactor,fontWeight:"bold"}}>{this.state.totalAnswered}</Text>
                        <Text style={{fontSize:13/fontFactor}}>/{this.state.totalQuestion}</Text>
                        </View>
                        <Text style={[styles.HeaderSubTitle,{color:"#4e4e4e",marginTop:-3}]}>{global.TextMessages.TDS_ANSWERD_ID}</Text>
                    </View>

                    <View style={{ flexDirection: "column", alignItems: "flex-start", justifyContent: "center", width: "50%", paddingStart: 15 }}>
                        <Text style={[styles.headerTitle,{color:"#4e4e4e"}]}>{global.TextMessages.TDS_REVIEWED_ID}</Text>
                        <Text style={[styles.DefaultSubText, { textAlign:"left",marginTop: 10 }]}>{global.TextMessages.TDS_ANSWERDMSG_ID}</Text>
                    </View>
                    <View style={{ flexDirection: "column", alignItems: "center", justifyContent: "center", width: "20%" }}>
                        <Image style={{ width: 30, height: 20, justifyContent: "center", position: 'absolute' }} source={require('./Images/next.png')}></Image>

                    </View>


                </View>
                {this.state.isLoading &&
                  <ActivityIndicator style={{ paddingBottom: 100 }} size="large" color={"#d33131"} />}
                  
            </ScrollView>
        );
    }
}

const localStyles = StyleSheet.create({
    largeText: {
        fontSize: 17.5/fontFactor,
        fontWeight: "600",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "left",
        color: "#4e4e4e"
    },
    smallText: {
        fontSize: 10.8/fontFactor,
        fontWeight: "normal",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "left",
        color: "#4e4e4e"
    }
})

export default TodaySession;
