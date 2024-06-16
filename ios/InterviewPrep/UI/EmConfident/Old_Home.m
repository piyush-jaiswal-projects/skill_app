//
//  Old_Home.m
//  InterviewPrep
//
//  Created by Uday Kranti on 19/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "Old_Home.h"
#import "Old_Login.h"
#import "Old_Registration.h"

@interface Old_Home ()
{
    UIImageView *topUIOther;
    UIView * bootomUI;
    UIButton * signIn;
    UIButton * signUp;
    UIView * saparator;
    UIView * invisible;
}

@end

@implementation Old_Home

- (void)viewDidLoad
  {
     [super viewDidLoad];
     appDelegate = APP_DELEGATE;
      
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
      
     self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
     [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
     self.navigationController.navigationBarHidden = YES;
      
     
      
      
     topUIOther = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
     topUIOther.image = [UIImage imageNamed:HOMESPLASHSCREEN];
     topUIOther.backgroundColor = [UIColor whiteColor];
     [self.view addSubview:topUIOther];
    
     
      

      
     bootomUI = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
     bootomUI.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
     [self.view addSubview:bootomUI];
      
      
      
     
     
      
     signIn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, 5, SCREEN_WIDTH/4, 30)];
     [signIn setTitle:@"Sign In"forState:UIControlStateNormal];
     [signIn setTitleColor:[self getUIColorObjectFromHexString:@"#5ac1dc" alpha:1.0] forState:UIControlStateNormal];
     [signIn addTarget:self action:@selector(clickSignIn:) forControlEvents:UIControlEventTouchDown];
     [bootomUI addSubview:signIn];
      
      
      
     
      
     signUp = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/8)+(SCREEN_WIDTH/2), 5, SCREEN_WIDTH/4, 30)];
     [signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
     [signUp setTitleColor:[self getUIColorObjectFromHexString:@"#5ac1dc" alpha:1.0] forState:UIControlStateNormal];
     [signUp addTarget:self action:@selector(clickSignUp:) forControlEvents:UIControlEventTouchDown];
     [bootomUI addSubview:signUp];
      
      
      
      
      
     saparator = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-2, 5, 3, 30)];
     saparator.backgroundColor = [self getUIColorObjectFromHexString:@"#ebebeb" alpha:1.0];
     [bootomUI addSubview:saparator];
    
    }

-(void)clickSignIn:(id)sender
   {
       
    Old_Login * pteObj = [[Old_Login alloc]initWithNibName:@"Old_Login" bundle:nil];
    [self.navigationController pushViewController:pteObj animated:TRUE];
       
   }
-(void)clickSignUp:(id)sender
   {
       
      Old_Registration * pteObj = [[Old_Registration alloc]initWithNibName:@"Old_Registration" bundle:nil];
      [self.navigationController pushViewController:pteObj animated:TRUE];
       
   }
- (void)didReceiveMemoryWarning
  {
    [super didReceiveMemoryWarning];
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
