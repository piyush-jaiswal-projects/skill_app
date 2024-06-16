import React, { Component } from 'react';
import { Text, View, StyleSheet, PixelRatio, Dimensions, Animated } from 'react-native';
import GlobalStyle from './vocabStyleSheet/styles'
import PrimaryButton from './component/Button';
import RadioGroup from './component/RadioGroup';
import {TrackHistory} from './utill/Network';
const screenWidth = Math.round(Dimensions.get('window').width);
const fontFactor = PixelRatio.getFontScale();
let IsAnswerCorrect = false;
let isValueSelected = false;
let selectedOptionId = -1;
let CorrectAnswer = "";
let QuestionData = "";
let isShowFeedback = false;
let isQuestionSubmit = false;
export default class Quiz_Body extends Component {
    constructor(props) {
        super(props);
        this.updateQuestion = this.updateQuestion.bind(this);
        this.state = {
            data: this.props.Question ? (this.props.Question.options?this.props.Question.options:this.props.Question.option) : {},
            showFeedback: false,
            isQuestionSubmited: isQuestionSubmit
        };
    }

    updateQuestion(QuestionContent) {
        this._b.updateOptions(QuestionContent.options?QuestionContent.options:QuestionContent.option);
        isValueSelected = false;
    }

    selectedButton = false;
    // update state
    onPress = data => {this.setState({ data: data });
    this.selectedButton = data.find(e => e.selected == true);
    selectedOptionId = this.selectedButton?this.selectedButton.id:-1;
    isValueSelected = this.selectedButton ? true : false;
    IsAnswerCorrect = this.selectedButton ? this.selectedButton.isCorrect : false;
    let CorrectOption = data.find(e => e.isCorrect == true);
    CorrectAnswer = CorrectOption ? CorrectOption.value : 'Correct Answer';
    this.selectedButton = this.selectedButton ? this.selectedButton.value :data[0].label;
};

    onSubmit = () => {
        if (isValueSelected ) {
            if (!isShowFeedback) {
                this.setState({ showFeedback: isShowFeedback, isQuestionSubmited: false });
                this.props.changeQuestion(selectedOptionId,QuestionData.qId?QuestionData.qId:QuestionData.qid,IsAnswerCorrect);
            } else if (this.state.isQuestionSubmited) {
                this.props.changeQuestion(selectedOptionId,QuestionData.qId?QuestionData.qId:QuestionData.qid,IsAnswerCorrect);
                this.setState({ showFeedback: false, isQuestionSubmited: false });
            }else{
                this.props.questionSubmitted();
                this.setState({ showFeedback: isShowFeedback, isQuestionSubmited: true });
            }
        } else {
            {
                alert("Please select option")
            }
        }
    }

    render() {
        QuestionData = this.props.Question;
        isShowFeedback = this.props.isShowFeedback;
        global.screenInfo.start_time = new Date().getTime();
        return (
            <View style={styles.container}>

                <Text style={[styles.chooseTheCorrectStyle,GlobalStyle.DefaultText, {color:global.colors.QB_CHOSE_TEXTCOLOR,textAlign:'left',marginTop: 10 }]}>Choose the correct answer</Text>
                <Text style={[GlobalStyle.DefaultText, {textAlign:'left', marginTop: 20 }]}>{QuestionData.question?QuestionData.question.replace(/\\'/g, "'"):QuestionData.question}
                </Text>
                <RadioGroup ref={ref => (this._b = ref)} radioButtons={this.state.data} onPress={this.onPress} isShow={this.state.showFeedback} isSubmitted = {this.state.isQuestionSubmited}  />
                {(this.state.showFeedback && !IsAnswerCorrect && false) && <View style={{ width: "100%", marginTop: 20,marginBottom:30 }}>
                    <Text style={{ backgroundColor: "#ed556588", fontWeight: 'bold', color: "#ed5565", width: "100%", paddingStart: 20, paddingTop: 10, paddingBottom: 10 }}>Feedback</Text>
                    <Text style={{ backgroundColor: "#ed556533", color: "#ed5565", width: "100%", paddingStart: 20, paddingTop: 10, paddingBottom: 70 }}>Correct Answer is:{CorrectAnswer}</Text>

                </View>}
                <PrimaryButton
                     text='Continue'
                     onPress={() => {global.screenInfo.end_time = new Date().getTime();this.onSubmit();TrackHistory("Continue","Click","",QuestionData.qId?QuestionData.qId:QuestionData.qid,QuestionData.quiz_id?QuestionData.quiz_id:QuestionData.quiz_id,isShowFeedback?"Quiz":"Placment Test","WordCard");}}/>


            </View>

        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'flex-start',
        marginEnd: 20,
        marginStart: 20,
        backgroundColor: "#ffffff"
    },
    valueText: {
        fontSize: 18/fontFactor,
        marginBottom: 50,
    },
    progressContainer: {
        height: 5,
        width: "90%",
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
        fontSize: 13.3/fontFactor,
        fontWeight: "normal",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "left",
        
    }
});
