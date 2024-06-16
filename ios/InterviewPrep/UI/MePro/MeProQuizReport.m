//
//  MeProQuizReport.m
//  InterviewPrep
//
//  Created by Amit Gupta on 18/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MeProQuizReport.h"
#import "MBCircularProgressBarView.h"
#import "MeProDashboard.h"
#import "MePro_Remediation.h"
#import "MeProTestInstruction.h"



@interface MeProQuizReport ()
{
    UIView * bar;
     UIButton *backBtn;
    UIView * headerView;
    UIScrollView *bgView;
   
    NSMutableArray * tempskillwithCount;
    UILabel * progressLbl;
    UITableView * skillTbl;
       //NSArray * skillArr ;
    BOOL isShowRemedian;
    UIView * backG;
    UIView * remediationView;
    UIButton *continueBtn;
    NSMutableArray * skill_progress;
    UIButton * insText,*crossbtn;
    UIView *testPopUp;
    NSDictionary * quizAddtionalProperty;
    
    
}

@end

@implementation MeProQuizReport

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
        [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
        self.navigationController.navigationBarHidden = YES;
        
        bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
        bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [self.view addSubview:bar];
        
    
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.TopicName];
        lbl.font = [UIFont systemFontOfSize:10.0];
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
         
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
        lblquiz.font = [UIFont systemFontOfSize:13.0];
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
        isShowRemedian = FALSE;
        
        quizAddtionalProperty = [appDelegate.engineObj getQuizOrAssementData:[self.testOBj valueForKey:@"uid"]:[[self.testOBj valueForKey:@"type"]intValue]];
        NSString * mapStr  = [quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_NO_SKILL_QUES]; //[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"map_ques_%@",[self.testOBj valueForKey:@"uid"]]];
         
         NSData *objectData1 = [mapStr dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary * mapObj  = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:objectData1 options:NSJSONReadingMutableContainers
         error:nil];
         
         
        NSString * __str = [quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_SKILLS]; // (NSString *) [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"skill_%@",[self.testOBj valueForKey:@"uid"]]];
           NSData *objectData = [__str dataUsingEncoding:NSUTF8StringEncoding];
           NSArray * __skillArr  = (NSArray *) [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers
         error:nil];
          tempskillwithCount =  [[NSMutableArray alloc]init];
         for (NSDictionary *skillObj in __skillArr) {
             NSMutableDictionary * tempObj = [[NSMutableDictionary alloc]init];
              [tempObj setValue:[skillObj valueForKey:@"skill_id"] forKey:@"skill_id"];
              NSDictionary * obj = (NSDictionary *)[mapObj valueForKey:[[NSString alloc]initWithFormat:@"%@",[skillObj valueForKey:@"skill_id"]]];
              
              [tempObj setValue:[obj valueForKey:@"qCount"] forKey:@"quesCount"];
              [tempObj setValue:[obj valueForKey:@"skill_name"] forKey:@"skill_name"];
              [tempObj setValue:@"0" forKey:@"isComplete"];
             [tempskillwithCount addObject:tempObj];
             
          }
         
         
    
    
        int question_count = [[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION]intValue];// [[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"total_show_question_%@",[self.testOBj valueForKey:@"uid"]]]intValue];
        
        bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
        bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        
        [self.view addSubview:bgView];
        
        UIView * _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 30)];
        _view.backgroundColor = [self getUIColorObjectFromHexString:QUIZPROGRESSBARCOLOR alpha:1.0];
        progressLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _view.frame.size.width-10, 30)];
        progressLbl.backgroundColor = [self getUIColorObjectFromHexString:QUIZPROGRESSBARCOLOR alpha:1.0];
        progressLbl.text = @"100% completed";
        progressLbl.font = [UIFont systemFontOfSize:12.0];
        progressLbl.textAlignment = NSTextAlignmentRight;
        progressLbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [_view addSubview:progressLbl];
        [bgView addSubview:_view];
        
        
        backG = [[UIView alloc]initWithFrame:CGRectMake(15, 40,bgView.frame.size.width-30,bgView.frame.size.height-80)];
        backG.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        backG.layer.cornerRadius = 10.0;
        backG.layer.masksToBounds = YES;
        [bgView addSubview:backG];
        
        UILabel * welcomelbl =  [[UILabel alloc]initWithFrame:CGRectMake(10, 15, backG.frame.size.width-20, 20)];
        welcomelbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        welcomelbl.text = [[NSString alloc]initWithFormat:@"%@ %@: %@ Score",LEVEL_TEXT,self.selectedLevel,self.quizName];
        welcomelbl.font = [UIFont systemFontOfSize:12.0];
        welcomelbl.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
        welcomelbl.textAlignment = NSTextAlignmentLeft;
        [backG addSubview:welcomelbl];
    
    
       UILabel * namelbl =  [[UILabel alloc]initWithFrame:CGRectMake(10, 40, backG.frame.size.width-20, 20)];
       namelbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
       namelbl.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.global_userInfo valueForKey:@"userName"]];
       namelbl.font = [UIFont systemFontOfSize:12.0];
       namelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
       namelbl.textAlignment = NSTextAlignmentLeft;
       [backG addSubview:namelbl];
    
    
        UILabel * emaillbl =  [[UILabel alloc]initWithFrame:CGRectMake(10, 65, backG.frame.size.width-20, 20)];
        emaillbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        emaillbl.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.global_userInfo valueForKey:@"loginid"]];
        emaillbl.font = [UIFont systemFontOfSize:12.0];
        emaillbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        emaillbl.textAlignment = NSTextAlignmentLeft;
        [backG addSubview:emaillbl];
    
    
        UILabel * scorelbl =  [[UILabel alloc]initWithFrame:CGRectMake(10, 90, backG.frame.size.width-20, 40)];
        scorelbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        NSInteger percent = ([self.correctAns integerValue]*100)/question_count;
        scorelbl.text = [[NSString alloc]initWithFormat:@"%ld%%",percent];
        scorelbl.font = [UIFont boldSystemFontOfSize:30.0];
        scorelbl.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        scorelbl.textAlignment = NSTextAlignmentLeft;
        [backG addSubview:scorelbl];
        
        
        
        UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(40, 135, 100, 20)];
        TText.font = [UIFont systemFontOfSize:12.0];
        TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [backG addSubview:TText];
        
        UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 135, 20, 20)];
       
        [backG addSubview:Timg];
        
        UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        Timg.image = T_img;
        [Timg setTintColor:[self getUIColorObjectFromHexString:@"#00a5a4" alpha:1.0]];
        
        UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(backG.frame.size.width/2+30, 135, 100, 20)];
        QText.font = [UIFont systemFontOfSize:12.0];
        QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [backG addSubview:QText];
    
    
        UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(backG.frame.size.width/2+5 , 135, 20, 20)];
        [backG addSubview:Qimg];
        UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        Qimg.image = Q_img;
         
        [Qimg setTintColor:[self getUIColorObjectFromHexString:@"#63c033" alpha:1.0]];
        
        int question = [self.correctAns intValue] ;//[[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"C_QuesCount_%@",[[topicDataArr objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID]]]intValue];
    //
        int count = [self.duration intValue];
        int interval = count/(int)1000;
    

        
        
        if(question > 1 )
            QText.text = [[NSString alloc]initWithFormat:@"%d/%d Questions",question,question_count ];
        else
            QText.text = [[NSString alloc]initWithFormat:@"%d/%d Question",question,question_count];
        
        TText.text = [[NSString alloc]initWithFormat:@"%d s",interval];
       
        
    
    
    
    
//    NSString * str = (NSString *) [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"skill_%@",[self.testOBj valueForKey:@"uid"]]];
//    NSData *objectData = [str dataUsingEncoding:NSUTF8StringEncoding];
//
//    skillArr  = (NSArray *) [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers
//      error:nil];
    
    int rowcount = [tempskillwithCount count]/2;
    int reminder =  [tempskillwithCount count]%2;
    
    int height = 190;
    
    
    skillTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 190,backG.frame.size.width,height) style:UITableViewStylePlain];
    [backG addSubview:skillTbl];
    [skillTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    skillTbl.delegate = self;
    skillTbl.dataSource = self;
    skillTbl.tableFooterView = [UIView new];
    skillTbl.bounces =  FALSE;
    skillTbl.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    
    
    
    
    
    if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 2)
    {
    
        remediationView = [[UIView alloc]initWithFrame:CGRectMake(15, backG.frame.size.height+50 ,bgView.frame.size.width-30,150)];
        remediationView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        remediationView.layer.cornerRadius = 10.0;
        remediationView.hidden = TRUE;
        remediationView.layer.masksToBounds = YES;
    
        UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(15, 5,remediationView.frame.size.width-50 , remediationView.frame.size.height-50)];
        msg.text = @"Before we jump to the review test, let us help to you strengthen your low performing skills via personalized remediation";
        msg.numberOfLines = 4;
        msg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        msg.font = [UIFont systemFontOfSize:12.0];
        msg.lineBreakMode = NSLineBreakByWordWrapping;
        [remediationView addSubview:msg];
    
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(remediationView.frame.size.width-33, ((remediationView.frame.size.height-45)/2)-15 , 30, 30)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:@"MePro_ReadQ.png"];
    
        [remediationView addSubview:imgView];
        UIButton *remeditionBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,remediationView.frame.size.height-45, remediationView.frame.size.width-80,UIBUTTONHEIGHT)];
        [remeditionBtn setTitle:@"Remediation" forState:UIControlStateNormal];
        remeditionBtn.titleLabel.font = BUTTONFONT;
        [remeditionBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
        [remeditionBtn.layer setMasksToBounds:YES];
        remeditionBtn.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff"  alpha:1.0];
        [remeditionBtn.layer setCornerRadius:BUTTONROUNDRECT];
        [remeditionBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
        [remeditionBtn.layer setBorderWidth:1];
    
        [remeditionBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [remeditionBtn setHighlighted:YES];
        [remeditionBtn addTarget:self action:@selector(clickNextScreen) forControlEvents:UIControlEventTouchUpInside];
        [remediationView addSubview:remeditionBtn];
        [bgView addSubview:remediationView];
        
        
        continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(55,backG.frame.size.height+50, remediationView.frame.size.width-80,UIBUTTONHEIGHT)];
        [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
        continueBtn.titleLabel.font = BUTTONFONT;
        [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
        [continueBtn.layer setMasksToBounds:YES];
        continueBtn.hidden = FALSE;
        continueBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
        [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
        [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
        [continueBtn.layer setBorderWidth:1];
        [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [continueBtn setHighlighted:YES];
        [continueBtn addTarget:self action:@selector(clickBackScreen) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:continueBtn];
        bgView.contentSize = CGSizeMake(bgView.frame.size.width, backG.frame.size.height+100);
  }
  else if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 3 )
  {
           remediationView = [[UIView alloc]initWithFrame:CGRectMake(15, backG.frame.size.height+50 ,bgView.frame.size.width-30,150)];
         [bgView addSubview:remediationView];
          remediationView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
          remediationView.layer.cornerRadius = 10.0;
          remediationView.hidden = FALSE;
          remediationView.layer.masksToBounds = YES;
      
          UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(15, 5,remediationView.frame.size.width-50 , remediationView.frame.size.height-40)];
           if(percent >= appDelegate.review_passing_percentage)
              msg.text = @"You’ve unlocked the next module! Continue with your learning journey";
           else
               msg.text = @"Retake the review test, improve your score & get access to rest of the learning modules";
          msg.numberOfLines = 4;
          msg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
          msg.font = [UIFont systemFontOfSize:12.0];
          msg.lineBreakMode = NSLineBreakByWordWrapping;
          [remediationView addSubview:msg];
      
          UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(remediationView.frame.size.width-33, ((remediationView.frame.size.height-45)/2)-15 , 30, 30)];
          imgView.contentMode = UIViewContentModeScaleAspectFit;
          if(percent >= appDelegate.review_passing_percentage)
             imgView.image = [UIImage imageNamed:@"mepro_review_success.png"];
         else
            imgView.image = [UIImage imageNamed:@"MePro_ReadQ.png"];
      
          [remediationView addSubview:imgView];
      
      
       
      continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(55,backG.frame.size.height+210, remediationView.frame.size.width-80,UIBUTTONHEIGHT)];
      if(percent >= appDelegate.review_passing_percentage){
         [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
          [continueBtn addTarget:self action:@selector(clickBackScreen) forControlEvents:UIControlEventTouchUpInside];
      }
      else
      {
          [continueBtn setTitle:@"Retake The Test" forState:UIControlStateNormal];
          [continueBtn addTarget:self action:@selector(clickStartQuesAgain) forControlEvents:UIControlEventTouchUpInside];
      }
      
      continueBtn.titleLabel.font = BUTTONFONT;
      [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
      [continueBtn.layer setMasksToBounds:YES];
      continueBtn.hidden = FALSE;
      continueBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
      [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
      [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
      [continueBtn.layer setBorderWidth:1];
      [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
      [continueBtn setHighlighted:YES];
      
      [bgView addSubview:continueBtn];
      bgView.contentSize = CGSizeMake(bgView.frame.size.width, backG.frame.size.height+260);
      
      if(percent < appDelegate.review_passing_percentage){
          UILabel * insImg = [[UILabel alloc]initWithFrame:CGRectMake(15, remediationView.frame.size.height-35,16, 16)];
          insImg.text = @"?";
          insImg.layer.masksToBounds = YES;
          insImg.layer.cornerRadius = 8.0;
          insImg.font = [UIFont systemFontOfSize:12];
          insImg.textAlignment = NSTextAlignmentCenter;
          insImg.textColor = [UIColor whiteColor];
          insImg.backgroundColor = [self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0];
          [remediationView addSubview:insImg];
      
          NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"Why should i take the test?"];
          [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
      
      
          insText  = [[UIButton alloc] initWithFrame:CGRectMake(32, remediationView.frame.size.height-35,remediationView.frame.size.width-75 , 20)];
          [insText setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
      
          [insText setAttributedTitle:tncString1 forState:UIControlStateNormal];
          [insText setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
          insText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
          insText.titleLabel.font = [UIFont systemFontOfSize: 12];
          [insText addTarget:self action:@selector(openPopUp) forControlEvents:UIControlEventTouchUpInside];
          [remediationView addSubview:insText];
      
      }
    
  }
  else if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 4)
  {
     
        remediationView = [[UIView alloc]initWithFrame:CGRectMake(15, backG.frame.size.height+50 ,bgView.frame.size.width-30,150)];
       [bgView addSubview:remediationView];
            remediationView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            remediationView.layer.cornerRadius = 10.0;
            remediationView.hidden = FALSE;
            remediationView.layer.masksToBounds = YES;
        
            UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(15, 5,remediationView.frame.size.width-50 , remediationView.frame.size.height-50)];
             if(percent >= appDelegate.level_passing_score)
                msg.text = @"Congratulations! You’ve made it to the next level ";
             else
                 msg.text = @"Retake the Level test, improve your score & get access to rest of the learning modules";
            msg.numberOfLines = 4;
            msg.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            msg.font = [UIFont systemFontOfSize:12.0];
            msg.lineBreakMode = NSLineBreakByWordWrapping;
            [remediationView addSubview:msg];
        
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(remediationView.frame.size.width-33, ((remediationView.frame.size.height-45)/2)-15 , 30, 30)];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            if(percent >= appDelegate.level_passing_score)
               imgView.image = [UIImage imageNamed:@"levelthumb.png"];
           else
              imgView.image = [UIImage imageNamed:@"review.png"];
        
            [remediationView addSubview:imgView];
        
        
        
        continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(55,backG.frame.size.height+210, remediationView.frame.size.width-80,UIBUTTONHEIGHT)];
        if(percent >= appDelegate.level_passing_score){
           [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
            [continueBtn addTarget:self action:@selector(clickBackScreen) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [continueBtn setTitle:@"Retake The Test" forState:UIControlStateNormal];
            [continueBtn addTarget:self action:@selector(clickStartQuesAgain) forControlEvents:UIControlEventTouchUpInside];
        }
        
        continueBtn.titleLabel.font = BUTTONFONT;
        [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
        [continueBtn.layer setMasksToBounds:YES];
        continueBtn.hidden = FALSE;
        continueBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
        [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
        [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
        [continueBtn.layer setBorderWidth:1];
        [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [continueBtn setHighlighted:YES];
        
        [bgView addSubview:continueBtn];
        bgView.contentSize = CGSizeMake(bgView.frame.size.width, backG.frame.size.height+260);
        
        if(percent < appDelegate.level_passing_score){
            UILabel * insImg = [[UILabel alloc]initWithFrame:CGRectMake(15, remediationView.frame.size.height-35,16, 16)];
            insImg.text = @"?";
            insImg.layer.masksToBounds = YES;
            insImg.layer.cornerRadius = 8.0;
            insImg.font = [UIFont systemFontOfSize:12];
            insImg.textAlignment = NSTextAlignmentCenter;
            insImg.textColor = [UIColor whiteColor];
            insImg.backgroundColor = [self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0];
            [remediationView addSubview:insImg];
        
            NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"Why should i take the test?"];
            [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
        
        
            insText  = [[UIButton alloc] initWithFrame:CGRectMake(32, remediationView.frame.size.height-35,remediationView.frame.size.width-75 , 20)];
            [insText setTitleColor:[UIColor grayColor]
                      forState:UIControlStateHighlighted];
        
            [insText setAttributedTitle:tncString1 forState:UIControlStateNormal];
            [insText setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
            insText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            insText.titleLabel.font = [UIFont systemFontOfSize: 12];
            [insText addTarget:self action:@selector(openPopUp) forControlEvents:UIControlEventTouchUpInside];
            [remediationView addSubview:insText];
        
        }
  }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                               selector:@selector(readResponseReport:)
                                                   name:SERVICE_LEVELUP
       
                                                 object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_LEVELUP object:nil];
    
}

   

 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 0)];
        return headerView;
    }

 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
    {
        NSString *sectionName;
        switch (section)
        {
            case 0:
                sectionName = @"";
                break;
                
            default:
                sectionName = @"";
                break;
        }
        return sectionName;
    }
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
      return 1;
    }

 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        int count    =  [tempskillwithCount count]/2;
        int reminder =  [tempskillwithCount count]%2;
        
        return count +reminder;
    }

 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        static NSString *liqvidIdentifier = @"wileyAssignmentCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
        UIView *ReadingL;
        UIView *ReadingR;

        NSMutableDictionary * courseObj;
        NSMutableDictionary * courseObj1;
        
        if([tempskillwithCount count] > 2*(indexPath.row))
           courseObj = [tempskillwithCount objectAtIndex:2*(indexPath.row)];
        else
           courseObj = NULL;
        
        
        if([tempskillwithCount count] > 2*(indexPath.row)+1)
           courseObj1 = [tempskillwithCount objectAtIndex:2*(indexPath.row)+1];
        else
           courseObj1 = NULL;
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
            cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
            cell.accessoryView = nil;
            
            
            ReadingL = [[UIView alloc]initWithFrame:CGRectMake(0, 10, tableView.frame.size.width/2, 80)];
            ReadingL.tag = 1;
            [cell.contentView addSubview:ReadingL];
            
            ReadingR = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2, 10, tableView.frame.size.width/2, 80)];
            ReadingR.tag = 2;
            [cell.contentView addSubview:ReadingR];
                 
        }
        else
        {
            ReadingL = (UIView *)[cell.contentView viewWithTag :1];
            ReadingR = (UIView *)[cell.contentView viewWithTag :2];
            
        }
        
        
        for (UIView *view in ReadingL.subviews) {
            [view removeFromSuperview];
        }
        
        for (UIView *view in ReadingR.subviews) {
            [view removeFromSuperview];
        }

         
        UIView *readingL = [[UIView alloc]initWithFrame:CGRectMake(ReadingL.frame.size.width/2-30, 0, 60, 60)];
        [ReadingL addSubview:readingL];
        NSString * skill_id = [[NSString alloc]initWithFormat:@"%d",[[courseObj valueForKey:@"skill_id"] intValue]];
        NSString * color =  [appDelegate.skillDict valueForKey:skill_id];
        int totalSskillQues = 6;
        MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
        generalP.frame = CGRectMake(0,0, readingL.frame.size.width, readingL.frame.size.width);
        generalP.backgroundColor = [UIColor whiteColor];
        [generalP setUnitString:@"%"];
        
        int score = [self skillProgress :[[courseObj valueForKey:@"skill_id"] intValue] total_skill_ques:totalSskillQues];
        if(score <  60 )
        {
            if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 2){
                isShowRemedian = TRUE;
                [courseObj setValue:@"1" forKey:@"isComplete"];
            }
        }
        [generalP setValue:score];
        
        [generalP setMaxValue:100.0f];
        [generalP setBorderPadding:1.f];
        [generalP setProgressAppearanceType:0];
        [generalP setProgressRotationAngle:0.f];
        [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
        [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
        [generalP setProgressCapType:kCGLineCapRound];
        [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
        [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
        [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
        [generalP setEmptyLineWidth:3.f];
        [generalP setProgressLineWidth:3.f];
        [generalP setProgressAngle:100.f];
        [generalP setUnitFontSize:12];
        [generalP setValueFontSize:12];
        [generalP setValueDecimalFontSize:-1];
        [generalP setDecimalPlaces:1];
        [generalP setShowUnitString:YES];
        [generalP setShowValueString:YES];
        [generalP setValueFontName:@"HelveticaNeue-Bold"];
        [generalP setTextOffset:CGPointMake(0, 0)];
        [generalP setUnitFontName:@"HelveticaNeue"];
        [generalP setCountdown:NO];
        [readingL addSubview:generalP];
        
       UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, ReadingL.frame.size.width, 15)];
        readingTextL.font = [UIFont systemFontOfSize:12.0];
        readingTextL.textAlignment = NSTextAlignmentCenter;
        readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        readingTextL.text = [appDelegate.skillNameDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[courseObj valueForKey:@"skill_id"]]];
        [ReadingL addSubview:readingTextL];
        
        
        if(courseObj1 != NULL)
        {
        UIView *readingR = [[UIView alloc]initWithFrame:CGRectMake(ReadingR.frame.size.width/2-30, 0, 60, 60)];
         [ReadingR addSubview:readingR];
         NSString * skill_id = [[NSString alloc]initWithFormat:@"%d",[[courseObj1 valueForKey:@"skill_id"] intValue]];
         int totalSskillQues = 6;
         NSString * color =  [appDelegate.skillDict valueForKey:skill_id];
         MBCircularProgressBarView * generalP = [[MBCircularProgressBarView alloc]init];
         generalP.frame = CGRectMake(0,0, readingR.frame.size.width, readingR.frame.size.width);
         generalP.backgroundColor = [UIColor whiteColor];
         [generalP setUnitString:@"%"];
            int score = [self skillProgress :[[courseObj1 valueForKey:@"skill_id"] intValue] total_skill_ques:totalSskillQues];
           if(score <  60 )
            {
                if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 2){
                    isShowRemedian = TRUE;
                    [courseObj1 setValue:@"1" forKey:@"isComplete"];
                }
            }
            
         [generalP setValue:score];
         [generalP setMaxValue:100.0f];
         [generalP setBorderPadding:1.f];
         [generalP setProgressAppearanceType:0];
         [generalP setProgressRotationAngle:0.f];
         [generalP setProgressStrokeColor:[self getUIColorObjectFromHexString:color alpha:1.0]];
         [generalP setProgressColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
         [generalP setProgressCapType:kCGLineCapRound];
         [generalP setEmptyLineColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
         [generalP setEmptyLineStrokeColor:[self getUIColorObjectFromHexString:@"#e5e5e5" alpha:1.0]];
         [generalP setFontColor: [self getUIColorObjectFromHexString:color alpha:1.0]];
         [generalP setEmptyLineWidth:3.f];
         [generalP setProgressLineWidth:3.f];
         [generalP setProgressAngle:100.f];
         [generalP setUnitFontSize:12];
         [generalP setValueFontSize:12];
         [generalP setValueDecimalFontSize:-1];
         [generalP setDecimalPlaces:1];
         [generalP setShowUnitString:YES];
         [generalP setShowValueString:YES];
         [generalP setValueFontName:@"HelveticaNeue-Bold"];
         [generalP setTextOffset:CGPointMake(0, 0)];
         [generalP setUnitFontName:@"HelveticaNeue"];
         [generalP setCountdown:NO];
         [readingR addSubview:generalP];
         UILabel * readingTextR = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, ReadingR.frame.size.width, 15)];
         readingTextR.font = [UIFont systemFontOfSize:12.0];
            readingTextR.textAlignment = NSTextAlignmentCenter;
         readingTextR.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         readingTextR.text =[appDelegate.skillNameDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[courseObj1 valueForKey:@"skill_id"]]];
         [ReadingR addSubview:readingTextR];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        if(isShowRemedian && [[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 2)
        {
            remediationView.hidden = FALSE;
            continueBtn.frame = CGRectMake(55,backG.frame.size.height+210, remediationView.frame.size.width-80,40);
            bgView.contentSize = CGSizeMake(bgView.frame.size.width, bgView.frame.size.height+260);
        }
         return cell;
    }
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
       return 0.0;
    }
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
      return 95.0;
    }
    
-(int)skillProgress :(int)skill_id total_skill_ques : (int )count
    {
        int rightCount = 0;
        for (NSDictionary *obj in self.trackArr) {
            if([[obj valueForKey:@"skill_id"]integerValue] == skill_id && [[obj valueForKey:@"ans_uniqid"]integerValue] == 1 )
            {
                
                rightCount ++;
            }
        }
        return (rightCount*100) / count;
    }




-(void)clickNextScreen
{
    MePro_Remediation * meproObj =  [[MePro_Remediation alloc]initWithNibName:@"MePro_Remediation" bundle:nil];
    meproObj.selectedLevel  = self.selectedLevel;
    meproObj.quizName = @"Remediation";
    meproObj.skillArr  = tempskillwithCount;
    meproObj.testOBj  = self.testOBj;
    meproObj.remediationEdgeId   = [self.testOBj valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
    
    [self.navigationController pushViewController:meproObj animated:YES];
}

-(void)clickStartQuesAgain
{
    MeProTestInstruction * instructObj = [[MeProTestInstruction alloc]initWithNibName:@"MeProTestInstruction" bundle:nil];
    instructObj.testOBj = self.testOBj;
    instructObj.selectedLevel = self.selectedLevel;
    instructObj.TopicName = self.TopicName;
    [self.navigationController pushViewController:instructObj animated:YES];
}

-(void)clickBackScreen
{

    if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 4)
    {
        
        
        
        NSString * curr_level = [[NSString alloc]initWithFormat:@"%@",self.selectedLevel];
        
        
        
        NSMutableDictionary * override = [[NSMutableDictionary alloc] init];
        [override setValue:curr_level forKey:@"current_level"];
        [override setValue:appDelegate.product_id forKey:@"product_id" ];
        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
        [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
        [reqObj setValue:JSON_UPGRADEFORMAT forKey:JSON_DECREE ];
        [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
        [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
        [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
        [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
        [reqObj setObject:CLIENT forKey:JSON_CLIENT];
        [reqObj setValue:override forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_LEVELUP forKey:@"SERVICE"];
        
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
        [self showGlobalProgress];
        return;
    }
    
    NSArray *array = [self.navigationController viewControllers];
    
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProDashboard class]]){
            MeProDashboard * meProObj = (MeProDashboard *)viewCObj;
            if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 4)
            {
              meProObj.isFlowContinue = FALSE;
            }
            else
            {
                meProObj.isFlowContinue = TRUE;
            }
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            return;
        }
    }
}


-(void)openPopUp
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
    testPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [testPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/4,SCREEN_WIDTH-60,SCREEN_HEIGHT/2-30)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [testPopUp addSubview:roundBlock];
    
    
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,roundBlock.frame.size.width-10 , 20)];
    hint1Text.text = @"Why should i take this test?";
    hint1Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint1Text.textAlignment = NSTextAlignmentLeft;
    hint1Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint1Text];
    
    UILabel * _hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 30,10 , 30)];
    _hint2Text.text = @"\u2022 ";
    _hint2Text.textColor = [UIColor redColor];
    _hint2Text.font = [UIFont boldSystemFontOfSize:12.0];
    [roundBlock addSubview:_hint2Text];
    
    UILabel * hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(20, 30,roundBlock.frame.size.width-40 , 60)];
    hint2Text.text = @"Instant accurate results to help learners get mapped to their current English proficiency level";
    hint2Text.numberOfLines = 3;
    hint2Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint2Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint2Text];
    
     UILabel * _hint3Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 90,10, 25)];
       _hint3Text.text = @"\u2022  ";
       _hint3Text.numberOfLines = 3;
       _hint3Text.lineBreakMode = NSLineBreakByWordWrapping;
       _hint3Text.textColor = [UIColor redColor];
       _hint3Text.font = [UIFont boldSystemFontOfSize:12.0];
       
       [roundBlock addSubview:_hint3Text];
    
    UILabel * hint3Text = [[UILabel alloc]initWithFrame:CGRectMake(20, 90,roundBlock.frame.size.width-40 , 40)];
    hint3Text.text = @"Evalution across writing, listening, reading, grammar and vocabulary";
    hint3Text.numberOfLines = 3;
    hint3Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint3Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint3Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint3Text];
    
    
    
    UILabel * _hint4Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 130,10 , 17)];
    _hint4Text.text = @"\u2022 ";
    _hint4Text.numberOfLines = 3;
    _hint4Text.lineBreakMode = NSLineBreakByWordWrapping;
    _hint4Text.textColor = [UIColor redColor];
    _hint4Text.font = [UIFont boldSystemFontOfSize:12.0];
    
    [roundBlock addSubview:_hint4Text];
    
    
    UILabel * hint4Text = [[UILabel alloc]initWithFrame:CGRectMake(20, 130,roundBlock.frame.size.width-40 , 30)];
    hint4Text.text = @"Accurate GSE score(10-90) mapped to CEFR";
    hint4Text.numberOfLines = 3;
    hint4Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint4Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint4Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint4Text];
    
    
    UILabel * _hint5Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 160,10 , 30)];
    _hint5Text.text = @"\u2022 ";
    _hint5Text.numberOfLines = 3;
    _hint5Text.lineBreakMode = NSLineBreakByWordWrapping;
    _hint5Text.textColor = [UIColor redColor];
    _hint5Text.font = [UIFont boldSystemFontOfSize:12.0];
    
    [roundBlock addSubview:_hint5Text];
    
    
    
    UILabel * hint5Text = [[UILabel alloc]initWithFrame:CGRectMake(20, 160,roundBlock.frame.size.width-40 , 60)];
    hint5Text.text = @"Uses integrated skill testing -  dual skill such as listening & writing,listening and speaking tested together to reflect real life circumstances";
    hint5Text.numberOfLines = 3;
    hint5Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint5Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint5Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint5Text];
    

    
    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, 75, 20, 20)];
   
    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
    [crossbtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
    [testPopUp addSubview:crossbtn];
    
    
    [self.view addSubview:testPopUp];
}
-(void)hidePopUp
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
    
    
}




-(void)openlevelPopUp :(NSString * )level
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
    testPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [testPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7]];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/4,SCREEN_WIDTH-60,SCREEN_HEIGHT/2-30)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [testPopUp addSubview:roundBlock];
    
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(roundBlock.frame.size.width/2-75, 10, 150, 75)];
    img.image = [UIImage imageNamed:@"levelup.png"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [roundBlock addSubview:img];
    
    
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 95,roundBlock.frame.size.width-20 , 40)];
    //int level = [self.selectedLevel intValue] +1;
    hint1Text.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,level];
    hint1Text.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    hint1Text.textAlignment = NSTextAlignmentCenter;
    hint1Text.font = [UIFont boldSystemFontOfSize:30.0];
    
    [roundBlock addSubview:hint1Text];
    
    UILabel * hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 150,roundBlock.frame.size.width-20 , 30)];
    hint2Text.text = @"Congratulations! You’ve made it to the next level";
    hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint2Text.numberOfLines = 2;
    hint2Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint2Text.textAlignment = NSTextAlignmentCenter;
    hint2Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint2Text];
    
    
    
    
    continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,roundBlock.frame.size.height-50, roundBlock.frame.size.width-80,UIBUTTONHEIGHT)];
    
       [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
        [continueBtn addTarget:self action:@selector(hidelevelPopUp) forControlEvents:UIControlEventTouchUpInside];
   
    continueBtn.titleLabel.font = BUTTONFONT;
    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    [continueBtn.layer setMasksToBounds:YES];
    continueBtn.hidden = FALSE;
    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
    [continueBtn.layer setBorderWidth:1];
    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [continueBtn setHighlighted:YES];
    
    [roundBlock addSubview:continueBtn];
    
    
    

    
    
//    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, 75, 20, 20)];
//
//    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
//    [crossbtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
//    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
//    [testPopUp addSubview:crossbtn];
    
    
    [self.view addSubview:testPopUp];
}
-(void)hidelevelPopUp
{
    if(testPopUp != NULL)
    {
        [testPopUp removeFromSuperview];
        testPopUp = NULL;
    }
    NSArray *array = [self.navigationController viewControllers];
    
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProDashboard class]]){
            appDelegate.workingCourseObj = NULL;
            if([self.selectedLevel isEqualToString:appDelegate.GSE_level] ){
                MeProDashboard * obj = (MeProDashboard *)viewCObj;
                obj.updateFlag = 2;
                
                
            }
            else
            {
                MeProDashboard * obj = (MeProDashboard *)viewCObj;
                obj.updateFlag = 1;

            }
            
            MeProDashboard * meProObj = (MeProDashboard *)viewCObj;
            meProObj.isFlowContinue = FALSE;
            meProObj.GSE_level = @"0";
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            return;
        }
    }
}
- (void)readResponseReport:(NSNotification *) notification
{
     [self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
       if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LEVELUP])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL && ![[temp valueForKey:@"retVal"] isEqual:[NSNull null]])
                {
                  NSDictionary * obj = [temp valueForKey:@"retVal"];
                  NSString * next_level = [[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"next_level"]];
                  NSArray *_arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:next_level];
                 appDelegate.GSE_level = [[NSString alloc]initWithFormat:@"%@",[obj valueForKey:@"user_current_level"]];
                  if([[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] == 0) return;
                
                 NSDictionary * courseObj = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] objectAtIndex:0];
                
                [self setLevelChangeBookmarks:[courseObj valueForKey:DATABASE_COURSE_DATA]];
                
                [self openlevelPopUp:next_level];
                }
                
               
                
                
            }
        }
        
    });
    
}



    @end
