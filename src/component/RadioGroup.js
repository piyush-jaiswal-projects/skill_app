import React, { Component } from 'react';
import { StyleSheet, Text, TouchableOpacity,PixelRatio, View, Dimensions,Image } from 'react-native';
const screenWidth = Math.round(Dimensions.get('window').width);
let valueSelected = false;
let isSubmitted = false;
const questionRightImage = '../Images/right_ans.png';
const questionWrongImage = '../Images/wrong_ans.png';
const fontFactor = PixelRatio.getFontScale();
const selectedColor = "#047a9c";
const color = "#959595";
export default class RadioGroup extends Component {
    constructor(props) {
        super(props);
        this.updateOptions = this.updateOptions.bind(this);
        this.state = {
            radioButtons: this.validate(this.props.radioButtons),
        };
    }


    updateOptions(updatedOptions){
        this.setState({radioButtons:this.validate(updatedOptions)})
    }

    validate(data) {
        let selected = false; // Variable to check if "selected: true" for more than one button.
        data.map(e => {
            e.color = e.color ? e.color : '#444';
            e.disabled = e.disabled ? e.disabled : false;
            e.label = e.label ? e.label : '';
            e.layout = e.layout ? e.layout : 'row';
            e.selected = e.selected ? e.selected : false;
            if (e.selected) {
                if (selected) {
                    e.selected = false; // Making "selected: false", if "selected: true" is assigned for more than one button.
                } else {
                    selected = true;
                }
            }
            e.size = e.size ? e.size : 24;
            e.value = e.value ? e.value : e.label;
        });
        return data;
    }

    onPress = label => {
        const radioButtons = this.state.radioButtons;
        const selectedIndex = radioButtons.findIndex(e => e.selected == true);
        const selectIndex = radioButtons.findIndex(e => e.label == label);
        if (selectedIndex != selectIndex) {
            selectedIndex > -1 ? radioButtons[selectedIndex].selected = false : "";
            radioButtons[selectIndex].selected = true;
            this.setState({ radioButtons });
            this.props.onPress(this.state.radioButtons);
        }
    };

    render() {
        valueSelected = this.props.isShow;
        isSubmitted = this.props.isSubmitted;
        return (
            <View style={[styles.container,{marginBottom:40}]}>
                <View style={{ flexDirection: this.props.flexDirection }}>
                    {this.state.radioButtons.map(data => (
                        <RadioButton
                            key={data.i}
                            data={data}
                            onPress={this.onPress}
                        />
                    ))}
                </View>
            </View>
        );
    }
}

class RadioButton extends Component {
    render() {
        const data = this.props.data;
        const opacity = data.disabled ? 0.2 : 1;
        let layout = { flexDirection: 'row' };
        let margin = { marginLeft: 10 };
        if (data.layout === 'column') {
            layout = { alignItems: 'center' };
            margin = { marginTop: 10 };
        }
        return (
            <TouchableOpacity
                style={[layout, { opacity, marginVertical: 5, width: screenWidth - 40 }]}
                onPress={() => {
                    isSubmitted ? null : this.props.onPress(data.label);
                }}>
                <View
                    style={[
                        styles.border,
                        {
                            borderColor: data.selected ? selectedColor : color,
                            width: data.size,
                            height: data.size,
                            
                            borderRadius: data.size / 2,
                            alignSelf: 'center'
                        },
                    ]}>
                    {data.selected &&
                        <View
                            style={{
                                backgroundColor: (data.selected ? selectedColor : color),
                                width: data.size / 2,
                                height: data.size / 2,
                                borderRadius: data.size / 2,
                            }}
                        />}
                </View>
                <View style={[{ alignSelf: 'center', borderColor: valueSelected&&(data.selected || data.isCorrect==1)?(data.isCorrect==1?"#89c63b":"#ed5565"):(data.selected ? selectedColor : color),backgroundColor: valueSelected&&(data.selected || data.isCorrect==1)?(data.isCorrect==1?"#89c63b22":"#ed556522"):"#ffffff", borderRadius: 20, borderWidth: 1, alignItems: "center", justifyContent: "center",flexDirection:"row", padding: 10, flex: 10 }, margin]}>
                    <Text style={{ alignSelf: 'flex-start',width:"90%",fontSize:18/fontFactor}}>{data.label.replace(/\\'/g, "'")}</Text>
                    <View style={{justifyContent:"center",width:"10%",alignItems:"center"}}>
                    {valueSelected&&(data.selected || data.isCorrect==1)&& <Image style={{width:20,height:19}} source={data.isCorrect==1?require('../Images/right_ans.png'):require('../Images/wrong_ans.png')}></Image>}
                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        justifyContent: 'flex-start',
        alignItems: 'flex-start',
        marginTop: 15,
    },
    border: {
        borderWidth: 2,
        justifyContent: 'center',
        alignItems: 'center',
    },
});
