import Constants from 'expo-constants';
export function TrackHistory(buttonId,actionId,word_id,question_id,_quiz_id,screen_name,target){
   
  var body_data = {
        user_id: global.personalInfo.user_id,
        device_id:Constants.deviceId,
        button_id:buttonId,
        action:actionId,
        screen_name:screen_name,
        word_id:word_id,
        question_id:question_id,
        quiz_id:_quiz_id,
        target:target,
        datetime:new Date().getTime(),
        starttime:global.screenInfo.start_time,
        endtime:global.screenInfo.end_time,

      }

      console.log("Request "+JSON.stringify(body_data));

        fetch(global.base_url+"trackHistory", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "token": global.token,
            "client_id":global.client_name,
          },
          body: JSON.stringify(body_data),
        })
  
          .then(response => response.json())
          .then(responseText => {
            console.log("Request "+JSON.stringify(responseText));
          })
          .catch(error => {
          });
}
