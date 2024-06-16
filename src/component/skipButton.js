import React from 'react'
import { Text, TouchableOpacity, StyleSheet } from 'react-native'

const PrimarySkipButton = ({ text, onPress }) => {
  return (
    <TouchableOpacity
    style={styles.skipBtnStyle}
    onPress={onPress}
    underlayColor='#fff'>
    <Text style={styles.getSkip}>{text}</Text>
    </TouchableOpacity>
  )
}

const styles = StyleSheet.create({

      skipBtnStyle:{

          marginLeft:10,
          marginTop:10,
          marginBottom:10,
          marginRight:10,
          width:'90%',
          height: 40,
          borderRadius: 20.5,
          backgroundColor: "#ffffff",
          borderStyle: "solid",
          borderWidth: 1,
          borderColor: "#ffffff",

        },
      getSkip:{
        fontSize: 15,
        marginTop:10,
        fontWeight: "normal",
        fontStyle: "normal",
        letterSpacing: 0,
        textAlign: "center",
        color: "#4e4e4e"
      },
})

export default PrimarySkipButton
