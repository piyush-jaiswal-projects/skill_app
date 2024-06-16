import React from 'react'
import {StyleSheet,PixelRatio,Dimensions} from 'react-native'
const fontFactor = PixelRatio.getFontScale();

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const styles = StyleSheet.create({
  spalsh: {
    backgroundColor: '#000000',
    flex: 1,
  },
  centerLogo: {
    justifyContent: 'center',
    alignItems: 'center',
    height: 56,
    width: 120,
    position: 'absolute',
    resizeMode:'contain'
  },
  mainContainer: {
    flex: 1,
    flexDirection: 'column',
    width: '100%',
    height: '100%',
    backgroundColor: "#f5f5f5",
    textAlign: "center",
  },
  logo: {
    width:screenWidth,
    height: 240,
    backgroundColor:"#000000",
  },
  splash_logo: {
    width: '100%',
    height: '90%'
  },

  topView: {
    paddingLeft: 10,
    paddingTop: 20,
    width: '100%',
    height: 200,


  },
  backBtnStyle:
  {
    width: 30,
    height: 20,
    marginTop: 20,
  },
  headerBackTitle: {
    marginLeft: 40,
    fontSize: 20 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    color: "#ffffff",
    textAlign:"center",

  },

  newHereCreateAccount: {
    fontSize: 15 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ff7200",
    lineHeight:20,
  },


  topView_bottom_TitleArrow: {
    flexDirection: 'row',
    flex: 2,
  },

  topView_bootom_TitleBox: {
    flexDirection: 'column-reverse',
    flex: 1,
  },
  stepStyle:{
    fontSize: 18/ fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff"
  },
  headerTitle: {
    fontSize: 24 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff",

  },
  WordTitle: {
    fontSize: 38 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color:"#4e4e4e" 

  },
  HeaderSubTitle: {
    fontSize: 13 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#ffffff",
    marginTop:5,
  },
  welcome_learn:{

    fontSize: 19/fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    marginLeft:16,
    color: "#fe7201",

  },
  welcome_learn_desc:{

    fontSize: 13/fontFactor,
    marginTop:10,
    marginLeft:16,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#4e4e4e"

  },
  textField_titleStyle: {
    height: 20,
    marginLeft: 10,
    fontSize: 15.5/fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#888888",
  },

  signup_textfieldStyle: {
    fontSize: 15 / fontFactor,
    marginLeft: 10,
    marginTop: 10,
    marginRight: 10,
    padding: 10,
    height: 40,
    borderRadius: 10,
    backgroundColor: "#ffffff",
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#c1c1c1",
  },

  termsandCondition: {
    fontSize: 13.3/fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    justifyContent: "center",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ff7200",
    textDecorationLine: 'underline',
  },

  messageView: {
    marginTop: 10,
    alignItems: 'center',
    justifyContent: 'flex-start',
    flexWrap: 'wrap',
    width: '100%',
    flexDirection: 'row',
  },
  messageAndDataRatesMayApply: {
    paddingLeft: 5,
    fontSize: 11 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ffffff"
  },

  messageViewLower: {
    marginTop: 10,
    alignItems: 'center',
    justifyContent: 'center',
    flexWrap: 'wrap',
    width: '100%',
    flexDirection: 'row',
  },
  messageAndDataRatesMayApplyLower: {
    fontSize: 13 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
  },

  card_ilogoStyle: {
    position: 'relative',
    width: 20,
    height: 20,
    margin: 20,
  },

  cardaudio_ilogoStyle: {
    position: 'relative',
    width: 40,
    height: 40,
    marginRight: 30,
  },

  ilogoStyle: {
    position: 'relative',
    width: 12,
    height: 12,
  },
  wordDot: {
    position: 'relative',
    width: 5,
    height: 5,
  },

  i_ins_logoStyle: {
    position: 'relative',
    width: 15,
    height: 15,
    resizeMode:'contain'
  },

  modalCloseStyle: {
    position: 'relative',
    width: 20,
    height: 20,
  },

  Title: {
    fontSize: 24 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
  },
  

  SubTitle: {
    fontSize: 15 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: '#4e4e4e'

  },

  DefaultDefinitionText: {
    fontSize: 20 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    justifyContent: "center",
    color: "#4e4e4e",
  },

  DefaultText: {
    fontSize: 18 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    justifyContent: "center",
    color: "#4e4e4e",
  },
  DefaultBoldText: {
    fontSize: 18 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    justifyContent: "center",
    color: "#4e4e4e",
  },
  DefaultSubText: {
    
    fontSize: 15 / fontFactor,
    fontWeight:"normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
    lineHeight:20,
  },

  DefaultSub_week_Text: {
    fontSize: 13 / fontFactor,
    fontWeight:"normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
  },

  DefaultSub_week_Text_Alert: {
    fontSize: 13 / fontFactor,
    fontWeight:"normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ff0000",
  },

  DefaultBoldSubText: {
    fontSize: 15 / fontFactor,
    fontWeight:"bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
  },



  ins_icon: {
    marginLeft: 30,
    marginRight: 10,
    position: 'relative',
    width: 40,
    height: 40,
    resizeMode:'contain'
  },

  cornerContainer: {
    marginTop: 30,
    marginBottom: 30,
    padding: 20,
    borderRadius: 25,
    backgroundColor: "#ffffff",
    flexDirection: 'column',
  },

  horizontalViewWithoutSpaceStyle: {
    marginTop: 30,
    marginBottom:30,
    alignItems: 'center',
    width: '80%',
    flexDirection: 'row',

  },

  horizontalViewStyle: {
    flexDirection: 'row',
    justifyContent: 'space-between',


  },
  centerView: {
    alignItems: 'center',
    margin: 20,
  },

  lowerStepView: {
    margin: 20,
  },
  line: {
    width: '90%',
    backgroundColor: "#eeeeee",
    height: 1,
  },
  plainLine: {
    width: '90%',
    backgroundColor: "#eeeeee",
    height: 1,
  },

  list_item: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#ffffff',
    marginVertical: 10,
    padding: 15,
    height: 50,
    borderStyle: "solid",
    borderRadius: 25,
    borderWidth: 1,
    borderColor: "#f5f5f5",

  },

  list_item_weekDay: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#ffffff',
    marginVertical: 10,
    height: 50,
  },

  list_item_dynamic: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#ffffff',
    marginVertical: 10,
    padding: 15,
    borderRadius: 25,
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#c1c1c1",
    alignItems:'center'

  },

  list_item_Line: {
    flex: 1,
    flexDirection: 'row',
    backgroundColor: '#ffffff',
    marginVertical: 10,
    padding: 20,
    height: 100,


  },

  list_item_Line_1: {
    height: 70,
    backgroundColor: '#000000',
    width: 2,

  },

  list_title: {
    fontSize: 18 / fontFactor,
    position: 'relative',
    width: '90%',
    textAlign: 'left',
    color:"#4e4e4e",

  },
  list_level_title: {
    fontSize: 15 / fontFactor,
    position: 'relative',
    width: '90%',
    textAlign: 'left',
    color:"#4e4e4e",

  },
  list_title_weekend: {
    fontSize: 18 / fontFactor,
    position: 'relative',
    fontWeight: "normal",
    fontStyle: "normal",
    width: '90%',
    textAlign: 'left',
    color:"#00a5a4"
  },



  list_title_Description: {
    fontSize: 12 / fontFactor,
    position: 'relative',
    width: '90%',
    textAlign: 'left'

  },
  list_rightArrow: {
    position: 'relative',
    width: 30,
    height: 15,
  },
  list_circle: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: "#ffffff",
    borderWidth: 0.5,
    borderColor: "#c1c1c1",
    position: 'relative',
  },


  skip : {
    fontSize: 18/fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#ffffff"
  },

  roundedRectangle: {
    width: 70,
    borderRadius: 14,
    backgroundColor: "#ffffff",
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#c12d30",
    padding:6
  },
  word: {
    marginBottom: 10,
    borderRadius: 25,
    backgroundColor: "#ffffff",
    flexDirection: 'column',
    shadowOffset: { width: 0, height: 5 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 2,
    shadowColor: '#000000'
  },
  wordblank: {
  },
  noMoreWordText: {
    fontSize: 22 / fontFactor,
  },


  saparator: {
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 60,
    width: '100%',
    marginBottom: 60,
    flexWrap: 'wrap',
    flexDirection: 'row',

  },
  hrline: {
    backgroundColor: '#c1c1c1',
    height: 1,
    width: 120,
    marginRight: 10,
    marginLeft: 10,

  },

  innerRoundBox:
  {
    width: '95%',
    borderRadius: 25,
    backgroundColor: "#f5f5f5",
    alignItems: 'center',
    justifyContent: 'center',

  },
  slider2: {
    backgroundColor: "#00ffee",
    position: 'relative',
    justifyContent: 'center',
    textAlign: 'center',
    padding: 15,

  },
  wordRoundBox:
  {

    alignItems: 'center',
    justifyContent: 'center',

  },

  lowerRoundBox: {

    width: '95%',
    margin: 30,
    padding: 30,
    borderRadius: 25,
    backgroundColor: "#f5f5f5",
    justifyContent: 'center',
    flexDirection: 'column',
  },

  picker: {
    margin: 30,
    width: '30%',
    height: 30,
    backgroundColor: '#ffffff',
    borderColor: '#bababa',
    borderWidth: 1,
  },
  pickerItem: {
    color: '#4e4e4e'
  },

  medium_ins_icon: {
    position: 'relative',
    width: 50,
    height: 50,
  },


  modalViewStyle: {
    width: '100%',
    padding: 30,
    borderRadius: 25,
    backgroundColor: "#ffffff",
    flexDirection: 'column',

  },

  textfieldStyle: {
    fontSize: 15 / fontFactor,
    marginLeft: 20,
    marginTop: 25,
    marginBottom: 10,
    marginRight: 20,
    padding: 10,
    height: 40,
    borderRadius: 20,
    backgroundColor: "#f4f4f4",
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#c1c1c1",
  },
  forgotPassword: {
    marginLeft: 10,
    marginTop: 0,
    marginBottom: 10,
    marginRight: 30,
    height: 17,
    fontSize: 11 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "right",
    color: "#4e4e4e",
  },

  otpBtnStyle: {
    marginLeft: 10,
    marginTop: 10,
    marginBottom: 10,
    marginRight: 10,
    width: '90%',
    height: 40,
    justifyContent: 'center',
    borderRadius: 20,
    backgroundColor: "#ffffff",
    borderStyle: "solid",
    borderWidth: 0.5,
    borderColor: "#ff7200"
  },
  otpTextSyle: {
    fontSize: 13.3 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e",
  },

  profileImg: {
    width: 90,
    height: 90,
    borderRadius: 45,
    overflow: "hidden",
    borderWidth: 1,
    borderColor: "#ffffff"
  },


  drawer_menuImage: {
    height: 70,
    width: 70,
    borderWidth: 1,
    borderRadius: 35,
    overflow: "hidden",
    borderColor: "#f5f5f5",
    
  },

  menuItemImage: {
    height: 20,
    width: 20,
    marginTop: 25,
    marginLeft: 25,
    resizeMode:'contain'

  },

  onePart: {
    width: '100%',
    alignItems: 'center'
  },
  twoPart: {
    width: '50%',
    alignItems: 'center'
  },
  threePart: {
    width: '33%',
    alignItems: 'center'
  },
  fourPart: {
    width: '25%',
    alignItems: 'center'
  },
  fifthPart: {
    width: '20%',
    alignItems: 'center'
  },
  sixthPart: {
    width: '16.6%',
    alignItems: 'center'
  },
  sevenPart: {
    width: '14.2%',
    alignItems: 'center'
  },
  eightPart: {
    width: '12.5%',
    alignItems: 'center'
  },
  ninePart: {
    width: '11.11%',
    alignItems: 'center'
  },
  tenPart: {
    width: '10%',
    alignItems: 'center'
  },
  errorTextStyle: {
    fontSize: 10 / fontFactor,
    color: "#ff0000",
    height: 20,
    textAlign: 'left',
    marginStart: 10
  },
  shadowStyel: {
    shadowOffset: { width: 0, height: 5 },
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 2,
    shadowColor: '#000000'
  },
  QuestionTextStyle: {
    fontSize: 15.5 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#000000"
  },

  TriangleShapeCSS: {

    width: 0,
    height: 0,
    borderLeftWidth: 12,
    borderRightWidth: 12,
    borderTopWidth: 6,
    borderStyle: 'solid',
    backgroundColor: 'transparent',
    borderLeftColor: 'transparent',
    borderRightColor: 'transparent',
    borderTopColor: '#fe7201'
  },
  item: {
    flex: 1,
    width: 80,
    flexDirection: 'column',
    backgroundColor: "#ffffff",
    padding: 15,
    marginEnd: 5,
    marginTop: 15,
    marginStart: 5,
    marginBottom: 10,
    borderRadius: 5,
    borderWidth: 1,
    borderColor: "#f5f5f5",

  },
  dayTextstyle: {
    fontSize: 9 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e"
  },
  dateTextStyle: {
    fontSize: 22 / fontFactor,
    fontWeight: "600",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "center",
    color: "#4e4e4e"
  },
  container: {
    flex: 1,
    height: 5,
    borderColor: "#ffffff",
    marginTop: 10,
    justifyContent: "center",
  },
  inner: {
    width: "100%",
    height: 3,
    borderRadius: 15,
    backgroundColor: "#e14051",
  },
  reviewView: {
    flexDirection: "column",
    flexWrap: "nowrap",
    marginStart: 20,
    marginEnd: 20,
    marginTop: 20,
    backgroundColor: "#ffffff",
    justifyContent: "center",
   
  },

  letsReiterate: {

    fontSize: 18 / fontFactor,
    fontWeight: "bold",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#4e4e4e",
    width: "100%",
    margin: 20,
    paddingStart: 20
  },
  xsWordStyle: {
    fontSize: 7.5 / fontFactor,
    fontWeight: "normal",
    fontStyle: "normal",
    letterSpacing: 0,
    textAlign: "left",
    color: "#4e4e4e"
  },
  hamburgIcon:{
    height:30,
    width:30,
  },
  AgeStyle:{
    fontSize: 26.5/fontFactor,
  fontWeight: "bold",
  fontStyle: "normal",
  letterSpacing: 0,
  textAlign: "left",
  color: "#414141"
  }
})

export default styles
