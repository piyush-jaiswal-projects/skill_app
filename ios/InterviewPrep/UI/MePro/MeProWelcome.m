//
//  MeProWelcome.m
//  InterviewPrep
//
//  Created by Amit Gupta on 29/11/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProWelcome.h"
#import "MeProCEFRTestScore.h"
#import "MeProCEFRTest.h"

@interface MeProWelcome ()
{
    UIView * bar;
    UIScrollView *bgView;
    UIView * headerView;
    float  imageheight;
    UIButton * continueBtn;
    UIButton * insText;
    UILabel *lblTitle;
    UILabel *lblDesc;
    
    UIView * testPopUp;
    UIButton *crossbtn;
    
}

@end

@implementation MeProWelcome
-(void)skipTest
{
    appDelegate.lti_Test_Score = 47;
    appDelegate.GSE_level = @"4";
    appDelegate.CEFR_level = @"B1";
    appDelegate.GSE_desc = @"advance";
    MeProCEFRTestScore * scorelObj = [[MeProCEFRTestScore alloc]initWithNibName:@"MeProCEFRTestScore" bundle:nil];
    [self.navigationController pushViewController:scorelObj animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    
    UITapGestureRecognizer *dashGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(skipTest)];
    dashGasture.numberOfTapsRequired = 3;
    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20,SCREEN_WIDTH,SCREEN_HEIGHT-20)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bgView];
    imageheight = bgView.frame.size.height/4;
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,bgView.frame.size.width,imageheight)];
    bgView.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    UIImageView * bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width , bgView.frame.size.height)];
    bg.image = [UIImage imageNamed:@"mepro_bg.jpg"];
    [bgView addSubview:bg];
    headerView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:headerView];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, headerView.frame.size.width-60, headerView.frame.size.height)];
    [headerView addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    //img.userInteractionEnabled = TRUE;
    //[img addGestureRecognizer:dashGasture];
    img.image = [UIImage imageNamed:@"MePro-Logo.png"];
    
    
    
    
    
        lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight +10 , SCREEN_WIDTH-60,20)];
        lblTitle.font = [UIFont systemFontOfSize:18.0];
        lblTitle.text = @"Let's get Started!";
        lblTitle.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:lblTitle];
    
    
         lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight +40 , SCREEN_WIDTH-60,20)];
         lblDesc.frame = CGRectMake(30, imageheight+30 , SCREEN_WIDTH-60,20);
         lblDesc.font = [UIFont systemFontOfSize:11.0];
         lblDesc.text = @"Take a quick test to know youe current level";
         lblDesc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
         lblDesc.textAlignment = NSTextAlignmentCenter;
         [bgView addSubview:lblDesc];
    
    
    
    
    UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 2*(SCREEN_HEIGHT/3)-30, 60, 60)];
    [bgView addSubview:img1];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.image = [UIImage imageNamed:@"Big-Leaf.png"];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/3+30,SCREEN_WIDTH-60,SCREEN_HEIGHT/3)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [bgView addSubview:roundBlock];
    
    UIImageView * hint1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15,30,30)];
    hint1.image = [UIImage imageNamed:@"MPClock.png"];
    [roundBlock addSubview:hint1];
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(60, 20,roundBlock.frame.size.width-40 , 20)];
    hint1Text.text = @"10 - 15 Minutes";
    hint1Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint1Text.font = TEXTTITLEFONT;
    
    [roundBlock addSubview:hint1Text];
    
    
    UIImageView * hint2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, roundBlock.frame.size.height/2-20,30,30)];
    hint2.image = [UIImage imageNamed:@"MPAns.png"];
    [roundBlock addSubview:hint2];
    
    UILabel * hint2Text = [[UILabel alloc]initWithFrame:CGRectMake(60, roundBlock.frame.size.height/2-20,roundBlock.frame.size.width-80 , 40)];
    hint2Text.text = @"Adapted based on your answer";
    hint2Text.numberOfLines = 2;
    hint2Text.lineBreakMode = kCTLineBreakByWordWrapping;
    hint2Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint2Text.font =TEXTTITLEFONT;
    
    [roundBlock addSubview:hint2Text];
    
    UIImageView * hint3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, roundBlock.frame.size.height-50,30,30)];
    hint3.image = [UIImage imageNamed:@"MPheadphone.png"];
    [roundBlock addSubview:hint3];
    
    UILabel * hint3Text = [[UILabel alloc]initWithFrame:CGRectMake(60, roundBlock.frame.size.height-45,roundBlock.frame.size.width-40 , 20)];
    hint3Text.text = @"Headphone Required";
    hint3Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    hint3Text.font = TEXTTITLEFONT;
    
    [roundBlock addSubview:hint3Text];
    
    continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,SCREEN_HEIGHT-100, SCREEN_WIDTH-80,UIBUTTONHEIGHT)];
    [continueBtn setTitle:@"Take a test" forState:UIControlStateNormal];
    continueBtn.titleLabel.font = BUTTONFONT;
    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    
    [continueBtn.layer setMasksToBounds:YES];
    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [continueBtn.layer setBorderWidth:1];
    
    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [continueBtn setHighlighted:YES];
    
    [continueBtn addTarget:self action:@selector(nextScreen) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:continueBtn];
    
    
    UILabel * insImg = [[UILabel alloc]initWithFrame:CGRectMake(70, SCREEN_HEIGHT-50,16, 16)];
    insImg.text = @"?";
    insImg.layer.masksToBounds = YES;
    insImg.layer.cornerRadius = 8.0;
    insImg.font = [UIFont systemFontOfSize:12];
    insImg.textAlignment = NSTextAlignmentCenter;
    insImg.textColor = [UIColor whiteColor];
    insImg.backgroundColor = [self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0];
    [bgView addSubview:insImg];
    
    NSMutableAttributedString* tncString1 = [[NSMutableAttributedString alloc] initWithString:@"Why should i take the test?"];
    [tncString1 addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
    //[tncString1 addAttribute:NSUnderlineColorAttributeName value:[self getUIColorObjectFromHexString:PRIVACYCOLOR alpha:1.0] range:NSMakeRange(0, [tncString1 length])];
    
    
    //[tncString1 addAttribute:NSUnderlineStyleAttributeName
                      // value:@(NSUnderlineStyleSingle)
                      // range:(NSRange){15,[tncString1 length]-15}];
    
    insText  = [[UIButton alloc] initWithFrame:CGRectMake(90,SCREEN_HEIGHT-50, SCREEN_WIDTH-160,20)];
    [insText setTitleColor:[UIColor grayColor]
                  forState:UIControlStateHighlighted];
    
    [insText setAttributedTitle:tncString1 forState:UIControlStateNormal];
    [insText setTitleColor: [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    insText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    insText.titleLabel.font = [UIFont systemFontOfSize: 12];
    [insText addTarget:self action:@selector(openPopUp) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:insText];
    
}
-(void)nextScreen
{
    MeProCEFRTest * ltiTest = [[MeProCEFRTest alloc]initWithNibName:@"MeProCEFRTest" bundle:nil];
    [self.navigationController pushViewController:ltiTest animated:YES];
        
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
    
    
    
    UILabel * hint1Text = [[UILabel alloc]initWithFrame:CGRectMake(10, 15,roundBlock.frame.size.width-10 , 15)];
    hint1Text.text = @"Why should i take this test?";
    hint1Text.textColor = [UIColor blackColor];
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
    hint2Text.textColor = [UIColor blackColor];
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
    hint3Text.textColor = [UIColor blackColor];
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
    hint4Text.textColor = [UIColor blackColor];
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
    hint5Text.textColor = [UIColor blackColor];
    hint5Text.font = [UIFont systemFontOfSize:12.0];
    
    [roundBlock addSubview:hint5Text];
    

    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(roundBlock.frame.size.width-35, 5, 20, 20)];
    
    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
    
    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage* T_img =  [UIImage imageNamed:@"popup_close.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [crossbtn setImage:T_img forState:UIControlStateNormal];
    crossbtn.imageView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
    [roundBlock addSubview:crossbtn];
    
    
//    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-35, 75, 20, 20)];
//   
//    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
//    [crossbtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
//    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [crossbtn addTarget:self action:@selector(hidePopUp) forControlEvents:UIControlEventTouchUpInside];
//    [testPopUp addSubview:crossbtn];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
