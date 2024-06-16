//
//  Dashboard.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 15/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "DashboardGraph.h"

#import <QuartzCore/QuartzCore.h>
#import "URL_Macro.h"
#import "ScenarioPracticeModule.h"

@interface DashboardGraph ()
{
    NSString * imgName;
    NSString * CurrentChapter;
    // UIActivityIndicatorView *activityIndicator;
}
@end

@implementation DashboardGraph

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    currentSeesion = NULL;
    [navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [nativeViewUpper setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [nativeViewLower setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    [webView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    CurrentChapter = [appDelegate.langObj get:@"CURRENT_CHAP_NA" alter:@"Current Chapter not available."];
    webView.backgroundColor = [UIColor clearColor];
    webView.layer.masksToBounds = YES;
    webView.opaque = NO;
    [WebViewJavascriptBridge enableLogging];
    webView.scrollView.scrollEnabled = NO;
    webView.scrollView.bounces = NO;
    webView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    super.bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString * returnJsonString = EMPTYSTRING;
        NSString * dataStr = (NSString *)data;
        NSError  *error;
        NSData *rawData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:rawData options:kNilOptions error:&error];
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_CURRENT])
        {
            responseCallback(CurrentChapter);
        }
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_MSG])
        {
//            returnJsonString = [appDelegate getMessageNSString:[[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY]intValue ]];
            responseCallback(returnJsonString);
        }
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DRAWDATA])
        {
            returnJsonString = [appDelegate.engineObj getDashboardData :appDelegate.coursePack];
            NSLog(@"data %@", returnJsonString);
            responseCallback(returnJsonString);
        }
        if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_SCNARIO])
        {
            NSError  *error1;
            NSData *rawData1 = [[jsonResponse valueForKey:HTML_JSON_KEY_DATAKEY] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponse1 = [NSJSONSerialization JSONObjectWithData:rawData1 options:kNilOptions error:&error1];
            NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse1 valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE]];
            NSString * zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
            if([zipName isEqualToString:@""])
            {
                responseCallback(@"");
                return ;
            }
            if(![appDelegate checkZipPath:zipName])
            {
                [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
            }
            else
            {
                ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                scnPModule.ScnEdgeId = [[currentSeesion valueForKey:HTML_JSON_KEY_UID] intValue];
                scnPModule.ScnType = [[jsonResponse1 valueForKey:HTML_JSON_KEY_TYPE] intValue];
                //scnPModule.titleName = [jsonResponse1 valueForKey:HTML_JSON_KEY_NAME];
                [self.navigationController pushViewController:scnPModule animated:YES];
            }
            
            
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DASHBOARD])
        {
            if(currentSeesion == nil )
            {
                [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
            }
            else
            {
              NSFileManager *fileManager = [[NSFileManager alloc] init];
                
                NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectoryPath = [documentPaths objectAtIndex:0];
                if([[currentSeesion valueForKey:DATABASE_SCENARIO_DATA] isEqualToString:@""])
                {
                    [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
                }
                else
                {
                    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[currentSeesion valueForKey:DATABASE_SCENARIO_DATA]];
                    
                    BOOL fileExists = [fileManager fileExistsAtPath:path];
                    
                    if (fileExists)
                    {
                        ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                         scnPModule.ScnEdgeId = [[currentSeesion valueForKey:DATABASE_SCENARIO_EDGEID] intValue];
                         scnPModule.ScnType = [[currentSeesion valueForKey:DATABASE_SCENARIO_SCATTYPE] intValue];
                        //scnPModule.titleName = [currentSeesion valueForKey:DATABASE_SCENARIO_NAME];
                        
                                       [self.navigationController pushViewController:scnPModule animated:YES];
                        
                    }
                    else
                    {
                        [appDelegate gotoNextController:self controllerType:enum_catelogControoler sendingObj:nil];
                    }
                }
                
                
                
            }
        }
        else if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:HTML_JSON_KEY_DOWNLOAD])
        {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
               NSDictionary * reportObj = [appDelegate.engineObj getAssessmentReportUrl:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSURL *url = [NSURL URLWithString:[[NSString alloc]initWithFormat:@"%@%@",AUDRO_ADDTION,[reportObj valueForKey:@"report_url"]]];
                        
                        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
                        }else{
                            // Fallback on earlier versions
                            [[UIApplication sharedApplication] openURL:url];
                        }
                        
                    });
            });
            NSLog(@"Download User Report");
        }
     }];
    
    [super loadExamplePage:webView screen:DASHBOARDSCREENPATHNEW];
}


- (void)webViewDidStartLoad:(UIWebView *)webView1
{
    [self showGlobalProgress];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView1
{
    [self hideGlobalProgress];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [webView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    [super loadExamplePage:webView screen:DASHBOARDSCREENPATHNEW];
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectZero];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = [UIFont boldSystemFontOfSize:16.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = [appDelegate.engineObj getCourseName];
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [lbl sizeToFit];
    navBar.topItem.titleView = lbl;
    navBar.topItem.leftBarButtonItem.tintColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];;
    navBar.topItem.rightBarButtonItem.tintColor =[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [CurrentSeesionText setText:[appDelegate.langObj get:@"CURRENT_CHAP" alter:@"Current Session"]];
    NSString *Value = [appDelegate getUserDefaultData:[[NSString alloc] initWithFormat:@"%@%@",appDelegate.courseCode,appDelegate.coursePack]];
    appDelegate.chapterId = Value;
    currentSeesion = [appDelegate.engineObj getCurrentSession:Value];
    
    if(currentSeesion != NULL)
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [documentPaths objectAtIndex:0];
        if([[currentSeesion valueForKey:DATABASE_SCENARIO_DATA] isEqualToString:@""])
        {
            CurrentChapter =[appDelegate.langObj get:@"CURRENT_CHAP_NA" alter:@"Current Chapter not available."];
            //currentSeesion = @"Currnet Chapter not available";
            [CurrentSeesion setText:@""];
        }
        else
        {
            NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[currentSeesion valueForKey:DATABASE_SCENARIO_DATA]];
            BOOL fileExists = [fileManager fileExistsAtPath:path];
            if (fileExists)
            {
                CurrentChapter =[currentSeesion valueForKey:DATABASE_SCENARIO_NAME];
                [CurrentSeesion setText:[currentSeesion valueForKey:DATABASE_SCENARIO_NAME]];
            }
            else
            {
                CurrentChapter =[appDelegate.langObj get:@"CURRENT_CHAP_NA" alter:@"Current Chapter not available."];
                //currentSeesion = @"Currnet Chapter not available";
                [CurrentSeesion setText:@""];
            }
        }
    }
    else
    {
        CurrentChapter =[appDelegate.langObj get:@"CURRENT_CHAP_NA" alter:@"Current Chapter not available."];
        //currentSeesion = @"Currnet Chapter not available";
        [CurrentSeesion setText:@""];
    }
    
    UIImage * image = [UIImage imageNamed:[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    self.imgView.image = image;
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                self.imgView.image = _img;
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
       self.imgView.image = Limg;
    }
    
   
    
    
    
    self.imgView.clipsToBounds = YES;
    [self setRoundedView:self.imgView toDiameter:90.0];
    
    username.text = [appDelegate.global_userInfo  valueForKey:DATABASE_USERNAME];
    username.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    
    
    roundedView.layer.cornerRadius = roundedView.frame.size.width / 2;
    roundedView.clipsToBounds = YES;
    
}


-(IBAction)goToHomeScreem:(id)sender
{
    actionSheetshare = [[UIActionSheet alloc] initWithTitle:[appDelegate.langObj get:@"SHARETITLE" alter:@"Application share Link."]
                                                   delegate:self
                                          cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:[appDelegate.langObj get:@"SHAREWHATSAPP" alter:@"Whatsapp"],[appDelegate.langObj get:@"SHAREFACEBOOK" alter:@"Facebook"],[appDelegate.langObj get:@"SHARETWITTER" alter:@"Twitter"],[appDelegate.langObj get:@"SHAREGMAIL" alter:@"Gmail"], nil];
    
    
    [actionSheetshare showInView:self.view];
    
    
    
    //[appDelegate gotoHomeScreen:self];
}


-(IBAction)ClickPhoto:(id)sen
{
    
    
//    actionSheetphoto = [[UIActionSheet alloc] initWithTitle:[appDelegate.langObj get:@"CHOOSE_PHOTO" alter:@"Choose Photo"]
//                                                   delegate:self
//                                          cancelButtonTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
//                                     destructiveButtonTitle:nil
//                                          otherButtonTitles:[appDelegate.langObj get:@"CHOOSE_GALLERY" alter:@"From photo gallery"],[appDelegate.langObj get:@"CHOOSE_CAMERA" alter:@"From camera"], nil];
//    
//    
//    [actionSheetphoto showInView:self.view];
//    
    
    
    
    //[self takePhoto];
    
}



- (void)takePhoto {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    
    
    picker.allowsEditing = YES;
    //picker.showsCameraControls = NO;
    picker.cameraViewTransform = CGAffineTransformIdentity;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      imgName ];
    
    NSString* path1 = [documentsDirectory stringByAppendingPathComponent:
                       @"userPic.png" ];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    [imageData writeToFile:path atomically:YES];
    [imageData writeToFile:path1 atomically:YES];
    
    self.imgView.image = chosenImage;
    [appDelegate.engineObj setImageFlag];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    //[ pObj dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super viewWillDisappear:animated];
    
    
}



-(IBAction)CurrentSeesionClick:(id)sender
{
    
    
    if(currentSeesion != NULL)
    {
        ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
        scnPModule.ScnEdgeId = [[currentSeesion valueForKey:DATABASE_SCENARIO_EDGEID] intValue];
        scnPModule.ScnType = [[currentSeesion valueForKey:DATABASE_SCENARIO_SCATTYPE] intValue];
         //scnPModule.titleName = [currentSeesion valueForKey:DATABASE_SCENARIO_NAME];
        [self.navigationController pushViewController:scnPModule animated:YES];
    }
    else{
       // [appDelegate gotoHomeScreen:self];
    }
    NSLog(@"Click On Current Session...");
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheetshare == actionSheet )
    {
        if(buttonIndex == 0)
        {
            
            NSString * msg = [[NSString alloc ]initWithFormat:@"%@ %@",APPNAMESHARE,appDelegate.APPSTOREURLSHARE];
            msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
            msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
            msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
            msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            msg = [msg stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
            NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
            if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
                [[UIApplication sharedApplication] openURL: whatsappURL];
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp Not Installed." message:@" WhatsApp is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }else if(buttonIndex == 1)
        {
            static NSString *const canOpenFacebookURL = @"fbauth2";
            NSURLComponents *components = [[NSURLComponents alloc] init];
            components.scheme = canOpenFacebookURL;
            components.path = @"/";
            
            
            
            if([[UIApplication sharedApplication]
                canOpenURL:components.URL]) {
                
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:APPNAMESHARE];
                [controller addURL:[NSURL URLWithString:appDelegate.APPSTOREURLSHARE]];
                // [controller addImage:[UIImage imageNamed:@"Appicon.png"]];
                
                [self presentViewController:controller animated:YES completion:Nil];
                
                //[self.navigationController pushViewController:controller animated:YES];
                
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Facebook Not Installed." message:@"Facebook is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
                
        
            
            
        }
        else if(buttonIndex == 2)
        {
            
            static NSString *const canOpenFacebookURL = @"twitterauth";
            NSURLComponents *components = [[NSURLComponents alloc] init];
            components.scheme = canOpenFacebookURL;
            components.path = @"/";
            
            
            
            if([[UIApplication sharedApplication]
                canOpenURL:components.URL]) {
                
                SLComposeViewController *controller = [SLComposeViewController
                                                                                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
                                                                           [controller setInitialText:APPNAMESHARE];
                                                                           [controller addURL:[NSURL URLWithString:appDelegate.APPSTOREURLSHARE]];
                [self presentViewController:controller animated:YES completion:Nil];
                
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Twitter Not Installed." message:@"Twitter is not installed on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        
        else if(buttonIndex == 3)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
                if(mailComposer == nil)
                {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Mail." message:@"Mail configuration is not Supported " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    mailComposer.mailComposeDelegate = self;
                    [mailComposer setSubject:APPNAMESHARE];
                    [mailComposer setMessageBody:appDelegate.APPSTOREURLSHARE isHTML:NO];
                    [self presentViewController:mailComposer animated:YES completion:nil];
                }
                //[self.navigationController pushViewController:mailComposer animated:YES];
            });
            
        }
    }
    else if (actionSheetphoto == actionSheet)
    {
        UIImagePickerController *picker;
        if(buttonIndex == 0)
        {
            
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            //[self.navigationController pushViewController:picker animated:TRUE];
            
            //[self presentViewController:picker animated:YES completion:NULL];
        }
        else if(buttonIndex == 1)
        {
            picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.cameraDevice=UIImagePickerControllerCameraDeviceFront;
            
            
            picker.allowsEditing = YES;
            //picker.showsCameraControls = NO;
            picker.cameraViewTransform = CGAffineTransformIdentity;
            //[self.navigationController pushViewController:picker animated:TRUE];
            // [self presentViewController:picker animated:YES completion:NULL];
        }
        
        if(buttonIndex == 0 || buttonIndex == 1){
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^() {
                    
                    
                    [self presentViewController:picker animated:YES completion:NULL];
                    
                    
                });
                
                
            } else {
                
                [self presentViewController:picker animated:YES completion:NULL];
                
                // [self presentModalViewController:picker animated:YES];
            }
        }
        
        
    }
    
    
    // NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %ld",(long)result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
    //[appDelegate goToCourseCode:self];
   // [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
}




@end
