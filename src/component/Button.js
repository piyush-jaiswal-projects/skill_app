import React from 'react'
import { Text, View, TouchableOpacity,PixelRatio, Dimensions, StyleSheet } from 'react-native'
const fontFactor = PixelRatio.getFontScale();
const PrimaryButton = ({ text, onPress }) => {
  return (

    <TouchableOpacity
      style={[styles.loginBtnStyle,{backgroundColor:global.colors.PRI_BTN_BGCOLOR}]}
      onPress={onPress}
      underlayColor='#fff'>
      <Text style={styles.getStarted}>{text}</Text>
      </TouchableOpacity>

  )
}

const styles = StyleSheet.create({
    loginBtnStyle:{

        marginLeft: 20,
        marginTop: 15,
        marginBottom: 10,
        marginRight: 20,
        height: 40,
        borderRadius: 20.5,
        alignItems:"center",
        justifyContent:'center',
        borderStyle: "solid",
        borderWidth: 1,
        borderColor: "#ffffff",
      },
      getStarted:{
        fontSize: 15/fontFactor,
        fontWeight: "bold",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "center",
        color: "#ffffff"
      },
})

export default PrimaryButton
