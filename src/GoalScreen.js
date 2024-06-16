import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Dimensions,Button} from 'react-native';
import PrimaryButton from './component/Button';
import PrimarySkipButton from './component/skipButton';
import Modal from 'react-native-modal';
import styles from './vocabStyleSheet/styles';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class GoalScreen extends React.Component {
  constructor(props){
    super(props);

    this.state={
      isShowMemoPopUp :false,
      isSkipGoalSetting:false,
    };
  }
  showHidePopUp = () => {
    this.setState({isShowMemoPopUp:!this.state.isShowMemoPopUp});

  };
  showSkipPopUp = () => {
    this.setState({isSkipGoalSetting:!this.state.isSkipGoalSetting});

  };
  showContinuePopUp = () => {
    this.setState({isSkipGoalSetting:!this.state.isSkipGoalSetting});
    global.screenInfo.end_time = new Date().getTime();
    TrackHistory("","","","","","GoalScreen","Dashboard");
    global.navigation.navigate('DashBoard')
  };
  
  componentDidMount() {
    global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
  }
  render() {
    return (
      <ScrollView style={[styles.mainContainer,{width:screenWidth}]}>
      <ImageBackground style={[styles.logo]} source={require('./Images/goalImg.png')}>
      <View style={styles.topView}></View>
      </ImageBackground>
      <View style={styles.topView_bootom_TitleBox}>

    </View>


    <Text style={[styles.headerTitle,{marginLeft:10,marginTop:-160,}]} >Achieving Goals</Text>
    <Text style={[styles.HeaderSubTitle,{marginLeft:10}]} >Goal-oriented users are 5x more likely to acomplish their goals.</Text>
   <TouchableOpacity onPress={() =>this.showHidePopUp()} underlayColor='#fff'>
    <View style={[styles.messageView,{marginLeft:10}]}>
      <Image style={styles.ilogoStyle} source={require('./Images/cefr_info.png')}></Image>
      <Text style={styles.messageAndDataRatesMayApply}>How to memorise quickly?</Text>
    </View>
    </TouchableOpacity>



      <View style={styles.cornerContainer}>
      <Text style={styles.Title} >How to achieve your goal? </Text>

      <View style={styles.horizontalViewWithoutSpaceStyle}>
        <Image style={styles.ins_icon} source={require('./Images/personalize_icon.png')}></Image>
        <Text style={styles.SubTitle} >Work in small & achievable steps</Text>
      </View>

      <View style={styles.horizontalViewWithoutSpaceStyle}>
        <Image style={styles.ins_icon} source={require('./Images/vector_smart_object_2.png')}></Image>
        <Text style={styles.SubTitle} >Set your target</Text>
      </View>

      <View style={styles.horizontalViewWithoutSpaceStyle}>
        <Image style={styles.ins_icon} source={require('./Images/vector_smart_object.png')}></Image>
        <Text style={styles.SubTitle} >Set your schedule</Text>
      </View>


      <PrimaryButton
          text='Start Goal Setting'
          onPress={() => {
            global.screenInfo.end_time = new Date().getTime();
            TrackHistory("","","","","","GoalScreen","SetGoal01Screen");
            global.navigation.navigate('SetGoal01Screen')}}
        />

        <PrimarySkipButton
            text='Skip'
            onPress={() => this.showSkipPopUp()}
        />

      </View>

      <Modal isVisible={this.state.isShowMemoPopUp}>
        <View style={{ flex: 1 }}>
        </View>
        <View style={[styles.modalViewStyle,{flex: 3}]}>
        <View style={[styles.horizontalViewStyle, {flex:1,justifyContent:'flex-end'}]}>
            <TouchableOpacity
               activeOpacity={1}
               style={[styles.wordblank]} onPress={() =>this.showHidePopUp()}>
                  <Image style={[styles.modalCloseStyle]} source={require('./Images/popup_close.png')}></Image>
             </TouchableOpacity>

        </View>
        <Text style={[styles.DefaultText,{flex:2,textAlign:'left',marginLeft:5}]}>How to memorise quickly?</Text>
        <Image style={[{flex:20,width:'100%'}]} source={require('./Images/memoryGoal.png')}></Image>
        <Text style={[styles.DefaultText,{flex:2,textAlign:'left',marginLeft:20}]}></Text>
        </View>
        <View style={{ flex: 1 }}>
        </View>
      </Modal>

      <Modal isVisible={this.state.isSkipGoalSetting}>
      <View style={{ flex: 2 }}>
      </View>
      <View style={[styles.modalViewStyle,{flex: 3}]}>
        <View style={{ flex: 1 }}>
        <Text style={[styles.Title,{textAlign:'center',marginLeft:5}]}>Are you sure want to skip the Goal setting</Text>
        </View>

        <View style={{ flex: 1 }}>
        <Text style={[styles.subTitle,{textAlign:'center',marginLeft:5}]}>You can fill it later from the app setting</Text>

        </View>

        <View style={{ flex: 1 }}>

        <View style={styles.centerView}>
        <View style={styles.plainLine}></View>
        <PrimarySkipButton
            text='Skip Goal Setting'
            onPress={() => this.showSkipPopUp()}
        />
        <View style={styles.plainLine}></View>
        </View>

        </View>

        <View style={{ flex: 1 }}>
        <View style={styles.centerView}>
        <PrimaryButton
            text='Continue'
            onPress={() => this.showContinuePopUp()}
          />
        </View>
        </View>

        </View>
        <View style={{ flex: 2 }}>
        </View>
      </Modal>





      </ScrollView>

    );
  }
}

export default GoalScreen;
