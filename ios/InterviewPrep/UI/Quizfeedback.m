//
//  Quizfeedback.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "Quizfeedback.h"
#import "MeProComponent.h"
#import "ScenarioPracticeModule.h"
#import "Assessment.h"
#import "MePro_Remediation.h"


@interface Quizfeedback ()
{
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
    UIScrollView *bgView;
    
    UIView * scoreView;
}

@end

@implementation Quizfeedback

- (void)viewDidLoad {
[super viewDidLoad];
appDelegate = APP_DELEGATE;
//    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    

    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
      UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
      lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.TopicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
      lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
      lbl.textAlignment = NSTextAlignmentCenter;
      [bar addSubview:lbl];
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
     
    
    
//    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,40,40)];
//    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    [bar addSubview:backBtn];
    

    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
    [self.view addSubview:bgView];
    
    scoreView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
        scoreView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scoreView];
        
        UILabel * QuixSummaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
        if([UISTANDERD isEqualToString:@"PRODUCT2"]){
            QuixSummaryLabel.text = @"You got";
        }
        else
        {
            QuixSummaryLabel.text = [appDelegate.langObj get:@"MCQ_RESULT" alter:@"RESULT"];
        }
        QuixSummaryLabel.font = [UIFont systemFontOfSize:22];
        QuixSummaryLabel.textAlignment = NSTextAlignmentCenter;
        
        [scoreView addSubview:QuixSummaryLabel];
        
        UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH,60)];
        leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [scoreView addSubview:leftView];
        
        
        UILabel * rightCounter = [[UILabel alloc]initWithFrame:CGRectMake(0,5,leftView.frame.size.width/2+2, 50)];
        
        rightCounter.text = [[NSString alloc]initWithFormat:@"%@",self.correctAns];
        rightCounter.textAlignment = NSTextAlignmentRight;
        rightCounter.font = [UIFont boldSystemFontOfSize:48];
        rightCounter.textColor  = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [leftView addSubview:rightCounter];
        UILabel * totalCounter = [[UILabel alloc]initWithFrame:CGRectMake(leftView.frame.size.width/2,30, 50, 20)];
        
       int  answerableQuestion =0;
        for (NSDictionary *obj in self.quesArray) {
            if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"av"])
            {

            }
            else if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"es"])
            {

            }
            else if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"ra"] && [[[obj valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0)
            {

            }
            else
            {
                answerableQuestion++;
            }
        }
        
        totalCounter.text = [[NSString alloc]initWithFormat:@"/%ld",(unsigned long)answerableQuestion];
        totalCounter.textAlignment = NSTextAlignmentLeft;
        totalCounter.font = [UIFont systemFontOfSize:20];
        totalCounter.textColor  = [UIColor blackColor];
        [leftView addSubview:totalCounter];
        
        UILabel * totalCounterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, leftView.frame.size.height/2+10, SCREEN_WIDTH, 50)];
        totalCounterLabel.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.langObj get:@"MCQ_CORRECTANSS" alter:@"Correct Answers"]];
        if([self.correctAns intValue] <2)
            totalCounterLabel.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.langObj get:@"MCQ_CORRECTANS" alter:@"Correct Answer"]];
        totalCounterLabel.textAlignment = NSTextAlignmentCenter;
        totalCounterLabel.font = [UIFont systemFontOfSize:13];
        totalCounterLabel.textColor  = [UIColor blackColor];
        [leftView addSubview:totalCounterLabel];
        
        
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH*(.90))/2, 170,SCREEN_WIDTH*(.90),scoreView.frame.size.height-290 )];
        imgView.image = [UIImage imageNamed:@"MePro-ScoreImag.png"];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [scoreView addSubview:imgView];
        
        UILabel * Subtext = [[UILabel alloc]initWithFrame:CGRectMake(0, leftView.frame.size.height + 220, SCREEN_WIDTH, 60)];
        Subtext.text = [appDelegate.langObj get:@"ASSES_DETAIL_MSG" alter:@"You will receive a detailed report at your registered email id."] ;
        Subtext.textAlignment = NSTextAlignmentCenter;
        Subtext.lineBreakMode = NSLineBreakByWordWrapping; // or NSLineBreakMode.ByWordWrapping
        Subtext.numberOfLines = 0;
        Subtext.font = [UIFont systemFontOfSize:15];
        
    
        
        UIButton * submitScoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, SCREEN_HEIGHT-170, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
          [submitScoreBtn setTitle:@"Continue" forState:UIControlStateNormal];
        else
          [submitScoreBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [scoreView addSubview:submitScoreBtn];
        
        submitScoreBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        [submitScoreBtn addTarget:self
                           action:@selector(ClickSubmit:)
                 forControlEvents:UIControlEventTouchUpInside];
        submitScoreBtn.titleLabel.font = BUTTONFONT;
        submitScoreBtn.titleLabel.tintColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        submitScoreBtn.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        submitScoreBtn.clipsToBounds = YES;
        
        
    
        UIButton * tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, SCREEN_HEIGHT-120, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
        [tryAgainBtn setTitle:@"Try Again" forState:UIControlStateNormal];
        [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0]  forState:UIControlStateNormal];
        [scoreView addSubview:tryAgainBtn];
        tryAgainBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        [tryAgainBtn.layer setMasksToBounds:YES];
        //tryAgainBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [tryAgainBtn.layer setCornerRadius:BUTTONROUNDRECT];
        [tryAgainBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
        [tryAgainBtn.layer setBorderWidth:1];
        [tryAgainBtn addTarget:self
                        action:@selector(ClickTryAgain:)
              forControlEvents:UIControlEventTouchUpInside];
        tryAgainBtn.layer.cornerRadius = 20; // this value vary as per your desire
        tryAgainBtn.clipsToBounds = YES;
        tryAgainBtn.titleLabel.font = BUTTONFONT;
        if(self.isRemediation)
         {
                tryAgainBtn.hidden = TRUE;
                Subtext.hidden = TRUE;
                [scoreView addSubview:Subtext];
         }
         
         
        
            
        
        

}

-(IBAction)ClickSubmit:(id)sender
{
    NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
    [jsonResponse setValue:self.trackArr forKey:@"param"];
    [jsonResponse setValue:[self.testOBj valueForKey:@"uid"] forKey:@"edgeId"];
    [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%@",self.correctAns] forKey:@"score"];
    if([UISTANDERD isEqualToString:@"PRODUCT2"] && self.isRemediation)
    {
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MePro_Remediation class]]){
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                return;
            }
        }
    }
    else if([UISTANDERD isEqualToString:@"PRODUCT2"] &&  [[self.testOBj valueForKey:@"type"]intValue] == 21  )
    {
        
        NSArray *array = [self.navigationController viewControllers];
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProComponent class]]){
                MeProComponent * compoanatObj = (MeProComponent *)[array objectAtIndex:i];
                compoanatObj.isFlowContinue = TRUE;
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
                return;
            }
        }

        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else if([[self.testOBj valueForKey:@"type"]intValue] == 21)
    {
        NSArray *array = [self.navigationController viewControllers];
        
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[ScenarioPracticeModule class]]){
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                return;
            }
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else if([[self.testOBj valueForKey:@"type"]intValue] == 3 || [[self.testOBj valueForKey:@"catType"]intValue] == 3 )
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:[array count]-3] animated:YES];
    }
    else
    {
        
    }
    
}
-(IBAction)ClickTryAgain:(id)sender
{
        //appDelegate.AssessmentQuesAttemptCounter = -1;
        Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
        assess.assessnetUid = [self.testOBj valueForKey:@"uid"];
        assess.cusTitleName = [self.testOBj valueForKey:@"name"];
        if([[self.testOBj valueForKey:@"type"]intValue] == 21)
        {
            assess.type = 21;
            assess.scnUid = self.chapterId;
            
            assess.TopicName = self.TopicName;
            assess.selectedLevel  = self.selectedLevel;
        }
        else
        {
            assess.type = 3;
            assess.scnUid = 0;
            assess.selectedLevel  = self.selectedLevel;
        }
        assess.testOBj = self.testOBj;
        assess.isRemediation = NO;
        assess.skillObj  = self.skillObj;
        [self.navigationController pushViewController:assess animated:YES];
    
  
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
