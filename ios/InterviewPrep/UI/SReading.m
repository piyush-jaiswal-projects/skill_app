//
//  SReading.m
//  InterviewPrep
//
//  Created by Amit Gupta on 09/10/18.
//  Copyright © 2018 Liqvid. All rights reserved.
//

#import "SReading.h"
#import "Assessment.h"

@interface SReading ()<UITextViewDelegate>
{
    UIView * navBar;
    UILabel * _title;
    UIButton *back;
    UIView * baseView;
    UILabel * InstructionLbl;
    UITextView * lblShowtext;
    
    UILabel * speedIns;
    UILabel * speed;
    
    
    
    UISlider *slider;
    NSString * paragraph;
    int numberOfWord;
    int play_time;
    NSTimer * playTimer;
    NSTimer * displayTimer;
    int startIndex;
    int endIndex;
    NSArray *yourWords;
    UIButton * startStop;
    UIView *lineView;
    UIButton * StartMCQ;
    UIView *lineView1;
    BOOL isPlay;
    NSUInteger index;
     NSInteger len;
    NSMutableDictionary *trackData;
    int wordDisplayTime;
    NSDictionary * obj;
     
    
   }





@end

@implementation SReading

- (void)viewDidLoad {
    [super viewDidLoad]; appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    trackData = [[NSMutableDictionary alloc]init];
    [trackData setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [trackData setValue:self.scnUid forKey:NATIVE_JSON_KEY_SCNID];
    [trackData setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [trackData setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    
    [trackData setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.speedId] forKey:NATIVE_JSON_KEY_EDGEID];
    [trackData setValue:[[NSString alloc] initWithFormat:@"%@",self.practiceType] forKey:NATIVE_JSON_KEY_TYPE];
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [trackData setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [trackData setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    obj =   [[appDelegate.engineObj getMCQObject:_speedId]valueForKey:@"assess"];
    isPlay = FALSE;
    index = 10;
    startIndex =0;
    //numberOfWord = 500; //[[[obj valueForKey:@"word_count"]valueForKey:@"text"] intValue];
    paragraph = [[obj valueForKey:@"para"]valueForKey:@"text"];
    yourWords = [paragraph componentsSeparatedByString:@" "];
    endIndex = [yourWords count];
    numberOfWord = endIndex;
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STSTUSNAVIGATIONBARHEIGHT)];
    [navBar setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [self.view addSubview:navBar];
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(10, 22, 40, 40)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //[back setTitle:@"Back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
       {
                   UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,15)];
                   lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
                   lbl.font = NAVIGATIONTITLEUPFONT;
                   lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
                   lbl.textAlignment = NSTextAlignmentCenter;
                   [navBar addSubview:lbl];
           
           UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,35,SCREEN_WIDTH-120,20)];
           lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.titleName];
           lblquiz.font = NAVIGATIONTITLEDOWNFONT;
           lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
           lblquiz.textAlignment = NSTextAlignmentCenter;
           [navBar addSubview:lblquiz];
       }
      else
      {
          UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,20,SCREEN_WIDTH-120,44)];
          lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.titleName];
          lblquiz.font = NAVIGATIONTITLEFONT;
          lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
          lblquiz.textAlignment = NSTextAlignmentCenter;
          [navBar addSubview:lblquiz];
      }
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(navBar.frame.size.width-40, 28, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:navBar];
        [navBar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
    
    baseView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    [baseView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:baseView];
    
    InstructionLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-15, 80)];
    InstructionLbl.text = [[obj valueForKey:@"instruction"]valueForKey:@"text"];
    InstructionLbl.textAlignment = NSTextAlignmentLeft;
    InstructionLbl.font = [UIFont systemFontOfSize:12.0f];
    InstructionLbl.numberOfLines =0;
    InstructionLbl.lineBreakMode  =NSLineBreakByWordWrapping;
    InstructionLbl.textColor =[self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    [baseView addSubview:InstructionLbl];
    
    UIView * borView = [[UIView alloc]initWithFrame:CGRectMake(10, 85, SCREEN_WIDTH-20, baseView.frame.size.height-200)];
    borView.layer.borderWidth = 1.0;
    borView.layer.cornerRadius = 10;
    
    borView.layer.borderColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    //InstructionLbl.textColor = [UIColor whiteColor];
     [baseView addSubview:borView];
    
    lblShowtext = [[UITextView alloc]initWithFrame:CGRectMake(3, 0, borView.frame.size.width-6, borView.frame.size.height)];
    lblShowtext.delegate = self;
    lblShowtext.textAlignment = NSTextAlignmentLeft;
    lblShowtext.font = [UIFont systemFontOfSize:13.0f];
    lblShowtext.textColor =[self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    lblShowtext.editable = FALSE;
//    lblShowtext.lineBreakMode = NSLineBreakByWordWrapping;
//    lblShowtext.numberOfLines = 14;
    
    [borView addSubview:lblShowtext];
//    [lblShowtext addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    
    speedIns = [[UILabel alloc]initWithFrame:CGRectMake(10, baseView.frame.size.height-107, SCREEN_WIDTH/2, 20)];
    speedIns.text = @"Words per minute";
    speedIns.textAlignment = NSTextAlignmentLeft;
    speedIns.textColor =[self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    speedIns.font = TEXTTITLEFONT;
    [baseView addSubview:speedIns];
    
    
    
    speed = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, baseView.frame.size.height-107, SCREEN_WIDTH/2-10, 20)];
    speed.text = @"10";
    speed.textAlignment = NSTextAlignmentRight;
    speed.textColor =[self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    speed.font = TEXTTITLEFONT;
    [baseView addSubview:speed];
    
    
    CGRect frame = CGRectMake(10, baseView.frame.size.height-72, SCREEN_WIDTH-20,4);
    UIView * sliderview = [[UIView alloc]initWithFrame:frame];
    UIColor *transBgColor = [self getUIColorObjectFromHexString:@"#87ab41" alpha:1.0];//[UIColor greenColor];
    UIColor *black = [self getUIColorObjectFromHexString:@"#f8a82d" alpha:1.0]; //[UIColor blackColor];
    UIColor *red = [self getUIColorObjectFromHexString:@"#c90419" alpha:1.0];//[UIColor redColor];
    
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.opacity = 1.0;
    maskLayer.colors = [NSArray arrayWithObjects:(id)transBgColor.CGColor,
                        (id)black.CGColor, (id)red.CGColor, nil];
    
    // Hoizontal - commenting these two lines will make the gradient veritcal
    maskLayer.startPoint = CGPointMake(0.0, 0.0);
    maskLayer.endPoint = CGPointMake(1.0, 0.0);
    
    NSNumber *gradTopStart = [NSNumber numberWithFloat:([[[[[[obj valueForKey:@"scale_range"]valueForKey:@"scale"] objectAtIndex:0]valueForKey:@"range"]valueForKey:@"text"]floatValue]/100)];
    NSNumber *gradTopEnd = [NSNumber numberWithFloat:[[[[[[obj valueForKey:@"scale_range"]valueForKey:@"scale"] objectAtIndex:1]valueForKey:@"range"]valueForKey:@"text"]floatValue]/100];
    NSNumber *gradBottomStart = [NSNumber numberWithFloat:[[[[[[obj valueForKey:@"scale_range"]valueForKey:@"scale"] objectAtIndex:2]valueForKey:@"range"]valueForKey:@"text"]floatValue]/100];

    maskLayer.locations = @[gradTopStart, gradTopEnd, gradBottomStart];
    
    maskLayer.bounds = sliderview.bounds;
    maskLayer.anchorPoint = CGPointZero;
    [sliderview.layer addSublayer:maskLayer];
    
    [baseView addSubview:sliderview];
  
    CGRect frame1 = CGRectMake(10, baseView.frame.size.height-85, SCREEN_WIDTH-20,30);
    slider = [[UISlider alloc] initWithFrame:frame1];
    slider.tintColor = [UIColor clearColor];//[self getUIColorObjectFromHexString:SPTRACKCOLOR alpha:1.0];
    slider.maximumTrackTintColor = [UIColor clearColor];
    slider.maximumTrackTintColor = [UIColor clearColor];
    [slider setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    
    slider.maximumValue = [[[obj valueForKey:@"max_scale"]valueForKey:@"text"]intValue];
    slider.minimumValue = [[[obj valueForKey:@"min_scale"]valueForKey:@"text"]intValue];;
    slider.value = [[[obj valueForKey:@"min_scale"]valueForKey:@"text"]intValue];;
    slider.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    //[slider setMaximumTrackTintColor:NAVIGATIONCOLOR];
    // As the slider moves it will continously call the -valueChanged:
    slider.continuous = YES; // NO makes it call only once you let go
    [slider addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    [baseView addSubview:slider];
    
    
    
    startStop = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, baseView.frame.size.height-50, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
    startStop.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
    startStop.clipsToBounds = YES;
    startStop.titleLabel.font = BUTTONFONT;
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, startStop.frame.size.width, 3)];
    
    [startStop addSubview:lineView];
    
    
    
    
    [startStop setTitle:[appDelegate.langObj get:@"START" alter:@"Start"] forState:UIControlStateNormal];
    startStop.titleLabel.textColor = [UIColor whiteColor];
    [startStop addTarget:self
                     action:@selector(startStop:)
           forControlEvents:UIControlEventTouchUpInside];
    startStop.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    lineView.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR alpha:1.0];
    
    [baseView addSubview:startStop];
    
    
    
    
//    StartMCQ = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, baseView.frame.size.height-50, 8*(SCREEN_WIDTH/10),40)];
//
//    [StartMCQ setTitle:[appDelegate.langObj get:@"START_QUIZ" alter:@"START QUIZ"] forState:UIControlStateNormal];
//    StartMCQ.titleLabel.textColor = [UIColor whiteColor];
//
//    [StartMCQ addTarget:self
//                 action:@selector(startMCQ:)
//       forControlEvents:UIControlEventTouchUpInside];
//    StartMCQ.backgroundColor = [self getUIColorObjectFromHexString:@"#242e3a" alpha:1.0];
//    [baseView addSubview:StartMCQ];
//    [StartMCQ.layer setMasksToBounds:YES];
//    StartMCQ.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
//    [StartMCQ.layer setCornerRadius:20.0f];
//    [StartMCQ setTitleColor:[self getUIColorObjectFromHexString:@"#da4453" alpha:1.0] forState:UIControlStateNormal];
//    [StartMCQ.layer setBorderColor:[self getUIColorObjectFromHexString:@"#da4453" alpha:1.0].CGColor];
//    [StartMCQ.layer setBorderWidth:1];
//    [StartMCQ setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    [StartMCQ setHighlighted:YES];

}
//-(void)textViewDidChange:(UITextView *)textView{
//    [self adjustContentSize:textView];
//}
//-(void)adjustContentSize:(UITextView*)tv{
//    CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
//    CGFloat inset = MAX(0, deadSpace/2.0);
//    tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [startStop setUserInteractionEnabled:TRUE];
    [slider setUserInteractionEnabled:TRUE];
    slider.maximumValue = [[[obj valueForKey:@"max_scale"]valueForKey:@"text"]intValue];
    slider.minimumValue = [[[obj valueForKey:@"min_scale"]valueForKey:@"text"]intValue];;
    slider.value = [[[obj valueForKey:@"min_scale"]valueForKey:@"text"]intValue];;
    index = [[[obj valueForKey:@"min_scale"]valueForKey:@"text"]intValue];;
    speed.text = @"10";
    lblShowtext.text = @""; //[[obj valueForKey:@"para"]valueForKey:@"text"];
    [startStop setTitle:[appDelegate.langObj get:@"START" alter:@"Start"] forState:UIControlStateNormal];
    
}
-(void)scrollText:(id)parameter{
    
    
    //lblShowtext.lineBreakMode = NSLineBreakByTruncatingHead;
    [lblShowtext setText:[paragraph substringWithRange:NSMakeRange(0, len++)]];
  
    [lblShowtext setTextAlignment:NSTextAlignmentRight];
    if (len == paragraph.length) {
         [playTimer invalidate];
         len =0;
    }
}

-(IBAction)startMCQ:(id)sender
{
    if(isPlay)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:[appDelegate.langObj get:@"SP_STOP_INS" alter:@"Please press stop button first."]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        int duration = 2; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }
    else
    {
    
    
    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
    assess.assessnetUid = self.speedId;
    assess.cusTitleName = self.titleName;
    assess.type = 21;
    assess.scnUid = self.scnUid;
        assess.selectedLevel  = @"-1";
        
        NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
        [assessmentObj setValue:self.speedId forKey:@"uid"];
        [assessmentObj setValue:self.titleName forKey:@"name"];
        [assessmentObj setValue:@"21" forKey:@"type"];
        assess.testOBj = assessmentObj;
        assess.isRemediation = FALSE;
        assess.skillObj  = NULL;
        appDelegate.AssessmentQuesAttemptCounter = -1;
        [self.navigationController pushViewController:assess animated:YES];
        
   
    }
}
-(IBAction)startStop:(id)sender
{
    
    NSDictionary * obj =   [[appDelegate.engineObj getMCQObject:_speedId]valueForKey:@"assess"];
     lblShowtext.text = [[obj valueForKey:@"para"]valueForKey:@"text"];
    CGFloat deadSpace = ([lblShowtext bounds].size.height - [lblShowtext contentSize].height);
    CGFloat inset = MAX(0, deadSpace/2.0);
    lblShowtext.contentInset = UIEdgeInsetsMake(inset, lblShowtext.contentInset.left, inset, lblShowtext.contentInset.right);
    ///[lblShowtext addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    [startStop setUserInteractionEnabled:FALSE];
    [slider setUserInteractionEnabled:FALSE];
    
    isPlay = !isPlay;
    
    if(isPlay)
    {
        //[startStop setTitle:[appDelegate.langObj get:@"STOP" alter:@"STOP"] forState:UIControlStateNormal];
        if(playTimer != NULL ){
            [playTimer invalidate];
            playTimer = NULL;
        }
        wordDisplayTime = (int) ceil(((float)numberOfWord/(float)index)*60);
        int lMin = wordDisplayTime/60;
        NSString* globalMin = [[NSString alloc]initWithFormat:@"%02d",lMin];
        int lSec = wordDisplayTime % 60;
        NSString* globalSec = [[NSString alloc]initWithFormat:@"%02d",lSec];
        [startStop setTitle:[[NSString alloc]initWithFormat:@"%@:%@",globalMin,globalSec] forState:UIControlStateNormal];
        NSLog(@"sliderIndex: %f", (float)wordDisplayTime);
        playTimer = [NSTimer scheduledTimerWithTimeInterval:wordDisplayTime  // 6.0
                                                     target:self
                                                   selector:@selector(ShowText:)
                                                   userInfo:nil
                                                    repeats:NO];
        
        
        displayTimer = [NSTimer scheduledTimerWithTimeInterval:1  // 6.0
          target:self
        selector:@selector(showDisplayText:)
        userInfo:nil
         repeats:YES];
        
//        playTimer = [NSTimer scheduledTimerWithTimeInterval:wordDisplayTime  // 6.0
//                                                     target:self
//                                                   selector:@selector(scrollText:)
//                                                   userInfo:nil
//                                                    repeats:YES];
        
    }
    else
    {
        [startStop setTitle:[appDelegate.langObj get:@"START" alter:@"Start"] forState:UIControlStateNormal];
        if(playTimer != NULL ){
            [playTimer invalidate];
            playTimer = NULL;
            index = 0;
            startIndex = 0;
            slider.value = index;
            len =0;
        }
    }
    
}

- (void)valueChanged:(UISlider *)sender {
    
    if(isPlay) return;
    
    UISlider * slider = (UISlider *)sender;
    index = (NSUInteger)(slider.value);
    
    
    
    speed.text = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)index];
    
    [slider setValue:index animated:NO];
    
    if(playTimer != NULL  ){
        [playTimer invalidate];
        playTimer = NULL;
    }
    
    if(index != 0)
    {
    
        wordDisplayTime = (int)ceil(((float)numberOfWord/(float)index)*60);
    
        NSLog(@"sliderIndex: %f", (float)wordDisplayTime);
        if(isPlay){
            playTimer = [NSTimer scheduledTimerWithTimeInterval:wordDisplayTime  // 6.0
                                                 target:self
                                               selector:@selector(ShowText:)
                                               userInfo:nil
                                                repeats:NO];
            
//            playTimer = [NSTimer scheduledTimerWithTimeInterval:wordDisplayTime  // 6.0
//                                                         target:self
//                                                       selector:@selector(scrollText:)
//                                                       userInfo:nil
//                                                        repeats:YES];
            
        }
    }
}
- (IBAction)showDisplayText:(id)sender{
    
    wordDisplayTime --;
    int lMin = wordDisplayTime/60;
    NSString* globalMin = [[NSString alloc]initWithFormat:@"%02d",lMin];
    int lSec = wordDisplayTime % 60;
    NSString* globalSec = [[NSString alloc]initWithFormat:@"%02d",lSec];
    [startStop setTitle:[[NSString alloc]initWithFormat:@"%@:%@",globalMin,globalSec] forState:UIControlStateNormal];
}

- (IBAction)ShowText:(id)sender{
    isPlay = FALSE;
    [playTimer invalidate];
    playTimer = NULL;
    [displayTimer invalidate];
    displayTimer = NULL;
    
    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
    assess.assessnetUid = self.speedId;
    assess.cusTitleName = self.titleName;
    assess.type = 21;
    assess.scnUid = self.scnUid;
    assess.selectedLevel  = @"-1";
    
    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
    [assessmentObj setValue:self.speedId forKey:@"uid"];
    [assessmentObj setValue:self.titleName forKey:@"name"];
    [assessmentObj setValue:@"21" forKey:@"type"];
    assess.testOBj = assessmentObj;
    assess.isRemediation = FALSE;
    assess.skillObj  = NULL;
    
    [self.navigationController pushViewController:assess animated:YES];
     
}




-(IBAction)clickBack:(id)sender
{
    
    [trackData setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    [trackData setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [trackData setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    if([[trackData valueForKey:NATIVE_JSON_KEY_ENDTIME]longLongValue] >= [[trackData valueForKey:NATIVE_JSON_KEY_STARTTIME]longLongValue])
      [appDelegate.engineObj setTracktableData:trackData];
   
    
    if(playTimer != NULL ){
        [playTimer invalidate];
        playTimer = NULL;
    }
    [self.navigationController popViewControllerAnimated:TRUE];
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

@end
