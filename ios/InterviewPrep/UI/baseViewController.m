//
//  baseViewController.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 13/04/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import "baseViewController.h"
#import "Dashboard.h"
#import "Catlog.h"
#import "CourseScreen.h"
#import "SSZipArchive.h"
#import "MyAccountScreen.h"
#import "FAQ.h"
#import "FeedbackViewController.h"
#import "MeProCEFRTestScore.h"

#import "MobileSplash.h"
#import "PDFViewer.h"
#import "MeProActivity.h"

#import "MeProAcadmic_Module.h"

#import "MeProDashboard.h"
#import "MeProModules.h"
#import "MePro_Products.h"

#import "MeProMyPerformance.h"
#import "WileyDashboard.h"

#import "ZoomGuide.h"
#import "WileyClassSlides.h"
#import "AssignmentListViewController.h"
#import "UserGraphPerformance.h"
#import "UserGraphPerformance_ChapterWise.h"
#import "aceInterviewVideo.h"


#import "PTEG_Preferences.h"
#import "PTEG_UserProfile.h"
#import "PTEG_LevelSelection.h"
#import "PTEG_AboutTest.h"
#import "PTEG_OpenUrlWeb.h"
#import "PTEG_FAQ.h"
#import "PTEG_AboutUs.h"
#import "PTEG_HelpDesk.h"
#import "PTEG_Dashboard.h"
#import "PTEG_MyPerformance.h"
#import "PTEG_ChatWithPalVC.h"
#import "PTEG_AboutProgram.h"
#import "MePro_Feedback.h"
#import "Vocab_Session.h"









@interface baseViewController ()<SSZipArchiveDelegate>
{
    UIAlertController *blockAlert;
    UIProgressView *pView;
    UILabel * Percentagelbl;
    UIButton * canbtn;
    UIAlertController * canDownloadUpdateBtn;
    UIView * slidingWindow;
    UIScrollView * sliderScroll;
    UIView * homeView;
    BOOL isShow;
    
    
    

    
}
@end
@implementation baseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.navigationController.navigationBarHidden = YES;
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    
    unsigned int hexint = [self intFromHexString:hexStr];
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
}


- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!appDelegate.isServiceRunning)
       [self b_getClentStatus];
    
    
    if(!appDelegate.isServiceRunning)
    {
        
        if(appDelegate.global_userInfo  != NULL)
        {
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                    selector:@selector(readBaseNetworkResponse:)
                                                        name:B_SERVICE_SYNCTRACK
            
                                                      object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:SERVICE_GETUSERCOINLIST
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_UPDATETOKEN
             
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_UPDATEVERSION
             
                                                       object:nil];
            
            
            
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_SYNCUSERIMAGE
             
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_SYNCAUDIOVIDEO
             
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_GETCLIENTSTATUS
             
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(readBaseNetworkResponse:)
                                                         name:B_SERVICE_SYNCCCTRACK
             
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                    selector:@selector(readBaseNetworkResponse:)
                                                        name:B_SERVICE_SYNCVISITEDUSER
            
                                                      object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                    selector:@selector(readBaseNetworkResponse:)
                                                        name:B_SERVICE_ONEWAYSYNCCCTRACK
            
                                                      object:nil];
            
            
            
            
            
            
            
            
            
            
            
            appDelegate.isServiceRunning = TRUE;
            [self b_updateToken];
            [NSTimer scheduledTimerWithTimeInterval:600  // 5.0
                                             target:self
                                           selector:@selector(callService)
                                           userInfo:nil
                                            repeats:YES];
        }
        
        
        
    }
    
    if( [[appDelegate getUserDefaultData:@"isBlock"]isEqualToString:@"no"] ){
        
        blockAlert = [UIAlertController alertControllerWithTitle:@""
                                                         message:@"Your account is deactivated. Please contact your institute administrator."
                                                  preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:blockAlert animated:YES completion:nil];
    }
    
    
    
    
}

-(void)callService
{
    [self b_updateToken];
    [self b_getClentStatus];
    [self b_syncVisitedData];

    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    // [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}



//-(BOOL)updateCourse:(NSString *)course_code course_EdgeId:(NSString *) edgeId
//{
//    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        if([appDelegate.engineObj DeleteCourseCode:course_code deleteDirectory:NO])
//        {
//            
//            NSMutableDictionary * val = [appDelegate.engineObj checkCourseCodeDirctoryExistonServer:course_code licence_key:appDelegate.coursePack];
//            if ( [[val valueForKey:@"resStat"] intValue] == 1)
//            {
//                
//                appDelegate.courseCode = course_code;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [self showGlobalProgress];
//                    
//                });
//                
//                [appDelegate.engineObj setCourseCode:course_code];
//                [appDelegate.engineObj DownloadNewCourseCode:[val valueForKey:@"xmlData"]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    // [self hideGlobalProgress];
//                    [appDelegate.engineObj updateComponant:edgeId];
//                    
//                    
//                    [self.delegate refreshUI:self];
//                    
//                    
//                    
//                    
//                });
//            }
//            else if ( [[val valueForKey:@"resStat"] intValue] == 2)
//            {
//                
//                
//            }
//            else
//            {
//            
//            }
//            
//            
//            
//        }
//        
//    });
//    return TRUE;
//}

//-(void)b_syncLockedChapter
//{
//
//    if(appDelegate.global_userInfo!= NULL)
//    {
//        NSString * Arr = @"[\"CRS-1063\",\"CRS-1064\",\"CRS-1065\",\"CRS-1052\",\"CRS-1059\", \"CRS-1058\", \"CRS-1060\", \"CRS-1054\", \"CRS-1061\", \"CRS-1088\", \"CRS-808\",\"CRS-813\", \"CRS-814\", \"CRS-815\", \"CRS-816\", \"CRS-817\", \"CRS-818\", \"CRS-819\", \"CRS-820\", \"CRS-821\", \"CRS-822\", \"CRS-741\", \"CRS-738\", \"CRS-1042\", \"CRS-1041\", \"CRS-1043\", \"CRS-987\", \"CRS-1046\", \"CRS-1047\", \"CRS-1045\", \"CRS-1044\", \"CRS-1340\" ]";
//
//        NSData* data = [Arr dataUsingEncoding:NSUTF8StringEncoding];
//        NSArray *courseArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSMutableArray * cou_Arr = [[NSMutableArray alloc]init];
//        for (NSString *obj in courseArr) {
//            [cou_Arr addObject:obj ];
//        }
//        if(cou_Arr!= NULL && [cou_Arr count] >0)
//        {
//            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//            [reqObj setValue:JSON_UNLOCKCHAPLIST forKey:JSON_DECREE ];
//            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//            NSMutableDictionary * paramObj = [[NSMutableDictionary alloc]init];
//            [paramObj setValue:CLIENT forKey:@"client_name"];
//            [paramObj setValue:cou_Arr forKey:JSON_COURSECODE];
//            [reqObj setValue:paramObj forKey:JSON_PARAM ];
//
//            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//            [_reqObj setValue:B_SERVICE_UNLOCKEDCHAPTER forKey:@"SERVICE"];
//            [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
//            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//
//        }
//    }
//
//
//}

-(BOOL)baseClass_syncCompletionComponant :(NSArray * )arr
{
    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_SYNCCOMPONANTCOMPLETION forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:arr forKey:JSON_PARAM];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SYNCCCTRACK forKey:@"SERVICE"];
    [_reqObj setValue:NSStringFromClass([self class]) forKey:@"original_source"];
    [_reqObj setValue:syncTime forKey:@"syncTime"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    return TRUE;
    
}

-(BOOL)baseClass_syncCompletionComponantOneway :(NSArray * )arr
{
    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_SYNCCOMPONANTCOMPLETION forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:arr forKey:JSON_PARAM];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_ONEWAYSYNCCCTRACK forKey:@"SERVICE"];
    [_reqObj setValue:NSStringFromClass([self class]) forKey:@"original_source"];
    [_reqObj setValue:syncTime forKey:@"syncTime"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    return TRUE;
    
}



-(BOOL)b_uploadZipToAduroFromLocal
{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * str = [[NSString alloc]initWithFormat:@"records.zip"];
    NSString * str1 = [[NSString alloc]initWithFormat:@"records"];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:str1];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:str];
    if([SSZipArchive createZipFileAtPath:dataPath1 withContentsOfDirectory:dataPath])
    {
        NSLog(@"Successfully Created");
    }
    
    
    
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                 NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString * oldName = [[NSString alloc]initWithFormat:@"%@/%@.zip",documentDir,@"records"];
    
    
    NSMutableString * url = [[NSMutableString alloc]initWithFormat:ADURO_AUDIO_URL];
    
    //                       ];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:oldName];
    NSMutableDictionary * resData;
    if(data.length > 50)
        resData =[appDelegate.engineObj.networkObj sendRequestToPicUploadAduro:url data:data method:@"POST":[appDelegate.global_userInfo valueForKey:DATABASE_USERID]: [appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]:@"true":@"records.zip"];
    
    
    
    if(resData != NULL && [[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL success = [fileManager removeItemAtPath:oldName error:&error];
        if (success) {
            BOOL success = [fileManager removeItemAtPath:dataPath error:&error];
            
        }
        else
        {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
    }
    else
    {
        
        
    }
    
    
    
    return TRUE;
}




-(void)b_uploadImageToAduroFromLocal
{
    
    if(appDelegate.global_userInfo!= NULL)
    {
        int flag = [[appDelegate.global_userInfo valueForKey:DATABASE_ISIMAGECAPTURE] intValue];
        if(flag == 0)
        {
            return;
        }
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_UPLOADLOC forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        NSArray * arr = [[NSArray alloc]initWithObjects:@"0", nil];
        NSMutableDictionary * file_types = [[NSMutableDictionary alloc]init];
        [file_types setValue:arr forKey:@"file_types"];
        [reqObj setValue:file_types forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:B_SERVICE_SYNCUSERIMAGE forKey:@"SERVICE"];
        [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        
    }
    
    
    
    
    
}

-(void)b_getAssessMCQDataService
{
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_PUSHANSWER forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        
        [reqObj setValue:[appDelegate.engineObj.dataMngntObj getAssessMCQData] forKey:JSON_PARAM ];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:B_SERVICE_SYNCMCQ forKey:@"SERVICE"];
        [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    else
    {
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_PUSHANSWEROLD forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        
        [reqObj setValue:[appDelegate.engineObj.dataMngntObj getAssessMCQDataOld] forKey:JSON_PARAM ];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:B_SERVICE_SYNCMCQ forKey:@"SERVICE"];
        [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }
    
}

-(void)b_getAssessMCQDataServiceOld
{
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_PUSHANSWEROLD forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    [reqObj setValue:[appDelegate.engineObj.dataMngntObj getAssessMCQData] forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SYNCMCQ forKey:@"SERVICE"];
    [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}

-(void)b_syncCoinsData
{
    if(![UISTANDERD isEqualToString:@"PRODUCT2"] )
    {
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_COINSDECREE forKey:JSON_DECREE ];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:[appDelegate.engineObj.dataMngntObj getCoinsArr] forKey:JSON_PARAM];
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:B_SERVICE_SYNCCOINS forKey:@"SERVICE"];
        [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
       // [appDelegate.engineObj.dataMngntObj deleteCoinsData];
    }
    
    
    
}

-(void)baseClass_syncTrackBasedOnEdgeId :(NSString * )edgeId
{
    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_TRACK forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    NSArray * arr =  [appDelegate.engineObj.dataMngntObj getAllTrackDataBasedOnEdgeId:edgeId];
    [reqObj setValue:arr forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SYNCTRACK forKey:@"SERVICE"];
   // [_reqObj setValue:syncTime forKey:@"syncTime"];
    //[_reqObj setValue:[arr copy] forKey:@"dataArr"];
    [_reqObj setValue:NSStringFromClass([self class]) forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    [self baseClass_syncCompletionComponantOneway :[arr copy]];
}


-(void)baseClass_syncTracktable
{
    //NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_TRACK forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    NSArray * arr =  [appDelegate.engineObj.dataMngntObj getAllTrackData:0];
    [reqObj setValue:arr forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SYNCTRACK forKey:@"SERVICE"];
//    [_reqObj setValue:syncTime forKey:@"syncTime"];
//    [_reqObj setValue:[arr copy] forKey:@"dataArr"];
    [_reqObj setValue:NSStringFromClass([self class]) forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
    
    [self baseClass_syncCompletionComponant :[arr copy]];
    

}

-(void)b_getUpdateVersion
{
    
    
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_COURSEVERSION forKey:JSON_DECREE ];
    [reqObj setValue:[appDelegate.engineObj.dataMngntObj getCourseArr] forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_UPDATEVERSION forKey:@"SERVICE"];
    [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

-(void)b_updateToken
{
    //[self showGlobalProgress];
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
    [_reqObj setValue:B_SERVICE_UPDATETOKEN forKey:@"SERVICE"];
    [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    return ;
}
-(void)b_getClentStatus
{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:CLASS_NAME forKey:JSON_CALSS_NAME];
    
    
    [data setObject:APPVERSION forKey:JSON_APPVERSION];
    [data setObject:@"iOS" forKey:JSON_PLATFORM];
    [data setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [data setObject:CLIENT forKey:JSON_CLIENT];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_CLIENTSTATUS forKey:JSON_DECREE ];
    [reqObj setValue:data forKey:JSON_PARAM ];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_GETCLIENTSTATUS forKey:@"SERVICE"];
    [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    return ;
}

-(void)b_syncVisitedData
{

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *visitedArr = [defaults valueForKey:@"visitedData"];
    
    if(visitedArr!= NULL && [visitedArr count] >0)
    {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setValue:CLASS_NAME forKey:JSON_CALSS_NAME];
        [data setObject:APPVERSION forKey:JSON_APPVERSION];
        [data setObject:@"iOS" forKey:JSON_PLATFORM];
        [data setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [data setObject:CLIENT forKey:JSON_CLIENT];
        [data setValue:visitedArr forKey:@"visit_data"];
        [data setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    
    
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
        [reqObj setValue:JSON_VISITED_LIST forKey:JSON_DECREE ];
        [reqObj setValue:data forKey:JSON_PARAM ];
    
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:B_SERVICE_SYNCVISITEDUSER forKey:@"SERVICE"];
        [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
     }
    
    return ;
}



-(void)boadcastCoinsMessage:(NSNotification *) notification
{
    if(ISENABLECOINSUI)
    {
        NSArray * arr = (NSArray *)[notification object];
            if(arr != NULL && [arr count] > 0 && self.coinView != NULL ){
                int total_coins = [[[arr objectAtIndex:0]valueForKey:DATABASE_COINSUSER_TOTALCOINS] intValue];
                int earn_coins = [[[arr objectAtIndex:0]valueForKey:DATABASE_COINSUSER_EARNEDCOINS] intValue];
                if(earn_coins > total_coins)
                {
                  [self.coinView increaseCoinsCounterNumber:total_coins totalCoins:total_coins];
                }
                else
                {
                    [self.coinView increaseCoinsCounterNumber:earn_coins totalCoins:total_coins];
                }
            }
            else
            {
                
            }
    }
  
}

-(void)readBaseNetworkResponse:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_UPDATETOKEN])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    [self updateUserTokenAndMode:resUserData];
                    [appDelegate.engineObj.dataMngntObj updateCoursePack:[resUserData valueForKey:@"packageInfo"]];
                    [self b_uploadImageToAduroFromLocal];
                    [self b_getUpdateVersion];
                    
                }
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCMCQ])
        {
            
            //&& ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]] &&  [[[temp valueForKey:@"retVal"] valueForKey:NETWORKSTATUS]isEqualToString:SUCCESSJOSN]  && [[temp valueForKey:@"retVal"] valueForKey:@"tracking"] != NULL && [[temp valueForKey:@"retVal"] valueForKey:@"tracking"] != [NSNull null]
            
            
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] )
            {
                [appDelegate.engineObj.dataMngntObj deleteTestData];
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_UPDATEVERSION])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSArray * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && resUserData != (id)[NSNull null] && [resUserData count] >0  )
                {
                    [appDelegate.engineObj.dataMngntObj updateAllComponant:resUserData];
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETUSERCOINLIST])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
            {
                NSDictionary  * dataObj  = [temp valueForKey:JSON_RETVAL];
                if(dataObj != NULL && dataObj != (id)[NSNull null])
                {
                    [appDelegate.engineObj.dataMngntObj updateUserCoins:dataObj];

                }
            }
            
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCTRACK])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]] &&  [[[temp valueForKey:@"retVal"] valueForKey:NETWORKSTATUS]isEqualToString:SUCCESSJOSN])
            {
               // [appDelegate.engineObj.dataMngntObj setTrackSyncTime:[[notification object] valueForKey:@"syncTime"]];
                
            }
            //[self baseClass_syncCompletionComponant :[[notification object] valueForKey:@"dataArr"]];
        }
        else if( [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCTRACK])
        {
           // [self reloadUIData];
            //[self baseClass_syncCompletionComponant :[[notification object] valueForKey:@"dataArr"]];
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCCCTRACK])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
            {
               
                //[appDelegate.engineObj.dataMngntObj deleteAllTrackingData];
                NSArray * trackArr = [temp valueForKey:@"retVal"];
                if(trackArr != NULL && trackArr != (id)[NSNull null] &&  [trackArr count] > 0){
                    //NSMutableArray * arr = [[NSMutableArray alloc]init];
                    for (NSDictionary * obj in trackArr) {
                        NSMutableDictionary * data = [[NSMutableDictionary alloc]init];
                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_MODULEID];
                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_SCNID];
                        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
                        
                        NSString * value = @"-1";
                        if([[obj valueForKey:@"completion"] isEqualToString:@"c"]){
                            value = @"1";
                        }
                        else if([[obj valueForKey:@"completion"] isEqualToString:@"nc"])
                        {
                            value = @"0";
                        }
                        else if([[obj valueForKey:@"completion"] isEqualToString:@"na"])
                        {
                            value = @"-1";
                        }
                        else
                        {
                            value = @"-1";
                        }
                        
                        [data setValue:value forKey:NATIVE_JSON_KEY_ISCOMP];
                        [data setValue:@"0" forKey:NATIVE_JSON_KEY_ENDTIME];
                        [data setValue:[obj valueForKey:@"edge_id"] forKey:NATIVE_JSON_KEY_EDGEID];
                        [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_TYPE];
                        [data setValue:@"0" forKey:NATIVE_JSON_KEY_STARTTIME];
                        [data setValue:[obj valueForKey:@"course_code"] forKey:NATIVE_JSON_KEY_COURSECODE];
                        [data setValue:[obj valueForKey:@"package_code"] forKey:NATIVE_JSON_KEY_COURSEPACK];
                        [appDelegate.engineObj.dataMngntObj setTracktableData:data];
                        //[arr addObject:data];
                    }
                    
                    [self reloadUIData];
                    //[appDelegate.engineObj.dataMngntObj setTracktableDataArr:arr];
                    
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_ONEWAYSYNCCCTRACK])
        {
            
        }
        
        if (![NSStringFromClass([self class]) isEqualToString: [[notification object]valueForKey:@"original_source"]] ){
            return;
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_GETCLIENTSTATUS])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                //NSUserDefaults
                
//                [[NSUserDefaults standardUserDefaults] setObject:[temp valueForKey:JSON_RETVAL] forKey:@"isBlock"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [appDelegate setUserDefaultData:[temp valueForKey:JSON_RETVAL] :@"isBlock"];
                
                
                if( [[temp valueForKey:JSON_RETVAL]isEqualToString:@"no"]){
                    if(![self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                    {
                        blockAlert = [UIAlertController alertControllerWithTitle:@""
                                                                         message:@"Your account is deactivated. Please contact your institute administrator."
                                                                  preferredStyle:UIAlertControllerStyleAlert];
                        [self presentViewController:blockAlert animated:YES completion:nil];
                    }
                }
                else{
                    
                    if([self.navigationController.visibleViewController isKindOfClass:[UIAlertController class]])
                    {
                        if(blockAlert != NULL) [self dismissViewControllerAnimated:TRUE completion:nil];
                    }
                }
            }
            else{
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCVISITEDUSER])
        {
             NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"visitedData"];
                
            }
        }
        

        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_SYNCUSERIMAGE])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
            {
                NSDictionary * valdict = [temp valueForKey:@"retVal"];
                NSArray * fileArr = [valdict valueForKey:@"file_locs"];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                     NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString* path = [documentsDirectory stringByAppendingPathComponent:
                                  @"userPic.png" ];
                NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
                NSMutableString * url = [[NSMutableString alloc]initWithFormat:ADURO_AUDIO_URL];
                NSMutableDictionary * resData =[appDelegate.engineObj.networkObj sendRequestToImageUploadAduro:url data:data method:@"POST":[fileArr objectAtIndex:0] : [appDelegate.global_userInfo valueForKey:DATABASE_USERID] : @"false" :@"image.png"];
                
                if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
                {
                    
                }
                else
                {
                    [appDelegate.engineObj.dataMngntObj setImage:NOIMAGECAPTURED];
                    
                }
            }
        }
//        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_UNLOCKEDCHAPTER])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [defaults setObject:[[temp valueForKey:@"retVal"] valueForKey:@"chapter_list"] forKey:@"unlocked_chapter_list"];
//
//                [defaults synchronize];
//            }
//        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_COURSE_DOWNLOAD])
        {
            
            
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [[resUserData valueForKey:NETWORKSTATUS]intValue] == 1 )
                {
                    if([[[notification object]valueForKey:@"action"]isEqualToString:@"courseDownload"])
                    {
                        [appDelegate.engineObj DownloadNewCourseCode:[resUserData valueForKey:@"courseArr"]];
                    }
                    else if([[[notification object]valueForKey:@"action"]isEqualToString:@"courseUpdate"])
                    {
                        if([appDelegate.engineObj DeleteCourseCode:[[[notification object]valueForKey:@"original_data"] valueForKey:DATABASE_COURSE_DATA] deleteDirectory:NO])
                        {
                            [appDelegate.engineObj DownloadNewCourseCode:[resUserData valueForKey:@"courseArr"]];
                        }
                    }
                    
                    NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
                    [obj setValue:[[notification object]valueForKey:@"action"] forKey:@"action"];
                    [obj setValue:[[notification object]valueForKey:@"original_data"] forKey:@"original_data"];
                    [obj setValue:[[notification object]valueForKey:@"original_source"] forKey:@"original_source"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self refreshBaseUI:obj];
                    });
                    
                    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
                    [override setValue:[resUserData valueForKey:@"course_code"]  forKey:JSON_COURSECODE];
                    [override setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
                    [reqObj setValue:JSON_COURSE_SIGNUP_DECREE forKey:JSON_DECREE ];
                    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                    [reqObj setValue:override forKey:JSON_PARAM];
                    
                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                    [_reqObj setValue:SERVICE_COURSE_DOWNLOAD_NOTYFY forKey:@"SERVICE"];
                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                    
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:B_SERVICE_CHAPTER_DOWNLOAD])
        {
            [self hideGlobalProgress];
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [[resUserData valueForKey:NETWORKSTATUS]intValue] == 1 )
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self downloadChapter:[[notification object]valueForKey:@"original_data"] : [[notification object]valueForKey:@"action"]:[resUserData valueForKey:@"chapComponent"]:[[notification object]valueForKey:@"original_data_source"]] ;
                    });
                    
                }
            }
            else
            {
            }
        }
    });
    
}

-(void)downloadCourse:(NSDictionary *)courseObj :(NSString *)action_name :(NSString *)source
{
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:[courseObj valueForKey:DATABASE_COURSE_DATA] forKey:JSON_COURSECODE];
    [override setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
    [override setValue: APPVERSION forKey:JSON_APPVERSION];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_COURSE_CHECK_DECREE forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_COURSE_DOWNLOAD forKey:@"SERVICE"];
    [_reqObj setValue:action_name forKey:@"action"];
    [_reqObj setValue:courseObj forKey:@"original_data"];
    [_reqObj setValue:source forKey:@"original_source"];
    
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}





-(void)downloadChapterData:(NSDictionary*)chapterObj :(NSString *)action_name :(NSString *)source
{
    
    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
    [override setValue:appDelegate.courseCode forKey:JSON_COURSECODE];
    [override setValue:[chapterObj valueForKey:DATABASE_SCENARIO_EDGEID] forKey:JSON_EDGEID];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_CHAPCOMPONENT_DECREE forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    [reqObj setValue:override forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_CHAPTER_DOWNLOAD forKey:@"SERVICE"];
    [_reqObj setValue:action_name forKey:@"action"];
    [_reqObj setValue:chapterObj forKey:@"original_data"];
    [_reqObj setValue:source forKey:@"original_source"];
    [self showGlobalProgress];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}
-(void)addProcessInQueue:(NSDictionary *)base_data :(NSString *)action_name :(NSString *)source
{
    if([action_name isEqualToString:@"courseDownload"] || [action_name isEqualToString:@"courseUpdate"] )
    {
        [self downloadCourse:base_data :action_name:source];
    }
    else if([action_name isEqualToString:@"chapterDownload"] || [action_name isEqualToString:@"chapterUpdate"]  )
    {
        [self downloadChapterData:base_data :action_name :source];
    }
    else if([action_name isEqualToString:@"assessmentDownload"] || [action_name isEqualToString:@"assessmentUpdate"]  )
    {
        [self downloadAssessment:base_data :action_name :source];
    }
    
}
-(void)downloadAssessment:(NSDictionary *)chapterObj :(NSString *)action_name :(NSString *)source
{
    //    if(base_chapter_downloadView != NULL )
    //    {
    //        base_chapter_downloadView.hidden = TRUE;
    //        [base_chapter_downloadView removeFromSuperview];
    //        base_chapter_downloadView =  NULL;
    //    }
    //
    //    base_chapter_downloadView  = [[UIView alloc] initWithFrame:self.view.frame];
    //    base_chapter_downloadView.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
    //    UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),110)];
    //
    //    canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 75, downloadView.frame.size.width, 30)];
    //    [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
    //    [canbtn addTarget:self
    //               action:@selector(clickBaseCancelBtn:)
    //     forControlEvents:UIControlEventTouchUpInside];
    //    [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
    //
    //    UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
    //    downloadinglbl.textAlignment = NSTextAlignmentCenter;
    //    downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    //    downloadinglbl.text = @"Downloading...";
    //    [downloadView addSubview:downloadinglbl];
    //
    //    UILabel * pleasewaitlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, downloadView.frame.size.width, 20)];
    //    pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
    //    pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    //    pleasewaitlbl.text = @"Please wait.";
    //    [downloadView addSubview:pleasewaitlbl];
    //
    //    downloadView.backgroundColor = [UIColor whiteColor];
    //    downloadView.layer.cornerRadius = 5;
    //    downloadView.layer.masksToBounds = YES;
    //    pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,50,downloadView.frame.size.width-20,20)];
    //    pView.trackTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    //    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    //    pView.transform = transform;
    //    [downloadView addSubview:pView];
    //    Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, pView.frame.size.height+55, downloadView.frame.size.width-20, 20)];
    //    Percentagelbl.textAlignment = NSTextAlignmentCenter;
    //    Percentagelbl.text = @"0%";
    //    Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    //    Percentagelbl.font = [UIFont systemFontOfSize:15];
    //    [downloadView addSubview:Percentagelbl];
    //    [downloadView addSubview:downloadinglbl];
    //    [downloadView addSubview:canbtn];
    //    [base_chapter_downloadView addSubview:downloadView];
    //    [self.view addSubview:base_chapter_downloadView];
    //
    //
    //
    //
    //    downloadinglbl.text = [appDelegate.langObj get:@"DLOAD_CHAP_MSG" alter:@"Downloading. Please wait…"];
    
    
    if(base_chapter_downloadView != NULL )
    {
        base_chapter_downloadView.hidden = TRUE;
        [base_chapter_downloadView removeFromSuperview];
        base_chapter_downloadView =  NULL;
    }
    base_chapter_downloadView  = [[UIView alloc] initWithFrame:self.view.frame];
    base_chapter_downloadView.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
    
    UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),180)];
    
    canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30)];
    [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
    [canbtn addTarget:self
               action:@selector(clickBaseCancelBtn:)
     forControlEvents:UIControlEventTouchUpInside];
    [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
    UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
    downloadinglbl.textAlignment = NSTextAlignmentCenter;
    downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    downloadinglbl.text = @"Downloading...";
    [downloadView addSubview:downloadinglbl];
    
    UILabel * pleasewaitlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, downloadView.frame.size.width, 20)];
    pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
    pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    pleasewaitlbl.text = @"Please wait.";
    [downloadView addSubview:pleasewaitlbl];
    
    downloadView.backgroundColor = [UIColor whiteColor];
    downloadView.layer.cornerRadius = 5;
    downloadView.layer.masksToBounds = YES;
    
    
    
    Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, downloadView.frame.size.width-20, 35)];
    Percentagelbl.textAlignment = NSTextAlignmentCenter;
    Percentagelbl.text = @"0%";
    Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    Percentagelbl.font = [UIFont systemFontOfSize:30];
    [downloadView addSubview:Percentagelbl];
    
    
    pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,120,downloadView.frame.size.width-20,10)];
    pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    pView.transform = transform;
    [downloadView addSubview:pView];
    
    [downloadView addSubview:canbtn];
    [base_chapter_downloadView addSubview:downloadView];
    [self.view addSubview:base_chapter_downloadView];
    
    
    self.sharedDownloadManager = [TCBlobDownloadManager sharedInstance];
    
    NSString * url = [[NSString alloc]initWithFormat:@"%@%@",AUDRO_ZIP_URL,[chapterObj valueForKey:@"zipurl"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:appDelegate.courseCode];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    
    [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:url] customPath:dataPath1
                                       firstResponse:NULL
                                            progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
        if (remainingTime != -1) {
            
            
            int val = [[NSNumber numberWithFloat:progress*100.00] intValue];
            NSLog(@"%d",val);
            Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",val];
            pView.progress =progress;
            pView .progressTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
            
            
            
        }
        else
        {
            
        }
        
    }
                                               error:^(NSError *error) {
        NSLog(@"Download Chapter Error : %@", error);
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
        if(base_chapter_downloadView != NULL )
        {
            base_chapter_downloadView.hidden = TRUE;
            [base_chapter_downloadView removeFromSuperview];
            base_chapter_downloadView =  NULL;
            if(canDownloadUpdateBtn !=  NULL)
            {
                [canDownloadUpdateBtn dismissViewControllerAnimated:YES completion:nil];
                canDownloadUpdateBtn = NULL;
            }
        }
        NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
        [obj setValue:@"NO" forKey:@"result"];
        [obj setValue:action_name forKey:@"action"];
        [obj setValue:chapterObj forKey:@"original_data"];
        [obj setValue:source forKey:@"original_source"];
        [self refreshBaseUI:obj];
        
        UIAlertController* errorAlert = [UIAlertController alertControllerWithTitle:@"" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [errorAlert addAction:okAction];
        [self presentViewController:errorAlert animated:YES completion:nil];
        
        
    }
                                            complete:^(BOOL downloadFinished, NSString *pathToFile) {
        
        if(downloadFinished )
        {
            
            [appDelegate.engineObj fromBaseEncryptAndParse:pathToFile:[chapterObj valueForKey:HTML_JSON_KEY_UID]];
            base_chapter_downloadView.hidden = TRUE;
            [base_chapter_downloadView removeFromSuperview];
            base_chapter_downloadView =  NULL;
            NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
            
            [obj setValue:@"YES" forKey:@"result"];
            [obj setValue:action_name forKey:@"action"];
            [obj setValue:chapterObj forKey:@"original_data"];
            [obj setValue:source forKey:@"original_source"];
            [self refreshBaseUI:obj];
            
        }
        else
        {
            [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
            base_chapter_downloadView.hidden = TRUE;
            [base_chapter_downloadView removeFromSuperview];
            base_chapter_downloadView =  NULL;
            if(canDownloadUpdateBtn !=  NULL)
            {
                [canDownloadUpdateBtn dismissViewControllerAnimated:YES completion:nil];
                canDownloadUpdateBtn = NULL;
            }
            
            NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
            [obj setValue:@"NO" forKey:@"result"];
            [obj setValue:action_name forKey:@"action"];
            [obj setValue:chapterObj forKey:@"original_data"];
            [obj setValue:source forKey:@"original_source"];
            [self refreshBaseUI:obj];
        }
    }];
    
}

-(void)downloadChapter:(NSDictionary *)chapterObj :(NSString *)action_name :(NSDictionary *)networkResp :(NSString *)source
{
    if(base_chapter_downloadView != NULL )
    {
        base_chapter_downloadView.hidden = TRUE;
        [base_chapter_downloadView removeFromSuperview];
        base_chapter_downloadView =  NULL;
    }
    base_chapter_downloadView  = [[UIView alloc] initWithFrame:self.view.frame];
    base_chapter_downloadView.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.9];
    [self.view addSubview:base_chapter_downloadView];
    UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),180)];
    
    canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30)];
    [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
    [canbtn addTarget:self
               action:@selector(clickBaseCancelBtn:)
     forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
    
    [downloadView addSubview:downloadinglbl];
    
    UILabel * pleasewaitlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, downloadView.frame.size.width, 20)];
    
    [downloadView addSubview:pleasewaitlbl];
    
    
    
    
    
    
    Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, downloadView.frame.size.width-20, 35)];
    
    [downloadView addSubview:Percentagelbl];
    
    
    pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,120,downloadView.frame.size.width-20,10)];
    pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    pView.transform = transform;
    [downloadView addSubview:pView];
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT3"])
    {
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -90, self.view.frame.size.width -(self.view.frame.size.width/5), 60)];
        image.image = [UIImage imageNamed:LOGO];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [base_chapter_downloadView addSubview:image];
        downloadView.frame = CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),(SCREEN_HEIGHT - ((self.view.frame.size.height/2) -30)));
        [canbtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:0.6] forState:UIControlStateNormal];
        canbtn.frame = CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30);
        downloadView.backgroundColor = [UIColor clearColor];
        
        downloadinglbl.textAlignment = NSTextAlignmentCenter;
        downloadinglbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.6];
        downloadinglbl.text = @"Downloading Test";
        downloadinglbl.font = BOLDTEXTTITLEFONT;
        
        
        pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
        pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.6];
        pleasewaitlbl.text = @"Please wait...";
        pleasewaitlbl.font = [UIFont systemFontOfSize:13.0];
        pleasewaitlbl.hidden = TRUE;
        
        Percentagelbl.frame = CGRectMake(10, 35, downloadView.frame.size.width-20, 20);
        Percentagelbl.textAlignment = NSTextAlignmentCenter;
        Percentagelbl.text = @"0%";
        Percentagelbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.6];
        Percentagelbl.font = [UIFont systemFontOfSize:13];
        pView.hidden = TRUE;
        
        
        UIImageView * rotateimage = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2)+40, self.view.frame.size.width -(self.view.frame.size.width/5), 60)];
        rotateimage.image = [UIImage imageNamed:@"PTEG_Downloading.png"];
        rotateimage.contentMode = UIViewContentModeScaleAspectFit;
        [base_chapter_downloadView addSubview:rotateimage];
        
//        [UIView animateWithDuration:1.0
//             delay:0.0
//           options:0
//        animations:^{
//            [UIView setAnimationRepeatCount:HUGE_VALF];
//            [UIView setAnimationBeginsFromCurrentState:YES];
//            rotateimage.transform = CGAffineTransformMakeRotation(2*M_PI);
//        }
//        completion:^(BOOL finished){
//            NSLog(@"Done!");
//        }];
        
        [self rotateImageView:rotateimage];
       
        
        
        
    }
    else
    {
        downloadView.frame = CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),180);
        canbtn.frame = CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30);
        [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
        downloadView.backgroundColor = [UIColor whiteColor];
        downloadView.layer.cornerRadius = 5;
        downloadView.layer.masksToBounds = YES;
        
        downloadinglbl.textAlignment = NSTextAlignmentCenter;
        downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
        downloadinglbl.text = @"Downloading...";
        downloadinglbl.font = [UIFont systemFontOfSize:13.0];
        
        Percentagelbl.frame = CGRectMake(10, 70, downloadView.frame.size.width-20, 35);
        pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
        pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        pleasewaitlbl.text = @"Please wait.";
        pleasewaitlbl.hidden = FALSE;
        
        
        Percentagelbl.textAlignment = NSTextAlignmentCenter;
        Percentagelbl.text = @"0%";
        Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        Percentagelbl.font = [UIFont systemFontOfSize:30];
        
        pView.hidden = FALSE;
        
    }
    
    [downloadView addSubview:canbtn];
    [base_chapter_downloadView addSubview:downloadView];
    
    if(networkResp != NULL)
    {
        
        self.sharedDownloadManager = [TCBlobDownloadManager sharedInstance];
        
        NSString * url = [[NSString alloc]initWithFormat:@"%@%@",AUDRO_ZIP_URL,[chapterObj valueForKey:DATABASE_SCENARIO_ZIPURL]];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
        dataPath1 = [dataPath1 stringByAppendingPathComponent:appDelegate.courseCode];
        dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
        
        [self.sharedDownloadManager startDownloadWithURL:[NSURL URLWithString:url] customPath:dataPath1
                                           firstResponse:NULL
                                                progress:^(uint64_t receivedLength, uint64_t totalLength, NSInteger remainingTime, float progress) {
            if (remainingTime != -1) {
                
                
                int val = [[NSNumber numberWithFloat:progress*100.00] intValue];
                NSLog(@"%d",val);
                if([UISTANDERD isEqualToString:@"PRODUCT3"])
                {
                    Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%% Complete",val];
                }
                else
                {
                    Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",val];
                }
                pView.progress =progress;
                pView .progressTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
                
                
                
            }
            else
            {
                
            }
            
        }
                                                   error:^(NSError *error) {
            NSLog(@"Download Chapter Error : %@", error);
            [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
            NSError *error1= NULL;
            NSString * lastZip = [url lastPathComponent];
            NSString * fileNameURL = [dataPath1 stringByAppendingPathComponent:lastZip];
            [[NSFileManager defaultManager] removeItemAtPath:fileNameURL error:&error1];
            
            if(base_chapter_downloadView != NULL )
            {
                base_chapter_downloadView.hidden = TRUE;
                [base_chapter_downloadView removeFromSuperview];
                base_chapter_downloadView =  NULL;
                if(canDownloadUpdateBtn !=  NULL)
                {
                    [canDownloadUpdateBtn dismissViewControllerAnimated:YES completion:nil];
                    canDownloadUpdateBtn = NULL;
                }
            }
            NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
            [obj setValue:@"NO" forKey:@"result"];
            [obj setValue:action_name forKey:@"action"];
            [obj setValue:chapterObj forKey:@"original_data"];
            [obj setValue:source forKey:@"original_source"];
            [self refreshBaseUI:obj];
            
            UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
            [errorAlrt show];
        }
                                                complete:^(BOOL downloadFinished, NSString *pathToFile) {
            
            if(downloadFinished )
            {
                //                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                //                    NSString *documentsDirectory = [paths objectAtIndex:0];
                //                    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
                //                    dataPath1 = [dataPath1 stringByAppendingPathComponent:appDelegate.courseCode];
                //                     dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
                //                     NSString * dataPath2 = [dataPath1 stringByAppendingPathComponent:[[NSURL URLWithString:url]lastPathComponent]];
                //                       NSError *error = nil;
                //
                //                      [[NSFileManager defaultManager] removeItemAtPath:dataPath2 error:&error];
                //                     [[NSFileManager defaultManager] copyItemAtPath:pathToFile toPath:dataPath1 error:&error];
                //                    // [[NSFileManager defaultManager] removeItemAtPath:pathToFile error:&error];
                //
                //
                //
                //
                //
                //
                //
                if([action_name isEqualToString:@"chapterUpdate"]){
                    [appDelegate.engineObj deleteScenario:[chapterObj valueForKey:DATABASE_SCENARIO_EDGEID] deleteDirectory:YES deleteZip:NO];
                    [appDelegate.engineObj updateComponant:[[NSString alloc]initWithFormat:@"%@",[chapterObj valueForKey:DATABASE_SCENARIO_EDGEID]]];
                }
                [appDelegate.engineObj parseChapComponent:networkResp];
                [appDelegate.engineObj fromBaseEncryptAndParse:pathToFile:[chapterObj valueForKey:DATABASE_SCENARIO_EDGEID]];
                base_chapter_downloadView.hidden = TRUE;
                [base_chapter_downloadView removeFromSuperview];
                base_chapter_downloadView =  NULL;
                NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
                
                [obj setValue:@"YES" forKey:@"result"];
                [obj setValue:action_name forKey:@"action"];
                [obj setValue:chapterObj forKey:@"original_data"];
                [obj setValue:source forKey:@"original_source"];
                [self refreshBaseUI:obj];
                
            }
            else
            {
                [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
                base_chapter_downloadView.hidden = TRUE;
                [base_chapter_downloadView removeFromSuperview];
                base_chapter_downloadView =  NULL;
                if(canDownloadUpdateBtn !=  NULL)
                {
                    [canDownloadUpdateBtn dismissViewControllerAnimated:YES completion:nil];
                    canDownloadUpdateBtn = NULL;
                }
                
                NSMutableDictionary * obj  = [[NSMutableDictionary alloc]init];
                [obj setValue:@"NO" forKey:@"result"];
                [obj setValue:action_name forKey:@"action"];
                [obj setValue:chapterObj forKey:@"original_data"];
                [obj setValue:source forKey:@"original_source"];
                [self refreshBaseUI:obj];
            }
        }];
        
    }
    else
    {
        UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Unable to download  from the server. Please check your network connection and try later."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
        if(base_chapter_downloadView != NULL )
        {
            base_chapter_downloadView.hidden = TRUE;
            [base_chapter_downloadView removeFromSuperview];
            base_chapter_downloadView =  NULL;
        }
        self.view.userInteractionEnabled = YES;
        [errorAlrt show];
    }
    
}
- (void)rotateImageView :(UIImageView *)img
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [img setTransform:CGAffineTransformRotate(img.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self rotateImageView:img];
        }
    }];
}

-(void)clickBaseCancelBtn:(id)sender
{
    
    canDownloadUpdateBtn = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:[appDelegate.langObj get:@"DOWNLOAD_CNL_MSG" alter:@"Do you want to stop download ?"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"YES" alter:@"Yes"] style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:YES];
        if(base_chapter_downloadView != NULL)
        {
            base_chapter_downloadView.hidden = TRUE;
            [base_chapter_downloadView removeFromSuperview];
            base_chapter_downloadView =  NULL;
        }
        
    }];
    
    
    
    
    
    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"NO" alter:@"No"] style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * action) {
        
    }];
    
    [canDownloadUpdateBtn addAction:YesAction];
    [canDownloadUpdateBtn addAction:NoAction];
    [self presentViewController:canDownloadUpdateBtn animated:YES completion:nil];
    
    
    
    
    
}
-(void)reloadUIData
{
    
}
-(void)refreshBaseUI :(NSDictionary *)base_data
{
    
}

-(void)showGlobalProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showInternalProgressBar];
        
    });
}
-(void)hideGlobalProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hideInternalProgressBar];
        
    });
}


-(void)showInternalProgressBar
{
    if(base_alert != NULL)
    {
        base_alert.hidden = true;
        [base_alert removeFromSuperview];
        base_alert = NULL;
    }
    base_alert = [[UIView alloc]initWithFrame:CGRectMake(70,(SCREEN_HEIGHT/2)-20, SCREEN_WIDTH-140, 40)];
    [base_alert setBackgroundColor:[self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0]];
    base_alert.hidden = false;
    base_alert.layer.cornerRadius= 10.0;
    base_alert.layer.borderWidth = 1.0;
    base_alert.layer.borderColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0].CGColor;
    base_alert.center = self.view.center;
    [self.view addSubview: base_alert];
    [self.view bringSubviewToFront:base_alert];
    UILabel * pleasewait = [[UILabel alloc]initWithFrame:CGRectMake(55, 10,base_alert.frame.size.width-50, 20)];
    pleasewait.text =  @"Please wait...";
    pleasewait.font = BOLDTEXTTITLEFONT;
    pleasewait.textAlignment = NSTextAlignmentLeft;
    pleasewait.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [base_alert addSubview:pleasewait];
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.frame = CGRectMake(20,10,20, 20);
    indicator.color = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    //indicator.center = base_alert.center;
    [indicator setUserInteractionEnabled:NO];
    [indicator startAnimating];
    self.view.userInteractionEnabled = FALSE;
    [base_alert addSubview:indicator];
    //[self showWileyDrawer];
    
    
}
-(void)hideInternalProgressBar
{
    if(base_alert != NULL)
    {
        base_alert.hidden = true;
        [base_alert removeFromSuperview];
        base_alert = NULL;
    }
    self.view.userInteractionEnabled = TRUE;
    //[self showWileyDrawer];
}


-(void)showGlobalSplashProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showInternalSplashProgressBar];
        
    });
}
-(void)hideGlobalSplashProgress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hideInternalSplashProgressBar];
        
    });
}


-(void)showInternalSplashProgressBar
{
    if(base_Splash_alert != NULL)
    {
        base_Splash_alert.hidden = true;
        [base_Splash_alert removeFromSuperview];
        base_Splash_alert = NULL;
    }
    base_Splash_alert = [[UIView alloc]initWithFrame:CGRectMake(70,SCREEN_HEIGHT-70, SCREEN_WIDTH-140, 40)];
    [base_Splash_alert setBackgroundColor:[self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0]];
    base_Splash_alert.hidden = false;
    base_Splash_alert.layer.cornerRadius= 10.0;
    base_Splash_alert.layer.borderWidth = 1.0;
    base_Splash_alert.layer.borderColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0].CGColor;
    //base_Splash_alert.center = self.view.center;
    [self.view addSubview: base_Splash_alert];
    [self.view bringSubviewToFront:base_Splash_alert];
    UILabel * pleasewait = [[UILabel alloc]initWithFrame:CGRectMake(55, 10,base_Splash_alert.frame.size.width-50, 20)];
    pleasewait.text =  @"Please wait...";
    pleasewait.font = BOLDTEXTTITLEFONT;
    pleasewait.textAlignment = NSTextAlignmentLeft;
    pleasewait.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [base_Splash_alert addSubview:pleasewait];
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color = [UIColor blackColor];
    indicator.frame = CGRectMake(20,10,20, 20);
    indicator.color = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    //indicator.center = base_alert.center;
    [indicator setUserInteractionEnabled:NO];
    [indicator startAnimating];
    self.view.userInteractionEnabled = FALSE;
    [base_Splash_alert addSubview:indicator];
    //[self showWileyDrawer];
    
    
}
-(void)hideInternalSplashProgressBar
{
    if(base_Splash_alert != NULL)
    {
        base_Splash_alert.hidden = true;
        [base_Splash_alert removeFromSuperview];
        base_Splash_alert = NULL;
    }
    self.view.userInteractionEnabled = TRUE;
    //[self showWileyDrawer];
}


-(void)hideACEDrawer
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
    }
}





-(IBAction)MyABTUSTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
        
        
    }
    [appDelegate gotoNextController:self controllerType:enum_aboutController sendingObj:nil];
}

-(void)PTEG_ABTUSTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_AboutUs"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_AboutUs class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_AboutUs * accObj = [[PTEG_AboutUs alloc]initWithNibName:@"PTEG_AboutUs" bundle:nil];
            [self.navigationController pushViewController:accObj animated:YES];
        }
    }
    
    
}

-(IBAction)MyFAQTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
        
        
    }
    FAQ * faq = [[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
    faq._strTitle = @"FAQs";
    [self.navigationController pushViewController:faq animated:YES];
}

-(IBAction)MyLOGOUTTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    [self logout];
}

-(void)MyPTEG_ProfileTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_UserProfile"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_UserProfile class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_UserProfile * accObj = [[PTEG_UserProfile alloc]initWithNibName:@"PTEG_UserProfile" bundle:nil];
            [self.navigationController pushViewController:accObj animated:YES];
        }
    }
    
}

-(IBAction)MyProfileTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
        
        
    }
    MyAccountScreen * accObj = [[MyAccountScreen alloc]initWithNibName:@"MyAccountScreen" bundle:nil];
    accObj.title = @"My Profile";
    [self.navigationController pushViewController:accObj animated:YES];
    
}

-(void)MyPTEG_HELPDESKTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_HelpDesk"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_HelpDesk class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_HelpDesk * ptehelpObj = [[PTEG_HelpDesk alloc]initWithNibName:@"PTEG_HelpDesk" bundle:nil];
            [self.navigationController pushViewController:ptehelpObj animated:TRUE];
        }
    }
    
    
    
}

-(IBAction)MyMeProHELPDESKTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FEEDBACKURL] options:@{} completionHandler:^(BOOL success) {
//        
//    }];
    MePro_Feedback * fedObj = [[MePro_Feedback alloc]initWithNibName:@"MePro_Feedback" bundle:nil];
    fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
    [self.navigationController pushViewController:fedObj animated:YES];
}




-(IBAction)openAceVideo:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    aceInterviewVideo * fedObj = [[aceInterviewVideo alloc]initWithNibName:@"aceInterviewVideo" bundle:nil];
    [self.navigationController pushViewController:fedObj animated:YES];
}


-(IBAction)MyHELPDESKTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    FeedbackViewController * fedObj = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
    fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
    //fedObj.url = FEEDBACKURL;
    [self.navigationController pushViewController:fedObj animated:YES];
}

-(void)showAddContentpack:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    WileyDashboard * dashBoard =  (WileyDashboard *)self;
    [dashBoard showContentPack];
}

-(void)showContentpackList:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    WileyDashboard * dashBoard =  (WileyDashboard *)self;
    [dashBoard showContentPackList];
}

-(IBAction)showACEDrawer
{
    isShow  = !isShow;
    if(slidingWindow == NULL && isShow)
    {
        float  LOGO_HEIGHT = 160.0;
        slidingWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        slidingWindow.backgroundColor = [self getUIColorObjectFromHexString:DRAWERCOLOR alpha:0.2];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showACEDrawer)];
        [slidingWindow addGestureRecognizer:singleFingerTap];
        sliderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,3*(SCREEN_WIDTH/4),slidingWindow.frame.size.height)];
        [sliderScroll setBackgroundColor:[self getUIColorObjectFromHexString:DRAWERCOLOR alpha:1.0]];
        sliderScroll.showsVerticalScrollIndicator=YES;
        sliderScroll.scrollEnabled=YES;
        sliderScroll.bounces = NO;
        sliderScroll.userInteractionEnabled=YES;
        [slidingWindow addSubview:sliderScroll];
        [self.view addSubview:slidingWindow];
        
        
        
       UIView * upperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, sliderScroll.frame.size.width,LOGO_HEIGHT)];
        upperView.backgroundColor = [self getUIColorObjectFromHexString:DRAWERCOLOR alpha:1.0];
        
        //        UIButton * local_back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
        //        [local_back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        //        [upperView addSubview:local_back];
        
        
        UIImageView * logo =[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 90, 90)];
        logo.layer.cornerRadius = logo.frame.size.width/2;
        logo.clipsToBounds = YES;
        
        
        UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        logo.image = image;
        NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    logo.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                }
                else
                {
                    // userImg.image = _img;
                }
                
            }];
        }
        else
        {
            logo.image = Limg;
        }
        
        logo.contentMode = UIViewContentModeScaleAspectFill;
        [upperView addSubview:logo];
        UILabel*  name = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, upperView.frame.size.width-100,20)];
        name.text = [[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME] uppercaseString];
        name.textColor = [UIColor whiteColor];
        name.font = BOLDTEXTTITLEFONT;
        [upperView addSubview:name];
        [sliderScroll addSubview:upperView];
        
        UILabel * username = [[UILabel alloc]initWithFrame:CGRectMake(100, 95, upperView.frame.size.width-100,20)];
        username.text = [appDelegate.global_userInfo valueForKey:DATABASE_LOGIN];
        username.textColor = [UIColor whiteColor];
        username.font = SUBTEXTTILEFONT;
        [upperView addSubview:username];
        
        
        UIView *myPView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *h_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *img = [UIImage imageNamed:@"WileyTurkeyDrawer-Menu-profile.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [h_img setImage:img];
        h_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [myPView addSubview:h_img];
        UITapGestureRecognizer *homeTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyProfileTap:)];
        [myPView addGestureRecognizer:homeTap];
        
        [sliderScroll addSubview:myPView];
        
        UILabel *HomeTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        HomeTxt.text = @"My Profile";
        HomeTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        HomeTxt.font = TEXTTITLEFONT;
        [myPView addSubview:HomeTxt];
        
        
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView * myPerformanceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPerformanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *myPerformance_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *myPerformanceImg = [UIImage imageNamed:@"My-Profile.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [myPerformance_img setImage:myPerformanceImg];
        myPerformance_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [myPerformanceView addSubview:myPerformance_img];
        UITapGestureRecognizer *myPerformanceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPerformanceTapChapterWise)];
        [myPerformanceView addGestureRecognizer:myPerformanceTap];
        [sliderScroll addSubview:myPerformanceView];
        
        UILabel *myPerformanceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPerformanceView.frame.size.width-55, 30)];
        myPerformanceTxt.text = @"My Performance";
        myPerformanceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        myPerformanceTxt.font = TEXTTITLEFONT;
        [myPerformanceView addSubview:myPerformanceTxt];
        
        UIView * m_borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,myPerformanceView.frame.size.height-1, myPerformanceView.frame.size.width,1)];
        m_borderLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [myPerformanceView addSubview:m_borderLine];
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
           if([NSStringFromClass([self class]) isEqualToString:@"WileyDashboard"] )
           {
           UIView * MyContectPackView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            MyContectPackView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            UIImageView *asign_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage *asignimg = [UIImage imageNamed:@"Add-contentPack.png"];
            //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [asign_img setImage:asignimg];
            asign_img.translatesAutoresizingMaskIntoConstraints = NO;
            //h_img.tintColor = [UIColor blackColor];
            [MyContectPackView addSubview:asign_img];
            UITapGestureRecognizer *asignmentTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(showAddContentpack:)];
            [MyContectPackView addGestureRecognizer:asignmentTap];

            [sliderScroll addSubview:MyContectPackView];

            UILabel *myContentTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, MyContectPackView.frame.size.width-55, 30)];
            myContentTxt.text = @"Add Content Pack";
            myContentTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myContentTxt.font = TEXTTITLEFONT;
            [MyContectPackView addSubview:myContentTxt];

           LOGO_HEIGHT = LOGO_HEIGHT + 60;
               
               
               UIView * MyContentPackListView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
                MyContentPackListView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                UIImageView *mycon_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
                UIImage *conimg = [UIImage imageNamed:@"content-pack.png"];
                //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                [mycon_img setImage:conimg];
                mycon_img.translatesAutoresizingMaskIntoConstraints = NO;
                //h_img.tintColor = [UIColor blackColor];
                [MyContentPackListView addSubview:mycon_img];
                UITapGestureRecognizer *myContentTap =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showContentpackList:)];
                [MyContentPackListView addGestureRecognizer:myContentTap];
                
                [sliderScroll addSubview:MyContentPackListView];
                
                UILabel *myContentPTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, MyContentPackListView.frame.size.width-55, 30)];
                myContentPTxt.text = @"My Content Pack";
                myContentPTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                myContentPTxt.font = TEXTTITLEFONT;
                [MyContentPackListView addSubview:myContentPTxt];
                
               LOGO_HEIGHT = LOGO_HEIGHT + 60;
           }
        
        UIView *  videoMenuView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        videoMenuView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *videoMenu_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *videoMenuimg = [UIImage imageNamed:@"zoom-b.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [videoMenu_img setImage:videoMenuimg];
        videoMenu_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [videoMenuView addSubview:videoMenu_img];
        UITapGestureRecognizer *videoMenuTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(openAceVideo:)];
        [videoMenuView addGestureRecognizer:videoMenuTap];
        
        [sliderScroll addSubview:videoMenuView];
        UILabel *videoMenuTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        videoMenuTxt.text = @"How to use the app";
        videoMenuTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        videoMenuTxt.font = TEXTTITLEFONT;
        [videoMenuView addSubview:videoMenuTxt];
        
        UIView * videoMenuborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,videoMenuView.frame.size.height-1, videoMenuView.frame.size.width,1)];
        videoMenuborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [videoMenuView addSubview:videoMenuborder_Line];
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        UIView *  faq = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        faq.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *faq_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _faq_img = [UIImage imageNamed:@"WileyTurkeyfaq.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [faq_img setImage:_faq_img];
        faq_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [faq addSubview:faq_img];
        UITapGestureRecognizer *faqTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyFAQTap:)];
        [faq addGestureRecognizer:faqTap];
        
        [sliderScroll addSubview:faq];
        UILabel *faqTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, faq.frame.size.width-55, 30)];
        faqTxt.text = @"FAQs";
        faqTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        faqTxt.font = TEXTTITLEFONT;
        [faq addSubview:faqTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        UIView *  abtus = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *abtus_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _abtus_img = [UIImage imageNamed:@"WileyTurkeyabout-us.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [abtus_img setImage:_abtus_img];
        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [abtus addSubview:abtus_img];
        UITapGestureRecognizer *abtusTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyABTUSTap:)];
        [abtus addGestureRecognizer:abtusTap];
        
        [sliderScroll addSubview:abtus];
        UILabel *abtusTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, abtus.frame.size.width-55, 30)];
        abtusTxt.text = @"About Us";
        abtusTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        abtusTxt.font = TEXTTITLEFONT;
        [abtus addSubview:abtusTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  helpdesk = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        helpdesk.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *helpdesk_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *helpdeskimg = [UIImage imageNamed:@"WileyTurkeyhelp-desk.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [helpdesk_img setImage:helpdeskimg];
        helpdesk_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [helpdesk addSubview:helpdesk_img];
        UITapGestureRecognizer *helpdeskTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyHELPDESKTap:)];
        [helpdesk addGestureRecognizer:helpdeskTap];
        
        [sliderScroll addSubview:helpdesk];
        UILabel *helpdeskTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        helpdeskTxt.text = @"Helpdesk";
        helpdeskTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        helpdeskTxt.font = TEXTTITLEFONT;
        [helpdesk addSubview:helpdeskTxt];
        
        UIView * helpdeskborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,helpdesk.frame.size.height-1, helpdesk.frame.size.width,1)];
        helpdeskborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [helpdesk addSubview:helpdeskborder_Line];
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView *  logOut = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        logOut.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *logOut_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _logOut_img = [UIImage imageNamed:@"WileyTurkeylogout.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [logOut_img setImage:_logOut_img];
        logOut_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [logOut addSubview:logOut_img];
        UITapGestureRecognizer *logOutTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyLOGOUTTap:)];
        [logOut addGestureRecognizer:logOutTap];
        
        [sliderScroll addSubview:logOut];
        UILabel *logOutTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, logOut.frame.size.width-55, 30)];
        logOutTxt.text = @"Logout";
        logOutTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        logOutTxt.font = TEXTTITLEFONT;
        [logOut addSubview:logOutTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  version = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        version.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [sliderScroll addSubview:version];
        UILabel *versionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, logOut.frame.size.width, 30)];
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        NSString* currentBuildVersion = infoDictionary[@"CFBundleVersion"];
        versionLbl.text = [[NSString alloc]initWithFormat:@"V %@:%@",currentVersion,currentBuildVersion];
        versionLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        versionLbl.textAlignment = NSTextAlignmentCenter;
        versionLbl.font = HEADERSECTIONTITLEFONT;
        [version addSubview:versionLbl];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        
        sliderScroll.contentSize = CGSizeMake(sliderScroll.frame.size.width, LOGO_HEIGHT);
        CGRect basketTopFrame = slidingWindow.frame;
        basketTopFrame.origin.x = 0;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{ slidingWindow.frame = basketTopFrame;
            
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        
    }
    
}


-(void)hideWileyDrawer
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
    }
}


-(IBAction)showWileyDrawer
{
    isShow  = !isShow;
    if(slidingWindow == NULL && isShow)
    {
        float  LOGO_HEIGHT = 160.0;
        slidingWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        slidingWindow.backgroundColor = [self getUIColorObjectFromHexString:DRAWERCOLOR alpha:0.2];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showWileyDrawer)];
        [slidingWindow addGestureRecognizer:singleFingerTap];
        sliderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,3*(SCREEN_WIDTH/4),slidingWindow.frame.size.height)];
        [sliderScroll setBackgroundColor:[self getUIColorObjectFromHexString:DRAWERCOLOR alpha:1.0]];
        sliderScroll.showsVerticalScrollIndicator=YES;
        sliderScroll.scrollEnabled=YES;
        sliderScroll.bounces = NO;
        sliderScroll.userInteractionEnabled=YES;
        [slidingWindow addSubview:sliderScroll];
        [self.view addSubview:slidingWindow];
        
        
        
       UIView * upperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, sliderScroll.frame.size.width,LOGO_HEIGHT)];
        upperView.backgroundColor = [self getUIColorObjectFromHexString:DRAWERCOLOR alpha:1.0];
        
        //        UIButton * local_back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 40, 40)];
        //        [local_back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        //        [upperView addSubview:local_back];
        
        
        UIImageView * logo =[[UIImageView alloc]initWithFrame:CGRectMake(5, 50, 90, 90)];
        logo.layer.cornerRadius = logo.frame.size.width/2;
        logo.clipsToBounds = YES;
        
        
        UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        logo.image = image;
        NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    logo.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                }
                else
                {
                    // userImg.image = _img;
                }
                
            }];
        }
        else
        {
            logo.image = Limg;
        }
        
        logo.contentMode = UIViewContentModeScaleAspectFill;
        [upperView addSubview:logo];
        UILabel*  name = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, upperView.frame.size.width-100,20)];
        name.text = [[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME] uppercaseString];
        name.textColor = [UIColor whiteColor];
        name.font = BOLDTEXTTITLEFONT;
        [upperView addSubview:name];
        [sliderScroll addSubview:upperView];
        
        UILabel * username = [[UILabel alloc]initWithFrame:CGRectMake(100, 95, upperView.frame.size.width-100,20)];
        username.text = [appDelegate.global_userInfo valueForKey:DATABASE_LOGIN];
        username.textColor = [UIColor whiteColor];
        username.font = SUBTEXTTILEFONT;
        [upperView addSubview:username];
        
        
        
        
        
        
        
        
        
        
        
        UIView *myPView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *h_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *img = [UIImage imageNamed:@"WileyTurkeyDrawer-Menu-profile.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [h_img setImage:img];
        h_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [myPView addSubview:h_img];
        UITapGestureRecognizer *homeTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyProfileTap:)];
        [myPView addGestureRecognizer:homeTap];
        
        [sliderScroll addSubview:myPView];
        
        UILabel *HomeTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        HomeTxt.text = @"My Profile";
        HomeTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        HomeTxt.font = TEXTTITLEFONT;
        [myPView addSubview:HomeTxt];
        
        UIView * borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,myPView.frame.size.height-1, myPView.frame.size.width,1)];
        borderLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [myPView addSubview:borderLine];
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        if(appDelegate.isPreRegisteredUser && ([CLASS_NAME isEqualToString:@"wiley"] )){
           UIView * assignmentView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            assignmentView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            UIImageView *asign_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage *asignimg = [UIImage imageNamed:@"assignment_drawer.png"];
            //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [asign_img setImage:asignimg];
            asign_img.translatesAutoresizingMaskIntoConstraints = NO;
            //h_img.tintColor = [UIColor blackColor];
            [assignmentView addSubview:asign_img];
            UITapGestureRecognizer *asignmentTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(MyAssignmentTap)];
            [assignmentView addGestureRecognizer:asignmentTap];
            
            [sliderScroll addSubview:assignmentView];
            
            UILabel *AsignmentTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, assignmentView.frame.size.width-55, 30)];
            AsignmentTxt.text = @"Assignment";
            AsignmentTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            AsignmentTxt.font = TEXTTITLEFONT;
            [assignmentView addSubview:AsignmentTxt];
            

            LOGO_HEIGHT = LOGO_HEIGHT + 60;
        }
        if(![NSStringFromClass([self class]) isEqualToString:@"WileyDashboard"] )
        {
            UIView * ClassSlidesView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            ClassSlidesView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            UIImageView *clas_img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
            UIImage *clasimg = [UIImage imageNamed:@"wiley_class.png"];
            [clas_img setImage:clasimg];
            clas_img.translatesAutoresizingMaskIntoConstraints = NO;
            [ClassSlidesView addSubview:clas_img];
            UITapGestureRecognizer *asignmentTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(openWileyClassSlide)];
            [ClassSlidesView addGestureRecognizer:asignmentTap];
            [sliderScroll addSubview:ClassSlidesView];

            UILabel *mySlidesTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, ClassSlidesView.frame.size.width-55, 30)];
            mySlidesTxt.text = @"Class Slides";
            mySlidesTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            mySlidesTxt.font = TEXTTITLEFONT;
            [ClassSlidesView addSubview:mySlidesTxt];

            LOGO_HEIGHT = LOGO_HEIGHT + 60;
        }
        
        UIView * VBuilderView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        VBuilderView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *clas_img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        UIImage *clasimg = [UIImage imageNamed:@"Wiley_vocab-drawer.png"];
        [clas_img setImage:clasimg];
        clas_img.translatesAutoresizingMaskIntoConstraints = NO;
        [VBuilderView addSubview:clas_img];
        UITapGestureRecognizer *asignmentTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyVocabTap:)];
        [VBuilderView addGestureRecognizer:asignmentTap];
        [sliderScroll addSubview:VBuilderView];

        UILabel *mySlidesTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, VBuilderView.frame.size.width-55, 30)];
        mySlidesTxt.text = @"Vocabulary Builder";
        mySlidesTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        mySlidesTxt.font = TEXTTITLEFONT;
        [VBuilderView addSubview:mySlidesTxt];

        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView * myPerformanceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPerformanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *myPerformance_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *myPerformanceImg = [UIImage imageNamed:@"My-Profile.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [myPerformance_img setImage:myPerformanceImg];
        myPerformance_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [myPerformanceView addSubview:myPerformance_img];
        UITapGestureRecognizer *myPerformanceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPerformanceTap)];
        [myPerformanceView addGestureRecognizer:myPerformanceTap];
        [sliderScroll addSubview:myPerformanceView];
        
        UILabel *myPerformanceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPerformanceView.frame.size.width-55, 30)];
        myPerformanceTxt.text = @"My Performance";
        myPerformanceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        myPerformanceTxt.font = TEXTTITLEFONT;
        [myPerformanceView addSubview:myPerformanceTxt];
        
        UIView * m_borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,myPerformanceView.frame.size.height-1, myPerformanceView.frame.size.width,1)];
        m_borderLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [myPerformanceView addSubview:m_borderLine];
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *  faq = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        faq.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *faq_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _faq_img = [UIImage imageNamed:@"WileyTurkeyfaq.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [faq_img setImage:_faq_img];
        faq_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [faq addSubview:faq_img];
        UITapGestureRecognizer *faqTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyFAQTap:)];
        [faq addGestureRecognizer:faqTap];
        
        [sliderScroll addSubview:faq];
        UILabel *faqTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, faq.frame.size.width-55, 30)];
        faqTxt.text = @"FAQs";
        faqTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        faqTxt.font = TEXTTITLEFONT;
        [faq addSubview:faqTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        if([CLASS_NAME isEqualToString:@"wiley"]){
            
           UIView *  zoomGuide = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            zoomGuide.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            UIImageView *zoomGuide_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage * _zoomGuide_img = [UIImage imageNamed:@"wiley_zoom.png"];
            //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [zoomGuide_img setImage:_zoomGuide_img];
            zoomGuide_img.translatesAutoresizingMaskIntoConstraints = NO;
            //faq_img.tintColor = [UIColor blackColor];
            [zoomGuide addSubview:zoomGuide_img];
            UITapGestureRecognizer *zoomGuideTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(MyZOOMGuideTap:)];
            [zoomGuide addGestureRecognizer:zoomGuideTap];
            
            [sliderScroll addSubview:zoomGuide];
            UILabel *zoomGuideTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, zoomGuide.frame.size.width-55, 30)];
            zoomGuideTxt.text = @"Zoom Guide";
            zoomGuideTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            zoomGuideTxt.font = TEXTTITLEFONT;
            [zoomGuide addSubview:zoomGuideTxt];
            LOGO_HEIGHT = LOGO_HEIGHT + 60;
            
            
        }
        
        
        
        UIView *  abtus = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *abtus_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _abtus_img = [UIImage imageNamed:@"WileyTurkeyabout-us.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [abtus_img setImage:_abtus_img];
        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [abtus addSubview:abtus_img];
        UITapGestureRecognizer *abtusTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyABTUSTap:)];
        [abtus addGestureRecognizer:abtusTap];
        
        [sliderScroll addSubview:abtus];
        UILabel *abtusTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, abtus.frame.size.width-55, 30)];
        abtusTxt.text = @"About Us";
        abtusTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        abtusTxt.font = TEXTTITLEFONT;
        [abtus addSubview:abtusTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  helpdesk = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        helpdesk.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *helpdesk_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *helpdeskimg = [UIImage imageNamed:@"WileyTurkeyhelp-desk.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [helpdesk_img setImage:helpdeskimg];
        helpdesk_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [UIColor blackColor];
        [helpdesk addSubview:helpdesk_img];
        UITapGestureRecognizer *helpdeskTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyHELPDESKTap:)];
        [helpdesk addGestureRecognizer:helpdeskTap];
        
        [sliderScroll addSubview:helpdesk];
        UILabel *helpdeskTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        helpdeskTxt.text = @"Helpdesk";
        helpdeskTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        helpdeskTxt.font = TEXTTITLEFONT;
        [helpdesk addSubview:helpdeskTxt];
        
        UIView * helpdeskborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,helpdesk.frame.size.height-1, helpdesk.frame.size.width,1)];
        helpdeskborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [helpdesk addSubview:helpdeskborder_Line];
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView *  logOut = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        logOut.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *logOut_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _logOut_img = [UIImage imageNamed:@"WileyTurkeylogout.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [logOut_img setImage:_logOut_img];
        logOut_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [UIColor blackColor];
        [logOut addSubview:logOut_img];
        UITapGestureRecognizer *logOutTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyLOGOUTTap:)];
        [logOut addGestureRecognizer:logOutTap];
        
        [sliderScroll addSubview:logOut];
        UILabel *logOutTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, logOut.frame.size.width-55, 30)];
        logOutTxt.text = @"Logout";
        logOutTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        logOutTxt.font = TEXTTITLEFONT;
        [logOut addSubview:logOutTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *  version = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        version.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [sliderScroll addSubview:version];
        UILabel *versionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, logOut.frame.size.width, 30)];
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        NSString* currentBuildVersion = infoDictionary[@"CFBundleVersion"];
        versionLbl.text = [[NSString alloc]initWithFormat:@"V %@:%@",currentVersion,currentBuildVersion];
        versionLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        versionLbl.textAlignment = NSTextAlignmentCenter;
        versionLbl.font = HEADERSECTIONTITLEFONT ;
        [version addSubview:versionLbl];
        
        UILabel *copyRightLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, logOut.frame.size.width, 30)];
        copyRightLbl.text = [[NSString alloc]initWithFormat:COPYRIGHT];
        copyRightLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        copyRightLbl.textAlignment = NSTextAlignmentCenter;
        copyRightLbl.font = HEADERSECTIONTITLEFONT ;
        [version addSubview:copyRightLbl];
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *  __abtus = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        __abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
               
               
       [sliderScroll addSubview:__abtus];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
         
         
         
        sliderScroll.contentSize = CGSizeMake(sliderScroll.frame.size.width, LOGO_HEIGHT);
        CGRect basketTopFrame = slidingWindow.frame;
        basketTopFrame.origin.x = 0;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{ slidingWindow.frame = basketTopFrame;
            
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        
    }
    
}

-(void)openWileyClassSlide
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    
    WileyClassSlides *pdfListView = [[WileyClassSlides alloc]initWithNibName:@"WileyClassSlides" bundle:nil];
    [self.navigationController pushViewController:pdfListView animated:YES];
}

-(IBAction)MyZOOMGuideTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
//    Vocab_Session *vc = [[Vocab_Session alloc]init];
//
//      //[self presentViewController:vc animated:YES completion:nil];
//     //[self.navigationController pushViewController:vc animated:YES];
//
//    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self.navigationController pushViewController:vc animated:YES];
//    //[self presentViewController:nv animated:YES completion:nil];
    
    ZoomGuide *pdfView = [[ZoomGuide alloc]initWithNibName:@"ZoomGuide" bundle:nil];
    pdfView.titleName = @"Zoom Guide";
    [self.navigationController pushViewController:pdfView animated:YES];
    
    
}

-(IBAction)MyVocabTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    Vocab_Session *vc = [[Vocab_Session alloc]init];
     
      //[self presentViewController:vc animated:YES completion:nil];
     //[self.navigationController pushViewController:vc animated:YES];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:nv animated:YES completion:nil];
    
//    ZoomGuide *pdfView = [[ZoomGuide alloc]initWithNibName:@"ZoomGuide" bundle:nil];
//    pdfView.titleName = @"Zoom Guide";
//    [self.navigationController pushViewController:pdfView animated:YES];
    
    
}

-(IBAction)MyAssignmentTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    UIStoryboard *willeySB = [UIStoryboard storyboardWithName:@"Wiley" bundle:nil];
    UIViewController *vc = [willeySB instantiateViewControllerWithIdentifier:@"AssignmentListViewController"];
    [self.navigationController pushViewController:vc animated:true];
    
    
    //    UIAlertController * alert = [UIAlertController
    //                                 alertControllerWithTitle:@""
    //                                 message:@"Assignment is under Development."
    //                                 preferredStyle:UIAlertControllerStyleAlert];
    //    [self presentViewController:alert animated:YES completion:nil];
    //    int duration = 2; // duration in seconds
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    //        [alert dismissViewControllerAnimated:YES completion:nil];
    //    });
}

-(IBAction)MyPerformanceTapChapterWise
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
        
        
    }
     UserGraphPerformance_ChapterWise * userGPPbj = [[UserGraphPerformance_ChapterWise alloc]initWithNibName:@"UserGraphPerformance_ChapterWise" bundle:nil];
     [self.navigationController pushViewController:userGPPbj animated:YES];

}
-(IBAction)MyPerformanceTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
        
        
        
    }
    UserGraphPerformance * userGPPbj = [[UserGraphPerformance alloc]initWithNibName:@"UserGraphPerformance" bundle:nil];
    [self.navigationController pushViewController:userGPPbj animated:YES];
    
}


-(IBAction)MyPTEG_aboutTestTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_AboutTest"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_AboutTest class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_AboutTest * pteAbout = [[PTEG_AboutTest alloc]initWithNibName:@"PTEG_AboutTest" bundle:nil];
            [self.navigationController pushViewController:pteAbout animated:TRUE];
        }
    }
    
}

-(IBAction)MyPTEG_examTipsTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_OpenUrlWeb"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_OpenUrlWeb class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_OpenUrlWeb * webObj = [[PTEG_OpenUrlWeb alloc]initWithNibName:@"PTEG_OpenUrlWeb" bundle:nil];
            webObj.titleName = @"Tips & Tricks";
            webObj.url = PTEG_TESTSTIPS;
            [self.navigationController pushViewController:webObj animated:TRUE];
        }
    }
    

}

-(void)logout
{
    
    UIAlertController* LogoutAlert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout"]
                                                                         message:@"Are you sure ?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
        
    }];
    
    [LogoutAlert addAction:NoAction];
    
    
    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
        [appDelegate.engineObj.dataMngntObj cleanUserDatabase];
        [self resetDefaults];
        appDelegate.isServiceRunning = FALSE;
        appDelegate.initPlayer = NO;
        appDelegate.rotationFlag = NO;
        appDelegate.vocabWordCookie= @"";
        //appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
        appDelegate.activityUpdate =0;
        appDelegate.coursePack = @"";
        appDelegate.topicId = @"";
        appDelegate.GSE_level  = @"-1";
        appDelegate.lti_Test_Score  = -1;
        appDelegate.GSE_desc = @"nil";
        appDelegate.CEFR_level = @"-1";
        appDelegate.global_userInfo = NULL;
        appDelegate.workingCourseObj = NULL;
        appDelegate.workingTopicObj = NULL;
        appDelegate.workingChapterObj = NULL;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [LogoutAlert addAction:YesAction];
    
    [self presentViewController:LogoutAlert animated:YES completion:nil];
    
}

-(void)setBookmarks
{
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_SETUSERBOOKMARKSTATUS forKey:JSON_DECREE ];
    NSMutableDictionary * data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.bookmark_type forKey:@"bookmark_type"];
    [data setValue:appDelegate.coursePack forKey:@"package_code"];
    [data setValue:appDelegate.topicId forKey:@"topic_edge_id"];
    [data setValue:appDelegate.courseCode forKey:@"course_code"];
    [data setValue:appDelegate.chapterId forKey:@"chapter_edge_id"];
     [data setValue:appDelegate.product_id forKey:@"product_id"];
    
    [reqObj setValue:data forKey:JSON_PARAM ];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SETBOOKMARKSSTATUS forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

-(void)setLevelChangeBookmarks:(NSString*)courseCode
{
    appDelegate.bookmark_type = @"chapter";
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_SETUSERBOOKMARKSTATUS forKey:JSON_DECREE ];
    NSMutableDictionary * data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.bookmark_type forKey:@"bookmark_type"];
    [data setValue:appDelegate.coursePack forKey:@"package_code"];
    //[data setValue:appDelegate.topicId forKey:@"topic_edge_id"];
    [data setValue:courseCode forKey:@"course_code"];
    //[data setValue:appDelegate.chapterId forKey:@"chapter_edge_id"];
     [data setValue:appDelegate.product_id forKey:@"product_id"];
    
    [reqObj setValue:data forKey:JSON_PARAM ];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:B_SERVICE_SETBOOKMARKSSTATUS forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}

- (void) moveDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileList = [fm contentsOfDirectoryAtPath: cacheDirectory error: nil];
    for(NSInteger i = 0; i < [fileList count]; ++i)
    {
        NSString *fp =  [fileList objectAtIndex: i];
        NSString *remPath = [cacheDirectory stringByAppendingPathComponent: fp];
        [fm removeItemAtPath: remPath error: nil];
    }
    
    
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths1 objectAtIndex:0];
    fileList = [fm contentsOfDirectoryAtPath: docDirectory error: nil];
    for(NSInteger j = 0; j < [fileList count]; ++j)
    {
        NSString *fp1 =  [fileList objectAtIndex: j];
        NSString *remPath1 = [docDirectory stringByAppendingPathComponent: fp1];
        [fm removeItemAtPath: remPath1 error: nil];
    }
    
    NSString *sqliteDB = [cacheDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"InterviewPrep_V2"
                                                             ofType:@"sqlite"];
    [fm copyItemAtPath:resourcePath toPath:sqliteDB error:nil];
    
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        if(![key hasPrefix:@"QT_"])
          [defs removeObjectForKey:key];
    }
    [defs synchronize];
}


-(void)updateUserTokenAndMode :(NSDictionary *)resUserData
{
    NSString * profile = @"defaultUserImg.png";
    if((id)[NSNull null] != [resUserData valueForKey:@"profile_pic"] )
    {
        profile = [resUserData valueForKey:@"profile_pic"];
    }
    [appDelegate.engineObj updateUser:[resUserData valueForKey:@"user_id"] :[resUserData valueForKey:JSON_TOKEN] :profile];
    appDelegate.global_userInfo = [appDelegate.engineObj getUserInfo];
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        appDelegate.master_mode = [[resUserData valueForKey:@"master_mode"]intValue];
        appDelegate.quiz_passing_percentage = [[resUserData valueForKey:@"quiz_passing_percentage"]intValue];
        appDelegate.review_passing_percentage = [[resUserData valueForKey:@"review_passing_percentage"]intValue];
        appDelegate.level_passing_score = [[resUserData valueForKey:@"level_passing_score"]intValue];
        appDelegate.chapter_quiz_passing_score = [[resUserData valueForKey:@"chapter_quiz_passing_score"]intValue];
    }
    else
    {
        appDelegate.master_mode = 0;
        appDelegate.quiz_passing_percentage = 0;
        appDelegate.review_passing_percentage = 0;
        appDelegate.level_passing_score = 0;
        appDelegate.chapter_quiz_passing_score = 0;
    }
}

-(void)setUserLTIScore :(NSDictionary *)resUserData
{
    //[appDelegate setUserDefaultData:resUserData:@"lti_test_data"];
    appDelegate.GSE_level = [[NSString alloc]initWithFormat:@"%@",[resUserData valueForKey:@"user_current_level"]];
    appDelegate.lti_Test_Score = [[resUserData valueForKey:@"score"]intValue];
    appDelegate.GSE_desc = [resUserData valueForKey:@"user_current_description"];
    appDelegate.CEFR_level = [resUserData valueForKey:@"user_current_mapto"];
}

-(IBAction)showPTEGeneralDrawer
{
    isShow  = !isShow;
    if(slidingWindow == NULL && isShow)
    {
        float  LOGO_HEIGHT = 44.0;
        slidingWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        slidingWindow.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.2];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showPTEGeneralDrawer)];
        [slidingWindow addGestureRecognizer:singleFingerTap];
        sliderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4,0,3*(SCREEN_WIDTH/4),slidingWindow.frame.size.height)];
        [sliderScroll setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        sliderScroll.showsVerticalScrollIndicator=YES;
        sliderScroll.scrollEnabled=YES;
        sliderScroll.bounces = NO;
        sliderScroll.userInteractionEnabled=YES;
        [slidingWindow addSubview:sliderScroll];
        [self.view addSubview:slidingWindow];
        
        
        UIButton * _h_btn = [[UIButton alloc]initWithFrame:CGRectMake(sliderScroll.frame.size.width-25, 10, 15, 15)];
        
        UIImage* T_img =  [UIImage imageNamed:@"PTEG_cross.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_h_btn setTintColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
        [_h_btn setImage:T_img forState:UIControlStateNormal];
        _h_btn.userInteractionEnabled = FALSE;
        [_h_btn bringSubviewToFront:self.view];
        [sliderScroll addSubview:_h_btn];
        
    
        
        UIView *  dashboardView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [dashboardView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
         UIImageView *hDash_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *dash_img = [UIImage imageNamed:@"PTEG_Dashboard.png"];
         [hDash_img setImage:dash_img];
         [dashboardView addSubview:hDash_img];
         UITapGestureRecognizer *myDashboardTap =
         [[UITapGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(MyPTEGeneralDashboardTap:)];
         [dashboardView addGestureRecognizer:myDashboardTap];

         [sliderScroll addSubview:dashboardView];

         UILabel *DashboardTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, dashboardView.frame.size.width-55, 20)];
         DashboardTxt.text = @"Dashboard";
         DashboardTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         DashboardTxt.font = TEXTTITLEFONT;
         [dashboardView addSubview:DashboardTxt];
        
         LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView *myPView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *h_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *img = [UIImage imageNamed:@"PTEG_MyProfile.png"];
        //img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [h_img setImage:img];
        //h_img.translatesAutoresizingMaskIntoConstraints = NO;
        //h_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [myPView addSubview:h_img];
        UITapGestureRecognizer *homeTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_ProfileTap:)];
        [myPView addGestureRecognizer:homeTap];

        [sliderScroll addSubview:myPView];

        UILabel *HomeTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 20)];
        HomeTxt.text = @"My Profile";
        HomeTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        HomeTxt.font = TEXTTITLEFONT;
        [myPView addSubview:HomeTxt];

        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  myPerformanceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        [myPerformanceView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *hPer_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *per_img = [UIImage imageNamed:@"PTEG_Performance.png"];
       // per_img = [per_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [hPer_img setImage:per_img];
        //hPer_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [myPerformanceView addSubview:hPer_img];
        UITapGestureRecognizer *myPerformanceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEGeneralPerformanceTap:)];
        [myPerformanceView addGestureRecognizer:myPerformanceTap];

        [sliderScroll addSubview:myPerformanceView];

        UILabel *PerformanceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 20)];
        PerformanceTxt.text = @"My Performance";
        PerformanceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        PerformanceTxt.font = TEXTTITLEFONT;
        [myPerformanceView addSubview:PerformanceTxt];
        UIView * PerformanceBorder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,myPerformanceView.frame.size.height-1, myPerformanceView.frame.size.width,1)];
        PerformanceBorder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [myPerformanceView addSubview:PerformanceBorder_Line];

        LOGO_HEIGHT = LOGO_HEIGHT + 80;
        
        
        
//        UIView *  levelView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
//        [levelView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
//        UIImageView *hlevel_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
//        UIImage *level_img = [UIImage imageNamed:@"level.png"];
//        //level_img = [level_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [hlevel_img setImage:level_img];
//        //hlevel_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        [levelView addSubview:hlevel_img];
//        UITapGestureRecognizer *levelTap =
//        [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                action:@selector(PTEG_BaseLevelSelection)];
//        [levelView addGestureRecognizer:levelTap];
//
//        [sliderScroll addSubview:levelView];
//
//        UILabel *LevelTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 20)];
//        LevelTxt.text = @"Select Level";
//        LevelTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        LevelTxt.font = TEXTTITLEFONT;
//        [levelView addSubview:LevelTxt];
//        UIView * LevelBorder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,levelView.frame.size.height-1, levelView.frame.size.width,1)];
//        LevelBorder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        [levelView addSubview:LevelBorder_Line];
//
//        LOGO_HEIGHT = LOGO_HEIGHT + 80;
//
//
//
        
        
        
        
        
        UIView *aboutTestView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        [aboutTestView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *aboutTest_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *aboutTestImg = [UIImage imageNamed:@"PTEG_AboutTest.png"];
        //aboutTestImg = [aboutTestImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [aboutTest_img setImage:aboutTestImg];
        //         aboutTest_img.translatesAutoresizingMaskIntoConstraints = NO;
        //aboutTest_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [aboutTestView addSubview:aboutTest_img];
        UITapGestureRecognizer *aboutTestTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_aboutTestTap:)];
        [aboutTestView addGestureRecognizer:aboutTestTap];
        
        [sliderScroll addSubview:aboutTestView];
        
        UILabel *aboutTestTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, aboutTestView.frame.size.width-55, 20)];
        aboutTestTxt.text = @"About the Exam";
        aboutTestTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        aboutTestTxt.font = TEXTTITLEFONT;
        [aboutTestView addSubview:aboutTestTxt];
        
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *examTipsView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [examTipsView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *examTipsImgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *examTipsImg = [UIImage imageNamed:@"PTEG_examTips.png"];
       // examTipsImg = [examTipsImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [examTipsImgV setImage:examTipsImg];
        //         examTipsImgV.translatesAutoresizingMaskIntoConstraints = NO;
        //examTipsImgV.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [examTipsView addSubview:examTipsImgV];
        UITapGestureRecognizer *examTipsTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_examTipsTap:)];
        [examTipsView addGestureRecognizer:examTipsTap];

        [sliderScroll addSubview:examTipsView];

        UILabel *examTipsTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, examTipsView.frame.size.width-55, 20)];
        examTipsTxt.text = @"Exam Tips";
        examTipsTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        examTipsTxt.font = TEXTTITLEFONT;
        [examTipsView addSubview:examTipsTxt];
//        UIView * kborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,examTipsView.frame.size.height-1, examTipsView.frame.size.width,1)];
//        kborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        [examTipsView addSubview:kborder_Line];

        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *resourceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [resourceView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *resourceViewImgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *resourceViewImg = [UIImage imageNamed:@"PTEG_Resources.png"];
        //resourceViewImg = [resourceViewImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [resourceViewImgV setImage:resourceViewImg];
        //         examTipsImgV.translatesAutoresizingMaskIntoConstraints = NO;
        //resourceViewImgV.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [resourceView addSubview:resourceViewImgV];
        UITapGestureRecognizer *resourceViewTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_resourceTap)];
        [resourceView addGestureRecognizer:resourceViewTap];
        
        [sliderScroll addSubview:resourceView];
        
        UILabel *resourceViewTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, resourceView.frame.size.width-55, 20)];
        resourceViewTxt.text = @"Resources";
        resourceViewTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        resourceViewTxt.font = TEXTTITLEFONT;
        [resourceView addSubview:resourceViewTxt];
        UIView * resourceViewborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,resourceView.frame.size.height-1, resourceView.frame.size.width,1)];
        resourceViewborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [resourceView addSubview:resourceViewborder_Line];
        
        LOGO_HEIGHT = LOGO_HEIGHT + 80;
        
        
        
        
        
        
        UIView *  faq = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        [faq setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *faq_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _faq_img = [UIImage imageNamed:@"PTEG_FAQ.png"];
        //_faq_img = [_faq_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [faq_img setImage:_faq_img];
        //        faq_img.translatesAutoresizingMaskIntoConstraints = NO;
        //faq_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [faq addSubview:faq_img];
        UITapGestureRecognizer *faqTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_FAQTap)];
        [faq addGestureRecognizer:faqTap];
        
        [sliderScroll addSubview:faq];
        UILabel *faqTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, faq.frame.size.width-55, 20)];
        faqTxt.text = @"FAQs";
        faqTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        faqTxt.font = TEXTTITLEFONT;
        [faq addSubview:faqTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView * abtus = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [abtus setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *abtus_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _abtus_img = [UIImage imageNamed:@"PTEG_Aboutus.png"];
        //_abtus_img = [_abtus_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [abtus_img setImage:_abtus_img];
        //        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        //abtus_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [abtus addSubview:abtus_img];
        UITapGestureRecognizer *abtusTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(PTEG_ABTUSTap)];
        [abtus addGestureRecognizer:abtusTap];

        [sliderScroll addSubview:abtus];
        UILabel *abtusTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, abtus.frame.size.width-55, 20)];
        abtusTxt.text = @"About Us";
        abtusTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        abtusTxt.font = TEXTTITLEFONT;
        [abtus addSubview:abtusTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        UIView * chatWithPalView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [chatWithPalView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *cwp_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _cwp_img = [UIImage imageNamed:@"PTEG_chatPal.png"];
        //_cwp_img = [_cwp_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cwp_img setImage:_cwp_img];
        //        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        cwp_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [chatWithPalView addSubview:cwp_img];
        UITapGestureRecognizer *cwpTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_ChatWithPalTap)];
        [chatWithPalView addGestureRecognizer:cwpTap];

        [sliderScroll addSubview:chatWithPalView];

        UILabel *cwpTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, chatWithPalView.frame.size.width-55, 20)];
        cwpTxt.text = @"Chat with PAL";
        cwpTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        cwpTxt.font = TEXTTITLEFONT;
        [chatWithPalView addSubview:cwpTxt];

        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        
        UIView * preferenceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [preferenceView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *prefence_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _prefence_img = [UIImage imageNamed:@"PTEG_Pref.png"];
        //_prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [prefence_img setImage:_prefence_img];
        //        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        //prefence_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [preferenceView addSubview:prefence_img];
        UITapGestureRecognizer *preferenceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_PreferenceTap)];
        [preferenceView addGestureRecognizer:preferenceTap];

        [sliderScroll addSubview:preferenceView];

        UILabel *preferenceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, preferenceView.frame.size.width-55, 20)];
        preferenceTxt.text = @"Preferences";
        preferenceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        preferenceTxt.font = TEXTTITLEFONT;
        [preferenceView addSubview:preferenceTxt];
        
//        UIView * preferenceBorder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,preferenceView.frame.size.height-1, preferenceView.frame.size.width,1)];
//        preferenceBorder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        [preferenceView addSubview:preferenceBorder_Line];
        
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView * aboutProgramView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [aboutProgramView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *aboutProgram_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _aboutProgram_img = [UIImage imageNamed:@"PTEG_AboutProgram.png"];
        //_prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [aboutProgram_img setImage:_aboutProgram_img];
        //        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
        //prefence_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [aboutProgramView addSubview:aboutProgram_img];
        UITapGestureRecognizer *aboutProgramTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_AboutProgramTap)];
        [aboutProgramView addGestureRecognizer:aboutProgramTap];
        
        [sliderScroll addSubview:aboutProgramView];
        
        UILabel *aboutProgramTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, aboutProgramView.frame.size.width-55, 20)];
        aboutProgramTxt.text = @"About the Program";
        aboutProgramTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        aboutProgramTxt.font = TEXTTITLEFONT;
        [aboutProgramView addSubview:aboutProgramTxt];
        
        UIView * aboutProgramBorder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,aboutProgramView.frame.size.height-1, aboutProgramView.frame.size.width,1)];
        aboutProgramBorder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [aboutProgramView addSubview:aboutProgramBorder_Line];
        
        
        
        LOGO_HEIGHT = LOGO_HEIGHT + 80;
        
        
        
        
        
        
        UIView * helpdesk = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        [helpdesk setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *helpdesk_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage *helpdeskimg = [UIImage imageNamed:@"PTEG_Feedback.png"];
        //helpdeskimg = [helpdeskimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [helpdesk_img setImage:helpdeskimg];
        //        helpdesk_img.translatesAutoresizingMaskIntoConstraints = NO;
        //helpdesk_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [helpdesk addSubview:helpdesk_img];
        UITapGestureRecognizer *helpdeskTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyPTEG_HELPDESKTap)];
        [helpdesk addGestureRecognizer:helpdeskTap];
        
        [sliderScroll addSubview:helpdesk];
        UILabel *helpdeskTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 20)];
        helpdeskTxt.text = @"Feedback";
        helpdeskTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        helpdeskTxt.font = TEXTTITLEFONT;
        [helpdesk addSubview:helpdeskTxt];
        
//        UIView * helpdeskborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,helpdesk.frame.size.height-1, helpdesk.frame.size.width,1)];
//        helpdeskborder_Line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        [helpdesk addSubview:helpdeskborder_Line];
        
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  logOut = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
         [logOut setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        UIImageView *logOut_img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 20, 20)];
        UIImage * _logOut_img = [UIImage imageNamed:@"PTEG_logout.png"];
        //_logOut_img = [_logOut_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [logOut_img setImage:_logOut_img];
        //        logOut_img.translatesAutoresizingMaskIntoConstraints = NO;
       // logOut_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [logOut addSubview:logOut_img];
        UITapGestureRecognizer *logOutTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyLOGOUTTap:)];
        [logOut addGestureRecognizer:logOutTap];
        
        [sliderScroll addSubview:logOut];
        UILabel *logOutTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, logOut.frame.size.width-55, 20)];
        logOutTxt.text = @"Logout";
        logOutTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        logOutTxt.font = TEXTTITLEFONT;
        [logOut addSubview:logOutTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView *  version = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        version.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [sliderScroll addSubview:version];
        UILabel *versionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, logOut.frame.size.width, 30)];
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
        NSString* currentBuildVersion = infoDictionary[@"CFBundleVersion"];
        versionLbl.text = [[NSString alloc]initWithFormat:@"V %@:%@",currentVersion,currentBuildVersion];
        versionLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        versionLbl.textAlignment = NSTextAlignmentCenter;
        versionLbl.font = HEADERSECTIONTITLEFONT;
        [version addSubview:versionLbl];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        sliderScroll.contentSize = CGSizeMake(sliderScroll.frame.size.width, LOGO_HEIGHT);
        
        CGRect basketTopFrame = slidingWindow.frame;
        basketTopFrame.origin.x = 0;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{ slidingWindow.frame = basketTopFrame;
            
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        
    }
    
}

-(void)MyPTEG_ChatWithPalTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_ChatWithPalVC"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_ChatWithPalVC class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
            UIViewController *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"ChatWithPalVC"];
            [self.navigationController pushViewController:vc animated:true];
        }
    }
    
    
    
    
}

-(void)MyPTEG_PreferenceTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_Preferences"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_Preferences class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_Preferences * prefObj = [[PTEG_Preferences alloc]initWithNibName:@"PTEG_Preferences" bundle:nil];
            [self.navigationController pushViewController:prefObj animated:TRUE];
        }
    }
    
    
    
}
-(void)MyPTEG_AboutProgramTap
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_AboutProgram"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_AboutProgram class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_AboutProgram * prefObj = [[PTEG_AboutProgram alloc]initWithNibName:@"PTEG_AboutProgram" bundle:nil];
            [self.navigationController pushViewController:prefObj animated:TRUE];
        }
    }
    
    
    
    
}
-(void)MyPTEG_resourceTap
{
   if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PTEG_RESOURCES] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
}

-(void)MyPTEG_FAQTap
{
   if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_FAQ"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_FAQ class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_FAQ * faqObj = [[PTEG_FAQ alloc]initWithNibName:@"PTEG_FAQ" bundle:nil];
            [self.navigationController pushViewController:faqObj animated:TRUE];
        }
    }
    
    
}



-(void)MyPTEGeneralDashboardTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_Dashboard"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_Dashboard class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_Dashboard * dashObj = [[PTEG_Dashboard alloc]initWithNibName:@"PTEG_Dashboard" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }
    }
    
}


-(void)MyPTEGeneralPerformanceTap:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"PTEG_MyPerformance"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[PTEG_MyPerformance class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            PTEG_MyPerformance * performanceObj = [[PTEG_MyPerformance alloc]initWithNibName:@"PTEG_MyPerformance" bundle:nil];
            [self.navigationController pushViewController:performanceObj animated:TRUE];
        }
    }
    
}

-(IBAction)showMeProDrawer
{
    isShow  = !isShow;
    if(slidingWindow == NULL && isShow)
    {
        float  LOGO_HEIGHT = STSTUSNAVIGATIONBARHEIGHT;
        slidingWindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        slidingWindow.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.2];
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showMeProDrawer)];
        [slidingWindow addGestureRecognizer:singleFingerTap];
        
        sliderScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4,0,3*(SCREEN_WIDTH/4),slidingWindow.frame.size.height)];
        [sliderScroll setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        sliderScroll.showsVerticalScrollIndicator=YES;
        sliderScroll.scrollEnabled=YES;
        sliderScroll.bounces = NO;
        sliderScroll.userInteractionEnabled=YES;
        [slidingWindow addSubview:sliderScroll];
        [self.view addSubview:slidingWindow];
        
        
        
        UIView *  upperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, sliderScroll.frame.size.width,LOGO_HEIGHT)];
        upperView.backgroundColor = [self getUIColorObjectFromHexString:DRAWERCOLOR alpha:1.0];
        
        UIImageView* logo =[[UIImageView alloc]initWithFrame:CGRectMake(5, upperView.frame.size.height-50,40 ,40)];
        logo.layer.cornerRadius = logo.frame.size.width/2;
        logo.clipsToBounds = YES;
        
        
        UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        logo.image = image;
        NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                UIImage * _img = [UIImage imageWithData:data];
                if(_img != NULL)
                {
                    logo.image = _img;
                    [appDelegate setUserDefaultData:data :imageUrl];
                }
                else
                {
                    // userImg.image = _img;
                }
                
            }];
        }
        else
        {
            logo.image = Limg;
        }
        
        logo.contentMode = UIViewContentModeScaleAspectFill;
        [upperView addSubview:logo];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(50, upperView.frame.size.height-50, upperView.frame.size.width-55,40)];
        name.text = [[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME] uppercaseString];
        name.textColor = [UIColor whiteColor];
        name.font = TEXTTITLEFONT;
        [upperView addSubview:name];
        [sliderScroll addSubview:upperView];
        
        //LOGO_HEIGHT = LOGO_HEIGHT-20;
        
        
        
        if(appDelegate.isShowDashboard){
        
        UIView * dashbordTabView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        UIImageView *dashbordTab_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *img = [UIImage imageNamed:@"MePro_DA.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [dashbordTab_img setImage:img];
        [dashbordTabView addSubview:dashbordTab_img];
        
        UITapGestureRecognizer *myPerformanceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(loadMyDashboardVC:)];
        [dashbordTabView addGestureRecognizer:myPerformanceTap];
        
        [sliderScroll addSubview:dashbordTabView];
        
        UILabel *dashbordTabTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, dashbordTabView.frame.size.width-55, 30)];
        dashbordTabTxt.text = @"Dashboard";
        
        if ([NSStringFromClass([self class]) isEqualToString:@"MeProDashboard"] )
        {
          
           dashbordTab_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           dashbordTabTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           dashbordTabView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
           
             dashbordTab_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
             dashbordTabTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             dashbordTabView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        
        dashbordTabTxt.font = TEXTTITLEFONT;
        [dashbordTabView addSubview:dashbordTabTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *moduleView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        UIImageView *module_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *moduleimg = [UIImage imageNamed:@"MePro_M.png"];
        moduleimg = [moduleimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [module_img setImage:moduleimg];
        module_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [moduleView addSubview:module_img];
        UITapGestureRecognizer *moduleTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(loadMyModulesVC:)];
        [moduleView addGestureRecognizer:moduleTap];
        [sliderScroll addSubview:moduleView];
        UILabel *moduleTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, moduleView.frame.size.width-55, 30)];
        moduleTxt.text = @"Learning Module";
        if ([NSStringFromClass([self class]) isEqualToString:@"MeProModules"] )
        {
          
           module_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           moduleTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           moduleView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
           
             module_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
             moduleTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             moduleView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        
        moduleTxt.font = TEXTTITLEFONT;
        [moduleView addSubview:moduleTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        
        
        UIView *performanceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        UIImageView *performance_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *performanceImg = [UIImage imageNamed:@"MePro_P.png"];
        performanceImg = [performanceImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [performance_img setImage:performanceImg];
        //         aboutTest_img.translatesAutoresizingMaskIntoConstraints = NO;
        performance_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [performanceView addSubview:performance_img];
        UITapGestureRecognizer *performanceTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(loadMyPerformanceVC:)];
        [performanceView addGestureRecognizer:performanceTap];
        
        [sliderScroll addSubview:performanceView];
        
        UILabel *performanceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, performanceView.frame.size.width-55, 30)];
        performanceTxt.text = @"My Performance";
       
        if([NSStringFromClass([self class]) isEqualToString:@"MeProMyPerformance"] )
        {
          
           performance_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           performanceTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           performanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
           
             performance_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
             performanceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             performanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        performanceTxt.font = TEXTTITLEFONT;
        [performanceView addSubview:performanceTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
            
            
            
         UIView *allProductView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            UIImageView *allProduct_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage *allProductimg = [UIImage imageNamed:@"MePro_M.png"];
            allProductimg = [allProductimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [allProduct_img setImage:allProductimg];
            allProduct_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [allProductView addSubview:allProduct_img];
            UITapGestureRecognizer *allProductTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(loadMyProdctdVC:)];
            [allProductView addGestureRecognizer:allProductTap];
            [sliderScroll addSubview:allProductView];
            UILabel *allProductTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, allProductView.frame.size.width-55, 30)];
            allProductTxt.text = @"All Product";
            if ([NSStringFromClass([self class]) isEqualToString:@"MePro_Product"] )
            {
              
               allProduct_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               allProductTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               allProductView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
            }
            else
            {
               
                 allProduct_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
                 allProductTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 allProductView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            }
            
            allProductTxt.font = TEXTTITLEFONT;
            [allProductView addSubview:allProductTxt];
            LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        UIView *liveSessionView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        UIImageView *liveSessionImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *liveSessionImg = [UIImage imageNamed:@"MePro_LS.png"];
        liveSessionImg = [liveSessionImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [liveSessionImgV setImage:liveSessionImg];
        liveSessionImgV.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [liveSessionView addSubview:liveSessionImgV];
        UITapGestureRecognizer *liveSessionTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(showLiveClassView:)];
        [liveSessionView addGestureRecognizer:liveSessionTap];
        
        [sliderScroll addSubview:liveSessionView];
        
        UILabel *liveSessionTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, liveSessionView.frame.size.width-55, 30)];
       liveSessionTxt.text = @"Live Session";
        
        if([NSStringFromClass([self class]) isEqualToString:@"Activity"] )
        {
          
           liveSessionImgV.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           liveSessionTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
           liveSessionView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
           
             liveSessionImgV.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
             liveSessionTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             liveSessionView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        
        liveSessionTxt.font = TEXTTITLEFONT;
        [liveSessionView addSubview:liveSessionTxt];

        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        }
        else
        {
            
            
            
            UIView *moduleView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            UIImageView *module_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage *moduleimg = [UIImage imageNamed:@"MePro_M.png"];
            moduleimg = [moduleimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [module_img setImage:moduleimg];
            module_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [moduleView addSubview:module_img];
            UITapGestureRecognizer *moduleTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(loadMyAcadmicModulesVC:)];
            [moduleView addGestureRecognizer:moduleTap];
            [sliderScroll addSubview:moduleView];
            UILabel *moduleTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, moduleView.frame.size.width-55, 30)];
            moduleTxt.text = @"Practice";
            if ([NSStringFromClass([self class]) isEqualToString:@"MeProAcadmic_Module"] )
            {
              
               module_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               moduleTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               moduleView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
            }
            else
            {
               
                 module_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
                 moduleTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 moduleView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            }
            
            moduleTxt.font = TEXTTITLEFONT;
            [moduleView addSubview:moduleTxt];
            LOGO_HEIGHT = LOGO_HEIGHT + 60;
            
            
            
            UIView *performanceView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
             UIImageView *performance_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
             UIImage *performanceImg = [UIImage imageNamed:@"MePro_P.png"];
             performanceImg = [performanceImg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
             [performance_img setImage:performanceImg];
             //         aboutTest_img.translatesAutoresizingMaskIntoConstraints = NO;
             performance_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             [performanceView addSubview:performance_img];
             UITapGestureRecognizer *performanceTap =
             [[UITapGestureRecognizer alloc] initWithTarget:self
                                                     action:@selector(loadMyPerformanceVC:)];
             [performanceView addGestureRecognizer:performanceTap];
             
             [sliderScroll addSubview:performanceView];
             
             UILabel *performanceTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, performanceView.frame.size.width-55, 30)];
             performanceTxt.text = @"My Performance";
            
             if([NSStringFromClass([self class]) isEqualToString:@"MeProMyPerformance"] )
             {
               
                performance_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
                performanceTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
                performanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
             }
             else
             {
                
                  performance_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
                  performanceTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                  performanceView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
             }
             performanceTxt.font = TEXTTITLEFONT;
             [performanceView addSubview:performanceTxt];
             LOGO_HEIGHT = LOGO_HEIGHT + 60;
            
            
            
            
            
            
            UIView *allProductView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
            UIImageView *allProduct_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
            UIImage *allProductimg = [UIImage imageNamed:@"MePro_M.png"];
            allProductimg = [allProductimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [allProduct_img setImage:allProductimg];
            allProduct_img.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [allProductView addSubview:allProduct_img];
            UITapGestureRecognizer *allProductTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(loadMyProdctdVC:)];
            [allProductView addGestureRecognizer:allProductTap];
            [sliderScroll addSubview:allProductView];
            UILabel *allProductTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, allProductView.frame.size.width-55, 30)];
            allProductTxt.text = @"All Product";
            if ([NSStringFromClass([self class]) isEqualToString:@"MePro_Product"] )
            {
              
               allProduct_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               allProductTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
               allProductView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
            }
            else
            {
               
                 allProduct_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
                 allProductTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 allProductView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            }
            
            allProductTxt.font = TEXTTITLEFONT;
            [allProductView addSubview:allProductTxt];
            LOGO_HEIGHT = LOGO_HEIGHT + 60;
            
            
            
            
            
        }
        
        UIView * myPView = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *h_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage *himg = [UIImage imageNamed:@"drawer-myprofile.png"];
        himg = [himg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [h_img setImage:himg];
        h_img.translatesAutoresizingMaskIntoConstraints = NO;
        [myPView addSubview:h_img];
        UITapGestureRecognizer *homeTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyProfileTap:)];
        [myPView addGestureRecognizer:homeTap];
        
        [sliderScroll addSubview:myPView];
        
        UILabel *HomeTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        HomeTxt.text = @"My Profile";
        if([NSStringFromClass([self class]) isEqualToString:@"MyAccountScreen"] )
        {
         
          h_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
          HomeTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
          myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
          
            h_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
            HomeTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            myPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        HomeTxt.font = TEXTTITLEFONT;
        [myPView addSubview:HomeTxt];
        
//        UIView * borderLine = [[UIView alloc]initWithFrame:CGRectMake(0,myPView.frame.size.height-1, myPView.frame.size.width,1)];
//        borderLine.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
//        [myPView addSubview:borderLine];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
//        UIView * meproAssignment = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
//        meproAssignment.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UIImageView *meproAssignment_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
//        UIImage * _meproAssignment_img = [UIImage imageNamed:@"assignment_drawer.png"];
//        _meproAssignment_img = [_meproAssignment_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [meproAssignment_img setImage:_meproAssignment_img];
//        meproAssignment_img.translatesAutoresizingMaskIntoConstraints = NO;
//        [meproAssignment addSubview:meproAssignment_img];
//        UITapGestureRecognizer *meproAssignmentTap =
//        [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                action:@selector(MyAssignmentTap)];
//        [meproAssignment addGestureRecognizer:meproAssignmentTap];
//
//        [sliderScroll addSubview:meproAssignment];
//        UILabel *meproAssignmentTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, meproAssignment.frame.size.width-55, 30)];
//        meproAssignmentTxt.text = @"Assignment";
//        if([NSStringFromClass([self class]) isEqualToString:@"FAQ"] )
//        {
//
//          meproAssignment_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//          meproAssignmentTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//          meproAssignment.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
//        }
//        else
//        {
//
//            meproAssignment_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
//            meproAssignmentTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            meproAssignment.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        }
//        meproAssignmentTxt.font = TEXTTITLEFONT;
//        [meproAssignment addSubview:meproAssignmentTxt];
//        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
//        UIView * abtus = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
//        abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        UIImageView *abtus_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
//        UIImage * _abtus_img = [UIImage imageNamed:@"WileyTurkeyabout-us.png"];
//        _abtus_img = [_abtus_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [abtus_img setImage:_abtus_img];
//        abtus_img.translatesAutoresizingMaskIntoConstraints = NO;
//        [abtus addSubview:abtus_img];
//        UITapGestureRecognizer *abtusTap =
//        [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                action:@selector(MyABTUSTap:)];
//        [abtus addGestureRecognizer:abtusTap];
//
//        [sliderScroll addSubview:abtus];
//        UILabel *abtusTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, abtus.frame.size.width-55, 30)];
//        abtusTxt.text = @"About Us";
//        if([NSStringFromClass([self class]) isEqualToString:@"aboutUS"] )
//        {
//
//          abtus_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//          abtusTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
//          abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
//        }
//        else
//        {
//
//            abtus_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
//            abtusTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            abtus.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//        }
//        abtusTxt.font = TEXTTITLEFONT;
//        [abtus addSubview:abtusTxt];
//        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView * helpdesk = [[UIView alloc]initWithFrame:CGRectMake(0,LOGO_HEIGHT, sliderScroll.frame.size.width,60)];
        helpdesk.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *helpdesk_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40, 40)];
        UIImage *helpdeskimg = [UIImage imageNamed:@"drawer-helpdesk.png"];
        helpdeskimg = [helpdeskimg imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [helpdesk_img setImage:helpdeskimg];
        helpdesk_img.translatesAutoresizingMaskIntoConstraints = NO;
        [helpdesk addSubview:helpdesk_img];
        UITapGestureRecognizer *helpdeskTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyMeProHELPDESKTap:)];
        [helpdesk addGestureRecognizer:helpdeskTap];
        [sliderScroll addSubview:helpdesk];
        UILabel *helpdeskTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, myPView.frame.size.width-55, 30)];
        helpdeskTxt.text = @"Support";
        if([NSStringFromClass([self class]) isEqualToString:@"FeedbackViewController"] )
        {
         
          helpdesk_img.tintColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
          helpdeskTxt.textColor = [self getUIColorObjectFromHexString:@"#1b486d" alpha:1.0];
          helpdesk.backgroundColor = [self getUIColorObjectFromHexString:@"#336187" alpha:0.08];
        }
        else
        {
          
            helpdesk_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
            helpdeskTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            helpdesk.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        
        helpdeskTxt.font = TEXTTITLEFONT;
        [helpdesk addSubview:helpdeskTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        
        
        
        
        
        //LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        UIView * logOut = [[UIView alloc]initWithFrame:CGRectMake(0,sliderScroll.frame.size.height-60, sliderScroll.frame.size.width,60)];
        logOut.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        UIImageView *logOut_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        UIImage * _logOut_img = [UIImage imageNamed:@"drawer-logout.png"];
        _logOut_img = [_logOut_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [logOut_img setImage:_logOut_img];
        logOut_img.translatesAutoresizingMaskIntoConstraints = NO;
        [logOut addSubview:logOut_img];
        UITapGestureRecognizer *logOutTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(MyLOGOUTTap:)];
        [logOut addGestureRecognizer:logOutTap];
        
        [sliderScroll addSubview:logOut];
        UILabel *logOutTxt = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, logOut.frame.size.width-55, 30)];
        logOutTxt.text = @"Logout";
        logOut_img.tintColor = [self getUIColorObjectFromHexString:@"#c7c7c7" alpha:1.0];
        logOutTxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        logOut.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        logOutTxt.font = TEXTTITLEFONT;
        [logOut addSubview:logOutTxt];
        LOGO_HEIGHT = LOGO_HEIGHT + 60;
        
        
        sliderScroll.contentSize = CGSizeMake(sliderScroll.frame.size.width, LOGO_HEIGHT);
        CGRect basketTopFrame = slidingWindow.frame;
        basketTopFrame.origin.x = 0;
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{ slidingWindow.frame = basketTopFrame;
            
        } completion:^(BOOL finished){
            
        }];
    }
    else
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        
    }
    
}
-(void)loadMyProdctdVC :(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    if(![NSStringFromClass([self class]) isEqualToString:@"MePro_Product"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MePro_Products class]]){
                flag = FALSE;
                MePro_Products * meProObj = (MePro_Products *)viewCObj;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MePro_Products * dashObj = [[MePro_Products alloc]initWithNibName:@"MePro_Products" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }

    }
}
-(void)loadMyDashboardVC:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    if(![NSStringFromClass([self class]) isEqualToString:@"MeProDashboard"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProDashboard class]]){
                flag = FALSE;
                MeProDashboard * meProObj = (MeProDashboard *)viewCObj;
                meProObj.isFlowContinue = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MeProDashboard * dashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }

    }
}
-(void)loadMyModulesVC:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"MeProModules"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProModules class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MeProModules * dashObj = [[MeProModules alloc]initWithNibName:@"MeProModules" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }
    }
}

-(void)loadMyAcadmicModulesVC:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"MeProAcadmic_Module"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProAcadmic_Module class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MeProAcadmic_Module * dashObj = [[MeProAcadmic_Module alloc]initWithNibName:@"MeProAcadmic_Module" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }
    }
}

-(void)loadMyPerformanceVC:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    if(![NSStringFromClass([self class]) isEqualToString:@"MeProMyPerformance"] )
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProMyPerformance class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MeProMyPerformance * dashObj = [[MeProMyPerformance alloc]initWithNibName:@"MeProMyPerformance" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }
    }
}
-(void)showLiveClassView:(id)sender
{
    if(slidingWindow != NULL && isShow)
    {
        [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
        [homeView setUserInteractionEnabled:TRUE];
        [slidingWindow removeFromSuperview];
        slidingWindow = NULL;
        isShow = FALSE;
    }
    
    if(![appDelegate isNetworkAvailable])
    {
        UIAlertView * netAlert = [[UIAlertView alloc]initWithTitle:@"Can't Connect" message:@"Check your internet connection and try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [netAlert show];
        return;
    }
    else
    {
        BOOL flag = TRUE;
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProActivity class]]){
                flag = FALSE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            }
        }
        if(flag)
        {
            MeProActivity * dashObj = [[MeProActivity alloc]initWithNibName:@"MeProActivity" bundle:nil];
            [self.navigationController pushViewController:dashObj animated:TRUE];
        }
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)PTEG_BaseLevelSelection
{
    if(slidingWindow != NULL && isShow)
       {
           [homeView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
           [homeView setUserInteractionEnabled:TRUE];
           [slidingWindow removeFromSuperview];
           slidingWindow = NULL;
           isShow = FALSE;
       }
    
    PTEG_LevelSelection * pteDashObj = [[PTEG_LevelSelection alloc]initWithNibName:@"PTEG_LevelSelection" bundle:nil];
    [self.navigationController pushViewController:pteDashObj animated:YES];
}

-(int)getLevelType:(NSString *)currentlevel
{
    if(appDelegate.master_mode == 1)
    {
        return enum_down_level;
    }
    else
    {
        if([currentlevel intValue] == [appDelegate.GSE_level intValue]) return enum_original_level;
        else if([currentlevel intValue] > [appDelegate.GSE_level intValue]) return enum_up_level;
        else return enum_down_level;
        
    }
    
}
@end
