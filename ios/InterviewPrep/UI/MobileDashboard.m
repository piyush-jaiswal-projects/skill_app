//
//  MobileDashboard.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "MobileDashboard.h"
#import "FAQ.h"
#import "FeedbackViewController.h"
#import "TestYourEnglish.h"
#import "MyAccountScreen.h"
#import "UIImageViewWithDownloading.h"
#import "UseFulResource.h"

@interface MobileDashboard ()
{
    UIView * bar;
    UIScrollView *bgView;
    UIImageViewWithDownloading * imgBg;
    UIImageView *img_logo;
    UILabel * img_lbl;
    
    UILabel *examOri;
    UIView * primilary;
    UIView *vintage;
    
    UILabel *PracticeLbl;
    UIView * prac1;
    UIView *prac2;
    
    UILabel *learningRes;
    UIView *bgLearning;
    UIView * test;
    UIView * usefulRes;
    UIView * books;
    
    UILabel *useRes;
     UIImageView *placeHolder;
    
    UIView * bootomUI;
    UIView *bootomUIBorder;
    
    UILabel * firstText,*secondText,*thirdText;
    
}

@property (strong, nonatomic) VCFloatingActionButton *addButton;
@end

@implementation MobileDashboard
@synthesize addButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
//    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,20)];
//    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    [self.view addSubview:bar];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-44)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    bgView.contentInsetAdjustmentBehavior = YES;
    [bgView setScrollEnabled:YES];
    bgView.showsVerticalScrollIndicator=YES;
    [bgView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+30)];
    [bgView setShowsHorizontalScrollIndicator:NO];
    [bgView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:bgView];
    
    int height =-20 ;
    
    imgBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0, height, bgView.frame.size.width,(bgView.frame.size.width*(.564)))];
    //
    NSString *imageUrl = HOMESPLASHSCREEN;
    UIImage *img = NULL;
    img = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(img == NULL ){
        imgBg.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:0.1];
        [imgBg setImageURLPath:imageUrl BlurImageLocalPath:HOMESPLASHBLURSCREEN];
    }
    else
    {
        imgBg.image = img;
        imgBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    imgBg.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imgBg];
    
    
    height = height + (bgView.frame.size.width*(.564))+10;
    
    examOri = [[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-10,20)];
    examOri.text = @"Exam Orientation";
    examOri.font = BOLDTEXTTITLEFONT;
    examOri.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [bgView addSubview:examOri];
    
    
    UIImageViewWithDownloading *priBg = NULL;
    UIImageViewWithDownloading *vinBg = NULL;
    UILabel *titleP = NULL;
    UILabel *DescP = NULL;
    UILabel *titleV = NULL;
    UILabel *DescV = NULL;
    
    UIImageViewWithDownloading *prac1bg = NULL;
    UIImageViewWithDownloading *prac2bg = NULL;
//    UILabel *titleprac1 = NULL;
//    UILabel *Descprac1 = NULL;
//    UILabel *titleprac2 = NULL;
//    UILabel *Descprac2 = NULL;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        height = height + 25;
        primilary = [[UIView alloc]initWithFrame:CGRectMake(10,height,(SCREEN_WIDTH/2)-15,180)];
        vintage = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)+5,height,(SCREEN_WIDTH/2)-15,180)];
        priBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,primilary.frame.size.width,100)];
        vinBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,vintage.frame.size.width,100)];
        titleP = [[UILabel alloc]initWithFrame:CGRectMake(5,100,primilary.frame.size.width,15)];
        DescP = [[UILabel alloc]initWithFrame:CGRectMake(5,130,primilary.frame.size.width,20)];
        titleV = [[UILabel alloc]initWithFrame:CGRectMake(5,100,vintage.frame.size.width,15)];
        DescV = [[UILabel alloc]initWithFrame:CGRectMake(5,130,vintage.frame.size.width,20)];
        
         height = height + 200;
        
        PracticeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-10,20)];
        
        height = height + 25;
        
        prac1 = [[UIView alloc]initWithFrame:CGRectMake(10,height,(SCREEN_WIDTH/2)-15,100)];
        prac2 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)+5,height,(SCREEN_WIDTH/2)-15,100)];
        prac1bg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,prac1.frame.size.width,100)];
        prac2bg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,prac2.frame.size.width,100)];
//        titleprac1 = [[UILabel alloc]initWithFrame:CGRectMake(5,100,prac1.frame.size.width,15)];
//        Descprac1 = [[UILabel alloc]initWithFrame:CGRectMake(5,135,prac1.frame.size.width,20)];
//        titleprac2 = [[UILabel alloc]initWithFrame:CGRectMake(5,100,prac2.frame.size.width,15)];
//        Descprac2 = [[UILabel alloc]initWithFrame:CGRectMake(5,135,prac2.frame.size.width,20)];
        
        height = height + 120;
        learningRes = [[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-10,20)];
        height = height + 35;
        bgLearning = [[UIView alloc]initWithFrame:CGRectMake(0,height,SCREEN_WIDTH,100)];
        height = height + 100;
        
    }else
    {
        height = height + 25;
        primilary = [[UIView alloc]initWithFrame:CGRectMake(10,height,(SCREEN_WIDTH/2)-13,140)];
        vintage = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)+2,height,(SCREEN_WIDTH/2)-13,140)];
        priBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,primilary.frame.size.width,85)];
        vinBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,vintage.frame.size.width,85)];
        titleP = [[UILabel alloc]initWithFrame:CGRectMake(5,80,primilary.frame.size.width,15)];
        DescP = [[UILabel alloc]initWithFrame:CGRectMake(5,110,primilary.frame.size.width,20)];
        titleV = [[UILabel alloc]initWithFrame:CGRectMake(5,80,vintage.frame.size.width,15)];
        DescV = [[UILabel alloc]initWithFrame:CGRectMake(5,110,vintage.frame.size.width,20)];
        height = height + 160;
        
        PracticeLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-10,20)];
                
                height = height + 25;
                
                prac1 = [[UIView alloc]initWithFrame:CGRectMake(10,height,(SCREEN_WIDTH/2)-13,80)];
                prac2 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)+2,height,(SCREEN_WIDTH/2)-13,80)];
                prac1bg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,prac1.frame.size.width,85)];
                prac2bg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0,0,prac2.frame.size.width,85)];
        //        titleprac1 = [[UILabel alloc]initWithFrame:CGRectMake(5,100,prac1.frame.size.width,15)];
        //        Descprac1 = [[UILabel alloc]initWithFrame:CGRectMake(5,135,prac1.frame.size.width,20)];
        //        titleprac2 = [[UILabel alloc]initWithFrame:CGRectMake(5,100,prac2.frame.size.width,15)];
        //        Descprac2 = [[UILabel alloc]initWithFrame:CGRectMake(5,135,prac2.frame.size.width,20)];
                
                height = height + 100;
        
        
        
        
        
        
        learningRes = [[UILabel alloc]initWithFrame:CGRectMake(10, height, SCREEN_WIDTH-10,20)];
        height = height + 25;
        bgLearning = [[UIView alloc]initWithFrame:CGRectMake(0,height,SCREEN_WIDTH,80)];
        height = height + 80;
        
    }
    
    
    
    
    PracticeLbl.text = @"Practice Test";
    PracticeLbl.font = BOLDTEXTTITLEFONT;
    PracticeLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [bgView addSubview:PracticeLbl];
    
    
    [bgView setContentSize:CGSizeMake(bgView.contentSize.width,height+20)];
    
    primilary.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    
//    priBg.image = [UIImage imageNamed:@"preliminary.jpg"];
//    priBg.contentMode = UIViewContentModeScaleAspectFit;
    
    //priBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0, height, bgView.frame.size.width, -2+bgView.frame.size.height/3)];
    NSString *imageUrl1 = [[NSString alloc] initWithFormat:@"%@live/resource/BEC/preliminary.jpg",AUDRO_ADDTION];
    UIImage *img1 = NULL;
    img1 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl1]];
    if(img1 == NULL ){
         priBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.1];
         [priBg setImageURLPath:imageUrl1 BlurImageLocalPath:@"preliminary.jpg"];
    }
    else
    {
        priBg.image = img1;
        priBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    priBg.contentMode = UIViewContentModeScaleAspectFit;
    [primilary addSubview:priBg];
    
    
    titleP.text = @"BEC B1 Business Preliminary";
    titleP.lineBreakMode = NSLineBreakByWordWrapping;
    titleP.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    titleP.numberOfLines = 2;
    [titleP sizeToFit];
    titleP.font = SUBTEXTTILEFONT;
    [primilary addSubview:titleP];
    
    
    
    DescP.text = @"Exam orientation and revision";
    DescP.font = SUBTEXTTILEFONT;
    DescP.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    DescP.lineBreakMode = NSLineBreakByWordWrapping;
    DescP.numberOfLines = 2;
    DescP.textColor = [UIColor grayColor];
    [DescP sizeToFit];
    [primilary addSubview:DescP];
    
    [primilary.layer setBorderColor:[self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor];
    [primilary.layer setBorderWidth:1.0f];
    [primilary.layer setShadowColor:[self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor];
    [primilary.layer setShadowOpacity:0.8];
    [primilary.layer setShadowRadius:3.0];
    [primilary.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    
    [bgView addSubview:primilary];
    
    
    
    
    UITapGestureRecognizer *PrimilinaryGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPriminilary)];
    PrimilinaryGas.numberOfTapsRequired = 1;
    [primilary addGestureRecognizer:PrimilinaryGas];
    
    
    
    
    
    
    
    vintage.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    
    //vinBg = [[UIImageViewWithDownloading alloc]initWithFrame:CGRectMake(0, height, bgView.frame.size.width, -2+bgView.frame.size.height/3)];
    NSString *imageUrl2 = [[NSString alloc] initWithFormat:@"%@live/resource/BEC/vantage.jpg",AUDRO_ADDTION];
    UIImage *img2 = NULL;
    img2 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl2]];
    if(img2 == NULL ){
        vinBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.1];
        [vinBg setImageURLPath:imageUrl2 BlurImageLocalPath:@"vantage.jpg"];
    }
    else
    {
        vinBg.image = img2;
        vinBg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    vinBg.contentMode = UIViewContentModeScaleAspectFit;
    
//    vinBg.image = [UIImage imageNamed:@"vantage.jpg"];
//    vinBg.contentMode = UIViewContentModeScaleAspectFit;
    [vintage addSubview:vinBg];
    
    
    titleV.text = @"BEC B2 Business Vantage";
    titleV.lineBreakMode = NSLineBreakByWordWrapping;
    titleV.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    titleV.numberOfLines = 2;
    [titleV sizeToFit];
    titleV.font = SUBTEXTTILEFONT;
    [vintage addSubview:titleV];
    
    
    DescV.text = @"Exam orientation and revision";
    DescV.font = SUBTEXTTILEFONT;
    DescV.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
    DescV.lineBreakMode = NSLineBreakByWordWrapping;
    DescV.textColor = [UIColor grayColor];
    DescV.numberOfLines = 2;
    [DescV sizeToFit];
    [vintage addSubview:DescV];
    
    UITapGestureRecognizer *VantageGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickVantage)];
    VantageGas.numberOfTapsRequired = 1;
    [vintage addGestureRecognizer:VantageGas];
    [vintage.layer setBorderColor:[self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor];
    [vintage.layer setBorderWidth:1.0f];
    
    // drop shadow
    [vintage.layer setShadowColor:[self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor];
    [vintage.layer setShadowOpacity:0.8];
    [vintage.layer setShadowRadius:3.0];
    [vintage.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [bgView addSubview:vintage];
    
    
    
    prac1.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    prac1.userInteractionEnabled = TRUE;
//    prac1bg.image = [UIImage imageNamed:@"BEC_prac1.jpg"];
//    prac1bg.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *imageUrl3 = [[NSString alloc] initWithFormat:@"%@live/resource/BEC/BEC_prac1.jpg",AUDRO_ADDTION];
    UIImage *img3 = NULL;
    img3 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl3]];
    if(img3 == NULL ){
         prac1bg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.1];
         [prac1bg setImageURLPath:imageUrl3 BlurImageLocalPath:@"BEC_prac1.jpg"];
    }
    else
    {
        prac1bg.image = img3;
        prac1bg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    prac1bg.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [prac1 addSubview:prac1bg];
    [bgView addSubview:prac1];
    
    UITapGestureRecognizer *prac1Gas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPractice1)];
    prac1Gas.numberOfTapsRequired = 1;
    [prac1 addGestureRecognizer:prac1Gas];
    
    
    
    prac2.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    prac2.userInteractionEnabled = TRUE;
//    prac2bg.image = [UIImage imageNamed:@"BEC_prac2.jpg"];
//    prac2bg.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *imageUrl4 = @"https://mobile.englishedge.in/emp/live/resource/BEC/BEC_prac2.jpg";
    UIImage *img4 = NULL;
    img4 = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl4]];
    if(img4 == NULL ){
         prac2bg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:0.1];
         [prac2bg setImageURLPath:imageUrl4 BlurImageLocalPath:@"BEC_prac2.jpg"];
    }
    else
    {
        prac2bg.image = img4;
        prac2bg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    }
    prac2bg.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [prac2 addSubview:prac2bg];
    [bgView addSubview:prac2];

    UITapGestureRecognizer *prac2Gas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPractice2)];
    prac2Gas.numberOfTapsRequired = 1;
    [prac2 addGestureRecognizer:prac2Gas];
    
    
//    UITapGestureRecognizer *usefulGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUsefulRes)];
//    usefulGas.numberOfTapsRequired = 1;
//    [usefulRes addGestureRecognizer:usefulGas];
    
    
    
    learningRes.text = @"Learning Resource";
    learningRes.font = BOLDTEXTTITLEFONT;
    learningRes.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [bgView addSubview:learningRes];
    
    
    
    //bgLearning = [[UIView alloc]initWithFrame:CGRectMake(0,bgView.frame.size.height/3+210,SCREEN_WIDTH,80)];
    bgLearning.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bgLearning];
    
    test = [[UIView alloc]initWithFrame:CGRectMake(10,0,(SCREEN_WIDTH/3)-15,80)];
    test.backgroundColor = [UIColor clearColor];
    UIImageView *testBg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,test.frame.size.width,80)];
    testBg.image = [UIImage imageNamed:@"Test-Your-English.png"];
    testBg.contentMode = UIViewContentModeScaleAspectFit;
    [test addSubview:testBg];
    
    UITapGestureRecognizer *TesteGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTest)];
    TesteGas.numberOfTapsRequired = 1;
    [test addGestureRecognizer:TesteGas];
    
    
    [bgLearning addSubview:test];
    
    
    usefulRes = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)+5,0,(SCREEN_WIDTH/3)-15,80)];
    usefulRes.backgroundColor = [UIColor clearColor];
    UIImageView *usefulResBg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,usefulRes.frame.size.width,80)];
    usefulResBg.image = [UIImage imageNamed:@"Useful-Resource.png"];
    usefulResBg.contentMode = UIViewContentModeScaleAspectFit;
    [usefulRes addSubview:usefulResBg];
    UITapGestureRecognizer *usefulGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUsefulRes)];
    usefulGas.numberOfTapsRequired = 1;
    [usefulRes addGestureRecognizer:usefulGas];
    [bgLearning addSubview:usefulRes];
    
    
    books = [[UIView alloc]initWithFrame:CGRectMake(2*(SCREEN_WIDTH/3)+5,0,(SCREEN_WIDTH/3)-15,80)];
    books.backgroundColor = [UIColor lightGrayColor];
    UIImageView *booksBg = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,books.frame.size.width,80)];
    booksBg.image = [UIImage imageNamed:@"books.png"];
    booksBg.contentMode = UIViewContentModeScaleAspectFit;
    [books addSubview:booksBg];
    UITapGestureRecognizer *bookGas = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBook)];
    bookGas.numberOfTapsRequired = 1;
    [books addGestureRecognizer:bookGas];
   // [bgLearning addSubview:books];
    
    
    
    
    useRes = [[UILabel alloc]initWithFrame:CGRectMake(5, bgView.frame.size.height/3+300, SCREEN_WIDTH-10,20)];
    useRes.text = @"Learning Services";
    useRes.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    useRes.font = [UIFont boldSystemFontOfSize:15];
    //[bgView addSubview:useRes];
    
    placeHolder =  [[UIImageView alloc]initWithFrame:CGRectMake(0,bgView.frame.size.height/3+330,SCREEN_WIDTH,80)];
    
    placeHolder.image = [UIImage imageNamed:@"PlaceHolde.png"];
    placeHolder.backgroundColor = [UIColor whiteColor];
    //[bgView addSubview:placeHolder];
    
//
//
//
//    bootomUIBorder = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 1)];
//    bootomUIBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0];
//    [self.view addSubview:bootomUIBorder];
    
    bootomUI = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];
    bootomUI.backgroundColor = [self getUIColorObjectFromHexString:BOTTOMMENUBARBACKGROUNDCOLOR alpha:1.0];
    bootomUI.layer.borderColor =  [self getUIColorObjectFromHexString:BOTTOMMENUBARLINECOLOR alpha:1.0].CGColor;
    bootomUI.layer.borderWidth= 1.0;
    [bootomUI setClipsToBounds:YES];
    [self.view addSubview:bootomUI];
    
    CGRect floatFrame = CGRectMake(SCREEN_WIDTH - 40,SCREEN_HEIGHT-35, 20, 20);
    addButton = [[VCFloatingActionButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] withScrollview:_dummyTable];
    
    addButton.imageArray = @[@"log_out",@"about",@"feedback_icon",@"faq_icon",@"about_us"];
    addButton.labelArray = @[[appDelegate.langObj get:@"MENU_LOGOUT" alter:@"Logout "],[appDelegate.langObj get:@"MENU_ABOUNTUS" alter:@"About Us "],[appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk "],[appDelegate.langObj get:@"MENU_FAQ" alter:@"FAQs "],[appDelegate.langObj get:@"MENU_AC" alter:@"My Account "]];
    
    addButton.hideWhileScrolling = YES;
    addButton.delegate = self;
    _dummyTable.dataSource = self;
    _dummyTable.delegate = self;
    [self.view addSubview:addButton];
    
    thirdText = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 45,SCREEN_HEIGHT-15, 30, 20)];
    [thirdText setText:@"More"];
    thirdText.textAlignment = NSTextAlignmentCenter;
    [thirdText setFont:[UIFont systemFontOfSize: 9]];
    [self.view addSubview:thirdText];
    [self.view bringSubviewToFront:thirdText];
    
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)clickBook
{
    
}

- (void)clickPractice1
{
    NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    [dicObj setValue:APP_LICENCE_KEY_PRACTEST1 forKey:@"licence"];
    [dicObj setValue:@"BEC Preliminary Practice Test" forKey:@"Title"];
    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
}

- (void)clickPractice2
{
   NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    [dicObj setValue:APP_LICENCE_KEY_PRACTEST2 forKey:@"licence"];
    [dicObj setValue:@"BEC Vantage Practice Test" forKey:@"Title"];
    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
}

- (void)clickPriminilary
{
    NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    [dicObj setValue:APP_LICENCE_KEY_PRIMINILARY forKey:@"licence"];
    [dicObj setValue:@"BEC B1 Business Preliminary" forKey:@"Title"];
    
    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
}
- (void)clickVantage
{
    NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    [dicObj setValue:APP_LICENCE_KEY_VINTAGE forKey:@"licence"];
    [dicObj setValue:@"BEC B2 Business Vantage" forKey:@"Title"];
    
    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
}

- (void)clickUsefulRes
{
    UseFulResource * useObj = [[UseFulResource alloc]initWithNibName:@"UseFulResource" bundle:nil];
    useObj._strTitle = @"Useful Resources";
    useObj.Html_Path = BEC_USEFULRESOURCE;
    [self.navigationController pushViewController:useObj animated:YES];
}



-(void)clickTest
{
    TestYourEnglish * eveObj = [[TestYourEnglish alloc]initWithNibName:@"TestYourEnglish" bundle:nil];
    eveObj._strTitle = @"Test your English";
    eveObj.Html_Path = BEC_TESTYOURENGLISH;
    [self.navigationController pushViewController:eveObj animated:TRUE];
}


-(void) didSelectMenuOptionAtIndex:(NSInteger)row
{
    
     if(row == 4){
         MyAccountScreen * accObj = [[MyAccountScreen alloc]initWithNibName:@"MyAccountScreen" bundle:nil];
         accObj.title = [appDelegate.langObj get:@"MENU_AC" alter:@"My Account"] ;;
         [self.navigationController pushViewController:accObj animated:YES];
        
    }
    else if(row == 3){
        FAQ * faq = [[FAQ alloc]initWithNibName:@"FAQ" bundle:nil];
        faq._strTitle = @"FAQs";
        [self.navigationController pushViewController:faq animated:YES];
    }
    else if(row == 2){
        
        
            FeedbackViewController * fedObj = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
            fedObj.titleName =   [appDelegate.langObj get:@"MENU_FEEDBACK" alter:@"Helpdesk"] ;;
            [self.navigationController pushViewController:fedObj animated:YES];

        
        
    }
    else if(row == 1){
        
            [appDelegate gotoNextController:self controllerType:enum_aboutController sendingObj:nil];

    }
    
    else if(row == 0){
        [self logout];
    }
    else{
        NSLog(@"Unknown Error and Floating action tapped index %tu",row);
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
