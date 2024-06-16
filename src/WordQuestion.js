import React, { Component } from 'react';
import { Text, View, StyleSheet, Image, Animated, Dimensions, ScrollView, ActivityIndicator } from 'react-native';
import QuizBody from './Quiz_Body';
import styles from './vocabStyleSheet/styles';
import { TrackHistory } from './utill/Network';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);
import BackButton from './component/BackButton';


let ComplPercentage = 0;
let WordId = 0;
let TotalQuestion = 0;
let correctAswered = 0;
export default class WordQuestion extends Component {
    constructor(props) {
        super(props);
        TotalQuestion = 0;
        correctAswered = 0;
    }
    state = {
        isLoading: true,
        currentQC: 0,
        isQuestionSubmitted:false,
        WordId: this.props.route.params.wordId,
        parent:this.props.route.params.parent,
        QuestionData: [
            {
                question: "This is sample Question",
                options: [
                    {
                        label: 'Answer 1',
                        color: "#959595",
                        selectedColor: "#047a9c",
                        id: "1",
                        isCorrect: 1
                    },
                    {
                        label: 'Answer 2',
                        color: "#959595",
                        selectedColor: "#047a9c",
                        id: "1",
                        isCorrect: 0
                    },
                    {
                        label: 'Answer 3',
                        color: "#959595",
                        selectedColor: "#047a9c",
                        id: "1",
                        isCorrect: 0
                    },
                    {
                        label: 'Answer 4',
                        color: "#959595",
                        selectedColor: "#047a9c",
                        id: "1",
                        isCorrect: 0
                    }
                ]
            },
        ]
    };

    loadAPI = (data_type, url, method, body_data) => {
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
                        var question = [];
                        this.setState({ isLoading: false });
                        if (responseText.code == 200 && responseText.data.length > 0) {
                            this.setState({ QuestionData: responseText.data });
                            this._b.updateQuestion(this.state.QuestionData[this.state.currentQC]);
                        } else {
                            alert("There is some problem. Please try after some time.")
                            global.navigation.goBack();
                        }

                    } else if (data_type === '2') {
                        console.log(JSON.stringify(responseText));
                    } else if (data_type === '3') {
                        if (responseText.code == 200) {
                            if (responseText.data.length > 0) {
                                this.setState({ QuestionData: responseText.data });
                                this._b.updateQuestion(this.state.QuestionData[this.state.currentQC]);
                            } else {
                                alert("Currently there is no learned question");
                                global.navigation.goBack();
                            }
                            /*var resp = responseText.data;
                            var events = resp.sort((a, b) => a.word < b.word ? -1 : 1)
                            global.WordArray = events;
                            var wordId = global.WordArray[0].id;
                            this.setState({ WordId: wordId });
                            this.callAPI(wordId);*/
                        }
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

    changeQuestion = (SelectedOptionId, QuestionId, isAnswerCorrect) => {
        this.setState({ isQuestionSubmitted: false });
        correctAswered = isAnswerCorrect ? correctAswered + 1 : correctAswered;
        TotalQuestion = TotalQuestion + 1;
        if (this.props.route.params.parent == "review"){
            this.saveQuizResponse(this.state.QuestionData[this.state.currentQC].word_id, QuestionId, SelectedOptionId,this.state.QuestionData[this.state.currentQC].quiz_id);
        }else{
            this.saveUserResponse(this.state.WordId, QuestionId, SelectedOptionId);
        }
        if ((this.state.currentQC + 1) < this.state.QuestionData.length) {
            //var wordObj = tempArray[currentIndex+1];
            //this.setState({WordId:wordObj.id,currentQC:this.state.currentQC+1});
            this.setState({ currentQC: this.state.currentQC + 1 });
            this._b.updateQuestion(this.state.QuestionData[this.state.currentQC + 1]);
            //this.callAPI(wordObj.id);
        } else {
            if (this.props.route.params.wordId == -1) {
                global.screenInfo.end_time = new Date().getTime();
                TrackHistory("", "", "", "","", "Quiz", "QuizScore");
                global.navigation.navigate('QuizScore', { totalQuestion: TotalQuestion, correctAnswer: correctAswered })
            } else {
                global.navigation.goBack();
            }
        }
    }

    questionSubmitted = () =>{
        this.setState({ isQuestionSubmitted: true });
    }

    componentDidMount() {

        if (this.props.route.params.parent == "review") {
            var body_data = {
                user_id: global.personalInfo.user_id,
            }
            this.setState({ isLoading: true });
            this.loadAPI('3', global.base_url+'getQuizQuestions', "POST", body_data);
        }
        else {
            this.callAPI(this.state.WordId);
        }
    }

    loadwordList = (responseText) => {

        if (responseText.code == 200) {
            var resp = responseText.data;
            finalArray = [];
            events = resp.sort((a, b) => a.word < b.word ? -1 : 1)
            global.WordArray = events;
            wordId = global.WordArray[0].wordId;
            this.updateWord();

        }
    }

    callAPI(wordId) {
        var body_data = {
            user_id: global.personalInfo.user_id,
            word_id: wordId

        }
        // alert(this.state.WordId);
        this.setState({ isLoading: true });
        this.loadAPI('1', global.base_url+'getQuestionsByWords', "POST", body_data);
    }

    saveUserResponse(word_id, question_id, option_id) {
        var body_data = {
            user_id: global.personalInfo.user_id,
            word_id: word_id,
            question_id: question_id,
            option_id: option_id,
            test_id: -1

        }
        console.log(JSON.stringify(body_data));
        this.loadAPI('2', global.base_url+'saveResponse', "POST", body_data);
    }

    saveQuizResponse(word_id, question_id, option_id,quiz_id) {
        var body_data = {
            user_id: global.personalInfo.user_id,
            word_id: word_id,
            question_id: question_id,
            option_id: option_id,
            quiz_id: quiz_id

        }
        console.log(JSON.stringify(body_data));
        this.loadAPI('2', global.base_url+'saveResponseQuiz', "POST", body_data);
    }

    render() {
        ComplPercentage = (this.state.currentQC + 1) * 100 / (this.state.QuestionData.length);
        return (
            <View style={{ backgroundColor: "#ffffff", height: "100%" }}>

                <View style={{ overflow: 'hidden', paddingBottom: 6, backgroundColor: global.colors.DS_LINEAR_START }}>
                    <View
                        style={{
                            marginTop: 29,
                            backgroundColor: global.colors.DS_LINEAR_START,
                            height: 60,
                            shadowColor: '#000',
                            shadowOffset: { width: 1, height: 0 },
                            shadowOpacity: 0.0,
                            shadowRadius: 3,
                            elevation: 0,
                        }}
                    >
                        <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between', marginTop: 15, marginLeft: 15 }]}>
                            <View style={[styles.topView_bottom_TitleArrow]}>
                                <BackButton
                                    text='Practice'

                                />
                            </View>
                        </View>
                    </View>
                </View>
                <ScrollView>
                {!this.state.isLoading && <View style={{ flexDirection: "row", height: 20, marginTop: 20, width: screenWidth - 40, marginLeft: 20, justifyContent: "center", alignItems: 'center' }}>
                        <View style={Localstyles.progressContainer}>
                            <Animated.View
                                style={[
                                    Localstyles.inner, { width: ComplPercentage + "%" },
                                ]}
                            />
                        </View>
                        <Text style={{ alignItems: "center", justifyContent: "center", width: "20%", textAlign: "right" }}>{this.state.currentQC + 1}/{this.state.QuestionData.length}</Text>
                    </View>}
                    {!this.state.isLoading && <QuizBody ref={ref => (this._b = ref)} Question={this.state.QuestionData[this.state.currentQC]} isShowFeedback={true} changeQuestion={this.changeQuestion} questionSubmitted={this.questionSubmitted}/>}
                    {!this.state.isLoading && <View onStartShouldSetResponder={() => {
                        global.screenInfo.end_time = new Date().getTime();
                        TrackHistory("Flip", "Click Flip", "", this.state.QuestionData[this.state.currentQC].qId ? this.state.QuestionData[this.state.currentQC].qId : this.state.QuestionData[this.state.currentQC].qid,this.state.QuestionData[this.state.currentQC].quiz_id ? this.state.QuestionData[this.state.currentQC].quiz_id : this.state.QuestionData[this.state.currentQC].quiz_id, "Quiz", "WordCard");
                        this.state.isQuestionSubmitted?(this.state.parent == "review"?global.navigation.navigate("Card_WordList", {title: "Practice",wordId: this.state.QuestionData[this.state.currentQC].word_id,parent:"quiz"}):global.navigation.navigate("Card_WordList", { wordId:this.state.WordId})):"";
                    }} style={[styles.horizontalViewStyle, { marginBottom: 40, height: 50, width: "100%", justifyContent: 'center', alignItems: "center" }]}>
                        <Text style={[styles.DefaultSubText,{color:this.state.isQuestionSubmitted?"#4e4e4e":"#dbdbdb"}]}>{global.TextMessages.CW_TTSDAE_ID}</Text>
                        <Image style={[styles.card_ilogoStyle, {marginLeft: 5,tintColor:this.state.isQuestionSubmitted?"#4e4e4e":"#dbdbdb"}]} source={require('./Images/flip.png')}></Image>

                    </View>}
                    {this.state.isLoading && <ActivityIndicator size="large" color={"#d33131"} />}

                </ScrollView>
            </View>
        )
    }
}

const Localstyles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'flex-start',
        justifyContent: 'flex-start',
        marginEnd: 20,
        marginStart: 20,
        backgroundColor: "#ffffff"
    },
    valueText: {
        fontSize: 18,
        marginBottom: 50,
    },
    progressContainer: {
        height: 5,
        width: "80%",
        borderColor: "#ffffff",
        backgroundColor: "#edebe1",
        justifyContent: "center",
        alignSelf: "center",
    },
    inner: {
        width: "100%",
        height: 3,
        borderRadius: 15,
        backgroundColor: "#63c033",
    },
    chooseTheCorrectStyle: {
        fontSize: 13.3,
        fontWeight: "normal",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "left",
        color: "#fe7201"
    }
});
