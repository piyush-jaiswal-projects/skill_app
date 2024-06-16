import React, { Component } from "react";
import {View,ScrollView,Image,Text,style,PixelRatio}  from "react-native";
import styles from './vocabStyleSheet/styles';
import BackButton from './component/BackButton';
import {TrackHistory} from './utill/Network';
const fontFactor = PixelRatio.getFontScale();

export default class QuizScore extends Component{
    constructor(props) {
        super(props);
        global.navigation = this.props.navigation;
        this.state = {
            totalQuestion:props.route.params.totalQuestion,
            correctQuestion:props.route.params.correctAnswer,
        };
    }
    componentDidMount() {

        global.screenInfo.start_time = new Date().getTime();
        global.screenInfo.end_time = "";
        
      }
    render(){
        return(
            <ScrollView style={{width:"100%",flex:1,backgroundColor:"#fe7201"}}>
            <View style={{width:"100%",flex:1,backgroundColor:"#fe7201",justifyContent:"center",alignContent:"center"}}>
            <View style={[styles.topView,{height: 100}]}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                    text='Practice'
                    />
                </View>
                </View>

                </View>

                    <View style={{justifyContent:"center",alignItems:"center",width:"100%",marginTop:30}}>

                    <Image style={{width: 90, height: 90 }} resizeMode="contain" source={require('./Images/quiz_icon.png')}></Image>

                    <View style={{flexDirection:"row",marginTop:30,alignItems:"baseline"}}>
                        <Text style={{fontSize:50,fontWeight:"bold",color:"#ffffff"}}>{this.state.correctQuestion}</Text>
                        <Text style={{fontSize:20,color:"#ffffff",paddingBottom:10}}>/{this.state.totalQuestion}</Text>
                    </View>
                    <Text style={{fontSize:20,color:"#ffffff",paddingBottom:10}}>{global.TextMessages.CORRECT_ANSWER}</Text>
                    <Image style={{width: 110, height: 130,marginTop:30 }} resizeMode="contain" source={require('./Images/quiz_cup.png')}></Image>
                    <Text style={{fontSize:20,color:"#ffffff",paddingTop:20}}>{global.TextMessages.SCORE_MSG}</Text>
                    <Text style={{fontSize:20,color:"#ffffff",paddingBottom:10}}>{global.TextMessages.SCORE_SUB_MSG}</Text>
                    <View onStartShouldSetResponder={() => {
                        global.screenInfo.end_time = new Date().getTime();
                        TrackHistory("","","","","","QuizScore","DashBoard");
                        global.navigation.navigate("DashBoard")
                    }}  style={{
                       width:"90%",
                       marginTop:30,
                       backgroundColor:"#ffffff",
                       height:40,
                       paddingTop:9,
                       borderColor:"#fe7201",
                       color:"#fe7201",
                       borderRadius:20,
                       borderStyle: "solid",
                       borderWidth:1,
                       textAlign:"center",
                       fontSize:20,
                       fontWeight:"bold",
                       alignItems:'center'}}>
                    <Text
                       style={{
                        color:"#fe7201",
                        fontSize: 15/fontFactor,
                        fontWeight: "bold",
                        fontStyle: "normal",
                        letterSpacing: 0,
                        textAlign: "center",
                      }}>Keep going</Text>
                       </View>
                    </View>

            </View>
            </ScrollView>
        );
    }
}