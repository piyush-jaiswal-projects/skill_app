//
//  Home.m
//  InterviewPrep
//
//  Created by Amit Gupta on 21/04/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "Home.h"
#import "MobileRegistrationScreen.h"
#import "mobileScreen.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface Home (){
    UIView * bootomUI;
    UIImageView *topUIOther;
    UIView *topUI;
    UIImageView *advertise;
    UIButton * signIn;
    UIButton * signUp;
    UIView * saparator;
    UIView * invisible;
    UITextView * Word ;
    UIView * playerView;
    UIImageView *iv;
    NSMutableDictionary * obj;
    AVPlayerViewController * moviePlayController;
}

@end

@implementation Home

- (void)viewDidLoad {
    
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    if([CLASS_NAME isEqualToString:@"englishEdge"] ||[CLASS_NAME isEqualToString:@"wileynxt"])
    {
         topUI = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        topUI.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:topUI];
        advertise = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,topUI.frame.size.height*.35)];
        advertise.backgroundColor = [UIColor redColor];
        advertise.image = [UIImage imageNamed:@"home.jpg"];
        [topUI addSubview:advertise];
        
        Word = [[UITextView alloc]initWithFrame:CGRectMake(0, topUI.frame.size.height*.35, SCREEN_WIDTH,topUI.frame.size.height*.30)];
        Word.editable = FALSE;
        Word.backgroundColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];
        [topUI addSubview:Word];
        
        playerView = [[UIView alloc]initWithFrame:CGRectMake(0, topUI.frame.size.height*.65, SCREEN_WIDTH, topUI.frame.size.height*.35)];
        
        playerView.backgroundColor = [UIColor redColor];
        [topUI addSubview:playerView];
        
        invisible = [[UIView alloc]initWithFrame:CGRectMake(playerView.frame.size.width-100,playerView.frame.size.height-50 , 100, 50)];
        
        invisible.backgroundColor = [UIColor clearColor];
        
        moviePlayController = [[AVPlayerViewController alloc] init];
        moviePlayController.showsPlaybackControls = NO;
        
        moviePlayController.showsPlaybackControls = TRUE;
        
        moviePlayController.view.frame = playerView.bounds;
       
        [playerView addSubview:moviePlayController.view];
        
        NSURL *fileURL = [NSURL URLWithString:@"https://mobile.englishedge.in/emp/live/resource/englishEdge/Untitled.mp4"];
        
       AVPlayer * playVideo = [[AVPlayer alloc] initWithURL:fileURL];
        moviePlayController.player = playVideo;
        [moviePlayController.player play];
        
        
//        moviePlayController=[[MPMoviePlayerController alloc] init];
//        [moviePlayController prepareToPlay];
//        moviePlayController.shouldAutoplay=NO;
//        [moviePlayController setScalingMode:MPMovieScalingModeAspectFill];
//        moviePlayController.controlStyle = MPMovieControlStyleEmbedded;
//        moviePlayController.view.frame = playerView.bounds;
//        NSURL *fileURL = [NSURL URLWithString:@"https://mobile.englishedge.in/emp/live/resource/englishEdge/Untitled.mp4"];
//        //NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Untitled" ofType:@"mp4"];
//        //NSURL *fileURL = [NSURL fileURLWithPath:filepath];
//        moviePlayController.contentURL = fileURL;
//
//        [playerView addSubview:moviePlayController.view];
        
        [moviePlayController.view addSubview:invisible];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            obj = [appDelegate.engineObj getWord];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //if(obj != NULL && )
                NSString *htmlString = [[NSString alloc] initWithFormat:@"<div style=\"padding:10;\"><font face=\"Helvetica Neue\"><h2>Word of the Day</h2><div style=\"display: inline-block\"><b>Word:&nbsp;</b>%@</div><br><div style=\"display: inline-block\"><b>Pronunciation:&nbsp;</b>%@</div><br><div style=\"display: inline-block\"><b>Description:&nbsp;</b>%@</div></font></div>",[obj valueForKey:@"word"],[obj valueForKey:@"pronunciation"],[obj valueForKey:@"meaning"]];
                
                
                
                
                htmlString = [htmlString stringByAppendingString:@"<style>body{font-family:'YOUR_FONT_HERE'; font-size:'SIZE';}</style>"];
                /*Example:
                 
                 htmlString = [htmlString stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",_myLabel.font.fontName,_myLabel.font.pointSize]];
                 */
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                        documentAttributes: nil
                                                        error: nil
                                                        ];
                Word.attributedText = attributedString;
                
                
                
                
                
                
            });
            
            
        });
        
    }
    else{
        topUIOther = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        topUIOther.image = [UIImage imageNamed:HOMESPLASHSCREEN];
        topUIOther.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:topUIOther];
    }
    
    
    
    
    
    bootomUI = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    bootomUI.backgroundColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];
    [self.view addSubview:bootomUI];
    
    signIn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, 5, SCREEN_WIDTH/4, 30)];
    [signIn setTitle:[appDelegate.langObj get:@"HM_LOGIN" alter:@"Sign In"]forState:UIControlStateNormal];
    if([CLASS_NAME  isEqualToString:@"BEC"] )
    {
       
        [signIn setTitleColor:[self getUIColorObjectFromHexString:@"#f05540" alpha:1.0] forState:UIControlStateNormal];
    }
    else{
      [signIn setTitleColor:[self getUIColorObjectFromHexString:@"#30c5fb" alpha:1.0] forState:UIControlStateNormal];
    }
    
    //[signIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signIn addTarget:self action:@selector(clickSignIn:) forControlEvents:UIControlEventTouchDown];
    [bootomUI addSubview:signIn];
    
    signUp = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/8)+(SCREEN_WIDTH/2), 5, SCREEN_WIDTH/4, 30)];
    [signUp setTitle:[appDelegate.langObj get:@"HM_SIGNUP" alter:@"Sign Up"] forState:UIControlStateNormal];
    
    if([CLASS_NAME  isEqualToString:@"BEC"] )
    {
        
        [signUp setTitleColor:[self getUIColorObjectFromHexString:@"#f05540" alpha:1.0] forState:UIControlStateNormal];
    }
    else{
        [signUp setTitleColor:[self getUIColorObjectFromHexString:@"#30c5fb" alpha:1.0] forState:UIControlStateNormal];
    }
    //[signUp setTitleColor:[self getUIColorObjectFromHexString:@"#30c5fb" alpha:1.0] forState:UIControlStateNormal];
    [signUp addTarget:self action:@selector(clickSignUp:) forControlEvents:UIControlEventTouchDown];
    //[signUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bootomUI addSubview:signUp];
     saparator = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 5, 1, 30)];
    if([CLASS_NAME  isEqualToString:@"BEC"] )
    {
     saparator.backgroundColor = [self getUIColorObjectFromHexString:@"#f05540" alpha:1.0];
    }
    else{
        
        saparator.backgroundColor = [self getUIColorObjectFromHexString:@"#555555" alpha:1.0];
    }
   
    [bootomUI addSubview:saparator];
    
    
    
    
    
    
    
    
    
//    UIImage *thumbnail = [moviePlayController thumbnailImageAtTime:5.0
//                                                timeOption:MPMovieTimeOptionNearestKeyFrame];
//    
//    iv = [[UIImageView alloc] initWithImage:thumbnail];
//    iv.userInteractionEnabled = YES;
//    //iv.frame = moviePlayController.;
//    [playerView addSubview:iv];
//    
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//    tap.numberOfTapsRequired = 1;
//    [iv addGestureRecognizer:tap];
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}


//- (void)handleTap:(UITapGestureRecognizer *)gesture{
//    iv.hidden = YES;
//    [moviePlayController play];
//}

-(IBAction)clickSignIn:(id)sender{
    
    [moviePlayController.player pause];
     mobileScreen * mobileloginObj = [[mobileScreen alloc]initWithNibName:@"mobileScreen" bundle:nil];
    [self.navigationController pushViewController:mobileloginObj animated:TRUE];
}
-(IBAction)clickSignUp:(id)sender{
   [moviePlayController.player pause];
    MobileRegistrationScreen * mobileRegisObj = [[MobileRegistrationScreen alloc]initWithNibName:@"MobileRegistrationScreen" bundle:nil];
    [self.navigationController pushViewController:mobileRegisObj animated:TRUE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
