// import React from 'react';
// import { ScrollView, View, ImageBackground, Image, StyleSheet, Text, TextInput, TouchableOpacity, Dimensions } from 'react-native';
// import { LinearGradient } from 'expo-linear-gradient';
// import BackButton from './component/BackButton';
// import { WebView } from 'react-native-webview';
// import styles from './vocabStyleSheet/styles';

// const screenWidth = Math.round(Dimensions.get('screen').width);
// const screenHeight = Math.round(Dimensions.get('screen').height);

// class about_us extends React.Component {
//   constructor(props) {
//     super(props);
    
//     this.state = {
//       htmlStr: "",

//     };
//   }
//   loadAPI = (data_type, url, method, body_data) => {

//     this.setState({ isLoading: true });
//     if (method == "GET") {
//       fetch(url, {
//         method: method,
//         headers: {
//           "Content-Type": "application/json",
//           "token": global.token,
//         },
//       })
//         .then(response => response.json())
//         .then(responseText => {
//           this.setState({ isLoading: false });
//           if (data_type === '1') {
//             this.aboutus(responseText);
//           }
//           else {
//             alert('unknown api call')
//           }
//         })
//         .catch(error => {
//           alert(error);
//         });
//     }
//     else {
//       fetch(url, {
//         method: method,
//         headers: {
//           "Content-Type": "application/json",
//           "token": global.token,
//         },
//         body: JSON.stringify(body_data),

//       })

//         .then(response => response.json())
//         .then(responseText => {
//           this.setState({ isLoading: false });
//           if (data_type === '1') {

//             this.aboutus(responseText);
//           }
//           else {
//             alert('unknown api call')
//           }
//         })
//         .catch(error => {
//           alert(error);
//         });
//     }
//   };
//   aboutus = (responseText) => {

//     if (responseText.code == 200) {
//       var resp = responseText.data;
//       this.setState({ htmlStr: resp.html });
//     }
//     else {  // for testing
//     }

//   }
//   componentDidMount() {
//     global.screenInfo.start_time = new Date().getTime();
//     global.screenInfo.end_time = "";
//     var body_data = {
//       user_id: global.personalInfo.user_id,
//       app_id: "1",
//     }
//     this.loadAPI('1', global.base_url+'getAboutus', "GET", body_data);
//   }



//   render() {
//     return (
//       <View style={{ height: "100%" }}>
//         <View style={[styles.mainContainer, { height: "100%" }]}>
//           <LinearGradient colors={["#f47920", "#d33131"]} style={styles.topView}>
//             <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
//               <View style={[styles.topView_bottom_TitleArrow]}>
//                 <BackButton
//                   text='About Us'
//                 />
//               </View>
//             </View>
//           </LinearGradient>
//           <View style={[styles.cornerContainer, { marginBottom: 0, height: "100%", flex: 1, marginTop: -100 }]}>
//             <WebView
//               style={{ height: "100%" }}
//               originWhitelist={['*']}
//               source={{ html: this.state.htmlStr }}
//             />
//           </View>
//         </View>
//       </View>
//     );
//   }
// }
// export default about_us;


import React from 'react';
import { View, Dimensions,ActivityIndicator } from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import BackButton from './component/BackButton';
import { WebView } from 'react-native-webview';
import styles from './vocabStyleSheet/styles';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

class about_us extends React.Component {
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
                  text='About Us'
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
              source={{ uri: global.base_url+'doc/about.php' }}
              onError={!this.state.isLoading}
             
             
            />
            {this.state.isLoading && <ActivityIndicator color={"#000000"} />}
          </View>
        </View>
        
      </View>
    );
  }
}
export default about_us;

