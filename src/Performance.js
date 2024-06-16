import React from 'react'
import { View, Dimensions, FlatList, Animated, Text,Image } from 'react-native'
import { BarChart, Grid, XAxis } from 'react-native-svg-charts'
import styles from './vocabStyleSheet/styles';
import PrimaryButton from './component/Button';

const DATA = [
    {
        id: 'bd7acbea-c1b1-46c2-aed5-3ad53abb28ba',
        date: 'Monday',
        day: '18',
        percentage: '50'
    },
    {
        id: '3ac68afc-c605-48d3-a4f8-fbd91aa97f63',
        date: 'Tuesday',
        day: '19',
        percentage: '30'
    },
    {
        id: '58694a0f-3da1-471f-bd96-145571e29d72',
        date: 'Wednesday',
        day: '20',
        percentage: '90'
    },
    {
        id: '58694a0f-3da1-471f-bd96-145571e29d721',
        date: 'Thruday',
        day: '21',
        percentage: '20'
    },
    {
        id: '58694a0f-3da1-471f-bd96-145571e29d722',
        date: 'Friday',
        day: '22',
        percentage: '70'
    },
];

const Item = ({ title }) => (

    //<TouchableOpacity onPress={() => global.navigation.navigate('SetGoal02Screen')}>
    <View style={[styles.item]}>
        <Text style={styles.dayTextstyle}>{title.date}</Text>
        <Text style={styles.dateTextStyle}>{title.day}</Text>
        <View style={styles.container}>
            <Animated.View
                style={[
                    styles.inner, { width: title.percentage + "%" },
                ]}
            />
        </View>
    </View>
    //</TouchableOpacity>
);
const renderItem = ({ item }) => (
    <Item title={item} />
);

export default class Performance extends React.PureComponent {
    
    render() {
        const fill = '#b0d070'
        const data = [50, 50, 10, 40, 95, 100, 100, 10, 10, 40, 95, 100, 10, 10, 40, 95]
        const label = ["a", "b", "c", "d", "a", "b", "c", "d", "a", "b", "c", "d", "a", "b", "c", "d"]
        console.log((Dimensions.get('window').width - 80) / data.length + data.length / 2);
        return (
            <View>
                <View style={{ backgroundColor: '#ffffff', padding: 20, marginLeft: 10, marginRight: 10, height: 250, marginTop: 40, borderRadius: 20, justifyContent: "center", alignItems: 'center' }}>
                    <View style={{ flexDirection: "row", justifyContent: "space-between", width: "100%" }}>
                        <Text style={{ textAlign: "left" }}>Overall Learning</Text>
                        <Text style={{color:"#c12d30",fontWeight:"bold"}}>46%</Text>
                    </View>
                    <View style={{ width: "100%", height: "100%" }}>
                        <BarChart style={{ height: 200, width: "100%" }} yMax={100} data={data} svg={{ fill }} contentInset={{ top: 30, bottom: 30 }}>
                            <Grid />
                        </BarChart>
                        <XAxis
                            style={{ marginHorizontal:0 }}
                            data={label}
                            contentInset={{ left: 7, right: 10 }}
                            formatLabel={(value, index) => index+1}
                            svg={{ fontSize: 10, fill: 'black' }}
                        />
                    </View>
                </View>

                <View style={{ width: "100%",marginTop:20,  flexDirection: "row", alignItems: "center", justifyContent: "space-between", paddingStart: 10, paddingEnd: 10 }}>
                    <View style={[{ backgroundColor: "#ffffff",justifyContent:"center",alignItems:"center", borderRadius: 25, height: 150, width: "49%", flexDirection: "column", padding: 20 }, styles.shadowStyel]}>

                    <Image style={{width:40,height:40}} source={require('./Images/book.png')}></Image>
                    <View style={{flexDirection:"row",alignItems:"baseline",marginTop:10}}>
                        <Text style={[styles.headerTitle,{color:"#c12d30"}]}>46</Text>
                        <Text style={{alignSelf:"baseline"}}> of 300</Text>
                    </View>
                    <Text> words learned</Text>
                    </View>

                    <View style={[{ backgroundColor: "#ffffff",justifyContent:"center",alignItems:"center", borderRadius: 25, height: 150, width: "49%", flexDirection: "column", padding: 20 }, styles.shadowStyel]}>

                    <Image style={{width:40,height:40}} source={require('./Images/clock_performance.png')}></Image>
                    <View style={{flexDirection:"row",alignItems:"baseline",marginTop:10}}>
                        <Text style={[styles.headerTitle,{color:"#c12d30"}]}>15</Text>
                        <Text style={{alignSelf:"baseline"}}> of 300</Text>
                    </View>
                    <Text> minutes spend</Text>

                    </View>


                </View>

                <View style={[styles.reviewView, styles.shadowStyel, { marginEnd: 15, marginStart: 15, marginBottom: 20, borderRadius: 15, backgroundColor: "#ffffff" }]}>

                    <Text style={styles.letsReiterate}>
                        Days Learned
                     </Text>
                    <View style={{ backgroundColor: "#eeeeee", alignSelf: 'stretch', marginStart: 20, marginEnd: 20, height: 1 }} />
                    <View style={{ flex: 1, marginBottom: 15 }}>
                        <FlatList
                            data={DATA}
                            horizontal={true}
                            renderItem={renderItem}
                            keyExtractor={item => item.id.toString()}
                        />
                    </View>
                </View>


                    <PrimaryButton
                        text='Keep Learning'
                    />
                

            </View>

        )
    }
}
