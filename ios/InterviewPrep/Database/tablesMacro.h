//
//  tablesMacro.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 18/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#ifndef InterviewPrep_tablesMacro_h
#define InterviewPrep_tablesMacro_h



#define DATABASE_LOCAL_DATA @"data"
#define DATABASE_LOCAL_ROWID @"row"


// UserInfoTable
#define DATABASE_TABLE_USERINFO @"UserInfoTable"

#define DATABASE_LOGIN @"loginid"
#define DATABASE_PASSWORD @"password"
#define DATABASE_USERNAME @"userName"
#define DATABASE_TIME @"writeTime"
#define DATABASE_ISIMAGECAPTURE @"isImageCapture"
#define DATABASE_LOGINTYPE @"loginType"
#define DATABASE_USERID @"user_id"
#define DATABASE_PROFILEPIC @"profile_pic"
#define DATABASE_TOKEN @"token"




//CourseTable   // course

#define DATABASE_TABLE_COURSETABLE @"CourseTable"

#define DATABASE_COURSE_CEDGE @"cEdgeID"
#define DATABASE_COURSE_NAME @"name"
#define DATABASE_COURSE_DATA @"data"
#define DATABASE_COURSE_DESC @"desc"
#define DATABASE_COURSE_TIME @"writeTime"
#define DATABASE_COURSE_VER @"version"
#define DATABASE_COURSE_IMGPATH @"imgPath"

#define DATABASE_COURSE_LEVELCEFRMAP @"level_cefr_map"
#define DATABASE_COURSE_LEVELDESC @"level_description"
#define DATABASE_COURSE_LEVELTEXT @"level_text"
#define DATABASE_COURSE_STANDERD @"standard"



//CoursePackTable   // course

#define DATABASE_TABLE_COURSEPACKTABLE @"CoursePackTable"

#define DATABASE_COURSEPACK_COURSEPACKCODE @"coursePackCode"
#define DATABASE_COURSEPACK_COURSEPACKDESCRIPTION @"coursePackDesc"
#define DATABASE_COURSEPACK_COURSEPACKDURATION @"coursePackDuration"
#define DATABASE_COURSEPACK_COURSEPACKBLOCK @"coursePackBlock"
#define DATABASE_COURSEPACK_DATE @"date"
#define DATABASE_COURSEPACK_DEVICESTATUS @"deviceStatus"
#define DATABASE_COURSEPACK_PLATFORMSTATUS @"coursePackPlatform"
#define DATABASE_COURSEPACK_PRODUCTCODE @"coursePackProductCode"


//CoursePackTableMapping   // course

#define DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE @"CoursePackCourseMappingTable"

#define DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE @"CoursePackCode"
#define DATABASE_COURSEPACKCOURSEMAPPING_DATABASE_COURSE_CEDGE @"cEdgeID"




//CategoryTable   //

#define DATABASE_TABLE_CATEGORY @"CategoryTable"


#define DATABASE_CATEGORY_CATEGORYNAME @"categoryName"
#define DATABASE_CATEGORY_CATEGORYCOURSEPACKCODE @"coursePackCode"
#define DATABASE_CATEGORY_CATEGORYID @"categoryId"



//CategoryTableTableMapping   //

#define DATABASE_TABLE_CATEGORYCOURSEMAPPING @"CategoryCourseMappingTable"

#define DATABASE_CATEGORYCOURSEMAPPING_CATEGORYID @"categoryId"
#define DATABASE_CATEGORYCOURSEMAPPING_COURSE_CEDGE @"cEdgeID"
#define DATABASE_CATEGORYCOURSEMAPPING_COURSEPACKCODE @"coursePackCode"





//CatLogContentTable  //

#define DATABASE_TABLE_CATLOGCONTENTTABLE @"CatLogContentTable"

#define DATABASE_CATLOGCONT_EDGEID @"catContEdgeID"
#define DATABASE_CATLOGCONT_CEDGEID @"catEdgeID"
#define DATABASE_CATLOGCONT_NAME @"name"  
#define DATABASE_CATLOGCONT_DATA @"data"
#define DATABASE_CATLOGCONT_DESC @"desc"
#define DATABASE_CATLOGCONT_CATTYPE @"catType"
#define DATABASE_CATLOGCONT_LOCAL_IR @"ir"
#define DATABASE_CATLOGCONT_ISLOCAL_LOCK @"isLock"
#define DATABASE_CATLOGCONT_ISLOCAL_COMPLETE @"isComp"

#define DATABASE_CATLOGCONT_TIME @"writeTime"
#define DATABASE_CATLOGCONT_ZIPURL @"zipurl"
#define DATABASE_CATLOGCONT_ZIPSIZE @"zipsize"
#define DATABASE_CATLOGCONT_ASSESSMENT_TYPE @"assessment_type"
#define DATABASE_CATLOGCONT_SKILLS @"skills"
#define DATABASE_CATLOGCONT_PASS_SCORE @"passing_score"
#define DATABASE_CATLOGCONT_TOTAL_QUESTION @"total_question"
#define DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION @"ttl_ques_to_show"
#define DATABASE_CATLOGCONT_NO_SKILL_QUES @"no_of_skill_ques"
#define DATABASE_CATLOGCONT_DURATION @"duration"
#define DATABASE_CATLOGCONT_THUMBNILIMG @"thumnailImg"
#define DATABASE_CATLOGCONT_ISTOPICLOCK @"isLocked"
#define DATABASE_CATLOGCONT_TOPIC_TYPE @"topic_type"
#define DATABASE_CATLOGCONT_REMEDIATIONEDGEID @"remediation_edge_id"





#define DATABASE_CATLOGCONT_ISCOMP @"isComp"
#define DATABASE_CATLOGCONT_TOTALCHAPTERS @"totalChapters"
#define DATABASE_CATLOGCONT_COMPCHAPTERS @"completeChapters"












//AssesmentTable

#define DATABASE_TABLE_ASSESSMENTTABLE  @"AssesmentTable"

#define DATABASE_ASSESSMENT_EDGEID @"assesEdgeID"
#define DATABASE_ASSESSMENT_CEDGEID @"catEdgeID" 
#define DATABASE_ASSESSMENT_SCORE @"score"
#define DATABASE_ASSESSMENT_NAME @"name"  
#define DATABASE_ASSESSMENT_DATA @"data" 
#define DATABASE_ASSESSMENT_DESC @"desc" 
#define DATABASE_ASSESSMENT_ISCOMP @"isComp" 
#define DATABASE_ASSESSMENT_TIME @"writeTime"



//ScenarioTable

#define DATABASE_TABLE_SCENARIOTABLE @"ScenarioTable"

#define DATABASE_SCENARIO_EDGEID @"scnEdgeID"
#define DATABASE_SCENARIO_CEDGEID @"catContEdgeID"
#define DATABASE_SCENARIO_NAME @"name"  
#define DATABASE_SCENARIO_DATA @"data" 
#define DATABASE_SCENARIO_DESC @"desc" 
#define DATABASE_SCENARIO_ISCOMP @"isComp"  
#define DATABASE_SCENARIO_TIME @"writeTime"
#define DATABASE_SCENARIO_IR @"ir"
#define DATABASE_SCENARIO_ZIPURL @"zipurl"
#define DATABASE_SCENARIO_ZIPSIZE @"zipsize"
#define DATABASE_SCENARIO_BGCOLOR @"bgcolor"
#define DATABASE_SCENARIO_DURATION @"duration"
#define DATABASE_SCENARIO_SKILL @"chapterSkill"
#define DATABASE_SCENARIO_THUMBNAIL @"thumnailImg"
#define DATABASE_SCENARIO_QUESCOUNT @"quesCount"
#define DATABASE_SCENARIO_SCATTYPE @"catType"
#define DATABASE_SCENARIO_IS_HIDE @"is_hide_resource"








// ExerciseTable    concept  and Scenario practice

#define DATABASE_TABLE_EXERCISETABLE @"ExerciseTable"
#define DATABASE_TABLE_CONCEPT_N @"concept"
#define DATABASE_TABLE_PRACTICE_N @"practice"





#define DATABASE_EXERCISE_EDGEID @"exEdgeID" 
#define DATABASE_EXERCISE_CEDGEID @"scnEdgeID" 
#define DATABASE_EXERCISE_CATTYPE @"catType"
#define DATABASE_EXERCISE_DATA @"data" 
#define DATABASE_EXERCISE_NAME @"name"
#define DATABASE_EXERCISE_DESC @"desc" 
#define DATABASE_EXERCISE_ISCOMP @"isComp"
#define DATABASE_EXERCISE_TIME @"writeTime"

#define DATABASE_EXERCISE_DISPLAYSEQUENCE @"comp_sequence"
#define DATABASE_EXERCISE_COMTHUMBNILIMG @"thumbnailImg"




//ActiviyTable  activity

#define DATABASE_TABLE_ACTIVITYTABLE @"ActiviyTable"

#define DATABASE_ACTIVITY_EDGEID  @"actEdgeID"
#define DATABASE_ACTIVITY_CEDGEID @"scnEdgeID" 
#define DATABASE_ACTIVITY_NAME @"name"  
#define DATABASE_ACTIVITY_DATA @"data" 
#define DATABASE_ACTIVITY_DESC @"desc" 
#define DATABASE_ACTIVITY_ISCOMP @"isComp" 
#define DATABASE_ACTIVITY_TIME @"writeTime"






//ConversationTable

#define DATABASE_TABLE_CONVERSATIONTABLE @"ConversationTable"

#define DATABASE_CONVERSATION_EDGEID @"convUnitID" 
#define DATABASE_CONVERSATION_CEDGEID @"pracEdgeID" 
#define DATABASE_CONVERSATION_IDEALTIME @"idealTime" 
#define DATABASE_CONVERSATION_CATTYPE @"catType" 
#define DATABASE_CONVERSATION_TIME @"writeTime"




//PracticeTable
#define DATABASE_TABLE_SCNPRACTABLE @"scnPracTable"
#define DATABASE_TABLE_VCBPRACTABLE @"vcbPracTable"
#define DATABASE_TABLE_MCQPRACTABLE @"MCQPracTable"
#define DATABASE_TABLE_GAMEPRACTABLE @"GAMEPracTable"
#define DATABASE_TABLE_SRPRACTABLE @"SRPracTable"
#define DATABASE_TABLE_RPRACTABLE @"resourceTable"









#define DATABASE_TABLE_PRACTICETABLE @"PracticeTable"

#define DATABASE_PRACTICE_EDGEID @"pracEdgeID"
#define DATABASE_PRACTICE_CEDGEID @"exEdgeID" 
#define DATABASE_PRACTICE_WATCHEDGEID @"watchEdgeID" 
#define DATABASE_PRACTICE_ENACTEDGEID @"enactEdgeID" 
#define DATABASE_PRACTICE_REVIEW_EDGEID @"reviewEdgeID" 
#define DATABASE_PRACTICE_CATETYPE @"catType" 
#define DATABASE_PRACTICE_NAME @"name"  
#define DATABASE_PRACTICE_DATA @"data" 
#define DATABASE_PRACTICE_DESC @"desc" 
#define DATABASE_PRACTICE_ISCOMP @"isComp" 
#define DATABASE_PRACTICE_TIME @"writeTime"
#define DATABASE_PRACTICE_DISPLAYSEQUENCE @"comp_sequence"
#define DATABASE_PRACTICE_COMTHUMBNILIMG @"thumbnailImg"
#define DATABASE_PRACTICE_INTERACTIVE_HTML @"interactive_html"




////ConversationTable
//
//
//#define DATABASE_TABLE_PRACTICETABLE @"PracticeTable"
//
//#define DATABASE_CONVERSATION_EDGEID @"convUnitID"
//#define DATABASE_CONVERSATION_CEDGEID @"pracEdgeID"
//#define DATABASE_CONVERSATION_IDEALTIME @"idealTime" 
//#define DATABASE_CONVERSATION_CATTYPE @"catType"
//#define DATABASE_CONVERSATION_TIME @"writeTime"



//VocabularyTable

#define DATABASE_TABLE_VOCABULARY @"VocabularyTable"

#define DATABASE_VOCAB_EDGEID @"vocabID" 
#define DATABASE_VOCAB_WORDID @"vocabWordID" 
#define DATABASE_VOCAB_WORD @"word"  
#define DATABASE_VOCAB_CEDGEID @"pracEdgeID" 
#define DATABASE_VOCAB_ISCOMP @"isComp"



//QuestionTable
#define DATABASE_TABLE_QUESTION @"QuestionTable"

#define DATABASE_QUESTION_EDGEID @"textID" 
#define DATABASE_QUESTION_CONUNITID @"convUnitID" 
#define DATABASE_QUESTION_TAG @"tag"
#define DATABASE_QUESTION_VPATH @"videoPath"
#define DATABASE_QUESTION_RECVIDEOPATH @"recVideoPath"
#define DATABASE_QUESTION_RECAUDIOPATH @"recAudioPath"
#define DATABASE_QUESTION_ISCOMP @"isComplete"




// AnswerTable

#define DATABASE_TABLE_ANSWER @"AnswerTable"

#define DATABASE_ANSWER_EDGEID @"textID"
#define DATABASE_ANSWER_CONUNITID @"convUnitID"
#define DATABASE_ANSWER_TAG @"tag"
#define DATABASE_ANSWER_PLAYPATH @"playPath"
#define DATABASE_ANSWER_RECVIDEOPATH @"recVideoPath"
#define DATABASE_ANSWER_RECAUDIOPATH @"recAudioPath"
#define DATABASE_ANSWER_ISCOMPLETE @"isComplete"



// TextSegmentTable (

#define DATABASE_TABLE_TEXTSEGMENT @"TextSegmentTable"

#define DATABASE_TEXTSEGMENT_EDGEID @"textSegID" 
#define DATABASE_TEXTSEGMENT_TEXTID @"textID"
#define DATABASE_TEXTSEGMENT_CLICKITEMID @"clickItemId"
#define DATABASE_TEXTSEGMENT_SIMPLETEXT @"simpleText"
#define DATABASE_TEXTSEGMENT_CLICKTEXT @"clickText"



//VocabWordTable


#define DATABASE_TABLE_VOCABWORD @"VocabWordTable"

#define DATABASE_VOCABWORD_WORDID @"vocabWordID"
 #define DATABASE_VOCABWORD_EDGEID @"edgeID"
 #define DATABASE_VOCABWORD_WORD @"word"
#define DATABASE_VOCABWORD_MEANING @"meaning"
 #define DATABASE_VOCABWORD_PRONOUNCIATION @"pronunciation"
 #define DATABASE_VOCABWORD_PARTOFSPEECH @"partOfSpeech"
 #define DATABASE_VOCABWORD_ETYMOLOGIES @"etymologies"
 #define DATABASE_VOCABWORD_USAGE @"usage"
 #define DATABASE_VOCABWORD_WORDAUDIOPATH @"wordAudioPath"
#define DATABASE_VOCABWORD_RECWORDAUDIOPATH @"recWordAudioPath"
 #define DATABASE_VOCABWORD_PSCORE @"pscore"
 #define DATABASE_VOCABWORD_TIME @"writeTime"
 #define DATABASE_VOCABWORD_COURSE_CODE @"courseCode"
 #define DATABASE_VOCABWORD_ISCOMP @"isComp"
 #define DATABASE_VOCABWORD_PLAYSTAT @"playStat"
 #define DATABASE_VOCABWORD_IMAGEPATH @"vocabImagePath"



//GameTable

#define DATABASE_GAMETABLE_EDGEID @"gameEdgeID" 
#define DATABASE_GAMETABLE_CEDGEID @"catContEdgeID" 
#define DATABASE_GAMETABLE_NAME @"name"  
#define DATABASE_GAMETABLE_DATA @"data"  
#define DATABASE_GAMETABLE_DESC @"desc" 
#define DATABASE_GAMETABLE_LOSS @"loss" 
#define DATABASE_GAMETABLE_WIN @"win"
#define DATABASE_GAMETABLE_ISCOMP @"isComp" 
#define DATABASE_GAMETABLE_TIME @"writeTime"



//TrackingTable

#define DATABASE_TABLE_TRACKTABLE @"TrackingTable"

#define DATABASE_TRACKINGTABLE_MOEDGEID @"moduleID" 
#define DATABASE_TRACKINGTABLE_SCNEDGEID @"scenarioID" 
#define DATABASE_TRACKINGTABLE_EDGEID @"edgeID"  
#define DATABASE_TRACKINGTABLE_TRACKTYPE @"trackType" 
#define DATABASE_TRACKINGTABLE_USAGESCORE @"usageScore"
#define DATABASE_TRACKINGTABLE_ISCOMP @"isComplete"	
#define DATABASE_TRACKINGTABLE_STARTTIME @"startTime" 
#define DATABASE_TRACKINGTABLE_ENDTIME @"endTime"
#define DATABASE_TRACKINGTABLE_COURSE_CODE @"courseCode"
#define DATABASE_TRACKINGTABLE_COURSEPACK @"package_code"

//
//

//TrackSyncTime
 #define DATABASE_TABLE_TRACKSYNCTIME @"TrackSyncTime"

#define DATABASE_TRACKSYNCTIME_TIME @"writeTime"
//
//
//


//AudroApiTable


#define DATABASE_ADUROAPI_ADUROAPIID @"audroApiID" 
#define DATABASE_ADUROAPI_APITYPE @"apiType" 
#define DATABASE_ADUROAPI_PULLTIME @"pullTime" 
#define DATABASE_ADUROAPI_PUSHTIME @"pushTime"


//
//
//
//PullIrTable


#define DATABASE_TABLE_PULLIRTABLE @"PullIrTable"


#define DATABASE_PULLIR_EDGEID  @"edgeID" 
#define DATABASE_PULLIR_AVGIR @"avgIR" 
#define DATABASE_PULLIR_MAXIR @"maxIR"
#define DATABASE_PULLIR_TIME @"writeTime"
//
//
//
//ModuleTable

#define DATABASE_MUDULE_ID @"moduleID"
#define DATABASE_MUDULE_EDGEID @"edgeID"
#define DATABASE_MUDULE_NAME @"moduleName"
#define DATABASE_MUDULE_DESC @"description"
#define DATABASE_MUDULE_IMAGEPATH @"imagePath"
#define DATABASE_MUDULE_MODULEIR @"moduleIR"
#define DATABASE_MUDULE_TIME @"writeTime"
//
///*
// #define CREATE_TABLE_EXERCISE @
// "CREATE TABLE ExerciseTable (
// exerciseID VARCHAR(100) NOT NULL PRIMARY KEY,
// scenarioID VARCHAR(100),
// edgeID INTEGER,
// xmlName  VARCHAR(100),
// description  VARCHAR(512),
// exerciseType  INTEGER,
// isComplete	boolean,
// maxPoint  INTEGER,
// practiceResult  INTEGER,
// writeTime INTEGER )"
// */
//


//TestTable

#define DATABASE_TABLE_TESTTABLE @"TestTable"

#define DATABASE_TEST_EDGEID @"edgeId" 
#define DATABASE_TEST_TESTID @"testUid"  
#define DATABASE_TEST_QUESID @"queUid" 
#define DATABASE_TEST_ANSID @"ansUid"  
#define DATABASE_TEST_SCORE @"score"    
#define DATABASE_TEST_DATAMS @"dateMS"
#define DATABASE_TEST_COURSE_CODE @"courseCode"
#define DATABASE_TEST_COURSEPACK @"package_code"
#define DATABASE_TEST_ESSASYANSWER @"essay_answer"
#define DATABASE_TEST_AVMEDIAFILES @"av_media_files"
#define DATABASE_TEST_ATTEMPT_ID @"attempt_id"





#define DATABASE_TABLE_ATTEMPTCOUNTER @"AttemptCounterTable"

#define DATABASE_ATTEMPTCOUNTER_EDGEID @"test_uniqid"
#define DATABASE_ATTEMPTCOUNTER_ATTEMPT_ID @"attempt_id"
#define DATABASE_ATTEMPTCOUNTER_TEST_TYPE @"type_of_test"
#define DATABASE_ATTEMPTCOUNTER_COURSE_CODE @"course_code"
#define DATABASE_ATTEMPTCOUNTER_COURSEPACK @"package_code"



#define DATABASE_TABLE_COINSTABLE @"CoinsTable"

#define DATABASE_COINS_COURSECODE  @"course_code"
#define DATABASE_COINS_TOPICID @"topic_edge_id"
#define DATABASE_COINS_CAHPTERID @"chapter_edge_id"
#define DATABASE_COINS_COMPONANTID @"component_edge_id"
#define DATABASE_COINS_COMPONANTTYPE @"component_type"
#define DATABASE_COINS_COMPONANTDATA @"component_data"
#define DATABASE_COINS_COMPONANTDATACOINS @"user_coins"




#define DATABASE_TABLE_COINSUSERTABLE @"CoinsUserTable"

#define DATABASE_COINSUSER_PACKAGECODE  @"coursePackCode"
#define DATABASE_COINSUSER_COMPONANTID @"component_edge_id"
#define DATABASE_COINSUSER_EARNEDCOINS @"user_coins"
#define DATABASE_COINSUSER_TOTALCOINS @"total_componant_coins"







//
//
//JumbleConversationTable
#define DATABASE_JUMBLECONVERSATION_ID @"jumbleConversationID" 
#define DATABASE_JUMBLECONVERSATION_EXERID @"exerciseID"
#define DATABASE_JUMBLECONVERSATION_QUESCARD @"quesCard" 
#define DATABASE_JUMBLECONVERSATION_QUESVIDEOPATH @"quesVideoPath"
#define DATABASE_JUMBLECONVERSATION_ANSCARD @"ansCard"
#define DATABASE_JUMBLECONVERSATION_ANSVIDEOPATH @"ansVideoPath" 
#define DATABASE_JUMBLECONVERSATION_RECVIDEOPATH @"recVideoPath"  
#define DATABASE_JUMBLECONVERSATION_RECAUDIOPATH @"recAudioPath"  
#define DATABASE_JUMBLECONVERSATION_SCOREHASHMAP @"scoreHashMap"
#define DATABASE_JUMBLECONVERSATION_ISCOMP @"isComplete"
#define DATABASE_JUMBLECONVERSATION_TIME @"writeTime"




#define RESULT @"result"


//  out put Query

 //








#define  CREATE_TABLE_USERINFO  @"CREATE TABLE UserInfoTable (loginid VARCHAR(100) NOT NULL PRIMARY KEY,userName  VARCHAR(100),password  VARCHAR(50), writeTime INTEGER )"

#define CREATE_TABLE_HONORTABLE @"CREATE TABLE HonorTable (honorID VARCHAR(100) NOT NULL PRIMARY KEY, isDone  boolean )"


#define CREATE_TABLE_COURSE @"CREATE TABLE CourseTable (cEdgeID VARCHAR(100) NOT NULL PRIMARY KEY, name  VARCHAR(100),data VARCHAR(512), desc VARCHAR(512), writeTime INTEGER )"


#define CREATE_TABLE_CATLOG_CONTENT @"CREATE TABLE CatLogContentTable (catContEdgeID VARCHAR(100) NOT NULL PRIMARY KEY,catEdgeID VARCHAR(100), name  VARCHAR(100), data VARCHAR(512),desc VARCHAR(512), catType INTEGER, ir float, isLock boolean,isComp boolean,writeTime INTEGER )"



#define CREATE_TABLE_ASSESMENT @"CREATE TABLE AssesmentTable (assesEdgeID VARCHAR(100) NOT NULL PRIMARY KEY, catEdgeID VARCHAR(100),score float,name  VARCHAR(100), data VARCHAR(512), desc VARCHAR(512), isComp boolean,writeTime INTEGER )"




#define CREATE_TABLE_SCENARIO @"CREATE TABLE ScenarioTable (scnEdgeID VARCHAR(100) NOT NULL PRIMARY KEY, catContEdgeID VARCHAR(100), name  VARCHAR(100),data VARCHAR(512),desc VARCHAR(512),isComp boolean,writeTime INTEGER )"




#define CREATE_TABLE_EXERCISE @"CREATE TABLE ExerciseTable (exEdgeID VARCHAR(100) NOT NULL PRIMARY KEY,scnEdgeID VARCHAR(100),catType INTEGER,name  VARCHAR(100),data VARCHAR(512),desc VARCHAR(512),isComp boolean,writeTime INTEGER )"



#define CREATE_TABLE_ACTIVITY @"CREATE TABLE ActiviyTable (actEdgeID VARCHAR(100) NOT NULL PRIMARY KEY,scnEdgeID VARCHAR(100),name  VARCHAR(100),data VARCHAR(512),desc VARCHAR(512),isComp boolean,writeTime INTEGER )"


/**
 *
 * scnEdgeID  : Practice node of Edgeid
 * pracEdgeID : scnpractice or voabpractice
 *  catType :  scnpractice or voabpractice
 */

#define CREATE_TABLE_PRACTICE @"CREATE TABLE PracticeTable (pracEdgeID VARCHAR(100) NOT NULL PRIMARY KEY,exEdgeID VARCHAR(100),watchEdgeID VARCHAR(100),enactEdgeID VARCHAR(100),reviewEdgeID VARCHAR(100),catType INTEGER,name  VARCHAR(100),data VARCHAR(512),desc VARCHAR(512),isComp boolean,writeTime INTEGER )"

/**
 * catType :  concept(edgeid) or paractice(watch , enact , scenario)
 * pracEdgeID : concept or paractice
 */
#define CREATE_TABLE_CONVERSATION @"CREATE TABLE ConversationTable (convUnitID VARCHAR(100) NOT NULL PRIMARY KEY,pracEdgeID VARCHAR(100),idealTime INTEGER,catType INTEGER,writeTime INTEGER )"


#define CREATE_TABLE_VOCABULARY @"CREATE TABLE VocabularyTable (vocabID VARCHAR(100) NOT NULL PRIMARY KEY,vocabWordID VARCHAR(100),word  VARCHAR(256),pracEdgeID VARCHAR(100),isComp	boolean )"



#define CREATE_TABLE_QUESTION @"CREATE TABLE QuestionTable (textID VARCHAR(100) NOT NULL PRIMARY KEY,convUnitID VARCHAR(100),tag VARCHAR(512),videoPath VARCHAR(100),recVideoPath VARCHAR(100),recAudioPath VARCHAR(100),isComplete	boolean )"


#define CREATE_TABLE_ANSWER @"CREATE TABLE AnswerTable (textID VARCHAR(100) NOT NULL PRIMARY KEY,convUnitID VARCHAR(100),tag VARCHAR(512),playPath VARCHAR(100),recVideoPath VARCHAR(100),recAudioPath VARCHAR(100),isComplete	boolean )"

#define CREATE_TABLE_TEXT_SEGMENT @"CREATE TABLE TextSegmentTable (textSegID VARCHAR(100) NOT NULL PRIMARY KEY,textID VARCHAR(100),clickItemId VARCHAR(100),simpleText VARCHAR(1024),clickText VARCHAR(512) )"


#define CREATE_TABLE_VOCABWORD @"CREATE TABLE VocabWordTable (vocabWordID VARCHAR(100) NOT NULL PRIMARY KEY,edgeID INTEGER,word  VARCHAR(256),meaning VARCHAR(512),pronunciation  VARCHAR(200),partOfSpeech VARCHAR(512),etymologies VARCHAR(512),usage VARCHAR(512),wordAudioPath  VARCHAR(300),recWordAudioPath  VARCHAR(300),pscore   INTEGER,writeTime INTEGER )"


#define CREATE_TABLE_GAMETABLE @"CREATE TABLE GameTable (gameEdgeID INTEGER NOT NULL PRIMARY KEY,catContEdgeID VARCHAR(100),name  VARCHAR(100),data VARCHAR(512),desc VARCHAR(512),loss INTEGER,win INTEGER,isComp boolean,writeTime INTEGER )"


#define CREATE_TABLE_TRACKING @"CREATE TABLE TrackingTable (moduleID VARCHAR(100),scenarioID VARCHAR(100),edgeID  VARCHAR(100),trackType INTEGER,usageScore float,isComplete	boolean,startTime INTEGER,endTime INTEGER )"


#define CREATE_TABLE_TRACKSYNCTIME @"CREATE TABLE TrackSyncTime (writeTime INTEGER )"



#define CREATE_TABLE_AUDROAPITABLE @"CREATE TABLE AudroApiTable (audroApiID VARCHAR(100) NOT NULL PRIMARY KEY,apiType VARCHAR(300),pullTime INTEGER,pushTime INTEGER )"



#define CREATE_TABLE_PULLIRTABLE @"CREATE TABLE PullIrTable (edgeID VARCHAR(100) NOT NULL PRIMARY KEY,avgIR float,maxIR float,writeTime INTEGER )"



#define CREATE_TABLE_MODULE @"CREATE TABLE ModuleTable (moduleID VARCHAR(100) NOT NULL PRIMARY KEY,edgeID INTEGER,moduleName  VARCHAR(50),description VARCHAR(512),imagePath  VARCHAR(300),moduleIR INTEGER,writeTime INTEGER )"

/*
 #define CREATE_TABLE_EXERCISE @
 "CREATE TABLE ExerciseTable (
 exerciseID VARCHAR(100) NOT NULL PRIMARY KEY,
 scenarioID VARCHAR(100),
 edgeID INTEGER,
 xmlName  VARCHAR(100),
 description  VARCHAR(512),
 exerciseType  INTEGER,
 isComplete	boolean,
 maxPoint  INTEGER,
 practiceResult  INTEGER,
 writeTime INTEGER )"
 */

#define CREATE_TABLE_TEST @"CREATE TABLE TestTable (edgeId VARCHAR(100),testUid  VARCHAR(1024),queUid VARCHAR(300),ansUid  VARCHAR(300),score    INTEGER,dateMS    INTEGER )"


#define CREATE_TABLE_JUMBLECONVERSATION @"CREATE TABLE JumbleConversationTable (jumbleConversationID VARCHAR(100) NOT NULL PRIMARY KEY,exerciseID VARCHAR(100),quesCard  VARCHAR(1024),quesVideoPath VARCHAR(300),ansCard  VARCHAR(1024),ansVideoPath  VARCHAR(300),recVideoPath  VARCHAR(300),recAudioPath  VARCHAR(300),scoreHashMap  VARCHAR(1024),isComplete	boolean,writeTime INTEGER )"



#define INSERTDATA_INTOUSERTABLE @"IN"











#define DATABASE_CATTYPE_COURSE_XML				 @"1"
#define DATABASE_CATTYPE_CATLOG					 @"2"
#define DATABASE_CATTYPE_ASSISMENT_XML			 @"3"
#define DATABASE_CATTYPE_MODULE				     @"4"

#define DATABASE_CATTYPE_SCENARIO				 @"5"
#define DATABASE_CATTYPE_CONCEPT_XML		     @"6"
#define DATABASE_CATTYPE_ACTIVITY 				 @"7"
#define DATABASE_CATTYPE_PRACTICE				 @"8"
#define DATABASE_CATTYPE_SCN_PRACTICE_XML		 @"9"
#define DATABASE_CATTYPE_VOCAB_PRACTICE_XML		 @"10"

#define DATABASE_CATTYPE_GAME					 @"11"
#define DATABASE_CATTYPE_VOCAB_WORD_XML			 @"12"

#define DATABASE_CATTYPE_PROFILE 				 @"13"
#define DATABASE_CATTYPE_COURSE 			     @"14"
#define DATABASE_CATTYPE_PROGRAM			     @"15"

#define DATABASE_CATTYPE_CANCEL					 @"16"
#define DATABASE_CATTYPE_AGREE					 @"17"
#define DATABASE_CATTYPE_WATCH_OBSERVE			 @"18"
#define DATABASE_CATTYPE_ENACT_SCN				 @"19"
#define DATABASE_CATTYPE_REVIEW					 @"20"
#define DATABASE_CATTYPE_MCQ_PRACTICE_XML		 @"21"
#define DATABASE_CATTYPE_SPEEDREADING            @"22"
#define DATABASE_CATTYPE_VOICERENISATION         @"23"
#define DATABASE_CATTYPE_RESOURSE                @"24"
#define DATABASE_CATTYPE_CONVERSATION            @"25"
#define DATABASE_CATTYPE_LEARNOSITY              @"26"










// QUERYTYPE





#endif
