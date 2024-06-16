import React from 'react'
import { Text, TouchableOpacity, StyleSheet } from 'react-native'

const BorderBtn = ({ text, onPress }) => {
  return (
    <TouchableOpacity
    style={[styles.skipBtnStyle,{borderColor:global.colors.PRI_BTN_BGCOLOR}]}
    onPress={onPress}
    underlayColor='#ff7200'>
    <Text style={[styles.getSkip,{color: global.colors.PRI_BTN_BGCOLOR}]}>{text}</Text>
    </TouchableOpacity>
  )
}

const styles = StyleSheet.create({

      skipBtnStyle:{
            marginLeft: 20,
            marginTop: 25,
            marginBottom: 5,
            marginRight: 20,
            height: 40,
            borderRadius: 20.5,
            backgroundColor: "#ffffff",
            borderStyle: "solid",
            borderWidth: 1,
            

        },
      getSkip:{
        fontSize: 15,
        marginTop:10,
        fontWeight: "normal",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "center",
        
      },
})

export default BorderBtn
