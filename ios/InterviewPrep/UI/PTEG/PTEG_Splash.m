//
//  PTEG_Splash.m
//  InterviewPrep
//
//  Created by Uday Kranti on 28/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Splash.h"
#import "PTEG_Dashboard.h"
#import "PTEG_Landing.h"
#import <AVFoundation/AVFoundation.h>

@interface PTEG_Splash ()
{
    UIView * bar;
    UIImageView * spalshImag;
    NSTimer * timer;
    UIActivityIndicatorView *  activityIndicator;
}

@end

@implementation PTEG_Splash

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:SPLASHCOLOR alpha:1.0];
//    [self.view addSubview:bar];
    //spalshImag = [[UIImageView alloc]initWithImage:[UIImage imageNamed:SPLASHSCREEN]];
    spalshImag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    spalshImag.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    spalshImag.contentMode = UIViewContentModeScaleAspectFill;
    spalshImag.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    spalshImag.image = [UIImage imageNamed:SPLASHSCREEN];
    [self.view addSubview:spalshImag];
    
    
    UIImageView * imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 40, SCREEN_WIDTH/2,70)];
    imgLogo.contentMode = UIViewContentModeScaleAspectFit;
    imgLogo.image = [UIImage imageNamed:@"PTEG_SLogo.png"];
    [spalshImag addSubview:imgLogo];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
                                             target:self
                                           selector:@selector(goToLoginScreen)
                                           userInfo:nil
                                            repeats:NO];
    
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(void)goToLoginScreen
{
    [timer invalidate];
    timer = NULL;
    
        
        if(appDelegate.global_userInfo != NULL)
        {
          
          appDelegate.coursePack = APP_LICENCE_KEY_PTEGENERAL;
          PTEG_Dashboard * pteDashObj = [[PTEG_Dashboard alloc]initWithNibName:@"PTEG_Dashboard" bundle:nil];
          [self.navigationController pushViewController:pteDashObj animated:YES];
          
        }
        else
        {
          PTEG_Landing * pteObj = [[PTEG_Landing alloc]initWithNibName:@"PTEG_Landing" bundle:nil];
          [self.navigationController pushViewController:pteObj animated:TRUE];
          
        }
    
}

@end
