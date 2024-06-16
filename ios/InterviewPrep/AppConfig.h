
//
//  AppConfig.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 28/04/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#ifndef InterviewPrep_AppConfig_h
#define InterviewPrep_AppConfig_h

#define LANGUAGESUPPORT @"single"
#define SHOWCAPTERBUY @"0"
#define APPVERSION @"2"

#define QA_SERVER  1
#define AIS_SERVER  3
#define PRODUCTION_SERVER  2

#define PEARSON_SERVER_DEV  4 // for mepro
#define PEARSON_SERVER_STG  5

#define JOBEDGE_SERVER  6

#define AMERICANLIFE_WILEY_SERVER  7


// 0 bridgestone
// 1 BEC
// 2 Orion Edutec
// 3 Digital English Courses
// 4 EnglishEdge Bangla
// 5 EVOX
// 6 ETOE
// 7 Cambridge Language Lab
// 8 EMConfident
// 9 Spoken English for Schools
// 10 Wiley English
// 11 Pearson MePro
// 12 WileyNXT
// 13 Pearson English Warm Up
// 14 UK Awards
// 15 Acing the Interviews
// 16 Quizky
// 17 Kananprep English
// 18 Cambridge Capable
// 19 Asipiring Careers
// 20 American Life ART

#define CUSTOMER 20 // selects which app to build
//
//#if CUSTOMER == 0
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "bridgeStone.h"
//
//#elif CUSTOMER == 1
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "bec.h"
//
//#elif CUSTOMER == 2
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "Orien.h"
//
//#elif CUSTOMER == 3
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "englishedge.h"
//
//#elif CUSTOMER == 4
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "englishedge.h"
//
//#elif CUSTOMER == 5
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "evox.h"
//
//#elif CUSTOMER == 6
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "etoe.h"
//
//#elif CUSTOMER == 7
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "cll.h"
//
//#elif CUSTOMER == 8
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "emConfident.h"
//
//#elif CUSTOMER == 9
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "bbc.h"
//
//#elif CUSTOMER == 10
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "wiley.h"
//
//#elif CUSTOMER == 11
//
//#define SERVER PEARSON_SERVER_STG
////#define AUDRO_ADDTION @"https://emp-dev.adurox.com/"
//#define AUDRO_ADDTION @"https://emp-stg.adurox.com/"
//#import "pearsonMePro.h"
//
//#elif CUSTOMER == 12
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "wileynxt.h"
//
//#elif CUSTOMER == 13
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "PTEGeneral.h"
//
//#elif CUSTOMER == 14
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "UKAwards.h"
//
//#elif CUSTOMER == 15
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "ace.h"
//
//#elif CUSTOMER == 16
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "quizky.h"
//
//#elif CUSTOMER == 17
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "kanan.h"
//
//#elif CUSTOMER == 18
//
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"
//#import "CamCapable.h"
//
//#elif CUSTOMER == 19
//
//#define SERVER JOBEDGE_SERVER
//#define AUDRO_ADDTION @"https://emp-product.englishedge.in/"
//#import "aspiring.h"
//
//#elif CUSTOMER == 20

#define SERVER AMERICANLIFE_WILEY_SERVER
#define AUDRO_ADDTION @"https://emp-art.englishedge.in/"
#import "americanLifeChange.h"
//#define SERVER PRODUCTION_SERVER
//#define AUDRO_ADDTION @"https://mobile.englishedge.in/emp/"


//#endif






//    1: QA  server  2: AWS PRODUCTION server // 3 :AIS Server // 4 Pearson dev Server // 5 Pearson stg Server


#if SERVER == 1  //QA


#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@view/uploads/",AUDRO_ADDTION]

#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]

#elif SERVER == 2  //LIVE

#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@live/",AUDRO_ADDTION]
#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]



#elif SERVER == 4  //PEARSON DEV

#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@view/uploads/",AUDRO_ADDTION]
#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]


#elif SERVER == 5  //PEARSON STG


#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@emp/view/uploads/,AUDRO_ADDTION]

#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL @"http://mypearsonhelp.com/pde"
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]



#elif SERVER == 6  // EMP EE (Scholar Jobedge)


#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@view/uploads/",AUDRO_ADDTION]

#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]




#elif SERVER == 7  // EMP American Life  (Wiley)

//#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@view/uploads/",AUDRO_ADDTION]
//
//#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
//#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
//#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
//#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
//#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
//#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
//#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
//#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
//#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
//#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
//#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]


#define AUDRO_PDF_PATH [[NSString alloc] initWithFormat:@"%@live/",AUDRO_ADDTION]
#define AUDRO_URL [[NSString alloc] initWithFormat:@"%@live/ios-service-mobile.php",AUDRO_ADDTION]
#define AUDRO_ZIP_URL [[NSString alloc] initWithFormat:@"%@view/course_data/",AUDRO_ADDTION]
#define ADURO_AUDIO_URL [[NSString alloc] initWithFormat:@"%@live/upload.php?",AUDRO_ADDTION]
#define IMAGEPATH  [[NSString alloc] initWithFormat:@"%@view/profile_pic/",AUDRO_ADDTION]
#define FEEDBACKURL  [[NSString alloc] initWithFormat:@"%@feedback/feedback.php",AUDRO_ADDTION]
#define SANAVOICEAPI  [[NSString alloc] initWithFormat:@"%@sana/sana-api.php",AUDRO_ADDTION]
#define DEMOGRAPHICURL  [[NSString alloc] initWithFormat:@"%@live/demographics_data.json",AUDRO_ADDTION]
#define LTITESTURL  [[NSString alloc] initWithFormat:@"%@live/lti/lti-request.php?token=%@",AUDRO_ADDTION]
#define ADURO_ASSIGNMENT_URL  [[NSString alloc] initWithFormat:@"%@live/upload_assignment.php",AUDRO_ADDTION]
#define ADURO_ADD_ATTENDEE  [[NSString alloc] initWithFormat:@"%@wiziq/ClassAPI/cs_addattendee.php",AUDRO_ADDTION]
#define ADURO_LEARNOSITY_URL   [[NSString alloc] initWithFormat:@"%@learnosity/learnosity.php?",AUDRO_ADDTION]



#endif




#define WILEY_ZOOMGUIDEURL [[NSString alloc] initWithFormat:@"%@live/resource/ala/Zoom.pdf",AUDRO_ADDTION]



#define BEC_TESTYOURENGLISH @"http://www.cambridgeenglish.org/in/test-your-english/business"
#define BEC_USEFULRESOURCE [[NSString alloc] initWithFormat:@"%@live/resource/BEC/usefulLink.html",AUDRO_ADDTION]



//#define ABOUTTESTS [[NSString alloc] initWithFormat:@"%@live/resource/pte/about_test.pdf",AUDRO_ADDTION]
//
//#define GUIDELEVEL [[NSString alloc] initWithFormat:@"%@live/resource/pte/guide-level-3.pdf",AUDRO_ADDTION]

#define TESTLENGTH [[NSString alloc] initWithFormat:@"%@live/resource/pte/test_length.html",AUDRO_ADDTION]

#define PTEG_TESTSTIPS [[NSString alloc] initWithFormat:@"%@live/resource/pte/test-tips.pdf",AUDRO_ADDTION]


#define PTEG_SCORING [[NSString alloc] initWithFormat:@"%@live/resource/pte/scoring.html",AUDRO_ADDTION]

#define PTEG_SKILLSTESTED [[NSString alloc] initWithFormat:@"%@live/resource/pte/skills_tested.html",AUDRO_ADDTION]

#define PTEG_TESTSCONTENT [[NSString alloc] initWithFormat:@"%@live/resource/pte/test_content.html",AUDRO_ADDTION]


#define PTEG_TESTSTRUCTURE [[NSString alloc] initWithFormat:@"%@live/resource/pte/test_structure.html",AUDRO_ADDTION]

#define PTEG_WHATIS [[NSString alloc] initWithFormat:@"%@live/resource/pte/what_is_pearson_english_international_certificate.html",AUDRO_ADDTION]

#define PTEG_WHATAKES [[NSString alloc] initWithFormat:@"%@live/resource/pte/who_takes_pearson_english_international_certificate.html",AUDRO_ADDTION]

#define PTEG_RESOURCES @"https://qualifications.pearson.com/en/qualifications/international-certificate.html"


#define ACE_VIDEO [[NSString alloc] initWithFormat:@"%@live/resource/ace/Acing-the-Interview.mp4",AUDRO_ADDTION]







// Encryption  Mechenism

//#define ENCRYPTION  @"YES"
#define ENCRYPTION  @"NO"


// Language Type

#define LANGUAGE_ENG   @"en"
#define LANGUAGE_CHAINA   @"zh-Hans"
#define LANGUAGE_HINDI   @"hi"
#define LANGUAGE_BN   @"bn"
#define LANGUAGE_KN   @"kn"
#define LANGUAGE_MR   @"mr"
#define LANGUAGE_TA   @"ta"
#define LANGUAGE_TE   @"te"
#define LANGUAGE_ML   @"ml"



#endif
