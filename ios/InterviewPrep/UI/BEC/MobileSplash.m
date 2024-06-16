//
//  MobileSplash.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MobileSplash.h"
#import "mobileScreen.h"
#import "MobileDashboard.h"
#import "WileyDashboard.h"
#import "Old_Home.h"
#import <AVFoundation/AVFoundation.h>





@interface MobileSplash ()
{
    UIView * bar;
    UIImageView * spalshImag;
    NSTimer * timer;
    UIActivityIndicatorView *  activityIndicator;
    
}

@end

@implementation MobileSplash

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:SPLASHCOLOR alpha:1.0];
//    [self.view addSubview:bar];
    //[self.navigationController preferredStatusBarStyle:UIStatusBarStyleDefault];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    spalshImag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    spalshImag.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    spalshImag.contentMode = UIViewContentModeScaleAspectFill;
    spalshImag.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    spalshImag.image = [UIImage imageNamed:SPLASHSCREEN];
    [self.view addSubview:spalshImag];
//    int* p = 0;
//    *p = 0;
//    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readSplash:)
                                                 name:SERVICE_GETFORCEUPDATE
                                               object:nil];
    
    
    [self showGlobalSplashProgress];
    
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_APPUPDATE forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETFORCEUPDATE forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    

}

- (void)readSplash:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalSplashProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETFORCEUPDATE])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL   )
            {
                
                
                if([[temp valueForKey:@"force_update"]isEqualToString:@"yes"])
               {
                 [self openAppUpdate:TRUE];
               }
               else if([[temp valueForKey:@"force_update"]isEqualToString:@"no"])
               {
                 [self openAppUpdate:FALSE];
               }
               else
               {
                   timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                            target:self
                                                          selector:@selector(goToLoginScreen)
                                                          userInfo:nil
                                                           repeats:NO];
               }
                
              
            }
            else
            {
                timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                         target:self
                                                       selector:@selector(goToLoginScreen)
                                                       userInfo:nil
                                                        repeats:NO];
            }
        }
        else
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                     target:self
                                                   selector:@selector(goToLoginScreen)
                                                   userInfo:nil
                                                    repeats:NO];
        }
        
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)openAppUpdate:(BOOL)isForceUpdate
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if(data != NULL){
        NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if ([lookup[@"resultCount"] integerValue] == 1){
            NSString* appStoreVersion = lookup[@"results"][0][@"version"];
            appDelegate.APPSTOREURLSHARE = lookup[@"results"][0][@"trackViewUrl"];
            //self.appName = lookup[@"results"][0][@"trackName"];
            NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
            if([appStoreVersion floatValue] > [currentVersion floatValue]){
                //if (![appStoreVersion isEqualToString:currentVersion]){
                NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:appDelegate.appName
                                                                                         message:@"An update is available for the App."
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Update"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {
                                                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[appDelegate.APPSTOREURLSHARE stringByTrimmingCharactersInSet:
                                                                                                                                      [NSCharacterSet whitespaceAndNewlineCharacterSet]]]];
                                                                 }]; //You can use a block here to handle a press on this button
                [alertController addAction:actionOk];
                if(!isForceUpdate){
                   UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Skip"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                       timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                                target:self
                                                              selector:@selector(goToLoginScreen)
                                                              userInfo:nil
                                                               repeats:NO];
                   }];
                
                    [alertController addAction:cancel];
                  }
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                         target:self
                                                       selector:@selector(goToLoginScreen)
                                                       userInfo:nil
                                                        repeats:NO];
            }
        }
        else
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                     target:self
                                                   selector:@selector(goToLoginScreen)
                                                   userInfo:nil
                                                    repeats:NO];
        }
    }
    else
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                                 target:self
                                               selector:@selector(goToLoginScreen)
                                               userInfo:nil
                                                repeats:NO];
    }
}






-(void)goToLoginScreen
{
    [timer invalidate];
    timer = NULL;
    //[[Crashlytics sharedInstance] crash];
//    @[][1];
//          int* p = 0;
//          *p = 0;
    if([CLASS_NAME isEqualToString:@"englishEdge"] ||[CLASS_NAME isEqualToString:@"wileynxt"] || [CLASS_NAME isEqualToString:@"quizky"] || [CLASS_NAME isEqualToString:@"kannanprep"])
    {
        NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
        [dicObj setValue:@"" forKey:@"licence"];
        [dicObj setValue:[appDelegate.langObj get:@"CLP_TITLE" alter:@"My Courses"] forKey:@"Title"];
        [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
    }
    else
    {
        
        if(appDelegate.global_userInfo != NULL)
        {
            if([CLASS_NAME  isEqualToString:@"BEC"]){
                
                MobileDashboard * becHome = [[MobileDashboard alloc]initWithNibName:@"MobileDashboard" bundle:nil];
                [self.navigationController pushViewController:becHome animated:YES];
            }
            else if([CLASS_NAME  isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"]|| [CLASS_NAME  isEqualToString:@"ace"]){
                //[[Crashlytics sharedInstance] crash];
                WileyDashboard * wileyHome = [[WileyDashboard alloc]initWithNibName:@"WileyDashboard" bundle:nil];
                [self.navigationController pushViewController:wileyHome animated:YES];
            }
            else
            {
                NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
                [dicObj setValue:@"" forKey:@"licence"];
                [dicObj setValue:[appDelegate.langObj get:@"CLP_TITLE" alter:@"My Courses"] forKey:@"Title"];
                [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
            }
        }
        else
        {
          if([CLASS_NAME isEqualToString:@"cuponline"] || [CLASS_NAME isEqualToString:@"cam_capable"])
          {
              Old_Home * homeObj = [[Old_Home alloc]initWithNibName:@"Old_Home" bundle:nil];
              [self.navigationController pushViewController:homeObj animated:TRUE];
          }
          else
          {
              mobileScreen * mobileloginObj = [[mobileScreen alloc]initWithNibName:@"mobileScreen" bundle:nil];
              [self.navigationController pushViewController:mobileloginObj animated:TRUE];
          }
        }
        
        
    }
    
}







/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
