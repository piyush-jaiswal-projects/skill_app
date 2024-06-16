import React from 'react';
import {ScrollView,View,ImageBackground,Image,StyleSheet,Text,TextInput,TouchableOpacity,Button,Dimensions,FlatList} from 'react-native';
import BackButton from './component/BackButton';
import styles from './vocabStyleSheet/styles';

const screenWidth = Math.round(Dimensions.get('screen').width);
const screenHeight = Math.round(Dimensions.get('screen').height);

const DATA = [
  {
    id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
    title: 'IELTS exam',
  },
  {
    id: '3ac68afc-c605-48d3-a4f8-fbd91aa97f63',
    title: 'TOEFL exam',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d72',
    title: 'PTE exam',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d721',
    title: 'Build my vocabulary',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d722',
    title: 'IELTS exam',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d723',
    title: 'TOEFL exam',
  },
  {
    id: '58694a0f-3da1-471f-bd96-145571e29d724',
    title: 'PTE exam',
  },
];
const Item = ({ title }) => (
  <TouchableOpacity onPress={() => global.navigation.navigate('SetGoal03Screen')}>
  <View style={styles.list_item}>
  <Text style={styles.list_title}>{title}</Text>
  <Image style={styles.list_rightArrow} source={require('./Images/next.png') }></Image>
  </View>
  </TouchableOpacity>
);
const renderItem = ({ item }) => (
  <Item title={item.title} />
);

class SetGoal02Screen extends React.Component {
  constructor(props){
    super(props);


  }

  render() {
    return (

      <View style={styles.mainContainer}>
      <ImageBackground style={[styles.logo]} source={require('./Images/step_1.png')}>

      <View style={styles.topView}>

      <View style={[styles.horizontalViewStyle, { justifyContent: 'space-between',marginTop:30 }]}>
              <View style={[styles.topView_bottom_TitleArrow]}>
                <BackButton
                  text=''
                />
              </View>
            </View>

      <View style={styles.topView_bootom_TitleBox}>
        <Text style={styles.headerTitle} >Why do you want to learn Vocabulary?</Text>
       {/*} <Text style={styles.HeaderSubTitle} >Set your goal first that will help youto learn faster</Text>*/}
      </View>

      </View>
      <View style={styles.cornerContainer}>
      <FlatList
        data={DATA}
        renderItem={renderItem}
        keyExtractor={item => item.id.toString()}
      />
      </View>

     </ImageBackground>

      </View>

    );
  }
}

export default SetGoal02Screen;
