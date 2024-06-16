//
//  PTEG_QuizSummery.m
//  InterviewPrep
//
//  Created by Uday Kranti on 21/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_QuizSummery.h"
#import "Assessment.h"
#import "ScenarioPracticeModule.h"
#import "PTEG_SummeryPteVC.h"
#import "ScenarioPracticeModule.h"

@interface PTEG_QuizSummery ()
{
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
    UIScrollView *bgView;
    UIView * scoreView;
    UIView * bgPointView;
}

@end

@implementation PTEG_QuizSummery

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [self.view addSubview:bgView];
    
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"logo_btext.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH,20)];
    viewTitle.text =  [[NSString alloc]initWithFormat:@"%@ Complete",self.quizName];
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:viewTitle];

    
//    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
//    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
//    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [backBtn setImage:img forState:UIControlStateNormal];
//    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
//    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    [bar addSubview:backBtn];
    
//    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
//    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
//    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
//    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
//    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
//    [bar addSubview:hamburgBtn];
    
    
    scoreView = [[UIView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    scoreView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    [self.view addSubview:scoreView];
    
//    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(0,20,SCREEN_WIDTH,44)];
//    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
//    lblquiz.font = NAVIGATIONTITLEFONT;
//    lblquiz.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    lblquiz.textAlignment = NSTextAlignmentCenter;
//    [scoreView addSubview:lblquiz];
    
    
    
    
    
    
                NSDictionary * chapObj = [appDelegate.engineObj getChapterData:appDelegate.chapterId];
                if([[chapObj valueForKey:DATABASE_SCENARIO_SKILL] intValue] == 1 || [[chapObj valueForKey:DATABASE_SCENARIO_SKILL] intValue] == 3  )
                {
//               if(TRUE)
//                    {
                    
                    
                  
                    
                    
                    
                    
                    UIImageView * img1,* img2,* img3,* img4,* img5;
                    UIView * starts = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 -50, 120, 100, 30)];
                    [scoreView addSubview:starts];
                    
                    
                    
                    
                    
                    UILabel * timelbl = [[UILabel alloc]initWithFrame:CGRectMake(0,170,SCREEN_WIDTH,20)];
                    timelbl.text = [[NSString alloc]initWithFormat:@"%@",@"Time Spent"];
                    timelbl.font =  TEXTTITLEFONT;
                    timelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
                    timelbl.textAlignment = NSTextAlignmentCenter;
                    [scoreView addSubview:timelbl];
                    
                    
                    int count = [self.duration intValue];
                    int interval = count/(int)1000;
                    
                    
                    UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(0, 190,SCREEN_WIDTH,20)];
                    TText.font = HEADERSECTIONTITLEFONT;
                    TText.textAlignment = NSTextAlignmentCenter;
                    TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    [scoreView addSubview:TText];
                    
                    
                    NSString * str = [self covertIntoHrMinSec:interval];
                               NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
                               [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
                               NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                               if(wordsAndEmptyStrings.count == 3){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(11,2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(5,2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
                                   
                               }
                               else if(wordsAndEmptyStrings.count == 2){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(6, 2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0, 2)];
                               }
                               else if(wordsAndEmptyStrings.count == 1){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
                               }
                               TText.attributedText = timeString;
                    
                    
                    
                    UILabel * correctlbl = [[UILabel alloc]initWithFrame:CGRectMake(0,220,SCREEN_WIDTH,20)];
                    correctlbl.text = [[NSString alloc]initWithFormat:@"%@",@"Correct Responses"];
                    correctlbl.font =  TEXTTITLEFONT;
                    correctlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
                    correctlbl.textAlignment = NSTextAlignmentCenter;
                    [scoreView addSubview:correctlbl];
                    
                    
                    
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
                    
                    
                    
                    UILabel * correctNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, 240,SCREEN_WIDTH,20)];
                    correctNumber.font = BOLDTEXTTITLEFONT;
                    correctNumber.textAlignment = NSTextAlignmentCenter;
                    correctNumber.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    correctNumber.text = [[NSString alloc]initWithFormat:@"%@/%d",self.correctAns,answerableQuestion];
                    [scoreView addSubview:correctNumber];
                        
                        [self showPoints:self.correctAns];
                    
                    
                    
                    int starCount = 0;
                    if(answerableQuestion > 0)
                    {
                      starCount = ceil(([self.correctAns floatValue] / answerableQuestion)*5);
                    }
                        
                      if(starCount == 0)
                      {
                          img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                          img1.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img1];
                          
                          img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                          img2.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img2];
                          
                          img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                          img3.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img3];
                          
                          img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                          img4.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img4];
                          
                          img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                          img5.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img5];
                      }
                      else if(starCount == 1)
                      {
                          img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                          img1.image = [UIImage imageNamed:@"stars.png"];
                          [starts addSubview:img1];
                          
                          img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                          img2.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img2];
                          
                          img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                          img3.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img3];
                          
                          img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                          img4.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img4];
                          
                          img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                          img5.image = [UIImage imageNamed:@"stars_d.png"];
                          [starts addSubview:img5];
                      }
                        else if(starCount == 2)
                        {
                            img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                            img1.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img1];
                            
                            img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                            img2.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img2];
                            
                            img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                            img3.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img3];
                            
                            img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                            img4.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img4];
                            
                            img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                            img5.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img5];
                        }
                        else if(starCount == 3)
                        {
                            img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                            img1.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img1];
                            
                            img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                            img2.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img2];
                            
                            img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                            img3.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img3];
                            
                            img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                            img4.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img4];
                            
                            img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                            img5.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img5];
                        }
                        else if(starCount == 4)
                        {
                            img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                            img1.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img1];
                            
                            img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                            img2.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img2];
                            
                            img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                            img3.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img3];
                            
                            img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                            img4.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img4];
                            
                            img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                            img5.image = [UIImage imageNamed:@"stars_d.png"];
                            [starts addSubview:img5];
                        }
                        else if(starCount == 5)
                        {
                            img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,3,20,20)];
                            img1.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img1];
                            
                            img2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,3,20,20)];
                            img2.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img2];
                            
                            img3 = [[UIImageView alloc]initWithFrame:CGRectMake(40,3,20,20)];
                            img3.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img3];
                            
                            img4 = [[UIImageView alloc]initWithFrame:CGRectMake(60,3,20,20)];
                            img4.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img4];
                            
                            img5 = [[UIImageView alloc]initWithFrame:CGRectMake(80,3,20,20)];
                            img5.image = [UIImage imageNamed:@"stars.png"];
                            [starts addSubview:img5];
                        }
                    
                    
                    
                    
                    
                    
                }
                else
                {
                    
                    UILabel * timelbl = [[UILabel alloc]initWithFrame:CGRectMake(0,80,SCREEN_WIDTH,20)];
                    timelbl.text = [[NSString alloc]initWithFormat:@"%@",@"Time Spent"];
                    timelbl.font =  TEXTTITLEFONT;
                    timelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
                    timelbl.textAlignment = NSTextAlignmentCenter;
                    [scoreView addSubview:timelbl];
                    
                    
                    int count = [self.duration intValue];
                    int interval = count/(int)1000;
                    
                    
                    UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH,20)];
                    TText.font = HEADERSECTIONTITLEFONT;
                    TText.textAlignment = NSTextAlignmentCenter;
                    TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                    [scoreView addSubview:TText];
                    
                    
                    NSString * str = [self covertIntoHrMinSec:interval];
                               NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:str];
                               [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0, [timeString length])];
                               NSArray *wordsAndEmptyStrings = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                               if(wordsAndEmptyStrings.count == 3){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(11,2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(5,2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
                                   
                               }
                               else if(wordsAndEmptyStrings.count == 2){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(6, 2)];
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0, 2)];
                               }
                               else if(wordsAndEmptyStrings.count == 1){
                                   [timeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0,2)];
                               }
                               TText.attributedText = timeString;
                    
                    
                    
                    UIImageView * instImg = [[UIImageView alloc]initWithFrame:CGRectMake(25,145,15,15)];
                    instImg.image = [UIImage imageNamed:@"PTEG_info.png"];
                    [scoreView addSubview:instImg];
                    
                    
                    UILabel * TTextDescription = [[UILabel alloc]initWithFrame:CGRectMake(40, 140,SCREEN_WIDTH-80,60)];
                    TTextDescription.font = TEXTTITLEFONT;
                    TTextDescription.textAlignment = NSTextAlignmentCenter;
                    TTextDescription.numberOfLines = 4;
                    TTextDescription.text = [[NSString alloc]initWithFormat:@"Answer for %@ are not evaluted. Please check model answer in summary to self evaluate",self.quizName];
                    TTextDescription.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
                    [scoreView addSubview:TTextDescription];
                }
                
    
    
    
    
//    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH,60)];
//    leftView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    [scoreView addSubview:leftView];
//
//
//    UILabel * rightCounter = [[UILabel alloc]initWithFrame:CGRectMake(0,5,leftView.frame.size.width/2+2, 50)];
//
//    rightCounter.text = [[NSString alloc]initWithFormat:@"%@",self.correctAns];
//    rightCounter.textAlignment = NSTextAlignmentRight;
//    rightCounter.font = [UIFont boldSystemFontOfSize:48];
//    rightCounter.textColor  = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [leftView addSubview:rightCounter];
//    UILabel * totalCounter = [[UILabel alloc]initWithFrame:CGRectMake(leftView.frame.size.width/2,30, 50, 20)];
//
//    int  answerableQuestion =0;
//    for (NSDictionary *obj in self.quesArray) {
//        if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"av"])
//        {
//
//        }
//        else if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"es"])
//        {
//
//        }
//        else if([[[[obj valueForKey:@"format"] valueForKey:@"delivery"] valueForKey:@"text"]isEqualToString:@"ra"] && [[[obj valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0)
//        {
//
//        }
//        else
//        {
//            answerableQuestion++;
//        }
//    }
//
//    totalCounter.text = [[NSString alloc]initWithFormat:@"/%ld",(unsigned long)answerableQuestion];
//    totalCounter.textAlignment = NSTextAlignmentLeft;
//    totalCounter.font = [UIFont systemFontOfSize:20];
//    totalCounter.textColor  = [UIColor blackColor];
//    [leftView addSubview:totalCounter];
//
//    UILabel * totalCounterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, leftView.frame.size.height/2+10, SCREEN_WIDTH, 50)];
//    totalCounterLabel.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.langObj get:@"MCQ_CORRECTANSS" alter:@"Correct Answers"]];
//    if([self.correctAns intValue] <2)
//        totalCounterLabel.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.langObj get:@"MCQ_CORRECTANS" alter:@"Correct Answer"]];
//    totalCounterLabel.textAlignment = NSTextAlignmentCenter;
//    totalCounterLabel.font = [UIFont systemFontOfSize:13];
//    totalCounterLabel.textColor  = [UIColor blackColor];
//    [leftView addSubview:totalCounterLabel];
    
    
    
    
    
    
    
    UIButton * tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, scoreView.frame.size.height-200, 8*(SCREEN_WIDTH/10),40)];
    [tryAgainBtn setTitle:@"Try Again" forState:UIControlStateNormal];
    
    
    UIImage * img = [UIImage imageNamed:@"PTEG_TryAgain.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [tryAgainBtn setImage:img forState:UIControlStateNormal];
    tryAgainBtn.tintColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    tryAgainBtn.titleEdgeInsets = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    [tryAgainBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
   
    [tryAgainBtn setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
    [scoreView addSubview:tryAgainBtn];
    
    [tryAgainBtn addTarget:self
                    action:@selector(ClickTryAgain:)
          forControlEvents:UIControlEventTouchUpInside];
    tryAgainBtn.titleLabel.font = BUTTONFONT;
    
    
    
    UIButton * viewSummaryBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, scoreView.frame.size.height-150, 8*(SCREEN_WIDTH/10),40)];
    [viewSummaryBtn setTitle:@"View Summary" forState:UIControlStateNormal];
    viewSummaryBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
    [viewSummaryBtn addTarget:self action:@selector(viewSummary:) forControlEvents:UIControlEventTouchUpInside];
    viewSummaryBtn.titleLabel.font = BUTTONFONT;
    viewSummaryBtn.layer.borderWidth = 1;
    viewSummaryBtn.layer.borderColor = [self getUIColorObjectFromHexString:@"#CACACA" alpha:1.0].CGColor;
     [viewSummaryBtn setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
    viewSummaryBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    viewSummaryBtn.layer.cornerRadius = 10; // this value vary as per your desire
    viewSummaryBtn.clipsToBounds = YES;
    [scoreView addSubview:viewSummaryBtn];
    
    
    
    UIButton * nextPracBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, scoreView.frame.size.height-100, 8*(SCREEN_WIDTH/10),40)];
    [nextPracBtn setTitle:@"Next Practice" forState:UIControlStateNormal];
   
    nextPracBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    [nextPracBtn addTarget:self
                       action:@selector(ClickNextPractice:)
             forControlEvents:UIControlEventTouchUpInside];
    nextPracBtn.titleLabel.font = BUTTONFONT;
    nextPracBtn.titleLabel.tintColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
    nextPracBtn.layer.cornerRadius = 10; // this value vary as per your desire
    nextPracBtn.clipsToBounds = YES;
    [scoreView addSubview:nextPracBtn];
    
    
    
    
    UIButton * submitScoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, scoreView.frame.size.height-50, 8*(SCREEN_WIDTH/10),40)];
    [submitScoreBtn setTitle:@"Back to Practice Home" forState:UIControlStateNormal];
    [submitScoreBtn setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    [submitScoreBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
    [submitScoreBtn addTarget:self
                       action:@selector(ClickSubmit:)
             forControlEvents:UIControlEventTouchUpInside];
    submitScoreBtn.titleLabel.font = BUTTONFONT;
    submitScoreBtn.layer.cornerRadius = 10; // this value vary as per your desire
    submitScoreBtn.clipsToBounds = YES;
    [scoreView addSubview:submitScoreBtn];
  
    
}

-(void)viewSummary :(id)sender
{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    PTEG_SummeryPteVC *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"SummeryPteVC"];
    vc.titleName = self.quizName;
    vc.totalSpentTime = [self.duration intValue]/1000;
    vc.questionArray = self.trackOriginalArr;
    [self.navigationController pushViewController:vc animated:true];

    
}

-(void)ClickNextPractice :(id)sender
{
    NSArray *array = [self.navigationController viewControllers];
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[ScenarioPracticeModule class]]){
            ScenarioPracticeModule * compoanatObj = (ScenarioPracticeModule *)[array objectAtIndex:i];
            compoanatObj.isFlowContinue = TRUE;
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
            return;
        }
    }

    [self.navigationController popViewControllerAnimated:TRUE];
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

-(NSString*)covertIntoHrMinSec:(int)overAllTime
{
    int hr = overAllTime/(int)(60*60);
    int _min = overAllTime%(int)(60*60);
    int min = (int)_min/(int)(60);
    int sec = (int)_min%(int)(60);
    NSString * str;
    if((hr == 0 && min == 0) || (hr == 0 && min == 0 && sec == 0) )
    {
        str = [[NSString alloc]initWithFormat:@"%02ds",sec];
    }
    else if(hr == 0)
    {
        str = [[NSString alloc]initWithFormat:@"%02dmin %02ds",min,sec];
    }
    else
    {
        str = [[NSString alloc]initWithFormat:@"%02dhr %02dmin %02ds",hr,min,sec];
    }
    return str;
}


-(void)showPoints:(NSString * )correct
{
    bgPointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [bgPointView setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
    
    UIView * pointView =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50,70 , 100, 40)];
    [pointView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    [pointView.layer setMasksToBounds:YES];
    pointView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [pointView.layer setCornerRadius:20.0f];
    [pointView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
    [pointView.layer setBorderWidth:1];
    
    UILabel * lblScore = [[UILabel alloc]initWithFrame:CGRectMake(10,5,80, 30)];
    lblScore.font = BOLDTEXTTITLEFONT;
    lblScore.textAlignment = NSTextAlignmentCenter;
    lblScore.text = [[NSString alloc]initWithFormat:@"+%@ points",correct];
    lblScore.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    [pointView addSubview:lblScore];
    [bgPointView addSubview:pointView];
    [self.view addSubview:bgPointView];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0  // 6.0
      target:self
    selector:@selector(hidePoint)
    userInfo:nil
     repeats:NO];
}

-(void)hidePoint
{
    [bgPointView removeFromSuperview];
    bgPointView = NULL;
}


@end
