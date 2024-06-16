//
//  MeProIntroduction.m
//  InterviewPrep
//
//  Created by Amit Gupta on 02/12/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MeProIntroduction.h"
#import "MeProDashboard.h"



@interface MeProIntroduction ()<UIScrollViewDelegate>
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

@implementation MeProIntroduction

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:LOGINSTATUSBARCOLOR alpha:1.0];
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
    img.image = [UIImage imageNamed:@"MePro-Logo.png"];
    
    lblDesc = [[UILabel alloc]initWithFrame:CGRectMake(30, imageheight , SCREEN_WIDTH-60,20)];
    //lblDesc.frame = CGRectMake(30,  , SCREEN_WIDTH-60,20);
    lblDesc.font = [UIFont systemFontOfSize:12.0];
    
    
    lblDesc.text = [[NSMutableString alloc]initWithFormat:@"Hi %@, welcome to MePro!",[appDelegate getFirstName]] ;
    lblDesc.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    lblDesc.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:lblDesc];
    
    
    
    
    UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2*(SCREEN_HEIGHT/3), 60, 60)];
    [bgView addSubview:img1];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.image = [UIImage imageNamed:@"leftLeaf.png"];
    
    UIView * roundBlock = [[UIView alloc]initWithFrame:CGRectMake(30,imageheight+30,SCREEN_WIDTH-60,SCREEN_HEIGHT/2+40)];
    roundBlock.backgroundColor = [UIColor whiteColor];
    roundBlock.layer.masksToBounds = YES;
    roundBlock.layer.cornerRadius = 8.0;
    [bgView addSubview:roundBlock];
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, roundBlock.frame.size.width, roundBlock.frame.size.height) configuration:theConfiguration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = false;
    webView.scrollView.bouncesZoom = false;
    webView.scrollView.bounces = false;
    NSURL *url = [[NSBundle mainBundle] URLForResource:MEPROINSTUCTIONHTMLPATH withExtension:@"html"];
    [webView loadFileURL:url allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
    [roundBlock addSubview:webView];
    
    continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,SCREEN_HEIGHT-50, SCREEN_WIDTH-80,UIBUTTONHEIGHT)];
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
    
    [continueBtn addTarget:self action:@selector(nextScreen) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:continueBtn];
    
    
}
-(void)nextScreen
{
    MeProDashboard * meproDashObj = [[MeProDashboard alloc]initWithNibName:@"MeProDashboard" bundle:nil];
    [self.navigationController pushViewController:meproDashObj animated:YES];
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
