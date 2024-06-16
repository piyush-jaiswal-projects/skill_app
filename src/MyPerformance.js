import React from 'react';
import { View, Text, Image, FlatList, Animated, ScrollView, TouchableOpacity,Dimensions } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { colors } from 'react-native-elements';
import Performance from './Performance';
import Review from './Review';
import styles from './vocabStyleSheet/styles';
import BackButton from './component/BackButton';
import * as ImagePicker from 'expo-image-picker';
import * as Permissions from 'expo-permissions';
import mime from "mime";
const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

export default class MyPerformance extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            isProgressSelected: false,
            isReviewSelected: true,
            image:''
        }
    }
    componentDidMount() {
        global.screenInfo.start_time = new Date().getTime();
        global.screenInfo.end_time = "";
      }

      uploadPic = async () => {
        console.log("PicIpload");
        const data = new FormData();
        const filePath = "file:///" + global.personalInfo.image.split("file:/").join("");
        data.append('user_id', global.personalInfo.user_id);
        data.append('profile_pic', { uri: filePath, name: filePath.split("/").pop(), type: mime.getType(filePath) });
        console.log(JSON.stringify(data))
        fetch(global.base_url+'updateUserPic', {
          method: "POST",
          headers: {
            'Content-Type': 'multipart/form-data; ',
            'Accept': "application/json",
            "token": global.token,
          },
          body: data,
        })
    
          .then(response => response.json())
          .then(responseText => {
              console.log(JSON.stringify(responseText))
          })
          .catch(error => {
            alert(error);
          });
      };
      
      getPermissionAsync = async () => {
          const { status } = await Permissions.askAsync(Permissions.CAMERA);
          if (status !== 'granted') {
            alert('Sorry, we need camera roll permissions to make this work!');
          }
      }
    
      _pickImage = async () => {
        if(global.client_name == "liqvid"){
        let result = await ImagePicker.launchImageLibraryAsync({
          mediaTypes: ImagePicker.MediaTypeOptions.image,
          allowsEditing: true,
          aspect: [4, 3],
        });
    
        console.log(result);
    
        if (!result.cancelled) {
            global.personalInfo.image = result.uri;
            this.setState({ image: result.uri });
            this.uploadPic();
        }
      }
      };
      
    render() {
       console.log(global.navigation);
        return (
            <ScrollView style={styles.mainContainer}>
                <LinearGradient colors={[global.colors.DS_LINEAR_START, global.colors.DS_LINEAR_END]} style={[styles.topView, { height: 290, borderBottomLeftRadius: 30, borderBottomRightRadius: 30 }]}>
                <View style={styles.topView}>
        <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:10 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text={global.TextMessages.MYP_TITLE_ID}
                />
              </View>
            </View>
          </View>
                </LinearGradient>
                <View style={{ backgroundColor: "#00ff0000", marginStart: 20, height: 190, marginTop: -220 }}>

                    <View style={{ flexDirection: "row", marginTop: 30, justifyContent: 'flex-start', alignItems: 'center' }}>
                        <Image onStartShouldSetResponder={() => this._pickImage()} source={global.personalInfo.image && global.personalInfo.image != '' ? { uri: global.personalInfo.image } :(this.state.image!='')?{ uri: global.personalInfo.image }: require('./Images/d_image.png')} style={styles.profileImg} />
                        <View style={{ flexDirection: "column", alignItems: 'flex-start', marginStart: 10 }}>
                            <Text style={[styles.SubTitle, { color: "#ffffff" }]}>{global.personalInfo.user_name}</Text>
                            <Text style={[styles.SubTitle, { color: "#ffffff" }]}>{global.personalInfo.city},{global.personalInfo.country}</Text>
                            <Text style={[styles.SubTitle, { color: "#ffffff" }]}>Level {global.personalInfo.current_level}</Text>
                        </View>
                    </View>

                </View>

                <View style={{ flexDirection: "row", marginTop: -62,marginLeft:20, marginBottom: 0 }}>
                    {/*<TouchableOpacity
                            onPress={() => { this.setState({ isProgressSelected: true, isReviewSelected: false }) }}
                            underlayColor='#fff'>
                        <View style={{ alignItems: 'center' }}>
                            <View style={{ backgroundColor: this.state.isProgressSelected ? "#ffffff" : "#ffffff00", height: 2, width: 60 }} />
                            <Text style={{ marginTop: 5, marginBottom: 5,color:"#ffffff",height:20 }}>Progress</Text>
                            <View style={[styles.TriangleShapeCSS, { borderTopColor: this.state.isProgressSelected ? "#fe7201" : "#ffffff00" }]} />
                        </View>
                        </TouchableOpacity>*/}
                        {/*<TouchableOpacity
                            onPress={() => { this.setState({ isProgressSelected: false, isReviewSelected: true }) }}
                            underlayColor='#fff'>
                            <View style={{ marginStart: 30, alignItems: 'center' }}>
                                <View style={{ backgroundColor: this.state.isReviewSelected ? "#ffffff" : "#ffffff00", height: 2, width: 60 }} />
                                <Text style={{ marginTop: 2, marginBottom: 0,color:"#ffffff",height:20 }}>Review</Text>
                                <View style={[styles.TriangleShapeCSS, { borderTopColor: this.state.isReviewSelected ? }"#fe7201" : "#ffffff00" }]} />
                            </View>
                        </TouchableOpacity>*/}
                    </View>

                {this.state.isProgressSelected && <Performance></Performance>}
                {this.state.isReviewSelected && <Review></Review>}


            </ScrollView>

        );
    }
}
