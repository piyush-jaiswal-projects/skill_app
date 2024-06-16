//
//  CoinsQuizfeedback.m
//  InterviewPrep
//
//  Created by Amit Gupta on 06/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "CoinsQuizfeedback.h"
#import "ScenarioPracticeModule.h"
#import "Assessment.h"

@interface CoinsQuizfeedback ()
{
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
    UIScrollView *bgView;
    
    UIView * scoreView;
}

@end

@implementation CoinsQuizfeedback

- (void)viewDidLoad {
[super viewDidLoad];
appDelegate = APP_DELEGATE;
self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
[self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
self.navigationController.navigationBarHidden = YES;
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
   
    

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
        
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 170,SCREEN_WIDTH,scoreView.frame.size.height-330 )];
       
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [scoreView addSubview:imgView];
        if([self.correctAns intValue] > 0)
        {
            imgView.image = [UIImage imageNamed:@"coinsCup_full.png"];
        }
       else
       {
            imgView.image = [UIImage imageNamed:@"coinsCup_empty.png"];
       }
        UILabel * Subtext = [[UILabel alloc]initWithFrame:CGRectMake(100, SCREEN_HEIGHT-240, SCREEN_WIDTH-200, 50)];
        Subtext.text = [[NSString alloc]initWithFormat:@"You earned %@ out of %d coins.",self.correctAns,answerableQuestion];
        Subtext.textColor  = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        Subtext.textAlignment = NSTextAlignmentCenter;
        Subtext.lineBreakMode = NSLineBreakByWordWrapping;
        Subtext.numberOfLines =  2;
        
        Subtext.font = [UIFont systemFontOfSize:13];
        [scoreView addSubview:Subtext];
        
    
        
        UIButton * submitScoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, SCREEN_HEIGHT-170, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
        
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
}

-(IBAction)ClickSubmit:(id)sender
{
    NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
    [jsonResponse setValue:self.trackArr forKey:@"param"];
    [jsonResponse setValue:[self.testOBj valueForKey:@"uid"] forKey:@"edgeId"];
    [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%@",self.correctAns] forKey:@"score"];
    
    if([[self.testOBj valueForKey:@"type"]intValue] == 21)
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
            assess.selectedLevel  = @"-1";
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


@end
