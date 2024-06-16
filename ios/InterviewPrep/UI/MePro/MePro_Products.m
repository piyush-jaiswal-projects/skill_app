//
//  MePro_Products.m
//  InterviewPrep
//
//  Created by Amit Gupta on 22/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Products.h"
#import "MeProDashboard.h"
#import "MeProWelcome.h"
#import "MeProAcadmic_Module.h"

#define SERVICE_GETPRODUCTLIST @"productList"
@interface MePro_Products ()
{
    UIScrollView *bgView;
    NSArray * courseArr;
    
}

@end


@implementation MePro_Products

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    //appDelegate.allowRotation = TRUE;
//    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
//    [UINavigationController attemptRotationToDeviceOrientation];
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,STSTUSNAVIGATIONBARHEIGHT)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [self.view addSubview:bar];
    
//    title= [[UILabel alloc]initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH-100, 20)];
//    title.text = @"Courses";
//    title.textAlignment = NSTextAlignmentCenter;
//    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
//    [self.view addSubview:title];
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    bgView.showsVerticalScrollIndicator=YES;
    bgView.contentInsetAdjustmentBehavior = YES;
    [bgView setScrollEnabled:YES];
    [bgView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgView setShowsHorizontalScrollIndicator:NO];
    [bgView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgView];
    
    
    UIImageView * imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width,150)];
    imgBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    imgBg.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imgBg];
    
    
    UILabel * lblProduct = [[UILabel alloc]initWithFrame:CGRectMake(10,100 ,imgBg.frame.size.width-35, 20)];
    lblProduct.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lblProduct.font = BOLDTEXTTITLEFONT;
    lblProduct.textAlignment = NSTextAlignmentLeft;
    lblProduct.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lblProduct.text = @"My Courses";
    [imgBg addSubview:lblProduct];
    
    
    UIView * curveView = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH,40)];
    curveView.layer.borderWidth = 1.0;
    curveView.layer.cornerRadius = 20;
    curveView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0].CGColor;
    curveView.layer.masksToBounds=YES;
    curveView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [imgBg addSubview:curveView];
    
    courseArr = (NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:[appDelegate getUserDefaultData:@"pearson_product_list"]];
    
    
    if(courseArr != NULL && [courseArr count]>0){
        [self DrawDashBoardUI];
    }
    else
    {
            [self showGlobalProgress];
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        
            [data setObject:APPVERSION forKey:JSON_APPVERSION];
            [data setObject:@"iOS" forKey:JSON_PLATFORM];
            [data setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [data setObject:CLIENT forKey:JSON_CLIENT];
            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
            [reqObj setValue:JSON_GETPRODUCT forKey:JSON_DECREE ];
            [reqObj setValue:data forKey:JSON_PARAM ];
        
            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_GETPRODUCTLIST forKey:@"SERVICE"];
            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    }

    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readProductScreenResponse:)
        name:SERVICE_GETPRODUCTLIST
      object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readProductScreenResponse:)
        name:SERVICE_GETPACKAGEINFO
      object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readProductScreenResponse:)
        name:SERVICE_LTISCORE
      object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(readProductScreenResponse:)
                                                    name:SERVICE_UPDATETOKEN_LOCAL
                                                  object:nil];
    
    
    
    
    
}

-(void)DrawDashBoardUI
{
    for (UIView *obj  in [bgView subviews] ) {
        [obj removeFromSuperview];
    }
    
    UIImageView * imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, bgView.frame.size.width,150)];
    imgBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    imgBg.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imgBg];
    
    
    UIImageView *  logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,120,80)];
    logo.image = [UIImage imageNamed:LOGO];
    //logo.backgroundColor = [UIColor redColor];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [imgBg addSubview:logo];
    
    
    UILabel * lblProduct = [[UILabel alloc]initWithFrame:CGRectMake(10,100 ,imgBg.frame.size.width-35, 20)];
    lblProduct.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lblProduct.font = BOLDTEXTTITLEFONT;
    lblProduct.textAlignment = NSTextAlignmentLeft;
    lblProduct.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lblProduct.text = @"My Courses";
    
    [imgBg addSubview:lblProduct];
    
    UIView * curveView = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH,40)];
       curveView.layer.borderWidth = 1.0;
       curveView.layer.cornerRadius = 20;
       curveView.layer.borderColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor;
       curveView.layer.masksToBounds=YES;
       curveView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
       [imgBg addSubview:curveView];
    
    int i = 0;
    int height = 0;
    for (NSDictionary *courseObj  in courseArr) {
         height =  120+(i*(((SCREEN_WIDTH-10)*.560)+55));
        
        UIView * beginerImg  = [[UIView alloc]initWithFrame:CGRectMake(5,height,SCREEN_WIDTH-10 ,((SCREEN_WIDTH-10)*.560)+45)];
        
        NSLog(@"%f",SCREEN_WIDTH-10);
        beginerImg.tag = i;
        UIImageView * beg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, beginerImg.frame.size.width,(beginerImg.frame.size.width)*.560)];
        
        NSString *imageUrl =[courseObj valueForKey:@"thumbnail"];
        UIImage *Limg = NULL;
        Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
        if(Limg == NULL ){
         beg.image = [UIImage imageNamed:@"malayalm.png"];
         NSURL * imgUrl = [NSURL URLWithString:imageUrl];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                beg.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
                
                beg.image = [UIImage imageNamed:@"malayalm.png"];
            }
            
        }];
        }
        else
        {
            beg.image = Limg;
        }
        beg.contentMode = UIViewContentModeScaleAspectFit;
        [beginerImg addSubview:beg];
        
        
        int localH = ((SCREEN_WIDTH-10)*.560);
        UILabel * lblbeg = [[UILabel alloc]initWithFrame:CGRectMake(20,localH , beginerImg.frame.size.width-35, 40)];
        lblbeg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lblbeg.font = BOLDTEXTTITLEFONT;
        [appDelegate setTextHTMLLabel:lblbeg:[[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:@"product_name"]]];
        
        [beginerImg addSubview:lblbeg];
        
//        localH = localH + 20;
//        UILabel * lblbegdesc = [[UILabel alloc]initWithFrame:CGRectMake(13,localH , beginerImg.frame.size.width-35, 40)];
//        lblbegdesc.text = [[NSMutableString alloc]initWithFormat:@"%@",@""];
//        //[courseObj valueForKey:@"product_desc"]
//        lblbegdesc.numberOfLines = 2;
//        lblbegdesc.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
//        lblbegdesc.font = SUBTEXTTILEFONT;
//        [beginerImg addSubview:lblbegdesc];
//
////        if([[courseObj valueForKey:HTML_JSON_KEY_ACTION]intValue] == 2){
////            UIImageView * theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(beginerImg.frame.size.width - 40, beginerImg.frame.size.height-40, 40, 40)];
////            theImageView.image = [UIImage imageNamed:@"update.png"];
////            [beginerImg addSubview:theImageView];
////        }
        beginerImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [bgView addSubview:beginerImg];
        
        beginerImg.layer.borderWidth = 1.0;
        beginerImg.layer.cornerRadius = 20;
        beginerImg.layer.borderColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0].CGColor;
        beginerImg.layer.masksToBounds=YES;
        
        UITapGestureRecognizer *wileyBegTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickBegin:)];
        wileyBegTouch.numberOfTapsRequired = 1;
        [beginerImg addGestureRecognizer:wileyBegTouch];
        i++;
    }
    bgView.contentSize = CGSizeMake(SCREEN_WIDTH, 140+((courseArr.count)*(((SCREEN_WIDTH-10)*.560)+55)));
    
    
}
- (void)ClickBegin:(id)sender{
    UITapGestureRecognizer *wileyBegTouch = (UITapGestureRecognizer *)sender;
    UIView * touchView = wileyBegTouch.view;
    NSDictionary * selectedproduct = [courseArr objectAtIndex:touchView.tag];
     appDelegate.workingCourseObj = NULL;
//    if([[selectedproduct valueForKey:@"is_purchased"]intValue] == 0)
//    {
//          UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Sorry"
//                             message:@"you didn't purchanse any product yet!\nPlease contact to Admin"
//                             preferredStyle:UIAlertControllerStyleAlert];
//
//
//                [self presentViewController:alert animated:YES completion:nil];
//                int duration = 4; // duration in seconds
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [alert dismissViewControllerAnimated:YES completion:nil];
//                });
//    }
//    else
//    {
        appDelegate.coursePack = [selectedproduct valueForKey:@"package_code"];
        appDelegate.product_id = [selectedproduct valueForKey:@"product_id"];
        appDelegate.product_name = [selectedproduct valueForKey:@"product_name"];
        appDelegate.isEnableLTITest = [[selectedproduct valueForKey:@"is_show_lti"] boolValue];
        appDelegate.isShowDashboard = [[selectedproduct valueForKey:@"is_show_dashboard"]boolValue];
        [appDelegate deleteUserDefaultData:@"product_bookmark"];
        [appDelegate setUserDefaultData:[NSKeyedArchiver archivedDataWithRootObject:selectedproduct]:@"product_bookmark"];
        
        if([appDelegate.engineObj coursePackExistorNot:appDelegate.coursePack])
        {

            [self showGlobalProgress];
            NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
            [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
            [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
            [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
            [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
            [ldict setObject:CLIENT forKey:JSON_CLIENT];
            [ldict setObject:appDelegate.product_id forKey:@"product_id"];

            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
            [reqObj setValue:ldict forKey:JSON_PARAM];
            [reqObj setValue: JSON_PRODUCTINFO_DECREE forKey:JSON_DECREE];
            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];

            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
            [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
            [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];

            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            
        }
        else
        {
            if(appDelegate.isEnableLTITest)
            {

                [self updateToken];
                
            }
            else if (appDelegate.isShowDashboard)
            {
               MeProDashboard * meproDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
                [self.navigationController pushViewController:meproDashObj animated:YES];
                                
            }
            else if(!appDelegate.isShowDashboard)
            {
                
                 MeProAcadmic_Module * dashObj = [[MeProAcadmic_Module alloc]initWithNibName:@"MeProAcadmic_Module" bundle:nil];
                [self.navigationController pushViewController:dashObj animated:TRUE];
            }
       }
   // }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_GETPRODUCTLIST object:nil];
    [center removeObserver:self name:SERVICE_GETPACKAGEINFO object:nil];
    [center removeObserver:self name:SERVICE_LTISCORE object:nil];
    [center removeObserver:self name:SERVICE_UPDATETOKEN_LOCAL object:nil];
    
    
    
}
-(void)updateToken
{
    [self showGlobalProgress];
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
- (void)readProductScreenResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPRODUCTLIST])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                courseArr = [temp valueForKey:JSON_RETVAL];
                if(courseArr != NULL && [courseArr count] >0)
                {
                    [appDelegate setUserDefaultData:[NSKeyedArchiver archivedDataWithRootObject:courseArr] :@"pearson_product_list"];
                    [self DrawDashBoardUI];
                }
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_UPDATETOKEN_LOCAL])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    [self updateUserTokenAndMode:resUserData];
                    
                    [self showGlobalProgress];
                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
                    [reqObj setValue:JSON_LTISCORE forKey:JSON_DECREE ];
                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                    [_reqObj setValue:SERVICE_LTISCORE forKey:@"SERVICE"];
                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                    
                    
                }
                
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETPACKAGEINFO])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
                    NSMutableArray * productArr = [[NSMutableArray alloc]init];
                    if(packArr != NULL && [packArr count] >0){
                        //appDelegate.coursePack = [[notification object]valueForKey:@"package_code"];
                        //[_reqObj setValue:[alertView textFieldAtIndex:0].text forKey:@"package_code"];
                        [appDelegate.engineObj.dataMngntObj updateCoursePackData:packArr];
                        if(appDelegate.isEnableLTITest)
                        {
                            [self updateToken];
                        }
                        else if (appDelegate.isShowDashboard)
                        {
                           MeProDashboard * meproDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
                            [self.navigationController pushViewController:meproDashObj animated:YES];
                        }
                        else if(!appDelegate.isShowDashboard)
                        {
                          MeProAcadmic_Module * dashObj = [[MeProAcadmic_Module alloc]initWithNibName:@"MeProAcadmic_Module" bundle:nil];
                          [self.navigationController pushViewController:dashObj animated:TRUE];
                        }
                        
                    }
                }
            }
            else
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
//                    UIAlertController * alert = [UIAlertController
//                                                 alertControllerWithTitle:@""
//                                                 message: [resUserData valueForKey:@"msg"]
//                                                 preferredStyle:UIAlertControllerStyleAlert];
//
//
//                    [self presentViewController:alert animated:YES completion:nil];
//
//
//
//                    int duration = 2; // duration in seconds
//
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                        [alert dismissViewControllerAnimated:YES completion:nil];
//                    });
//                    return;
                    
//                    [self showGlobalProgress];
//                    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//                    [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
//                    [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
//                    [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//                    [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
//                    [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//                    [ldict setObject:CLIENT forKey:JSON_CLIENT];
//
//                    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
//                    [reqObj setValue:ldict forKey:JSON_PARAM];
//                    [reqObj setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
//                    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//
//                    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//                    [_reqObj setValue:SERVICE_GETPACKAGEINFO forKey:@"SERVICE"];
//                    [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];
//
//                    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                    
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
                    
                    
                    
                    
                    
                }
                else
                {
                    
                    MeProWelcome * meprowelObj = [[MeProWelcome alloc]initWithNibName:@"MeProWelcome" bundle:nil];
                    [self.navigationController pushViewController:meprowelObj animated:YES];
                    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
