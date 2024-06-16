import React from 'react';
import { View, Dimensions,ActivityIndicator } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import BackButton from './component/BackButton';
import { WebView } from 'react-native-webview';
import styles from './vocabStyleSheet/styles';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class feedback extends React.Component {
  constructor(props) {
    super(props);
    
    this.state = {
      htmlStr: "",
      isLoading:true,

    };
  }
  
  componentDidMount() {
      //alert("Hello");
    /*global.screenInfo.start_time = new Date().getTime();
    global.screenInfo.end_time = "";
    var body_data = {
      user_id: global.personalInfo.user_id,
      app_id: "1",
    }
    this.loadAPI('1', global.base_url+'getAboutus', "GET", body_data);*/
  }


  render() {
    
    return (
      <View style={{ height: "100%" }}>
        <View style={[styles.mainContainer, { height: "100%" }]}>
          <LinearGradient colors={["#f47920", "#d33131"]} style={styles.topView}>
            <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text='Helpdesk'
                />
              </View>
            </View>
          </LinearGradient>
          <View style={[styles.cornerContainer, { marginBottom: 0, height: "100%", flex: 1, marginTop: -100 }]}>
            <WebView
             
              onLoadEnd={() => this.setState({ isLoading: false })}
              onLoadStart={() => this.setState({ isLoading: true })}
              style={{ height: "100%" }}
              originWhitelist={['*']}
              source={{ uri: global.base_url+'feedback/feedback.php' }}
              onError={!this.state.isLoading}
             
             
            />
            {this.state.isLoading && <ActivityIndicator color={"#000000"} />}
          </View>
        </View>
        
      </View>
    );
  }
}
export default feedback;
