//
//  GlobalHeader.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 18/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "AppConfig.h"
#ifndef InterviewPrep_GlobalHeader_h
#define InterviewPrep_GlobalHeader_h



//#define kLiqvidProductID @"com.liqvid.interviewprepEdge_scn2"

////  for Appdelegate Class getUI message According to Screen /////

//#define  			MINEVENTTYPE				-1
//#define 			LOGIN						 0
//#define 			HONOR						 1
//#define 			HOME						 2
//#define 			CATOG						 10
//#define 			LIQVIDACTIVITY				 4
//#define 			INSTRUCTION					 5
//#define 			SETTINGS					 6
//#define 			TYPE_GAME				     7
//#define 			PROGRAM						 8
//#define 			MENU						 9
//
//#define 			TYPE_MODULE				     3
//#define 			SCENARIO			    	 11
//#define 			ASSITPRACTICE				 12
//#define 			VIDEOVIEW					 13
//#define 			CAMERA						 14
//#define 			ASSISTEDPRACTICE			 15
//#define 			VOCABULARY					 16
//#define 			TYPE_VOCABPRACTICE		     17
//
//
//#define 			ASSISMENT					 18
//#define 			CONVPRACTICE				 19
//#define 			PRACTICERESULT				 20
//#define 			VIEWCONVERSATION			 21
//#define 			UPDATESCORE					 22
//
//
//#define 			MCQ							 23
//#define 			VIDEO						 24
//#define  			MAXEVENTTYPE 				 25
//#define  			DHINCHUK                     28
//#define             DHINCHUKDASHBOARD            29 
//#define             PROFILEDASHBOARD             30 



#define IMAGECAPTURED 1
#define NOIMAGECAPTURED 0



#define EMPTYLOGINSTRING @""
// GENERAL Purpose
#define EMPTYSTRING @"0"

#define NASTRING @"N/A"

// coming from network respose

#define SUCCESSJOSN @"SUCCESS"
#define EXISTJOSN @"EXISTS"
#define TRACKING @"tracking"
#define LOGINFAILEDJSON @"LOGIN_FAILED"




#define COURSEZIPNAME @"course.zip"
#define COURSEZIPFOLDERNAME @"course"
#define COURSETEMPZIPFOLDERNAME @"course1"
#define ROOTFOLDERNAME  @"PracticeApp"
#define VOCABLARYZIPNAME @"vocabulary.zip"
#define VOCABLARYFOLDERNAME @"vocabulary"
#define VOCABLARYWORDFOLDERNAME @"words"

// UI DICTIONARY

#define JSON_LOFFILE @"[{1}]"
#define JSON_PROFILEPIC @"[{0}]"
#define JSON_UPLOADLOC @"uploadloc"
#define JSON_LOGIN @"login"
#define JSON_ACCEPTTERMS @"settnc"
#define JSON_LTISCORE @"get_lti_score"
#define JSON_APPUPDATE @"getAppUpdate_test"
#define JSON_GENERATEOTP @"generateOTP"
#define JSON_GETUSERBOOKMARKSTATUS @"get_user_bookmark"
#define JSON_SETUSERBOOKMARKSTATUS @"set_user_bookmark"

#define JSON_VERIFYOTP @"verifyOTP"
#define JSON_GETUSERDETAIL @"getuserdetails"
#define JSON_SETUSERDETAIL @"setuserdetails"
#define JSON_GETCAPTCHA @"getCaptcha"
#define JSON_VERIFYCAPTCHA @"validateCaptcha"

#define JSON_FORGOTPASSWORD @"frgtpass"
#define JSON_REGISTRATION @"register"
#define JSON_RESETPASSWORD @"changePassword"
#define JSON_GETWORD @"getword"
#define JSON_REFRESHTOKEN @"refreshtoken"
#define JSON_CLIENTSTATUS @"clientStatus" 
#define JSON_LOGIN_SOCIAL @"rlblreg"
#define JSON_LOGIN_TOCKEN @"rlbltok"
#define JSON_PASSWORD @"password"
#define JSON_NAME @"name"
#define JSON_PRACTICENAME @"practiceName"
#define JSON_RETVAL @"retVal"
#define JSON_RETMSG @"msg"
#define JSON_TOKEN @"token"
#define JSON_IRPULL  @"irpull"
#define JSON_SETGOAL @"set_goal"
#define JSON_GETGOAL @"get_goal"
#define JSON_GETGOALTIME @"get_daily_goal"
#define JSON_UPGRADEFORMAT @"upgrade_level"
#define JSON_GETOVERALLGRAPHDATA @"course_overall_data"
#define JSON_GETCOURSECOMPLETION @"getCompletion"

#define JSON_GETSKILLGRAPHDATA @"course_skill_data"
#define JSON_GETTESTGRAPHDATA @"get_test_data"
#define JSON_GETPRODUCT @"product_by_user"






#define JSON_APPVERSION @"appVersion"
#define JSON_DEVICEID  @"deviceId"
#define JSON_TERMSSERVICE @"termsService"
#define JSON_PLATFORM @"platform"
#define JSON_CALSS_NAME @"class_name"
#define JSON_CLIENT @"client"
#define JSON_PACKAGECODES @"package_codes"
#define JSON_COURSEVERSION @"version"

#define JSON_LICENCE_KEY @"unique_code"


#define JSON_EVENTLIST_DECREE @"eventlist"
#define JSON_GETUSERCOIN_DECREE @"getUserCoins"

#define JSON_EVENTCANCEL_DECREE @"cancelevent"
#define JSON_EVENTJOIN_DECREE @"joinevent"
#define JSON_EVENTNOTI_DECREE @"notievent"
#define JSON_COURSE_SIGNUP_DECREE @"user_course_signup"
#define JSON_COURSEPACKINFO_DECREE @"packageinfo"
#define JSON_COURSESLIDE_DECREE @"getResourcesByCourse"
#define JSON_COURSESLIDEFROMFILES_DECREE @"getResourcesByCourseFileFolder"
#define JSON_RESCOURSEPACKINFO_DECREE @"getpackageinfo"
#define JSON_PRODUCTINFO_DECREE @"course_by_product"

#define JSON_COURSE_CHECK_DECREE @"courseCheck"
#define __JSON_CHAPCOMPONENT_DECREE @"chapComponent"
#define JSON_CHAPCOMPONENT_DECREE @"getChapterMultiComponent"
#define JSON_GETASSIGNMENTLIST @"getUserAssignments"
#define JSON_GETQUIZASSESSMETREPORT_DECREE @"get_last_attempt_detail"
#define JSON_GETQUIZAVGSCOREFORCHAPTER_DECREE @"get_avg_quiz_score"






#define JSON_USERDEVICETOKEN_DECREE @"user_device_token"
#define JSON_UNLOCKCHAPLIST @"unlockedChapterList"
#define JSON_VISITED_LIST @"visiting_user"
#define JSON_COURSE_STATUS @"course_status"





#define JSON_IRPUSH  @"irpush"
#define JSON_DECREE @"decree"
#define JSON_COURSECODE @"course_code"
#define JSON_COURSEPACK @"package_code"
#define JSON_ISCOMP @"completion"
#define JSON_PUSHANSWEROLD @"pushanswer"
#define JSON_PUSHANSWER @"pushanswerattempt"
#define JSON_COINSDECREE @"setUserCoins"

#define JSON_TRACK @"track"
#define JSON_SYNCCOMPONANTCOMPLETION @"syncComponentCompletion"
#define JSON_GETUSERREPORT @"getUserCourseReport"

#define JSON_GETUSERPERFORMANCE @"getUserPerformance"

#define JSON_GETWILEYUSERPERFORMANCE @"getMyPerformance"

#define JSON_GETLEVELDATA @"getDataByLevel"



#define JSON_COURSEID @"course_edge_id"

#define JSON_NULL @"null"

#define JSON_MAXIR @"maxir"
#define JSON_AVGIRARRAY @"avg_irs"
#define JSON_AVGIR @"avgir"

#define  JSON_EDGEID @"edge_id"
#define  JSON_CLASSID @"class_id"


#define  JSON_TYPE @"otype"
#define  JSON_COURSE_TYPE @"C%d"
#define  JSON_ACTIVITY_TYPE @"A"




#define JSON_PARAM  @"param"
#define JSON_ARRAY @"array"

#define JSON_ANSUID @"ans_uniqid"
#define JSON_DATAMS @"date_ms"
#define JSON_QUESID @"ques_uniqid"
#define  JSON_TESTID @"test_uniqid"
#define  JSON_COURSE_CODE @"course_code"
#define  JSON_PACKAGE_CODE @"package_code"





#define JSON_SATRTTIMEMS @"start_date_ms"
#define JSON_ENDTIMEMS @"end_date_ms"












#define  UIRESPONSE @"RESP"
#define  UIRESPONSERESULT @"RESPRESLT"

#define  UIAUDIORESPONSE @"sentencescore"
#define  SUCCESS @"SUCCESS"
#define  FAILURE @"FAILURE"



#define  DATANULL @"3"
#define DIFFERENTUSERLOGIN  @"1"
#define USERNAMEPASSWORDWRONG  @"2"
#define SOCIALNETWORKMSG  @"4"
#define NOALERT  @"0"
#define UIMSG @"MSG"



#define NEWCOURSEXMLPATH @"course/course.xml"
#define COURSEXMLPATH @"course/course.xml"

#define NEWPREASSESSXMLPATH @"course/pre_assess.xml"
#define PREASSESSXMLPATH @"course/pre_assess.xml"


#define NEWMIDASSESSXMLPATH @"course/assess.xml"
#define MIDASSESSXMLPATH @"course/assess.xml"


#define NEWPOSTASSESSXMLPATH @"course/post_assess.xml"
#define POSTASSESSXMLPATH @"course/post_assess.xml"




///  HTML Catlog KeyWord


#define HTML_JSONKEY_COURSE @"course"

#define HTML_JSON_KEY_ISCOMPLETE  @"isComp"
#define HTML_JSON_KEY_ISLOCK @"isLock"
#define HTML_JSON_KEY_NAME @"name"
#define HTML_JSON_KEY_TOPIC_NAME @"Tname"
#define HTML_JSON_KEY_TOPIC_EDGEID @"edgeId"
#define HTML_JSON_KEY_TOPIC_COUNTER @"TCounter"
#define HTML_JSON_KEY_TOPIC_DESC @"Tdesc"
#define HTML_JSON_KEY_INSTRUCTION @"instruction"
#define HTML_JSON_KEY_SCNARRAY @"scnArray"
#define HTML_JSON_KEY_TYPE @"type"
#define HTML_JSON_KEY_STATUS @"status"

#define HTML_JSON_KEY_DATAPATH @"path"
#define HTML_JSON_KEY_UID @"uid"
#define HTML_JSON_KEY_SEQUENCE @"comp_sequence"
#define HTML_JSON_KEY_COMP_IMAGE @"comp_Image"
#define HTML_JSON_KEY_ACTION @"action"
#define HTML_JSON_KEY_VERSION @"version"
#define HTML_JSON_KEY_COURSECODE @"course_code"
#define HTML_JSON_KEY_CANCEL @"cancel"
#define HTML_JSON_KEY_EDGEID @"edgeId"
#define HTML_JSON_KEY_SCORE @"score"
#define HTML_JSON_KEY_DESC @"desc"
#define HTML_JSON_KEY_SIZE @"size"
#define HTML_JSON_KEY_ZIPURL @"ZIPURL"
#define HTML_JSON_KEY_CAPARRAY @"capArray"
#define HTML_JSON_KEY_CAPTYPE @"capType"
#define HTML_JSON_KEY_CONTENTARRAY @"contentArray"

#define HTML_JSON_KEY_LOGIN @"userName"
#define HTML_JSON_KEY_PASSWORD @"password"
#define HTML_JSON_KEY_LOGINTYPE @"loginType"



#define HTML_JSON_KEY_MSG @"msg"
#define HTML_JSON_KEY_CLOSE @"close"
#define HTML_JSON_KEY_CURRENT @"current"
#define HTML_JSON_KEY_DATAKEY @"data"
#define HTML_JSON_KEY_DRAWDATA @"drawData"
#define HTML_JSON_KEY_COUNT @"counter"

#define HTML_JSON_KEY_IMAGE @"1" // "image"
#define HTML_JSON_KEY_AUDIO @"2"// "audio"
#define HTML_JSON_KEY_VIDEO @"3" // "Video"
#define HTML_JSON_KEY_IMAGEAUDIO @"4" // "image audio"
#define HTML_JSON_KEY_PATH1 @"path1" // "image audio"
#define HTML_JSON_KEY_PATH2 @"path2" // "image audio"



#define HTML_JSON_KEY_DASHBOARD @"dashboard"
#define HTML_JSON_KEY_DOWNLOAD @"download"
#define HTML_JSON_KEY_SCNARIO @"scn"
#define HTML_JSON_KEY_ASSESSMENT @"assessment"
#define HTML_JSON_KEY_VOCABAUDIOPRAC @"vocabAudioPrac"
#define HTML_JSON_KEY_SUBMITSCORE @"submitScore"

#define HTML_JSON_KEY_GETCOOKIE @"getcookie"
#define HTML_JSON_KEY_SETCOOKIE @"setcookie"

#define HTML_JSON_KEY_LOGIN_KEY @"login"
#define HTML_JSON_KEY_FACEBOOK_LOGIN_KEY @"facebookLogin"
#define HTML_JSON_KEY_PACKAGEINFO @"packageInfo" 
#define HTML_JSON_KEY_REGISTRATION @"registration"
#define HTML_JSON_KEY_WORDNAME @"wordName"
#define HTML_JSON_KEY_WORDID @"wordId"
#define HTML_JSON_KEY_STATUS @"status"
#define HTML_JSON_KEY_VOCABARRY  @"vocabArray"

#define HTML_JSON_KEY_PARAM  @"param"

#define HTML_JSON_KEY_ANSID  @"ans_uniqid"
#define HTML_JSON_KEY_DATEMS  @"date_ms"
#define HTML_JSON_KEY_QUESID  @"ques_uniqid"
#define HTML_JSON_KEY_TESTID  @"test_uniqid"

#define HTML_JSON_KEY_EVENT  @"event"
#define HTML_JSON_KEY_EVENTDATA  @"eventData"


#define HTML_JSON_KEY_CCVID_GETXMLFILEDATA  @"ccvid_getXmlFileData"
#define HTML_JSON_KEY_CCVID_PLAY  @"ccvid_play"
#define HTML_JSON_KEY_CCVID_PAUSE  @"ccvid_pause"
#define HTML_JSON_KEY_CCVID_CLICKONWORD  @"ccvid_clickOnWord"
#define HTML_JSON_KEY_CCVID_FULLSCREEN  @"ccvid_fullScreen"
#define HTML_JSON_KEY_CCVID_JUMPTOVIDEO  @"ccvid_jumpToVideo"
#define HTML_JSON_KEY_CCVID_VIDEOPATH  @"videoPath"

#define HTML_JSON_KEY_AVGIR  @"avgIR"
#define HTML_JSON_KEY_BADGENO  @"badgeNo"
#define HTML_JSON_KEY_IRDATA  @"irData"
#define HTML_JSON_KEY_IRPERCENTAGEDATA  @"irPercData"
#define HTML_JSON_KEY_PERCENTAGE  @"percentage"
#define HTML_JSON_KEY_TOPIC_PERCENTAGE  @"percentage"
#define HTML_JSON_KEY_YOURIR  @"yourIR"
#define HTML_JSON_KEY_ARRAY  @"array"
#define HTML_JSON_KEY_IMGPATH  @"imgPath"
#define HTML_JSON_KEY_CHAPTERS  @"chapters"






#define HTML_JSON_KEY_XMLTEXT @"xmlText"

#define JSON_KEY_SCNPRACTEXTARRAY @"array"

#define JSON_KEY_SCNPRACMEDIAPATH @"mediapath"
#define JSON_KEY_SCNPRACEDGE @"EdgeId"
#define JSON_KEY_HEADING @"heading"
#define JSON_KEY_IDEALTIME @"idealTime"
#define JSON_KEY_SUBHEADING @"subheading"
#define JSON_KEY_SCNPRACTEXT @"text"
#define JSON_KEY_SCNPRACQATYPE @"type"
#define JSON_KEY_SCNPRACQTYPE @"question"
#define JSON_KEY_SCNPRACATYPE @"answer"

#define JSON_KEY_TYPE @"type"
#define JSON_KEY_SCNUID @"scnEdgeID"






#define HTML_JSON_KEY_HIDE_NOTIFICATION @"{\"event\":\"hide_topBar\"}"
#define HTML_JSON_KEY_NOTIFICATION @"{\"event\":\"ccvid_nextVideoNotification\"}"
#define HTML_JSON_KEY_SCRIPT_NOTIFICATION @"{\"event\":\"ccvid_showScriptText\"}"

#define HTML_JSON_KEY_PLAYPAUSE_NOTIFICATION @"{\"event\":\"ccvid_playPauseNotification\"}"















#define NATIVE_JSON_KEY_MODULEID  @"moduleid"
#define NATIVE_JSON_KEY_SCNID  @"scnId"
#define NATIVE_JSON_KEY_EDGEID  @"edgeId"
#define SERVER_JSON_KEY_EDGEID  @"edge_id"
#define NATIVE_JSON_KEY_TYPE  @"type"
#define NATIVE_JSON_KEY_USAGESCORE  @"usageScore"
#define NATIVE_JSON_KEY_ISCOMP  @"iscomp"
#define NATIVE_JSON_KEY_STARTTIME  @"startTime"
#define NATIVE_JSON_KEY_ENDTIME  @"EndTime"
#define NATIVE_JSON_KEY_DURATION @"duration_ms"
#define NATIVE_JSON_KEY_COURSECODE @"courseCode"
#define SERVER_JSON_KEY_COURSECODE @"course_code"
#define NATIVE_JSON_KEY_COURSEPACK @"package_code"




#define ZERO @"0"
#define ONE @"1"
#define TWO @"2"
#define THREE @"3"
#define FOUR @"4"









#define HTML_JSON_KEY_GRAY @"-1"
#define HTML_JSON_KEY_RED @"0"
#define HTML_JSON_KEY_YELLOW @"1"
#define HTML_JSON_KEY_GREEN @"2"
#define HTML_JSON_KEY_ORANG @"3"







#define SERVICETIMEINTERVAL 300


#define CLOSEMENUPROGRESS @"closeProgress"

#define SHOWDOWNLOADPROGRESS @"{\"type\":\"showProgress\"}"
#define CLOSEDOWNLOADPROGRESS @"{\"type\":\"closeProgress\"}"
#define SETPERCENTAGEDOWNLOADPROGRESS @"{\"type\":\"percentage\",\"number\":\"%@\"}"

#define SETERRORALERT @"{\"type\":\"error\",\"msg\":\"%@\"}"

#define SETNOTIFICATION @"{\"type\":\"notification\",\"value\":\"%@\"}"


#define GETNEXTUINOTIFICATIONNAME @"nextui"
#define GETSERVERMSGNOTIFICATIONNAME @"getServerMsg"

#define DOWNLOADCOMPLETENOTIFICATIONNAME @"downLoadComplete"
#define DOWNLOADERRORNOTIFICATIONNAME @"errorDownload"
#define GETPERCENTAGENOTIFICATIONNAME @"getPercentage"




#define SOMEKEY @"someKey"
#define FILENAME @"fileName"



//  HTML PATH

#define  MEPROINSTUCTIONHTMLPATH @"instruction/slide"
#define  PTEGINSTUCTIONHTMLPATH @"instruction-PTEG/slide"





#define ENCRYPT true


#define COMPLETE 3
#define INPROCESS 2
#define INITIAL 0
#define READY 1


#define UIERROR @"Error"
#define UIDATANOTFOUND @"data not found"



#define EDGECOMPLETE @"1"
#define EDGENOTCOMPLETE @"0"
#define EDGENOTSTARTED @"-1"

#define EDGEZEROSCORE @"0"
#define FIXVALUEFOUR @"4"   // according to neeraj



#define NOUPDATEACTION @"0"
#define NEWACTION @"1"
#define UPDATEACTION  @"2"
#define DELETEACTION @"3"



#define UNIQUE_ID @"unique_id"
#define EMAIL_ID @"email_id"
#define PHONE @"phone_num"
#define FIRSTNAME @"first_name"
#define LASTNAME @"last_name"
#define APPNAME @"appname"

#define SOCIAL @"social"
#define APPLICATION @"app"

#define JSON_MCQ @"mcq"
#define UIACTIVITYTIME  @"newTime"
#define UIACTIVITYDATE  @"newDate"
#define UIACTIVITYDURATION  @"duration"
#define UIACTIVITYHEADERTITLE  @"title"
#define UIACTIVITYHEADERDESCRIPTION  @"description"
#define UIACTIVITYUSERIMAGE  @"teacher_image"
#define UIACTIVITYUSERNAME  @"teacher_name"
#define UIACTIVITYTOTELSEATS  @"num_total"
#define UIACTIVITYISRECORDED  @"isRecording"
#define UIACTIVITYBOOKEDSHEET  @"num_avail"
#define UIACTIVITYISBOOKED  @"is_booked"
#define UIACTIVITYISBOOKEDAVAILABLE  @"isAvailable"
//#define UIACTIVITYCOURSEID @"course_id"
//#define UIACTIVITYTOPICID @"topic_id"
//#define UIACTIVITYCHAPTERID @"chapter_id"
//#define UIACTIVITYACTIVITYID  @"activity_id"
#define UIACTIVITYEVENTID  @"class_id"
#define UIACTIVITYWIZIQURL  @"bookurl"
#define UIACTIVITYPROVIDERID  @"provider_id"
#define UIACTIVITYRECORDURL @"recording_url"



#endif
