//
//  MeProCEFRTestScore.m
//  InterviewPrep
//
//  Created by Amit Gupta on 29/11/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProCEFRTestScore.h"
#import "MeProIntroduction.h"

@interface MeProCEFRTestScore ()
{
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    UIButton * backBtn;
    UIButton * continueBtn;
    UIButton * insText;
    UILabel * lblIns;
    //int currentLevel;
    BOOL isFirst;
    
    
    UIView * testPopUp;
    UIButton *crossbtn;
    UITableView * levelTbl;
    UILabel * lft;
    UILabel * testScoreIns;
    NSString *  __GSE_level;
    
    
}

@end

@implementation MeProCEFRTestScore
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showGlobalProgress];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_LTISCORE forKey:JSON_DECREE ];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_LTISCORE forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}


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
    
    __GSE_level = @"0";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readTestScoreLoginResponse:)
                                                 name:SERVICE_LTISCORE
                                               object:nil];
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#e2eaed" alpha:1.0];
    [self.view addSubview:bgView];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(50, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-100, 44)];
    title.text = @"Score";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:title];
    
    
    UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width , bgView.frame.size.height)];
    bg.image = [UIImage imageNamed:@"mepro_bg.jpg"];
    
    
    UIView * upperView = [[UIView alloc]initWithFrame:CGRectMake(10, 10,bgView.frame.size.width-20,bgView.frame.size.height/2 -20)];
    upperView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:upperView];
    
    lft = [[UILabel alloc]initWithFrame:CGRectMake(0, 20,upperView.frame.size.width/2, 40)];
    lft.text =@"0";
    lft.textColor = [self getUIColorObjectFromHexString:@"#00a5a4" alpha:1.0];
    lft.textAlignment = NSTextAlignmentRight;
    lft.font = [UIFont boldSystemFontOfSize:35.0];
    [upperView addSubview:lft];
    
    UILabel * rgt = [[UILabel alloc]initWithFrame:CGRectMake(upperView.frame.size.width/2,40,upperView.frame.size.width/2, 15)];
    rgt.text =@"/ 90";
    rgt.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    rgt.textAlignment = NSTextAlignmentLeft;
    rgt.font = [UIFont systemFontOfSize:14.0];
    [upperView addSubview:rgt];
    
    
    UILabel * testText = [[UILabel alloc]initWithFrame:CGRectMake(0,60,upperView.frame.size.width , 15)];
    testText.text =@"TEST SCORE";
    testText.textColor = [self getUIColorObjectFromHexString:@"#898989" alpha:1.0];
    testText.textAlignment = NSTextAlignmentCenter;
    testText.font = [UIFont systemFontOfSize:12.0];
    [upperView addSubview:testText];
    
    
    lblIns = [[UILabel alloc]initWithFrame:CGRectMake(20, 95,upperView.frame.size.width-40, 60)];
    
    
    NSString * text =[[NSMutableString alloc]initWithFormat:@"Hi %@, you have been placed at Advance Score on GSE and B1 in CEFR",[appDelegate getFirstName]];
    NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc] initWithString:text];
    [attrS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(text.length-10, 10)];
    [attrS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(text.length-35, 20)];
    
    lblIns.attributedText = attrS;
    [lblIns setFont:[UIFont systemFontOfSize:16.0]];
    lblIns.numberOfLines = 3;
    lblIns.lineBreakMode =NSLineBreakByWordWrapping;
    [lblIns setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
    
    
    
    
    lblIns.textAlignment = NSTextAlignmentLeft;
    
    
    [upperView addSubview:lblIns];
    
    UILabel * insImg = [[UILabel alloc]initWithFrame:CGRectMake(20, 170,16, 16)];
    insImg.text = @"?";
    insImg.layer.masksToBounds = YES;
    insImg.layer.cornerRadius = 8.0;
    insImg.font = [UIFont systemFontOfSize:12];
    insImg.textAlignment = NSTextAlignmentCenter;
    insImg.textColor = [UIColor whiteColor];
    insImg.backgroundColor = [self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0];
    [upperView addSubview:insImg];
    
    NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"What is GSE and CEFR"];
    [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
    //[tncString1 addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
    
    
    //[tncString1 addAttribute:NSUnderlineStyleAttributeName
    // value:@(NSUnderlineStyleSingle)
    // range:(NSRange){15,[tncString1 length]-15}];
    
    insText  = [[UIButton alloc] initWithFrame:CGRectMake(40,170, 200,20)];
    [insText setTitleColor:[UIColor grayColor]
                  forState:UIControlStateHighlighted];
    
    [insText setAttributedTitle:tncString1 forState:UIControlStateNormal];
    [insText setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    insText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    insText.titleLabel.font = [UIFont systemFontOfSize: 12];
    [insText addTarget:self action:@selector(openPopUp) forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:insText];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, bgView.frame.size.height/2, bgView.frame.size.width-20, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    label.textColor = [self getUIColorObjectFromHexString:@"#898989" alpha:1.0];
    label.textAlignment = NSTextAlignmentLeft;
    NSString *string =@"Levels";
    [label setText:string];
    [bgView addSubview:label];
    
    
    
    UIView * lvlView = [[UIView alloc]initWithFrame:CGRectMake(10, bgView.frame.size.height/2+30,bgView.frame.size.width-20,30)];
    lvlView.backgroundColor = [UIColor whiteColor];
    lvlView.tag = 101;
    [bgView addSubview:lvlView];
    
//    for(int i=0;i<10;i++)
//    {
//        float x = i*(lvlView.frame.size.width/10);
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,0, lvlView.frame.size.width/10, 30)];
//        if(i == __GSE_level-1){
//            label.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
//            label.textColor = [UIColor whiteColor];
//        }
//        else
//        {
//            label.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//            label.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
//        }
//        [label setFont:[UIFont systemFontOfSize:12]];
//
//        label.textAlignment = NSTextAlignmentCenter;
//        [label setText:[[NSString alloc]initWithFormat:@"%d",i+1]];
//        [lvlView addSubview:label];
//    }
        
        
    
    
    testScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(30,240+(bgView.frame.size.height-280)/2, bgView.frame.size.width-60, 40)];
    testScoreIns.font = [UIFont systemFontOfSize: 16];
    testScoreIns.numberOfLines = 2;
    testScoreIns.textAlignment = NSTextAlignmentCenter;
    testScoreIns.lineBreakMode = NSLineBreakByWordWrapping;
    [testScoreIns setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
    
    [bgView addSubview:testScoreIns];
    
    
    continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,bgView.frame.size.height-50, SCREEN_WIDTH-80,UIBUTTONHEIGHT)];
    [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
    continueBtn.titleLabel.font = BUTTONFONT;
    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    [continueBtn.layer setMasksToBounds:YES];
    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [continueBtn.layer setBorderWidth:1];
    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [continueBtn setHighlighted:YES];
    [continueBtn addTarget:self action:@selector(clickNextScreen) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:continueBtn];
    
    
    
    // Do any additional setup after loading the view from its nib.
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
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(20,SCREEN_HEIGHT/5,SCREEN_WIDTH-40,SCREEN_HEIGHT-(2*SCREEN_HEIGHT/5))];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [testPopUp addSubview:roundBlock];
    
    
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 20,roundBlock.frame.size.width-10 , 20)];
    hint1Text.text = @"What is GSE and CEFR?";
    hint1Text.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint1Text.textAlignment = NSTextAlignmentLeft;
    hint1Text.font = [UIFont systemFontOfSize:16.0];
    
    [roundBlock addSubview:hint1Text];
    
    
    
    UILabel * hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 50,roundBlock.frame.size.width-20 , 140)];
    hint2Text.text = @"The Global Scale of English (GSE) is the first truly global English language standard. It extends the Common European Framework of Reference (CEFR) by pinpointing on a scale from 10 to 90 on what needs to be mastered for the four skills of speaking, listening, reading and writing within a CEFR level, using a more granular approach.";
    hint2Text.numberOfLines = 10;
    hint2Text.lineBreakMode = NSLineBreakByWordWrapping;
    hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint2Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint2Text];
    
    
    
    UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, roundBlock.frame.size.height-140,roundBlock.frame.size.width-20 , 130)];
    [roundBlock addSubview:img1];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.image = [UIImage imageNamed:@"level.jpg"];
    
    
    
    
    
    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(roundBlock.frame.size.width-35, 5, 20, 20)];
    
    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
    
    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage* T_img =  [UIImage imageNamed:@"popup_close.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [crossbtn setImage:T_img forState:UIControlStateNormal];
    crossbtn.imageView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
    [roundBlock addSubview:crossbtn];
    
    
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

-(void)clickNextScreen{
    MeProIntroduction * meProlObj = [[MeProIntroduction alloc]initWithNibName:@"MeProIntroduction" bundle:nil];
    [self.navigationController pushViewController:meProlObj animated:YES];
    
}

- (void)readTestScoreLoginResponse:(NSNotification *) notification
{
    [self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
    if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_LTISCORE])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL && [resUserData valueForKey:@"score"] != NULL )
                {
                    [self setUserLTIScore:resUserData];
                    
                    __GSE_level = [resUserData valueForKey:@"user_current_level"];
                    lft.text =[[NSString alloc]initWithFormat:@"%d",[[resUserData valueForKey:@"score"]intValue] ];
                    testScoreIns.text = [[NSString alloc]initWithFormat:@"Based on your score, you can directly jump to Level %@",__GSE_level];
                    
                    NSString * text =[[NSMutableString alloc]initWithFormat:@"Hi %@, you have been placed at %@ Score on GSE and %@ in CEFR",[appDelegate getFirstName],appDelegate.GSE_desc,appDelegate.CEFR_level];
                    NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc] initWithString:text];
                    [attrS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(text.length-10, 10)];
                    
                    [attrS addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(text.length-(28+appDelegate.GSE_desc.length), (13+appDelegate.GSE_desc.length))];
                    
                    lblIns.attributedText = attrS;
                    
                    UIView * lvlView = (UIView*)[bgView viewWithTag:101];
                    for (UIView *view in lvlView.subviews) {
                        [view removeFromSuperview];
                    }
                     NSMutableArray * levelDataArr = [appDelegate.engineObj getlevelArrayFromCourses:appDelegate.coursePack];
                    for(int i=0;i<[levelDataArr count];i++)
                    {
                        float x = i*(lvlView.frame.size.width/10);
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,0, lvlView.frame.size.width/10, 30)];
                        NSString *lvl = [[levelDataArr objectAtIndex:i]valueForKey:@"level"];
                        if([lvl isEqualToString:__GSE_level]){
                            label.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
                            label.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                        }
                        else
                        {
                            label.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                            label.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
                        }
                        [label setFont:[UIFont systemFontOfSize:12]];
                        
                        label.textAlignment = NSTextAlignmentCenter;
                        [label setText:[[NSString alloc]initWithFormat:@"%@",lvl]];
                        [lvlView addSubview:label];
                    }
                }
                else
                {
                    
                }
            }
            else
            {
                
            }
        }
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message: [[notification object]valueForKey:NETWORKDATA]
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            int duration = 2; // duration in seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            return;
        }
        
    });
    
}

@end
