//
//  PTEGeneral.h
//  InterviewPrep
//
//  Created by Amit Gupta on 12/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#ifndef PTEGeneral_h
#define PTEGeneral_h

#define APPNAMESHARE @"Pearson English Warm Up"
#define CLASS_NAME @"pte"
#define CLIENT @"pte"
#define UISTANDERD @"PRODUCT3"
#define LOGINSTATUSBARCOLOR @"#ffffff"
#define SPLASHCOLOR @"#0E5C72"
#define SPLASHSCREEN  @"PTEG_Spalsh.png"
#define HOMESPLASHSCREEN  @""
#define HOMESPLASHBLURSCREEN  @""
#define PROGRESS_BAR_COLOR  @"#0E5C72"
#define SIGNSIGNUPCOLOR @"#00A39D"

#define LOGO @"PTEG_Logo.png"
#define COURSELOGO @""

#define TERMSCOLOR @"#0087A7"
#define DOCUMENETSSERVERPATH [[NSString alloc] initWithFormat:@"%@live/resource/pte/",AUDRO_ADDTION]
//#define TERMSANDSERVICES @"https://mobile.englishedge.in/emp/live/resource/pte/termsandcondition.html"
#define TERMSANDSERVICES @"https://login-dev.pearson.com/v1/piapi-dev/policies/static/html/UKLearnsTermsOfUsePolicy.html"

#define PRIVACYCOLOR @"#0087A7"
#define PRIVACY @"https://pi.pearsoned.com/v1/piapi/policies/static/html/PearsonPrivacyPolicy.html?"

#define EULACOLOR @""
#define EULASERVICE @""

#define APP_ABOUTUS [[NSString alloc] initWithFormat:@"%@live/resource/pte/aboutus.html",AUDRO_ADDTION]
#define APP_ABOUTPROGRAM [[NSString alloc] initWithFormat:@"%@live/resource/pte/about_programme.html",AUDRO_ADDTION]

#define FAQURL [[NSString alloc] initWithFormat:@"%@live/resource/pte/faq.html",AUDRO_ADDTION]

#define APP_LICENCE_KEY_PRIMINILARY @""
#define APP_LICENCE_KEY_VINTAGE @""
#define APP_LICENCE_KEY_PRACTEST1 @""
#define APP_LICENCE_KEY_PRACTEST2 @""


#define APP_LICENCE_KEY_WILEY_BASIC @""
#define APP_LICENCE_KEY_WILEY_INTERMEDIATE @""
#define APP_LICENCE_KEY_WILEY_ADVANCE  @""


#define APP_LICENCE_KEY_MEPRO  @""
#define APP_BACKGROUND_IMAGE @""
#define APP_LICENCE_KEY_PTEGENERAL @"PTEGENERAL" //@"8EAEB998FF"  //



#define PERCENTAGECIRCLE @"#77ba2e"

#define QUIZPROGRESSTRACKBARCOLOR @"#EDECE1"
#define QUIZPROGRESSBARCOLOR @"#63c033"


#define DRAWERCOLOR @"#0E5C72"
#define DRAWERCOLOR_ICON @"#ffffff"

#define STATUSBARCOLOR @"#0E5C72"
#define HEADER_TEXT_COLOR   @"#ffffff"

#define FOOTER_BACKGROUND_COLOR  @"#0E5C72"
#define FOOTER_TEXT_COLOR  @"#ffffff"

#define CATEGOEY_HEADER_COLOR @"#ebebeb"


#define  WIDGET_BUTTON_TEXT_DISABLE_COLOR @"#3a3a3a"
#define  WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR  @"#d9d9d9"

#define  WIDGET_BUTTON_BACKGROUD_COLOR  @"#0E5C72"
#define  WIDGET_BUTTON_TEXT_COLOR @"#ffffff"

#define  WIDGET_MCQ_BUTTON_BACKGROUD_COLOR  @"#00A39D"
#define  WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR  @"#00A39D"


#define  DEFAULTTEXTCOLOR @"#333333"
#define  DEFAULTLIGHTTEXTCOLOR @"#888888"

#define BOTTOMMENUBARBACKGROUNDCOLOR @"#ffffff"
#define BOTTOMMENUBARLINECOLOR @"#f2f2f2"

#define BACKGROUND_COLOR  @"#f5f5f5"


#define BLACKCOLOR @"#000000"


#define APPFONTBOLD @"HelveticaNeue-Bold"
#define APPFONTNORMAL @"HelveticaNeue"

#define GOOGLESERVICEINFOPLIST @"GoogleService-Info"
#define RC4KEYVALUE @"pract1ceAtl!qv!d"//@"p1^bil" //

#define ISAESENCRYPTIONENABLE  YES
#define ISENABLECOINSUI NO
#define ISENABLERESUMEQUIZ YES

//#define STSTUSNAVIGATIONBARHEIGHT 64
#define STSTUSNAVIGATIONBARHEIGHT (([[UIScreen mainScreen] bounds].size.height-812 >= 0)?138:104)
#define STSTUSNAVIGATIONBARHEIGHT_BOTTOM (([[UIScreen mainScreen] bounds].size.height-812 >=0 )?109:74)


#define BUTTONROUNDRECT 10.0f

#define   SPLASHCLASS   PTEG_Splash
#define   SPLASHCLASSXIB   @"PTEG_Splash"

#define SUMMARYSCREENCALSS  PTEG_QuizSummery
#define SUMMARYSCREENXIB  @"PTEG_QuizSummery"

#define VOCABULARYPRACTICECLASS vocabAudioPracticeViewController
#define VOCABULARYPRACTICEXIB   @"vocabAudioPracticeViewController"

#define ASSESSMENTQUESANDQT Assessment
#define ASSESSMENTQUESANDQTXIB   @"Assessment"

#define APP_QUIZ_RECORD_ICON @"MicEnable_Ani.png"
#define APP_QUIZ_EXPERT_ICON @"Play.png"
#define APP_QUIZ_PAUSE_ICON @"RecordingAble_Ani.png"



#define LOGINTITLEHEADER [UIFont boldSystemFontOfSize:21.0]
#define NAVIGATIONTITLEFONT  [UIFont systemFontOfSize:18.0]
#define GRPAHTITLEFONT  [UIFont boldSystemFontOfSize:18.0]


#define NAVIGATIONTITLEUPFONT  [UIFont systemFontOfSize:13]
#define NAVIGATIONTITLEDOWNFONT  [UIFont systemFontOfSize:16]


#define BUTTONFONT  [UIFont systemFontOfSize:16]
#define HEADERSECTIONTITLEFONT  [UIFont systemFontOfSize:15]
#define HEADERSECTIONTITLEBOLDFONT  [UIFont boldSystemFontOfSize:15]


#define BOLDTEXTTITLEFONT [UIFont boldSystemFontOfSize:16]
#define TEXTTITLEFONT  [UIFont systemFontOfSize:16]
#define SUBTEXTTILEFONT [UIFont systemFontOfSize:13]


#define UIBUTTONHEIGHT 40

#define HM_MEPRO_LOGIN      @"Sign In"
#define RP_MEPRO_SIGNUP_TEXT @"Sign Up"
#define COPYRIGHT @""
#define DASHBOARDTEXTCOLOR @"#4e4e4e"
#define  DASHBOARDBTNCOLOR  @"#cd2443"
#define LEVEL_TEXT @""
#endif /* pearsonMePro_h */

