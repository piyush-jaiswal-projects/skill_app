import * as React from 'react';
import { View, Text } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import AppFlow from './src/AppFlow';
import SplashScreen from './src/SplashScreen';
import welcomeScreen from './src/welcomeScreen';
import SigninScreen from './src/SigninScreen';
import SignupScreen from './src/SignupScreen';
import RegOTPVerification from './src/RegOTPVerification';
import GoalScreen from './src/GoalScreen';
import SetGoal01Screen from './src/SetGoal01Screen';
import SetGoal02Screen from './src/SetGoal02Screen';
import SetGoal03Screen from './src/SetGoal03Screen';
import SetGoal05Screen from './src/SetGoal05Screen';
import SetGoal06Screen from './src/SetGoal06Screen';
import SetGoal07Screen from './src/SetGoal07Screen';
import SetGoal08Screen from './src/SetGoal08Screen';
import SetGoal09Screen from './src/SetGoal09Screen';
import DashBoard from './src/DashBoard';
import ThankYouTest from './src/ThankYouTest';

import GoalSummary from './src/GoalSummary';
import TodaySession from './src/TodaySession';
import WordList from './src/WordList';
import Card_WordList from './src/Card_WordList';
import Quiz_Body from './src/Quiz_Body';
import PlacementTest from './src/PlacementTest';
import MyPerformance from './src/MyPerformance';
import about_us from './src/about_us';
import FAQ from './src/FAQ';
import WordQuestion from './src/WordQuestion';
import QuizScore from './src/QuizScore';
import feedback from './src/feedback';
import TermsCondition from './src/TermsCondition';
import ViewTermsCondition from './src/ViewTermsCondition';
import privacy from './src/privacy';

const Stack = createStackNavigator();
class App extends React.Component {
  
  render() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerShown: false,
        }}>
        <Stack.Screen name="AppFlow" component={AppFlow} options={{
          gestureEnabled: false,
        }}
        initialParams={this.props}
        />  
        <Stack.Screen name="SplashScreen" component={SplashScreen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="welcomeScreen" component={welcomeScreen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SigninScreen" component={SigninScreen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SignupScreen" component={SignupScreen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="RegOTPVerification" component={RegOTPVerification} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal01Screen" component={SetGoal01Screen} options={{
          gestureEnabled: false,
        }} />
        <Stack.Screen name="SetGoal02Screen" component={SetGoal02Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal03Screen" component={SetGoal03Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal05Screen" component={SetGoal05Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal07Screen" component={SetGoal07Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal08Screen" component={SetGoal08Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal09Screen" component={SetGoal09Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="GoalScreen" component={GoalScreen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="DashBoard" component={DashBoard} options={{
          gestureEnabled: false,
          
        }}/>
        <Stack.Screen name="GoalSummary" component={GoalSummary} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="WordList" component={WordList} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="TodaySession" component={TodaySession} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="ThankYouTest" component={ThankYouTest} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="PlacementTest" component={PlacementTest} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="Quiz_Body" component={Quiz_Body} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="Card_WordList" component={Card_WordList} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="SetGoal06Screen" component={SetGoal06Screen} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="MyPerformance" component={MyPerformance} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="FAQ" component={FAQ} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="about_us" component={about_us} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="WordQuestion" component={WordQuestion} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="QuizScore" component={QuizScore} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="feedback" component={feedback} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="TermsCondition" component={TermsCondition} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="ViewTermsCondition" component={ViewTermsCondition} options={{
          gestureEnabled: false,
        }}/>
        <Stack.Screen name="privacy" component={privacy} options={{
          gestureEnabled: false,
        }}/>


      </Stack.Navigator>

    </NavigationContainer>
  )};
}

export default App;
