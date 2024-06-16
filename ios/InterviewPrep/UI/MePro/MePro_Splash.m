//
//  MePro_Splash.m
//  InterviewPrep
//
//  Created by Uday Kranti on 24/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Splash.h"
#import "mobileScreen.h"
#import "MeProWelcome.h"
#import "MeProCEFRTestScore.h"
#import "MeProDashboard.h"
#import "MeProCEFRTest.h"
#import "MePro_Products.h"
#import "MeProAcadmic_Module.h"
#import <AVFoundation/AVFoundation.h>

@interface MePro_Splash ()
{
    UIView * bar;
    UIImageView * spalshImag;
    NSTimer * timer;
    UIActivityIndicatorView *  activityIndicator;
    
}

@end

@implementation MePro_Splash

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:SPLASHCOLOR alpha:1.0];
    [self.view addSubview:bar];
    //[self.navigationController preferredStatusBarStyle:UIStatusBarStyleDefault];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    spalshImag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    spalshImag.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    spalshImag.contentMode = UIViewContentModeScaleAspectFill;
    spalshImag.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    spalshImag.image = [UIImage imageNamed:SPLASHSCREEN];
    [self.view addSubview:spalshImag];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readSplashResponse:)
                                                 name:SERVICE_UPDATETOKEN_LOCAL
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readSplashResponse:)
                                                 name:SERVICE_LTISCORE
                                               object:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                             target:self
                                           selector:@selector(goToLoginScreen)
                                           userInfo:nil
                                            repeats:NO];
    
    
}

- (void)readSplashResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalSplashProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_UPDATETOKEN_LOCAL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    [self updateUserTokenAndMode:resUserData];
                    
                    [self showGlobalSplashProgress];
                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
                    [reqObj setValue:JSON_LTISCORE forKey:JSON_DECREE ];
                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                    [_reqObj setValue:SERVICE_LTISCORE forKey:@"SERVICE"];
                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                    
                    
                }
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LTISCORE])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSMutableDictionary * userData= [[NSMutableDictionary alloc] init];
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && ![NSNull isEqual:[resUserData valueForKey:@"imsx_messageIdentifier"]] && [[resUserData valueForKey:@"imsx_messageIdentifier"]intValue] > 0 )
                {
                    [self setUserLTIScore:resUserData];
                
                    MeProDashboard * meProDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
                    [self.navigationController pushViewController:meProDashObj animated:YES];
                    
                    //                    CEFRTest * ltiTest = [[CEFRTest alloc]initWithNibName:@"CEFRTest" bundle:nil];
                    //                    [self.navigationController pushViewController:ltiTest animated:YES];
                    
                    
                    
                }
                else
                {
                    
                    MeProWelcome * meprowelObj = [[MeProWelcome alloc]initWithNibName:@"MeProWelcome" bundle:nil];
                    [self.navigationController pushViewController:meprowelObj animated:YES];
                    
                }
            }
            else if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:LOGINFAILEDJSON])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@""
                                                 message:[resUserData valueForKey:@"msg"]
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                    
                    int duration = 2; // duration in seconds
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                    });
                    return;
                }
            }
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == 5)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"The network connection was lost."
                                         message:[[notification object]valueForKey:@"SERVICE"]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }
    });
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_LTISCORE object:nil];
    [center removeObserver:self name:SERVICE_UPDATETOKEN_LOCAL object:nil];
    
}




-(void)updateToken
{
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:[appDelegate.global_userInfo valueForKey:DATABASE_LOGIN] forKey:JSON_LOGIN];
    [data setValue:[appDelegate.global_userInfo valueForKey:DATABASE_PASSWORD] forKey:JSON_PASSWORD];
    [data setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    
    [data setObject:APPVERSION forKey:JSON_APPVERSION];
    [data setObject:@"iOS" forKey:JSON_PLATFORM];
    [data setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [data setObject:CLIENT forKey:JSON_CLIENT];
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:JSON_NULL forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_REFRESHTOKEN forKey:JSON_DECREE ];
    [reqObj setValue:data forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_UPDATETOKEN_LOCAL forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}
-(void)goToLoginScreen
{
    [timer invalidate];
    timer = NULL;
    
    if(appDelegate.global_userInfo != NULL)
    {
        
       
        NSDictionary * localProductBookmark = (NSDictionary *) [NSKeyedUnarchiver unarchiveObjectWithData:[appDelegate getUserDefaultData:@"product_bookmark"]];
        
        appDelegate.isEnableLTITest = [[localProductBookmark valueForKey:@"is_show_lti"]boolValue];
        appDelegate.isShowDashboard = [[localProductBookmark valueForKey:@"is_show_dashboard"]boolValue];
        
        if(localProductBookmark != NULL && appDelegate.isEnableLTITest)
        {
            appDelegate.product_id = [localProductBookmark valueForKey:@"product_id"];
            appDelegate.product_name = [localProductBookmark valueForKey:@"product_name"];
            appDelegate.coursePack = [localProductBookmark valueForKey:@"package_code"];
            
            
            
            if(appDelegate.lti_Test_Score  == -1){
                
                [self showGlobalSplashProgress];
                [self updateToken];
            }
            else
            {
                MeProDashboard * meProDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
                [self.navigationController pushViewController:meProDashObj animated:YES];
            }
        }
        else if(localProductBookmark != NULL && appDelegate.isShowDashboard)
        {
            appDelegate.product_id = [localProductBookmark valueForKey:@"product_id"];
            appDelegate.coursePack = [localProductBookmark valueForKey:@"package_code"];
            appDelegate.product_name = [localProductBookmark valueForKey:@"product_name"];
            
            MeProDashboard * meProDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
            [self.navigationController pushViewController:meProDashObj animated:YES];
        }
        else if(localProductBookmark != NULL && !appDelegate.isShowDashboard)
        {
            appDelegate.product_id = [localProductBookmark valueForKey:@"product_id"];
            appDelegate.coursePack = [localProductBookmark valueForKey:@"package_code"];
            appDelegate.product_name = [localProductBookmark valueForKey:@"product_name"];
            MeProAcadmic_Module * dashObj = [[MeProAcadmic_Module alloc]initWithNibName:@"MeProAcadmic_Module" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
            
            
        }
        else
        {
            
            MePro_Products * productObj = [[MePro_Products alloc]initWithNibName:@"MePro_Products" bundle:nil];
            [self.navigationController pushViewController:productObj animated:YES];
        }
            
        
    }
    else
    {
        mobileScreen * mobileloginObj = [[mobileScreen alloc]initWithNibName:@"mobileScreen" bundle:nil];
        [self.navigationController pushViewController:mobileloginObj animated:TRUE];
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
