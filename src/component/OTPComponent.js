
import React from 'react';
import { StyleSheet, TextInput } from 'react-native';
import { Grid, Col } from 'react-native-easy-grid';

class OtpInputs extends React.Component {
    state = { otp: [] };
    otpTextInput = [];
    otpColor = ["#f47a1a", "#f6954c", "#f8b17a", "#f9bd90", "#fbcaa8", "#fcd8bd"];

    componentDidMount() {
        this.otpTextInput[0].focus();
    }

    renderInputs() {
        const inputs = Array(6).fill(0);
        const txt = inputs.map(
            (i, j) => <Col key={j} style={styles.txtMargin}>
                <TextInput
                    style={{ borderWidth: 1, borderRadius: 20, width: 40, height: 40, textAlign: "center", color: "#000000", backgroundColor: this.otpColor[j], borderColor: this.otpColor[j] }}
                    keyboardType="numeric"
                    onChangeText={v => this.focusNext(j, v)}
                    onKeyPress={e => this.focusPrevious(e.nativeEvent.key, j)}
                    ref={ref => this.otpTextInput[j] = ref}
                />
            </Col>
        );
        return txt;
    }

    focusPrevious(key, index) {
        if (key === 'Backspace' && index !== 0)
            this.otpTextInput[index - 1].focus();
    }

    focusNext(index, value) {
        if (index < this.otpTextInput.length - 1 && value) {
            this.otpTextInput[index + 1].focus();
        }
        if (index === this.otpTextInput.length - 1) {
            this.otpTextInput[index].blur();
        }
        const otp = this.state.otp;
        otp[index] = value;
        this.setState({ otp });
        this.props.getOtp(otp.join(''));
    }


    render() {
        console.log("OTP"+this.state.otp);
        return (

            <Grid style={styles.gridPad}>
                {this.renderInputs()}
            </Grid>

        );
    }
}

const styles = StyleSheet.create({
    gridPad: { padding: 30, width: '100%', justifyContent: 'center', alignItems: "center" },
    txtMargin: { margin: 1, justifyContent: 'center', alignItems: "center" },
    inputRadius: { textAlign: 'center' }
});

export default OtpInputs;
