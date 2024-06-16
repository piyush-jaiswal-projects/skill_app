//
//  AppDelegate.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 13/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#include<unistd.h>
#include<netdb.h>
#import "AppDelegate.h"
#import "MobileSplash.h"
#import "PTEG_Splash.h"
#import "MePro_Splash.h"
#import "Language.h"
#import "GlobalHeader.h"
#import "FileLogger.h"
#import "Catlog.h"
#import "Dashboard.h"
#import "ScenarioPracticeModule.h"
//#import "vocabPractice.h"
#import "ScnarioPracticeInstruction.h"
#import "ConceptAndScnpractice.h"
#import "baseViewController.h"
#import "ChooseLanguage.h"
#import "CourseScreen.h"
#import "URL_Macro.h"
//hm#import "Home.h"
#import "aboutUS.h"
#import "Notification_Event.h"
#import "IQKeyboardManager.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTLinkingManager.h>

#import <UMCore/UMModuleRegistry.h>
#import <UMReactNativeAdapter/UMNativeModulesProxy.h>
#import <UMReactNativeAdapter/UMModuleRegistryAdapter.h>
#import <EXSplashScreen/EXSplashScreenService.h>
#import <UMCore/UMModuleRegistryProvider.h>

#if defined(FB_SONARKIT_ENABLED) && __has_include(<FlipperKit/FlipperClient.h>)
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif







@import UserNotifications;
@interface AppDelegate ()<UNUserNotificationCenterDelegate,RCTBridgeDelegate>
{
    NSString * pauseTime;
    UINavigationController *navigation;
    UIAlertController * alert;
}
@property (nonatomic, strong) UMModuleRegistryAdapter *moduleRegistryAdapter;


@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    
    self.global_userInfo = [self.engineObj getUserInfo];
    if(self.global_userInfo != NULL)
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSArray *visitedArr = [defaults valueForKey:@"visitedData"];
        NSMutableArray * _visitedArr = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in visitedArr) {
            NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
            [_Obj setValue:[obj valueForKey:@"user_id"] forKey:@"user_id"];
            [_Obj setValue:[obj valueForKey:@"date"] forKey:@"date"];
            
            [_Obj setValue:[obj valueForKey:@"date_with_time"] forKey:@"date_with_time"];
            [_Obj setValue:@"lerner" forKey:@"role"];
            
            [_visitedArr addObject:_Obj];
        }
        NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
        [_Obj setValue:[defaults valueForKey:@"user_id"] forKey:@"user_id"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-M-d";
        NSString *string = [formatter stringFromDate:[NSDate date]];
        
        [_Obj setValue:string forKey:@"date"];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *string1 = [formatter1 stringFromDate:[NSDate date]];
        [_Obj setValue:string1 forKey:@"date_with_time"];
        [_Obj setValue:@"lerner" forKey:@"role"];
        [_visitedArr addObject:_Obj];
        [defaults setObject:_visitedArr  forKey:@"visitedData"];
        
        [defaults synchronize];
        
    }
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.launchOptions = launchOptions;


  
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error: nil];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    //[FIRApp configure];
    NSString *filePath;
    filePath = [[NSBundle mainBundle] pathForResource:GOOGLESERVICEINFOPLIST ofType:@"plist" inDirectory:nil];
     FIROptions *options = [[FIROptions alloc] initWithContentsOfFile:filePath];
    [FIRApp configureWithOptions:options];
    
    //[FIRMessaging messaging].delegate = self;
    //[Fabric.sharedSDK setDebug:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
//                                                 name:kFIRInstanceIDTokenRefreshNotification object:nil];
    // [END set_messaging_delegate]
    
    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    // [START register_for_notifications]
    
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    [application registerForRemoteNotifications];
    
    IQKeyboardManager.sharedManager.enable = true;


    
    
     self.skillDict =  [[NSMutableDictionary alloc]init];
     
     [self.skillDict setValue:@"#00a5a4" forKey:@"1"]; // listening
     [self.skillDict setValue:@"#643474" forKey:@"2"]; // Speaking
     [self.skillDict setValue:@"#336187" forKey:@"3"]; //Reading
     [self.skillDict setValue:@"#63c033" forKey:@"4"]; // Writing
     [self.skillDict setValue:@"#41A9CE" forKey:@"5"]; //  Vocabulary
     [self.skillDict setValue:@"#ffeabb" forKey:@"6"]; // Grammar
     [self.skillDict setValue:@"#047b9d" forKey:@"7"]; // undefined
    
     self.skillImgDict =  [[NSMutableDictionary alloc]init];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/reading_icon-1579009149.png",AUDRO_ADDTION] forKey:@"3"];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/mepro_writing_icon-1579009016.png",AUDRO_ADDTION] forKey:@"4"];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/speaking_icon-1579009110.png",AUDRO_ADDTION] forKey:@"2"];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/mapro_list_icon-1579008950.png",AUDRO_ADDTION] forKey:@"1"];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/mepro_vocab_icon-1579009202.png",AUDRO_ADDTION] forKey:@"5"];
     [self.skillImgDict setValue:[[NSString alloc] initWithFormat:@"%@view/uploads/mepro_grammer_icon-1579008025.png",AUDRO_ADDTION] forKey:@"6"];
     [self.skillImgDict setValue:@"" forKey:@"7"];
    
    
    
    
     self.skillNameDict =  [[NSMutableDictionary alloc]init];
     [self.skillNameDict setValue:@"Listening" forKey:@"1"]; //listening
     [self.skillNameDict setValue:@"Speaking" forKey:@"2"]; // Speaking
     [self.skillNameDict setValue:@"Reading" forKey:@"3"]; // Reading
     [self.skillNameDict setValue:@"Writing" forKey:@"4"]; // Writing
     [self.skillNameDict setValue:@"Vocabulary" forKey:@"5"]; //  Vocabulary
     [self.skillNameDict setValue:@"Grammar" forKey:@"6"]; // Grammar
     [self.skillNameDict setValue:@"Undefined" forKey:@"7"]; // undefined
     [self.skillNameDict setValue:@"Personal Introduction" forKey:@"8"]; //Reading
     [self.skillNameDict setValue:@"Read Aloud" forKey:@"9"]; // Writing
     [self.skillNameDict setValue:@"Repeat Sentence" forKey:@"10"]; // Speaking
     [self.skillNameDict setValue:@"Describe Image" forKey:@"11"]; // listening
     [self.skillNameDict setValue:@"Re-tell Lecture" forKey:@"12"]; //  Vocabulary
     [self.skillNameDict setValue:@"Answer Short Question" forKey:@"13"]; // Grammar
     [self.skillNameDict setValue:@"Summarize Written Text" forKey:@"14"]; // undefined
     [self.skillNameDict setValue:@"Essay" forKey:@"15"]; //Reading
     [self.skillNameDict setValue:@"Reading & Writing Fill in the Blanks" forKey:@"16"]; // Writing
     [self.skillNameDict setValue:@"Multiple Choice, Multiple Answer" forKey:@"17"]; // Speaking
     [self.skillNameDict setValue:@"Multiple Choice, Multiple Answer" forKey:@"18"]; // listening
     [self.skillNameDict setValue:@"Fill in the Blanks" forKey:@"18"]; //  Vocabulary
     [self.skillNameDict setValue:@"Multiple Choice, Single Answer" forKey:@"20"]; // Grammar
     [self.skillNameDict setValue:@"Summarize Spoken Text" forKey:@"21"]; // undefined
     [self.skillNameDict setValue:@"Highlight Correct Summary" forKey:@"22"]; //Reading
     [self.skillNameDict setValue:@"Select Missing Word" forKey:@"23"]; // Writing
     [self.skillNameDict setValue:@"Highlight Incorrect Words" forKey:@"24"]; // Speaking
     [self.skillNameDict setValue:@"Write From Dictation" forKey:@"25"]; // listening
    
    
    
     self.default_Componant_mg =  [[NSMutableDictionary alloc]init];
     [self.default_Componant_mg setValue:[[NSString alloc] initWithFormat:@"%@view/images/concept.png",AUDRO_ADDTION] forKey:@"concept"];
     [self.default_Componant_mg setValue:[[NSString alloc] initWithFormat:@"%@view/images/conversation.png",AUDRO_ADDTION] forKey:@"Conversation"];
     [self.default_Componant_mg setValue:[[NSString alloc] initWithFormat:@"%@view/images/resources.png",AUDRO_ADDTION] forKey:@"resource"];
     [self.default_Componant_mg setValue:@"Writing" forKey:@"4"]; // listening
     [self.default_Componant_mg setValue:@"Vocabulary" forKey:@"5"]; //  Vocabulary
     [self.default_Componant_mg setValue:@"Grammar" forKey:@"6"]; // Grammar
     [self.default_Componant_mg setValue:@"Undefined" forKey:@"7"]; // undefined
    
    
    self.overAllDictionary = NULL;
    self.skilDataDictionary = NULL;
    self.testDataDictionary = NULL;
    
    self.goalData = NULL;
    
    self.workingCourseObj= NULL;
    self.workingTopicObj= NULL;
    self.workingChapterObj= NULL;
    self.product_id= @"-1";
    self.product_name= @"EnglishEdge";
    self.isShowDashboard= FALSE;
    self.isEnableLTITest= FALSE;
     
    
    self.AssessmentQuesAttemptCounter = -1;
    self.isServiceRunning = FALSE;
    self.initPlayer = NO;
    self.rotationFlag = NO;
    self.vocabWordCookie= @"";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.langObj = [[Language alloc]initialize:[self getLanguage]];
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(id)kCFBundleNameKey];
    self.appName = appName;
    self.activityUpdate =0;
    self.engineObj = [[Engine alloc]init:self.langObj courseCode:self.courseCode];
    self.coursePack = @"";
    self.topicId = @"";
    self.chapterId = @"";
    self.GSE_level  = @"-1";
    self.lti_Test_Score  = -1;
    self.GSE_desc = @"nil";
    self.CEFR_level = @"-1";
    self.global_userInfo = NULL;
    self.leveType = enum_original_level;
    self.bookmark_type =@"";
    self.master_mode = 0;
    self.quiz_passing_percentage = 0;
    self.review_passing_percentage = 0;
    self.level_passing_score = 0;
    self.chapter_quiz_passing_score = 0;
    
    if([CLASS_NAME isEqualToString:@"BEC"]){
        
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        self.countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        NSLog(@"countryCode: %@", self.countryCode);
    }
    else
    {
       self.countryCode = @"US";
       NSLog(@"countryCode: %@", self.countryCode);
    }
    self.GSE_level  = @"-1";
    self.lti_Test_Score  = -1;
    self.GSE_desc = @"nil";
    self.CEFR_level = @"-1";

    self.global_userInfo = [self.engineObj getUserInfo];
    
    if(self.global_userInfo != NULL)
    {
        self.isPreRegisteredUser  = [self.engineObj isPreregisteredUser];
    }
    else
    {
        self.isPreRegisteredUser = FALSE;
    }
    
    
    
//for(NSString *fontfamilyname in [UIFont familyNames])
//{
//    NSLog(@"Family:'%@'",fontfamilyname);
//    for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//{
//    NSLog(@"\tfont:'%@'",fontName);
//}
//NSLog(@"---");
//}
    
    
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    UIViewController* viewController;
    viewController  = [[SPLASHCLASS alloc] initWithNibName:SPLASHCLASSXIB bundle:nil];
    navigation = [[UINavigationController alloc]initWithRootViewController:viewController];
    navigation.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.window.rootViewController = navigation;
    self.allowRotation = false;
    
    [self.window makeKeyAndVisible];
    
    [Logger logAduro:@"AppDelegate : Exit Function didFinishLaunchingWithOptions." ];
    return YES;
}

//- (void)tokenRefreshNotification:(NSNotification *)notification {
////    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
////    NSLog(@"InstanceID token: %@", refreshedToken);
////    self.notification_token_id = "";
//}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
        
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}
// [END receive_message]

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
// Handle incoming notification messages while app is in the foreground.

//Comes when App is OPEn


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    if([userInfo valueForKey:@"event_url"]!= NULL && [userInfo valueForKey:@"event_title"]!= NULL )
    {
        
        UIAlertController *_alert = [UIAlertController alertControllerWithTitle:[userInfo valueForKey:@"event_title"]
                                                                        message:@""
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Open"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             NSURL *url = [NSURL URLWithString:[userInfo valueForKey:@"event_url"]];
//                                                             if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                                                 Notification_Event *obj = [[Notification_Event alloc]initWithNibName:@"Notification_Event" bundle:nil];
                                                             NSRange range = [[userInfo valueForKey:@"event_url"] rangeOfString:@"?"];
                                                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                             
                                                             //NSString * val = [defaults valueForKey:@"user_id"];
                                                             NSString * val = [self.global_userInfo valueForKey:DATABASE_TOKEN];
                                                             //NSString * val = [defaults valueForKey:@"user_id"];
                                                             if (range.location != NSNotFound)
                                                             {
                                                                obj.url = [[NSString alloc]initWithFormat:@"%@&token=%@",[userInfo valueForKey:@"event_url"],val];
                                                             }
                                                             else
                                                             {
                                                                obj.url = [[NSString alloc]initWithFormat:@"%@?token=%@",[userInfo valueForKey:@"event_url"],val];
                                                             }
                                                             
                                                             
                                                             
                                                                 obj.title = [userInfo valueForKey:@"event_title"];
                                                             
                                                                 [navigation pushViewController:obj animated:TRUE];
                                                                 
                                                                 
                                                          //   }
                                                         }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                       }];
        [_alert addAction:okAction];
        [_alert addAction:cancel];
        
        [navigation presentViewController:_alert animated:YES completion:nil];
        
    }
    
    
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}





// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    
    if([userInfo valueForKey:@"event_url"]!= NULL && [userInfo valueForKey:@"event_title"]!= NULL )
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(alert != NULL)
                [alert dismissViewControllerAnimated:YES completion:nil];
        });
        Notification_Event *obj = [[Notification_Event alloc]initWithNibName:@"Notification_Event" bundle:nil];
        NSRange range = [[userInfo valueForKey:@"event_url"] rangeOfString:@"?"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        //NSString * val = [defaults valueForKey:@"user_id"];
        NSString * val = [self.global_userInfo valueForKey:DATABASE_TOKEN];
        if (range.location != NSNotFound)
        {
            obj.url = [[NSString alloc]initWithFormat:@"%@&token=%@",[userInfo valueForKey:@"event_url"],val];
        }
        else
        {
            obj.url = [[NSString alloc]initWithFormat:@"%@?token=%@",[userInfo valueForKey:@"event_url"],val];
        }
        obj.title = [userInfo valueForKey:@"event_title"];
        
        [navigation presentViewController:obj animated:TRUE completion:^{
            
        }];
    }
    
    completionHandler();
}

// [END ios_10_message_handling]

// [START refresh_token]
//- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
//    NSLog(@"FCM registration token: %@", fcmToken);
//    self.notification_token_id = fcmToken;
//    // Notify about received token.
//    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:
//     @"FCMToken" object:nil userInfo:dataDict];
//    // TODO: If necessary send token to application server.
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
//- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    NSLog(@"Received data message: %@", remoteMessage.appData);
//}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}










- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString * deviceTokenString = [[[[deviceToken description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@",deviceTokenString);
    
}




//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + [[[userInfo objectForKey:@"aps"] objectForKey: @"badge"] intValue];
//
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    pauseTime = [self getCurrentTime];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    self.global_userInfo = [self.engineObj getUserInfo];
    if(self.global_userInfo != NULL)
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSArray *visitedArr = [defaults valueForKey:@"visitedData"];
        NSMutableArray * _visitedArr = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in visitedArr) {
            NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
            [_Obj setValue:[obj valueForKey:@"user_id"] forKey:@"user_id"];
            
            
            
            [_Obj setValue:[obj valueForKey:@"date"] forKey:@"date"];
            
            [_Obj setValue:[obj valueForKey:@"date_with_time"] forKey:@"date_with_time"];
            [_Obj setValue:@"lerner" forKey:@"role"];
            
            [_visitedArr addObject:_Obj];
        }
        NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
        [_Obj setValue:[defaults valueForKey:@"user_id"] forKey:@"user_id"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-M-d";
        NSString *string = [formatter stringFromDate:[NSDate date]];
        
        [_Obj setValue:string forKey:@"date"];
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *string1 = [formatter1 stringFromDate:[NSDate date]];
        [_Obj setValue:string1 forKey:@"date_with_time"];
        [_Obj setValue:@"lerner" forKey:@"role"];
        [_visitedArr addObject:_Obj];
        [defaults setObject:_visitedArr  forKey:@"visitedData"];
        
        [defaults synchronize];
     }
   [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
}

-(void)gotoNextController:(UIViewController *)CurrentController controllerType :(controllerType)Ctype sendingObj :(NSMutableDictionary *)obj
{
    
    
    //
    
    
    if(enum_minController < Ctype && Ctype < enum_maxController)
    {
        switch (Ctype) {
           
//            case (enum_homeController) :
//
//                [self goHomeScreen:CurrentController];
//                break;
                
            case (enum_languageController) :
                [self goToLanguage:CurrentController];
                break;
                
            case (enum_courseCodeController) :
                [self goToCourseCode:CurrentController :obj];
                break;
                
            case (enum_dashboardController) :
                [self goToDashBoard:CurrentController];
                break;
                
            case (enum_graphDashboardController) :
               // [self goToDashBoardGraph:CurrentController];
                break;
                
            case (enum_catelogControoler) :
                [self goToModule:CurrentController];
                break;
            case (enum_aboutController) :
                [self goAboutScreen:CurrentController];
                break;
            case (enum_mcqAssessmentController) :
                
                break;
                
            case (enum_scenarioController) :
                
                break;
            case (enum_scnPracInsController) :
                
                break;
            case (enum_scnPracController) :
                
                break;
            case (enum_vocablistController) :
                
                break;
            case (enum_vocabController) :
                
                break;
            case (enum_conceptController) :
                
                break;
                
            case (enum_actvityController) :
                
                break;
                
                
                
                
            default:
                break;
        }
    }
}





-(void)goToLanguage :(UIViewController *) controller
{
    
    self.baseObj = controller;
    ChooseLanguage *clController;
    
    [Logger logAduro:@"AppDelegate : Enter Function goto Choose Language."];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        //its iPhone. Find out which one?
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            clController  = [[ChooseLanguage alloc]initWithNibName:@"Language-4" bundle:nil];
            
        }
        else if(result.height == 568)
        {
            clController  = [[ChooseLanguage alloc]initWithNibName:@"Language-5" bundle:nil];
            
        }
        else if(result.height == 667)
        {
            clController  = [[ChooseLanguage alloc]initWithNibName:@"Language-6" bundle:nil];
            
        }
        else if(result.height == 736)
        {
            clController  = [[ChooseLanguage alloc]initWithNibName:@"Language-6p" bundle:nil];
            
        }
    }
    else
    {
        
        clController  = [[ChooseLanguage alloc]initWithNibName:@"ChooseLanguage" bundle:nil];
        
        
    }
    if(controller != NULL)
    {
        [Logger logAduro:@"AppDelegate : exit Function goto Choose Language.." ];
        [controller.navigationController pushViewController:clController animated:YES];
        // [controller presentViewController:clController animated:YES completion:NULL];
    }
    
    
}

-(void)goAboutScreen:(UIViewController *) controller
{
    self.baseObj = controller;
    aboutUS *aboutController;
    [Logger logAduro:@"AppDelegate : Enter Function aboutUS." ];
    
    
    aboutController  = [[aboutUS alloc]initWithNibName:@"aboutUS" bundle:nil];
    [Logger logAduro:@"AppDelegate : exit Function aboutUS." ];
    [controller.navigationController pushViewController:aboutController animated:YES];
    
}




-(void)goToDashBoard :(UIViewController *) controller
{
    self.baseObj = controller;
    Dashboard *dashbrd;
    [Logger logAduro:@"AppDelegate : Enter Function goToDashBoard." ];
    dashbrd  = [[Dashboard alloc]initWithNibName:@"Dashboard-iPad" bundle:nil];
    if(controller != NULL)
    {
        [Logger logAduro:@"AppDelegate : exit Function goToDashBoard." ];
        [controller.navigationController pushViewController:dashbrd animated:YES];
        
    }
}

-(void)goToModule :(UIViewController *) controller
{
    self.baseObj = controller;
    Catlog *catelog;
    catelog  = [[Catlog alloc]initWithNibName:@"Catlog" bundle:nil];
    if(controller != NULL)
    {
        [Logger logAduro:@"AppDelegate : exit Function goToModule." ];
        [controller.navigationController pushViewController:catelog animated:YES];
        //[controller presentViewController:catelog animated:YES completion:NULL];
    }
}



-(void)goScenarioPractice:(UIViewController *)controller :(int )scnPracticeUid : (int ) scnUid :(int ) scnType :(int ) scnPracticeType TitleName:(NSString *)titleName :(NSString *) level :(NSString *) topicname
{
    
    self.baseObj = controller;
    [Logger logAduro:@"AppDelegate : Enter Function goScenarioPractice." ];
    ScnarioPracticeInstruction *scnPracObj;
    scnPracObj  = [[ScnarioPracticeInstruction alloc]initWithNibName:@"ScnarioPracticeInstruction" bundle:nil];
    if(scnPracObj != NULL)
    {
        scnPracObj.scnpracID = scnPracticeUid;
        scnPracObj.scnPracType = scnPracticeType;
        scnPracObj.scnType = scnType;
        scnPracObj.cusTitleName = titleName;
        
        scnPracObj.scnUid = scnUid;
        scnPracObj.selectedLevel = level;
        scnPracObj.topicName =topicname;
        [Logger logAduro:@"AppDelegate : Exit Function goScenarioPractice." ];
        
        [controller.navigationController pushViewController:scnPracObj animated:YES];
        
        // [controller presentViewController:scnPracObj animated:YES completion:NULL];
    }
    
}



-(void)gotoScnVideoAudioPractice:(UIViewController *)controller :(int )practiceUid :(int )ScnPracticeUid :(NSString * )practiceType :(int)scnUid :(int)scnType :(int) scnPracticeType :(int) recordingType :(NSString *) level :(NSString *) topicname
{
    self.baseObj = controller;
    ConceptAndScnpractice *ConceptScenario;
    ConceptScenario  = [[ConceptAndScnpractice alloc]initWithNibName:@"ConceptAndScnpractice-4" bundle:nil];
    if(ConceptScenario != NULL)
    {
        ConceptScenario.scnarioPracUid = ScnPracticeUid;
        ConceptScenario.practiceType = practiceType;
        ConceptScenario.scnUid = scnUid;
        ConceptScenario.scnPracType = scnPracticeType;
        ConceptScenario.scnType = scnType;
        ConceptScenario.practiceUid = practiceUid;
        ConceptScenario.recordingType = recordingType;
        ConceptScenario.selectedLevel = level;
        ConceptScenario.topicName =topicname;
        
        [Logger logAduro:@"AppDelegate : Exit Function gotoScnVideoAudioPractice." ];
        [controller.navigationController pushViewController:ConceptScenario animated:YES];
        // [controller presentViewController:ConceptScenario animated:YES completion:NULL];
    }
    
}


-(void)goToCourseCode:(UIViewController *)controller :(NSDictionary *)obj

{
    self.baseObj = controller;
    CourseScreen * courseCode  = [[CourseScreen alloc]initWithNibName:@"CourseScreen" bundle:nil];
    courseCode._title = [obj valueForKey:@"Title"];
    courseCode.key = [obj valueForKey:@"licence"];
    courseCode.selectedLevel = [obj valueForKey:@"level"];
    [controller.navigationController pushViewController:courseCode animated:YES];
    
    
}


-(NSString *)getCurrentTime
{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]];
}

-(NSString *)getCurrentTimeWithResumeTime:(long long)value
{
    NSDate *date = [NSDate date];
    
    long long data = [@(floor([date timeIntervalSince1970] * 1000)) longLongValue] - value;
    return [NSString stringWithFormat: @"%lld",data];
}

- (void)renameFileWithName:(NSString *)filePathSrc toName:(NSString *)filePathDst
{
    filePathSrc = [filePathSrc stringByReplacingOccurrencesOfString:@" " withString:@""];
    filePathDst = [filePathDst stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager moveItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"There is an Error: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", filePathSrc);
    }
}
-(void )setLanguage:(NSString *)lang
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Lang.plist"];
    
    if ([fileManager fileExistsAtPath:path] == NO) {
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource: @"Lang" ofType: @"plist"];
        
        [fileManager copyItemAtPath:filepath  toPath:path error:&error];
        if(error != nil) {
            
        }
    }
    if(path)
    {
        NSMutableDictionary *plist = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        [plist setObject:lang forKey:@"lang"];
        [plist writeToFile:path atomically:YES];
    }
    
}

-(NSString *)getLanguage
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Lang.plist"];
    
    if ([fileManager fileExistsAtPath:path] == NO) {
        
        NSString *filepath = [[NSBundle mainBundle] pathForResource: @"Lang" ofType: @"plist"];
        
        [fileManager copyItemAtPath:filepath  toPath:path error:&error];
        if(error != nil)
        {
            
        }
    }
    
    
    
    NSMutableDictionary *dictplist =[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSString *returnVal = [dictplist valueForKey:@"lang"] ;
    //NSLog(@"%@",dictplist);
    
    return returnVal;
    
}

-(NSString *)getGoogleLanguage
{
    if([[self getLanguage]isEqualToString:@"en"])
    {
        return @"ENGLISH";
    }
    else if([[self getLanguage]isEqualToString:@"hi"])
    {
        return @"HINDI";
    }
    else if([[self getLanguage]isEqualToString:@"kn"])
    {
        return @"KANNADA";
    }
    else if([[self getLanguage]isEqualToString:@"ml"])
    {
        return @"MALAYALAM";
    }
    else if([[self getLanguage]isEqualToString:@"ta"])
    {
        return @"TAMIL";
    }
    else if([[self getLanguage]isEqualToString:@"te"])
    {
        return @"TELUGU";
    }
    else if([[self getLanguage]isEqualToString:@"bn"])
    {
        return @"BENGALI";
    }
    return @"ENGLISH";
    
}

- (void) moviePlayerWillEnterFullscreenNotification:(NSNotification*)notification {
    self.allowRotation = YES;
}
- (void) moviePlayerWillExitFullscreenNotification:(NSNotification*)notification {
    self.allowRotation = NO;
    self.initPlayer = TRUE;
    
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    else if (self.rotationFlag)
    {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}


-(BOOL)isNetworkAvailable
{
    return [self.engineObj.networkObj isNetworkAvailbale];
}

-(BOOL) checkZipPath:(NSString *)fileName :(NSString *)course_code
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:course_code];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:fileName];
    dataPath1=[dataPath1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:dataPath1] ;
}


-(BOOL) checkZipPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:self.courseCode];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:fileName];
    dataPath1=[dataPath1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:dataPath1] ;
}


-(NSString *)getFirstName
{
     NSString * firstName = @"Anonymous";
     if(self.global_userInfo != NULL){
        NSString *trimmed = [[self.global_userInfo valueForKey:DATABASE_USERNAME] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray * arr = [trimmed componentsSeparatedByString:@" "];
        NSLog(@"Array values are : %@",arr);
        if(arr != NULL && [arr count] >0)
        {
            firstName = [arr objectAtIndex:0];
        }
        else
        {
            firstName = trimmed;
        }
    }
     return firstName;
        
   
}
-(void)setUserDefaultData:(id)value:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(id)getUserDefaultData:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

-(void)deleteUserDefaultData:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+(void)setUserDefaultData:(id)value:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)getUserDefaultData:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void)deleteUserDefaultData:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)setTextHTMLLabel :(UILabel *)lbl :(NSString*)strData
{
   NSString* newString = [strData stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
    NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
    NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
    NSString* newString8 = [newString7 stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    lbl.text  = newString8;
}
-(void)setTextHTMLTextView :(UITextView *)lbl :(NSString*)strData
{
    NSString* newString = [strData stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
    NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
    NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
    NSString* newString8 = [newString7 stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    lbl.text  = newString8;
}

-(BOOL)isCheckNULLNIlniladnJSONNULL :(id)obj
{
    if(obj == NULL || obj == Nil || obj == nil || [obj isEqual:[NSNull null]])
        return TRUE;
    else
        return FALSE;
        
    
}
-(BOOL)isResourceAvailable:(NSString *)file_path
{
    NSString * phoneDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path =[phoneDocumentDirectory stringByAppendingPathComponent:file_path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return TRUE;
    else return FALSE;
}

- (RCTBridge *)initializeReactNativeApp:(UIViewController *)controller
{
#if defined(FB_SONARKIT_ENABLED) && __has_include(<FlipperKit/FlipperClient.h>)
  InitializeFlipper(application);
#endif
    
    self.moduleRegistryAdapter = [[UMModuleRegistryAdapter alloc] initWithModuleRegistryProvider:[[UMModuleRegistryProvider alloc] init]];
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:self.launchOptions];
  return bridge;
 }


- (RCTBridge *)initializeReactNativeApp
{
#if defined(FB_SONARKIT_ENABLED) && __has_include(<FlipperKit/FlipperClient.h>)
  InitializeFlipper(application);
#endif

    self.moduleRegistryAdapter = [[UMModuleRegistryAdapter alloc] initWithModuleRegistryProvider:[[UMModuleRegistryProvider alloc] init]];
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:self.launchOptions];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"main" initialProperties:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

  return bridge;
 }


- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge
{
  NSArray<id<RCTBridgeModule>> *extraModules = [_moduleRegistryAdapter extraModulesForBridge:bridge];
  // If you'd like to export some custom RCTBridgeModules that are not Expo modules, add them here!
  return extraModules;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge {
 #ifdef DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
 #else
    return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];;
 #endif
}

- (void)appController:(EXUpdatesAppController *)appController didStartWithSuccess:(BOOL)success {
  appController.bridge = [self initializeReactNativeApp];
  EXSplashScreenService *splashScreenService = (EXSplashScreenService *)[UMModuleRegistryProvider getSingletonModuleForClass:[EXSplashScreenService class]];
  [splashScreenService showSplashScreenFor:self.window.rootViewController];
}

// Linking API
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  return [RCTLinkingManager application:application openURL:url options:options];
}

// Universal Links
- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
 return [RCTLinkingManager application:application
                  continueUserActivity:userActivity
                    restorationHandler:restorationHandler];
}



@end


