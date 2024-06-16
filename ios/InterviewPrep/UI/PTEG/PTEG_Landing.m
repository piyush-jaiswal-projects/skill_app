//
//  PTEG_Landing.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Landing.h"
#import "PTEG_Registration.h"
#import "PTEG_Login.h"


@interface PTEG_Landing ()

@end

@implementation PTEG_Landing

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    
    
    pagingView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH,SCREEN_HEIGHT-110)];
    [self.view addSubview:pagingView];
    
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, pagingView.frame.size.width, pagingView.frame.size.height) configuration:theConfiguration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self ;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = false;
    webView.scrollView.bouncesZoom = false;
    webView.scrollView.bounces = false;
    NSURL *url = [[NSBundle mainBundle] URLForResource:PTEGINSTUCTIONHTMLPATH withExtension:@"html"];
    [webView loadFileURL:url allowingReadAccessToURL:[NSBundle mainBundle].bundleURL];
    [pagingView addSubview:webView];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH,100)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    UIButton * createAc  = [[UIButton alloc] initWithFrame:CGRectMake(40,bottomView.frame.size.height-90, bottomView.frame.size.width-80,UIBUTTONHEIGHT)];
    [createAc setTitle:@"Create Account" forState:UIControlStateNormal];
    createAc.titleLabel.font = BUTTONFONT;
    [createAc setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    
    [createAc.layer setMasksToBounds:YES];
    createAc.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
    [createAc.layer setCornerRadius:BUTTONROUNDRECT];
    [createAc.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
    [createAc.layer setBorderWidth:1];
    
    [createAc setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [createAc setHighlighted:YES];
    
     [createAc addTarget:self action:@selector(createAccountClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:createAc];
    
    
    UIButton * signIn  = [[UIButton alloc] initWithFrame:CGRectMake(40, bottomView.frame.size.height-40, SCREEN_WIDTH-80,30)];
    [signIn setTitle:@"Login" forState:UIControlStateNormal];
    signIn.titleLabel.font = BUTTONFONT;
    [signIn setTitleColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0] forState:UIControlStateNormal];
    signIn.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [signIn.layer setMasksToBounds:YES];
    [signIn.layer setCornerRadius:BUTTONROUNDRECT];
    [signIn.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
    [signIn.layer setBorderWidth:1];
    [signIn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [signIn setHighlighted:YES];
    [signIn addTarget:self action:@selector(loginScreenClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:signIn];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)createAccountClick
{
    PTEG_Registration * PTERegObj = [[PTEG_Registration alloc]initWithNibName:@"PTEG_Registration" bundle:nil];
    [self.navigationController pushViewController:PTERegObj animated:TRUE];
}

-(void)loginScreenClick
{
    PTEG_Login * PTELogObj = [[PTEG_Login alloc]initWithNibName:@"PTEG_Login" bundle:nil];
    [self.navigationController pushViewController:PTELogObj animated:TRUE];
}

@end
