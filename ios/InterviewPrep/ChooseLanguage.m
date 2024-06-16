//
//  ChooseLanguage.m
//  InterviewPrep
//
//  Created by Amit Gupta on 18/05/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import "ChooseLanguage.h"
#import "mobileScreen.h"

@interface ChooseLanguage ()

@end

@implementation ChooseLanguage

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    [scrollView setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    
    
    hindiBtn.layer.borderColor = [UIColor redColor].CGColor;
    hindiBtn.layer.borderWidth = 1.0;
    hindiBtn.layer.cornerRadius = 10.0;
    //hindiBtn.hidden = TRUE;
    
    
    
    engBtn.layer.borderColor = [UIColor redColor].CGColor;
    engBtn.layer.borderWidth = 1.0;
    engBtn.layer.cornerRadius = 10.0;
    //engBtn.hidden = TRUE;
    
    
    bangalibtn.layer.borderColor = [UIColor redColor].CGColor;
    bangalibtn.layer.borderWidth = 1.0;
    bangalibtn.layer.cornerRadius = 10.0;
    //bangalibtn.hidden = TRUE;
    
    
    knBtn.layer.borderColor = [UIColor redColor].CGColor;
    knBtn.layer.borderWidth = 1.0;
    knBtn.layer.cornerRadius = 10.0;
     //knBtn.hidden = TRUE;
    
    mlBtn.layer.borderColor = [UIColor redColor].CGColor;
    mlBtn.layer.borderWidth = 1.0;
    mlBtn.layer.cornerRadius = 10.0;
    //mlBtn.hidden = TRUE;
    
    
    tabtn.layer.borderColor = [UIColor redColor].CGColor;
    tabtn.layer.borderWidth = 1.0;
    tabtn.layer.cornerRadius = 10.0;
    //tabtn.hidden = TRUE;
    
    
    teBtn.layer.borderColor = [UIColor redColor].CGColor;
    teBtn.layer.borderWidth = 1.0;
    teBtn.layer.cornerRadius = 10.0;
    
    //teBtn.hidden = TRUE;
    

    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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


-(IBAction)ClickLanguage:(id)sender
{
    

    
    NSString * lang ;
    //NSString * CourseCode;
    if(((UIButton *)sender).tag == 0 )
    {
       lang = LANGUAGE_HINDI;
       
    }
    else if(((UIButton *)sender).tag == 1)
    {
         lang = LANGUAGE_ENG;
        
        
    }
    else if(((UIButton *)sender).tag == 2)
    {
        lang =  LANGUAGE_BN;
        
    }
    else if(((UIButton *)sender).tag == 3)
    {
        lang =  LANGUAGE_KN;
        
    }
    else if(((UIButton *)sender).tag == 4)
    {
        lang =  LANGUAGE_ML;
       
    }
    else if(((UIButton *)sender).tag == 5)
    {
        lang =  LANGUAGE_TA;
        
    }
    else if(((UIButton *)sender).tag == 6)
    {
        lang =  LANGUAGE_TE;
       
    }
    else if(((UIButton *)sender).tag == 7)
    {
        lang =  LANGUAGE_CHAINA;
    }
    
    [appDelegate setLanguage:lang];
    
    
    
    appDelegate.langObj = [[Language alloc]initialize:lang];
    appDelegate.engineObj = [[Engine alloc]init:appDelegate.langObj courseCode:appDelegate.courseCode];
    
    mobileScreen * mobileloginObj = [[mobileScreen alloc]initWithNibName:@"mobileScreen" bundle:nil];
    [self.navigationController pushViewController:mobileloginObj animated:TRUE];
    
}

@end
