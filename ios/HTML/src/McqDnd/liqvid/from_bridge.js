function liqIsSoundEffectOn() {
	if(JSInterface.getMcqSound()==1){
		  return true;
	}
	else{
		  return false;
	}

  
}

var liqLabelInterface = null;
function liqGetStaticMessages(key) {
    if(liqLabelInterface==null) {
       //var labelJsonStr = JSInterface.getScreenMsg(28);
       liqLabelInterface = messageObj;
    }
    if(liqLabelInterface != null && liqLabelInterface[key]!= undefined)
    	return liqLabelInterface[key] ;
    else
    	return key;
}

function liqSendResultData(obj) {
    return JSON.stringify(obj);
}

function liqTestGetEdgeId() {
    return "000001";// JSInterface.getMcqEdgeID();
}

function liqTestGetTitle() {
    return practiceName;
}
    
function liqTestGetPracticeXMLString(edgeId) {
  //  return "<assess uniqid=\"practice_sc_1\"><name>Practice test 1 </name><description> Mid Course preparation test for Conversations </description><delivery><flow>random</flow><selection>6</selection><max_minutes>30</max_minutes></delivery><question uniqid=\"practice_sc_1.1\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>Why was Dinesh sad?</content><guidelines></guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.1.1\"><content>Couldn't go running.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.1.2\"><content>Malti didn't play with him.</content><is_correct>true</is_correct></answer><answer uniqid=\"practice_sc_1.1.3\"><content>Couldn't find his friends.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.1.4\"><content>Couldn't find the equipment.</content><is_correct>false</is_correct></answer></answers></question><question uniqid=\"practice_sc_1.2\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>Why didn't Malti play with him anymore?</content><guidelines></guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.2.1\"><content>Malti was tired.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.2.2\"><content>Malti was busy.</content><is_correct>true</is_correct></answer><answer uniqid=\"practice_sc_1.2.3\"><content>Dinesh was busy.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.2.4\"><content>They had a fight. </content><is_correct>false</is_correct></answer></answers></question><question uniqid=\"practice_sc_1.3\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>Why couldn't Dinesh play with his friends next door? </content><guidelines></guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.3.1\"><content>They were not interested.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.3.2\"><content>They couldn't find him.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.3.3\"><content>They were studying.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.3.4\"><content>They were traveling.</content><is_correct>true</is_correct></answer></answers></question><question uniqid=\"practice_sc_1.4\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>Why couldn't he play cricket?</content><guidelines></guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.4.1\"><content>It was really hot.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.4.2\"><content>It was raining hard.</content><is_correct>true</is_correct></answer><answer uniqid=\"practice_sc_1.4.3\"><content>He lost his bat.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.4.4\"><content>He couldn't bowl well.</content><is_correct>false</is_correct></answer></answers></question><question uniqid=\"practice_sc_1.5\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>Why was Dinesh happy after talking to Meena?</content><guidelines></guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.5.1\"><content>Meena fought with him.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.5.2\"><content>They went shopping.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.5.3\"><content>They decided to play.</content><is_correct>true</is_correct></answer><answer uniqid=\"practice_sc_1.5.4\"><content>She gave him money.</content><is_correct>false</is_correct></answer></answers></question><!-- <question uniqid=\"practice_sc_1.6\"><format><delivery>mc</delivery><qform>t</qform><aform>t</aform></format><instruction>Choose the correct option </instruction><content>If you are a software developer, which of the following hobbies is most relevant for you as a professional? </content><guidelines>For a software developer, reading techie magazines seems the most relevant hobby. Internet surfing is not something limited to tech savvy people. Gardening and shopping are irrelevant in this case.&#10;</guidelines><answers  choice=\"single\" served=\"random\" display_time=\"0\"><answer uniqid=\"practice_sc_1.6.1\"><content>Gardening because it shows your love for nature</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.6.2\"><content>Reading techie magazines because it shows your love for technology.</content><is_correct>true</is_correct></answer><answer uniqid=\"practice_sc_1.6.3\"><content>Shopping because it shows you are up-to-date on recent fashion trends.</content><is_correct>false</is_correct></answer><answer uniqid=\"practice_sc_1.6.4\"><content>Internet surfing because it shows that you are Internet savvy.</content><is_correct>false</is_correct></answer></answers></question>  --></assess>";
	return ConceptXmlData; //JSInterface.convXmlToString(edgeId);
		

}
function playMusicfromNativ(path)
{
   JSInterface.playMusic(path); 
}
