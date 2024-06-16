import React from 'react'
import { Text,View, TouchableOpacity,Image, StyleSheet } from 'react-native'
import Globalstyles from '../vocabStyleSheet/styles';
const BackButton = ({ text}) => {
  return (
    <View  style={styles.backBtnStyle}>
    <Image onStartShouldSetResponder={() => global.navigation.goBack()} style={styles.backImgStyle} source={require('../Images/back.png')}></Image>
    <Text style={Globalstyles.headerBackTitle}>{text}</Text>
    </View>
  )
}

const styles = StyleSheet.create({
  backImgStyle:
  {
    position: 'absolute',
    width: 30,
    height: 20,
  },
  backBtnStyle:{
    paddingLeft:10,
    justifyContent:"center"
  },

})

export default BackButton
