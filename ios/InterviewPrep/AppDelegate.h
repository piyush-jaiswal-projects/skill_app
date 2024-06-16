//
//  AppDelegate.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 13/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Engine.h"
#import "Language.h"
#import <Foundation/Foundation.h>
#import <EXUpdates/EXUpdatesAppController.h>
#import <React/RCTBridgeDelegate.h>
#import <UMCore/UMAppDelegateWrapper.h>



#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

@import Firebase;



@interface AppDelegate : UIResponder<UIApplicationDelegate>

 enum
{
    enum_minController = 0,
    enum_courseCodeController = 3,
    enum_dashboardController = 4,
    enum_graphDashboardController = 5,
    enum_catelogControoler = 6,
    enum_programOverviewController =7,
    enum_scenarioController =8,
    enum_conceptController = 9,
    enum_vocablistController =10,
    enum_vocabController =11,
    enum_mcqAssessmentController =12,
    enum_scnPracController= 13,
    enum_scnPracInsController=14,
    enum_actvityController = 15,
    enum_languageController =16,
    //enum_homeController = 17,
    enum_aboutController = 18,
    enum_maxController = 19
    
};
typedef int controllerType;

#define enum_down_level  -1
#define enum_original_level  0
#define enum_up_level  1



@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *launchOptions;
@property (strong, atomic) Engine   *engineObj;
@property Language *langObj;
@property NSString *Cookie;
@property NSString *Lang;
@property BOOL allowRotation;
@property BOOL initPlayer;
@property int activityUpdate;

@property NSString *appName;
@property NSString * appType;

@property NSString *coursePack;

@property NSDictionary * workingCourseObj;
@property NSString *courseCode;
@property NSString * product_id;
@property NSString * product_name;

@property BOOL  isEnableLTITest;
@property BOOL  isShowDashboard;




@property NSDictionary * workingTopicObj;
@property NSString *topicId;
@property NSString *topicName;


@property NSDictionary * workingChapterObj;
@property NSString *chapterId;
@property NSString *chapterName;

@property NSString *expiryDays;
@property NSString *app_Code;

@property NSString *notification_token_id;
@property NSString *vocabWordCookie;
@property BOOL isServiceRunning;
@property BOOL rotationFlag;
@property BOOL viewMode;   //FALSE B to C //TRUE B to B
@property NSString * currScnId;
@property NSString*  GSE_level;
@property int  lti_Test_Score;
@property NSString * GSE_desc;
@property NSString * CEFR_level;
@property UIViewController * baseObj;
@property NSString * APPSTOREURLSHARE;
@property NSDictionary * global_userInfo;
@property NSMutableDictionary *skillDict;
@property NSMutableDictionary *skillImgDict;
@property NSMutableDictionary *skillNameDict;
@property NSMutableDictionary *default_Componant_mg;
@property int AssessmentQuesAttemptCounter;   // -1 unlimited
@property BOOL isPreRegisteredUser;

@property int master_mode;
@property int quiz_passing_percentage;
@property int review_passing_percentage;
@property int level_passing_score;
@property int chapter_quiz_passing_score;
@property NSString * bookmark_type;
@property NSString * countryCode;


@property NSDictionary * overAllDictionary;
@property NSDictionary * skilDataDictionary;
@property NSDictionary * testDataDictionary;
@property NSDictionary * goalData;












// to Know User is up from Current Level or Down
@property int leveType;

//- (NSString *)getMessageNSString :(int)type;

- (NSString *)getCurrentTime;
- (NSString *)getCurrentTimeWithResumeTime:(long long)value;
- (NSString *)getFirstName;





-(void)gotoNextController:(UIViewController *)CurrentController controllerType :(controllerType)Ctype sendingObj :(NSMutableDictionary *)obj;
//-(void)goToActivity:(UIViewController *)controller :(NSString * )data :(NSString * )type;
//-(void )startService;
//-(void)goVocabPractice:(UIViewController *)controller :(int )data : (int ) scnUid :(int ) type :(int ) vocabtype TitleName:(NSString *)titleName;
-(void)gotoScnVideoAudioPractice:(UIViewController *)controller :(int )practiceUid :(int )ScnPracticeUid :(NSString * )practiceType :(int)scnUid :(int)scnType :(int) scnPracticeType :(int) recordingType :(NSString *) level :(NSString *) topicname;
-(void)goScenarioPractice:(UIViewController *)controller :(int )scnPracticeUid : (int ) scnUid :(int ) scnType :(int ) scnPracticeType TitleName:(NSString *)titleName :(NSString *) level :(NSString *) topicname;
//-(void)gotoVocabWordAudioPractice:(UIViewController *)controller : (NSString *)word_Id : (int )parent_Id :(int ) scnUid :(int ) type :(int ) vocabtype :(int)count  WordName:(NSString *)name;





-(void)renameFileWithName:(NSString *)filePathSrc toName:(NSString *)filePathDst;
//-(int) getUserTrackScore :(int) idealTime :(long) pracTime;
-(void )setLanguage:(NSString *)lang;
-(NSString * )getGoogleLanguage;
-(BOOL)isNetworkAvailable;

-(BOOL) checkZipPath:(NSString *)fileName;
-(BOOL) checkZipPath:(NSString *)fileName :(NSString *)course_code;

-(void)setUserDefaultData:(id)value:(NSString *)key;
-(id)getUserDefaultData:(NSString *)key;
-(void)deleteUserDefaultData:(NSString *)key;

+(void)setUserDefaultData:(id)value:(NSString *)key;
+(id)getUserDefaultData:(NSString *)key;
+(void)deleteUserDefaultData:(NSString *)key;




-(void)setTextHTMLLabel :(UILabel *)lbl :(NSString*)str;
-(void)setTextHTMLTextView :(UILabel *)lbl :(NSString*)str;
-(BOOL)isResourceAvailable:(NSString *)file_path;

- (RCTBridge *)initializeReactNativeApp:(UIViewController *)controller;


@end



// for BEC facebookId 2113673442208445
// Cambridge CLL  facebook Id 419767115373674
// Digital Englishedge  709655849395962

// Wiley NXT 2526740847590637


