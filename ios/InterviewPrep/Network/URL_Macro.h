//
//  URL_Macro.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 18/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#ifndef InterviewPrep_URL_Macro_h
#define InterviewPrep_URL_Macro_h


#define NETWORKSTATUS @"status"
#define NETWORKDATA @"data"
#define URLNOTFOUND @"1"
#define NETWORKNOTFOUND @"2"
#define SERVERNOTFOUND @"3"
#define SUCCESSRESULT @"4"
#define NOINTERNETFOUND @"5"




#define SERVICE_ACCEPTTERMS         @"acceptTerms"
#define SERVICE_LOGIN          @"login"
#define SERVICE_LTISCORE          @"ltiscore"



#define SERVICE_GETAVG_QUIZ_SCORE  @"get_chap_avg_score"
#define SERVICE_SETGOAL          @"set_goal"
#define SERVICE_GETGOAL          @"get_goal"
#define SERVICE_GETGOALTIME          @"get_goalTime"
#define SERVICE_GETOVERALLGRAPHDATA  @"overall_graph_data"
#define SERVICE_GETTESTGRAPHDATA  @"test_graph_data"
#define SERVICE_GETSKILLGRAPHDATA  @"skill_graph_data"

#define SERVICE_GETFORCEUPDATE  @"forceUpdate"


#define SERVICE_REGISTER       @"register"
#define SERVICE_VERIFYOTP      @"verifyOTP"
#define SERVICE_SENTFOROTP     @"sentOTP"
#define SERVICE_GENERATECAPTCHA @"generateCaptcha"
#define SERVICE_VERIFYCAPTCHA @"veryFyCaptcha"
#define SERVICE_GENERATEFRTMOBILEOTP  @"generateMobileOTP"
#define SERVICE_GENERATEFRTEMAILOTP  @"generateEmailOTP"
#define SERVICE_RESETPASSWORD  @"resetpassword"
#define SERVICE_GETUSERDETAIL  @"getUserDetail"
#define SERVICE_SETUSERDETAIL  @"setUserDetail"
#define SERVICE_UPDATETOKEN    @"updateToken"
#define SERVICE_UPDATETOKEN_LOCAL @"updateToken_local"
#define SERVICE_SCORE_UPDATETOKEN_LOCAL @"score_updateToken_local"
#define SERVICE_UPDATEVERSION  @"updateVersion"
//#define SERVICE_SYNCTRACK      @"syncTrack"
//#define SERVICE_SYNCCCTRACK      @"syncComponentCompletion"
#define SERVICE_SYNCMCQ        @"syncMCQ"
#define SERVICE_SYNCAUDIOVIDEO @"uploadAudioVideo"
#define SERVICE_SYNCUSERIMAGE @"uploadUserImage"
//#define SERVICE_UNLOCKEDCHAPTER @"getLockedChapter"
#define SERVICE_COURSE_DOWNLOAD @"courseDownload"
#define SERVICE_GETPACKAGEINFO @"getPackageInfo"
#define SERVICE_GETCOURSESTATUS @"getCourseStatus"
#define SERVICE_GETCOURSESLIDES @"getCourseSlides"


#define SERVICE_COURSE_DOWNLOAD_FROM_EDASHBOARD @"courseDownloadFromEDashboard"
#define SERVICE_COURSE_UPDATE_DOWNLOAD @"courseUpdateDownload"
#define SERVICE_COURSE_DOWNLOAD_NOTYFY @"courseDownloadNotiFy"

#define B_SERVICE_UPDATETOKEN    @"b_updateToken"
#define B_SERVICE_UPDATETOKEN_LOCAL @"b_updateToken_local"
#define B_SERVICE_SCORE_UPDATETOKEN_LOCAL @"b_score_updateToken_local"
#define B_SERVICE_UPDATEVERSION  @"b_updateVersion"
#define B_SERVICE_SYNCTRACK      @"b_syncTrack"
#define B_SERVICE_SYNCCCTRACK      @"b_syncComponentCompletion"
#define B_SERVICE_ONEWAYSYNCCCTRACK      @"b_syncComponentOneWayCompletion"

#define B_SERVICE_SYNCMCQ        @"b_syncMCQ"
#define B_SERVICE_SYNCCOINS        @"b_syncCoins"
#define SERVICE_LEVELUP        @"levelUp"
#define B_SERVICE_SYNCAUDIOVIDEO @"b_uploadAudioVideo"
#define B_SERVICE_SYNCUSERIMAGE @"b_uploadUserImage"
//#define B_SERVICE_UNLOCKEDCHAPTER @"b_getLockedChapter"
#define B_SERVICE_GETCLIENTSTATUS @"b_getClientStatus"
#define B_SERVICE_SYNCVISITEDUSER @"b_visitedUser"
#define B_SERVICE_COURSE_DOWNLOAD @"b_courseDownload"
#define B_SERVICE_CHAPTER_DOWNLOAD @"b_chapterDownload"
#define SERVICE_GETBOOKMARKSSTATUS  @"b_bookmarkstatus"
#define B_SERVICE_SETBOOKMARKSSTATUS  @"b_setbookmarkstatus"
#define SERVICE_GETASSIGNMENTLIST  @"getAssignmentList"
#define SERVICE_GETLIVESESSIONLIST @"getLiveSessionList"
#define SERVICE_GETPERFORMANCEGRAPHDATA @"getPerformanceData"
#define SERVICE_ASSESSMENTQUIZDATA @"getAssessmentQuizData"

#define SERVICE_JOINSESSION @"joinSession"
#define SERVICE_CANCELSESSION @"cancelSession"

#define SERVICE_GETUSERCOINLIST @"getUserEarnedCoins"

#define SERVICE_SANAAUDIOUPLOAD @"sanaAudioUpload"

#define SERVICE_BROADCASTCOINS @"broadCasttotalcoins"
#define SERVICE_COURSECOMPSTATUS @"courseCompletionStatus"

#define SERVICE_DASHBOARDGETLEVELSTATUS @"getDashboardLevelStatus"

#define SERVICE_LEVELSCREENGETLEVELSTATUS @"getlevelScreenLevelStatus"
#define SERVICE_PTEGPERFORMANCEGETLEVELSTATUS @"getptegeneralLevelStatus"





#endif
