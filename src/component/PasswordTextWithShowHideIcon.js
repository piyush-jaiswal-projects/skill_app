import React from 'react'
import { TextInput, View,PixelRatio, TouchableOpacity,Image, StyleSheet } from 'react-native'
import styles from '../vocabStyleSheet/styles';

const fontFactor = PixelRatio.getFontScale();

const PasswordTextWithShowHideIcon = ({ text,isShow,onPress,onChange,style,placeholder }) => {
  return (
    <View style={[styles.horizontalViewStyle,style, {flex:1,flexDirection:'row'}]}>
    <View style={ {flex:32}}>
      <TextInput
      style={{fontSize:15/fontFactor}}
      secureTextEntry={isShow}
      placeholder={placeholder}
      defaultValue={text}
      onChangeText={ (value) => onChange(value)}>
      </TextInput>
    </View>
    <View style={ {flex:3,justifyContent:'flex-end'}}>
     <TouchableOpacity
      onPress={onPress}
      underlayColor='#fff'>
       <Image style={[styles.card_ilogoStyle,{margin:0}]} source={require('../Images/eye.png')}></Image>
      </TouchableOpacity>
    </View>
      </View>


  )
}



export default PasswordTextWithShowHideIcon
