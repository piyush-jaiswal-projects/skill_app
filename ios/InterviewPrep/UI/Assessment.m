//
//  Assessment.m
//  InterviewPrep
//
//  Created by Amit Gupta on 25/09/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "Assessment.h"
#import "ifb_AssessmentTemplate.h"
#import "fb_AssessmentTemplate.h"
#import "mc_AssessmentTemplate.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ZoomWebView.h"
#import "SampleAnswer.h"
//#import "LSFloatingActionMenu.h"
#import "ScenarioPracticeModule.h"
#import <GameplayKit/GameplayKit.h>
#import <WebKit/WebKit.h>
#import <TTGTagCollectionView/TTGTagCollectionView.h>
#import "TTGTagCollectionView.h"
#import "TTGTextTagCollectionView.h"
#import "DragAndDropTableView.h"
#import "UAProgressView.h"
#import "MeProQuizReport.h"
#import "Quizfeedback.h"
#import "CoinsQuizfeedback.h"
#import "MeProComponent.h"
#import "MePro_Remediation.h"
#import "CustomUIView.h"
#import "PTEG_QuizSummery.h"





#define SELECTION_BG_COLOR  @"#ebf8fc"
#define SELECTION_OURLINECOLOR @"#36bbe1"

#define WRONG_SELECTION_BG_COLOR  @"#fdeeef"
#define WRONG_SELECTION_OURLINECOLOR @"#ed5565"

#define RIGHT_SELECTION_BG_COLOR  @"#e7f4d8"
#define RIGHT_SELECTION_OURLINECOLOR @"#89c63b"

#define MC_MMC_TEST_TOP_BOTTOM_PADDING 25



@interface Assessment ()<WKUIDelegate,WKNavigationDelegate,TTGTextTagCollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,DragAndDropTableViewDataSource,DragAndDropTableViewDelegate,UIGestureRecognizerDelegate>
{
    UIView * areaTxt;
    UIView * bar;
    UIButton *backBtn;
    UIView * sampleAnswerView;
    NSDictionary *quizAddtionalProperty;
    UAProgressView *progressView4;
    NSTimer * sanaTimer;
    CGFloat localProgress;
    UIButton* floaButtonView;
    UILabel * sampleText;
    CGFloat old_distance;
    int numberofChar;
    UIProgressView *progressView;
    NSMutableArray * quesArr;
    UITextView *instext;
    BOOL isGlobalTimer;
    NSTimer * MCQTimer;
    UIView *lineView;
    UIView * scriptbtnView;
    UILabel * scriptbtn;
    UIView * same;
    BOOL quesRand;
    BOOL optRand;
    NSDictionary * SanaResp;
    UITapGestureRecognizer * gasture;
    
    NSMutableArray * leftArr;
    NSMutableArray * rightArr;
    
    AVAudioPlayer * option1player;
    AVAudioPlayer * option2player;
    AVAudioPlayer * option3player;
    AVAudioPlayer * option4player;
    AVAudioPlayer * option5player;
    AVAudioPlayer * option6player;
    AVAudioPlayer * option7player;
    AVAudioPlayer * option8player;
    UIButton *opa1;
    UIButton *opa2;
    UIButton *opa3;
    UIButton *opa4;
    UIButton *opa5;
    UIButton *opa6;
    UIButton *opa7;
    UIButton *opa8;
    
    
    
    UITableView *leftTableView;
    DragAndDropTableView *rightTableView;
    
    
    
    UIView * lop1;
    UIView * lop2;
    UIView * lop3;
    UIView * lop4;
    UIView * lop5;
    UIView * lop6;
    UIView * lop7;
    UIView * lop8;
    
    UIView * rop1;
    UIView * rop2;
    UIView * rop3;
    UIView * rop4;
    UIView * rop5;
    UIView * rop6;
    UIView * rop7;
    UIView * rop8;
    
    UILabel * lt1;
    UILabel * lt2;
    UILabel * lt3;
    UILabel * lt4;
    UILabel * rt1;
    UILabel * rt2;
    UILabel * rt3;
    UILabel * rt4;
    
    
    
    
    NSString * globalMin;
    NSString * globalSec;
    int globalTotalSec;
    int globalCalTotalSec;
    
    UILabel * globalTimer;
    UITapGestureRecognizer * transG;
    
    UIView * backGView;
    UIView * backGCameraView;
    UIView * scoreView;
    UIView * backProgressView;
    UIProgressView * timerProgressView;
    UILabel * l1;
    
    UIView *footerView;
    UIButton * prev;
    UIButton *submit;
    UIButton *next;
    UIButton *mcqSubmitBtn;
    UIButton *contiBtn;
    
    UIScrollView * instructionView;
    UIButton *insStartBtn;
    UILabel * quesNo;
    int questionCounter;
    
    UIScrollView * inputView;
    UIImageView * QuesImg;
    AVPlayerViewController *videoViewPlayer;
    AVPlayer * playVideo;
    UIView *movieView;
    AVAudioPlayer *audioPlayer , *sanaAudioPlayer;
    UITextView *questionView;
    UIButton * audioBtn;
    UIProgressView * timerProgressAudioView;
    UILabel* AudioTimerLnbl;
    NSArray * QuesAVArr;
    NSMutableArray * recoededAVArr;
    
    AVAudioRecorder *recorder;
    AVAudioRecorder *sana_recorder;
    AVAudioRecorder *avrecorder;
    
    UIButton * recordSanaStop;
    UIButton * recordStop;
    UIButton * recordAVStop;
    UIButton * recordStop1;
    
    int AVCounter;
    NSString * answerUid;
    BOOL isRecording;
    BOOL isAudioRecording;
    //BOOL isOpenKey;
    
    // for MC
    CustomUIView *op1,*op2,*op3,*op4,*op5,*op6,*op7,*op8;
    UITapGestureRecognizer *op1Touch,*op1Touch1,*op1Touch2,*op1Touch3,*op1Touch4,*op1Touch5,*op1Touch6,*op1Touch7;
    UIImageView * cirImg,* cirImg1,* cirImg2,* cirImg3,* cirImg4,* cirImg5,* cirImg6,* cirImg7;
    UILabel *text,* text1,* text2,* text3,*text4,* text5,* text6,* text7;
    UIView *textView,* textView1,* textView2,* textView3,*textView4,* textView5,* textView6,* textView7;
    
    TTGTextTagCollectionView * dottedBox , * ddBox;
    
    NSMutableArray *ddBoxArr;
    NSMutableArray *dottedBoxArr;
    
    UIView * pwdottedBox , * pwBox;
    
    UIButton *pwopt1,*pwopt2,*pwopt3,*pwopt4;
    UIButton *slopt1,*slopt2,*slopt3,*slopt4;
    
    UIButton * globalBtn;
    NSDictionary * globalDictionary;
    
    UITextView *esTextView;
    fb_AssessmentTemplate * fbView;
    ifb_AssessmentTemplate * ibfbView;
    mc_AssessmentTemplate *mcView;
    //UITextView *fbTextView1,*fbTextView2,*fbTextView3,*fbTextView4,*fbTextView5;
    UILabel *minLength, *total;
    
    AVAudioPlayer *reAudioPlayer;
    UIView * PlayerFotterView1;
    
    AVPlayerViewController *recVideoPlayer;
    UIImagePickerController *pickerObj;
    NSMutableArray * ansTrackArray;
    
    NSMutableArray * selectedDragArr;
    int totalCorrectAns;
    int answerableQuestion;
    
    UILabel *tapIns;
    UILabel *minute;
    UILabel *remaingText;
    UILabel *minute1;
    UILabel *remaingText1;
    UILabel *tapIns1;
    NSTimer * recordingTimer;
    int totaltime;
    
    NSMutableArray * jsonArr;
    NSMutableArray * fileArray;
    NSString *audioPath;
    
    BOOL isShowTransscript;
    UITextView * ScriptViewText;
    UIScrollView * scrollView;
    
    NSDictionary * g_quizObj;
    UITapGestureRecognizer * insGasture;
    UIView * backInsImgView;
    UIImageView * insImgView;
    NSString *phoneDocumentDirectory;
    
    UIView *popup;
    
    
    BOOL isNextClick;
    BOOL isPreClick;
    
    WKWebView *sanaLbl;
    UILabel *sanaScoLbl;
    UILabel *sanaScoreIns;
    // UIActivityIndicatorView *activityIndicator;
    NSArray * wordSANAArr;
    NSArray *  phoneme_scores;
    UIView *sanaScoreView;
    UIButton *crossbtn;
    AVSpeechUtterance *utterance;
    UITableView * sanatable;
    NSInteger questheight1;
    
    int rightDrawFlag;
    NSString * rightAnsFBSpace;
    UIButton *audioSanaBtn;
    UIView * answerFeedbackUi;
    BOOL isShowFeedback;
    NSArray * feedbackArray;
    NSMutableParagraphStyle *style;
    BOOL isFirst;
    
}
//@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@end

@implementation Assessment


- (IBAction)ShowSampleAns:(UIButton *)sender {
    if([sampleText.text isEqualToString:@"Close"])
    {
        for (UIView *v1 in sampleAnswerView.subviews) {
            if(v1.tag == 11 || v1.tag == 12) [v1 removeFromSuperview];
        }
        [floaButtonView setImage:[UIImage imageNamed:@"sample_icon"] forState:UIControlStateNormal];
        sampleText.text = @"Sample Answer";
    }
    else
    {
        [floaButtonView setImage:[UIImage imageNamed:@"Sampleclose"] forState:UIControlStateNormal];
        sampleText.text = @"Close";
        
        
        int i = 0;
        if([[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"] != NULL && ![[[NSString alloc]initWithFormat:@"%@",[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]] isEqualToString:@""])
        {
            i++;
        }
        
        if([[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"] != NULL && ![[[NSString alloc]initWithFormat:@"%@",[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]] isEqualToString:@""])
        {
            i++;
        }
        if(i>1)
        {
            UIButton * floaButtonView1 = [[UIButton alloc]initWithFrame:CGRectMake(sampleAnswerView.frame.size.width-135, 10, 20, 20)];
            floaButtonView1.tag =11;
            [floaButtonView1 setImage:[UIImage imageNamed:@"sampleAnswer"] forState:UIControlStateNormal];
           [floaButtonView1 addTarget:self
                               action:@selector(ShowSampleAns1:)
                     forControlEvents:UIControlEventTouchUpInside];
            
            
            [sampleAnswerView addSubview:floaButtonView1];
            
            UIButton * floaButtonView2 = [[UIButton alloc]initWithFrame:CGRectMake(sampleAnswerView.frame.size.width-165, 10, 20, 20)];
            floaButtonView2.tag =12;
             [floaButtonView2 setImage:[UIImage imageNamed:@"sampleAnswer"] forState:UIControlStateNormal];
            [floaButtonView2 addTarget:self
                                action:@selector(ShowSampleAns2:)
                      forControlEvents:UIControlEventTouchUpInside];
             
             
             [sampleAnswerView addSubview:floaButtonView2];
        }
        else
        {
            UIButton * floaButtonView1 = [[UIButton alloc]initWithFrame:CGRectMake(sampleAnswerView.frame.size.width-135, 10, 20, 20)];
            floaButtonView1.tag =11;
             [floaButtonView1 setImage:[UIImage imageNamed:@"sampleAnswer"] forState:UIControlStateNormal];
            [floaButtonView1 addTarget:self
                                action:@selector(ShowSampleAns1:)
                      forControlEvents:UIControlEventTouchUpInside];
            [sampleAnswerView addSubview:floaButtonView1];
        }
        
        
    }
  
    
    
    
   // [self showMenuFromButton:sender withDirection:LSFloatingActionMenuDirectionRight];
    
}

-(IBAction)ShowSampleAns1:(UIButton *)sender
{
    for (UIView *v1 in sampleAnswerView.subviews) {
        if(v1.tag == 11 || v1.tag == 12) [v1 removeFromSuperview];
    }
    [floaButtonView setImage:[UIImage imageNamed:@"sample_icon"] forState:UIControlStateNormal];
    sampleText.text = @"Sample Answer";
    
    NSString * str;
    if ([[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]isEqualToString:@""]) {
        NSLog(@"%@",[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]);
        str = [[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"];
    }
    else
        
    {
        NSLog(@"%@",[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]);
        str = [[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"];
    }
    
    SampleAnswer * saObj = [[SampleAnswer alloc]initWithNibName:@"SampleAnswer" bundle:nil];
    saObj.title = @"Sample Answer";
    saObj.path = @"";
    saObj.sampleText = str;
    saObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:saObj animated:NO completion:nil];
}

-(IBAction)ShowSampleAns2:(UIButton *)sender
{
    for (UIView *v1 in sampleAnswerView.subviews) {
        if(v1.tag == 11 || v1.tag == 12) [v1 removeFromSuperview];
    }
    [floaButtonView setImage:[UIImage imageNamed:@"sample_icon"] forState:UIControlStateNormal];
    sampleText.text = @"Sample Answer";
    
    NSLog(@"%@",[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]);
    NSString * str = [[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"];
    SampleAnswer * saObj = [[SampleAnswer alloc]initWithNibName:@"SampleAnswer" bundle:nil];
    saObj.title = @"Sample Answer";
    saObj.path = @"";
    saObj.sampleText = str;
    saObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:saObj animated:NO completion:nil];
}

//#pragma mark - Private
//
//- (void)showMenuFromButton:(UIButton *)button withDirection:(LSFloatingActionMenuDirection)direction {
//
//    NSArray *menuIcons;
//    if(![[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]isEqualToString:@""] && ![[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]isEqualToString:@""]){
//        menuIcons = @[@"Sampleclose",@"sampleAnswer", @"sampleAnswer"];
//    }
//    else{
//        menuIcons = @[@"Sampleclose",@"sampleAnswer"];
//    }
//    NSMutableArray *menus = [NSMutableArray array];
//
//    CGSize itemSize = CGSizeMake(25, 25);
//    for (NSString *icon in menuIcons) {
//        LSFloatingActionMenuItem *item = [[LSFloatingActionMenuItem alloc] initWithImage:[UIImage imageNamed:icon] highlightedImage:[UIImage imageNamed:icon]];
//        item.userInteractionEnabled = TRUE;
//        item.itemSize = itemSize;
//        [menus addObject:item];
//    }
//    [floaButtonView setImage:[UIImage imageNamed:@"Sampleclose"] forState:UIControlStateNormal];
//    sampleText.text = @"Close";
//    self.actionMenu = [[LSFloatingActionMenu alloc] initWithFrame:sampleAnswerView.bounds direction:direction menuItems:menus menuHandler:^(LSFloatingActionMenuItem *item, NSUInteger index) {
////        if(audioPlayer!= NULL && audioPlayer.isPlaying )
////        {
////            [audioPlayer pause];
////            [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
////        }
////
////        if(videoViewPlayer != NULL)
////            [videoViewPlayer.player pause];
//
//        NSLog(@"%@",[NSString stringWithFormat:@"Click at index %d", (int)index]);
//        NSString * str ;
//        if((int)index == 1)
//        {
//            if ([[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]isEqualToString:@""]) {
//                NSLog(@"%@",[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]);
//                str = [[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"];
//            }
//            else
//
//            {
//                NSLog(@"%@",[[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"]);
//                str = [[globalDictionary valueForKey:@"sample1"]valueForKey:@"text"];
//            }
//
//        }
//        else
//        {
//            NSLog(@"%@",[[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"]);
//            str = [[globalDictionary valueForKey:@"sample2"]valueForKey:@"text"];
//        }
//
//        SampleAnswer * saObj = [[SampleAnswer alloc]initWithNibName:@"SampleAnswer" bundle:nil];
//        saObj.title = @"Sample Answer";
//        saObj.path = @"";
//        saObj.sampleText = str;
//        saObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        [self presentViewController:saObj animated:NO completion:nil];
//
//
//    } closeHandler:^{
//        [self.actionMenu removeFromSuperview];
//        self.actionMenu = nil;
//        scrollView.scrollEnabled = TRUE;
//        [floaButtonView setImage:[UIImage imageNamed:@"sample_icon"] forState:UIControlStateNormal];
//        sampleText.text = @"Sample Answer";
//        //button.hidden = NO;
//    }];
//    self.actionMenu.userInteractionEnabled = TRUE;
//    self.actionMenu.itemSpacing = 15;
//    self.actionMenu.startPoint = button.center;
//    sampleAnswerView.userInteractionEnabled = TRUE;
//    scrollView.scrollEnabled = false;
//    [sampleAnswerView addSubview:self.actionMenu];
//    [self.actionMenu open];
//}
-(void)showTransTouchClick:(UITapGestureRecognizer *)tap
{
    
    isShowTransscript = !isShowTransscript;
    if(isShowTransscript)
    {
        scriptbtn.text = @"⇩ Hide";
        NSString * transscript = [[globalDictionary valueForKey:@"audio_transcript"]valueForKey:@"text"];
        ScriptViewText = [[UITextView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH-30,inputView.frame.size.height/3)];
        ScriptViewText.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        ScriptViewText.text = transscript;
        ScriptViewText.editable = FALSE;
        [inputView addSubview:ScriptViewText];
    }
    else{
        scriptbtn.text = @"⇧ Transcript";
        if(ScriptViewText != NULL){
            ScriptViewText.hidden = TRUE;
            [ScriptViewText removeFromSuperview];
            ScriptViewText = NULL;
        }
    }
}



- (void)openInsZoomView:(UITapGestureRecognizer *)TouchClick
{
    NSString *imageFilePath;
    //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
    
    
    NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
    imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    ZoomWebView * zoomObj = [[ZoomWebView alloc]initWithNibName:@"ZoomWebView" bundle:nil];
    zoomObj.path = imageFilePath;
    zoomObj.original_path = [[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"];
    [self presentViewController:zoomObj animated:YES completion:nil];
}

- (void)openZoomView:(UITapGestureRecognizer *)TouchClick
{
    NSString *imageFilePath;
    NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]];
    imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]];
    ZoomWebView * zoomObj = [[ZoomWebView alloc]initWithNibName:@"ZoomWebView" bundle:nil];
    zoomObj.path = imageFilePath;
    zoomObj.original_path = [[globalDictionary valueForKey:@"image"]valueForKey:@"text"];
    [self presentViewController:zoomObj animated:YES completion:nil];
}

-(IBAction)option1AudioPlay:(id)sender
{
    
    if(option1player != NULL && option1player.isPlaying)
    {
        [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        [option1player stop];
        option1player = NULL;
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:0]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:0]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        option1player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option1player.delegate = self;
        [option1player play];
        
        [opa1 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}


-(IBAction)option2AudioPlay:(id)sender
{
    if(option2player != NULL && option2player.isPlaying)
    {
        [option2player stop];
        option2player = NULL;
        [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        // imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:1]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:1]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option2player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option2player.delegate = self;
        [option2player play];
        
        [opa2 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}
-(IBAction)option3AudioPlay:(id)sender
{
    if(option3player != NULL && option3player.isPlaying)
    {
        [option3player stop];
        option3player = NULL;
        [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:2]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:2]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option3player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option3player.delegate = self;
        [option3player play];
        
        [opa3 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}
-(IBAction)option4AudioPlay:(id)sender
{
    
    if(option4player != NULL && option4player.isPlaying)
    {
        [option4player stop];
        option4player = NULL;
        [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else{
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:3]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:3]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option4player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option4player.delegate = self;
        [option4player play];
        [opa4 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
        
    }
    
}
-(IBAction)option5AudioPlay:(id)sender
{
    
    if(option5player != NULL && option5player.isPlaying)
    {
        [opa5 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        [option5player stop];
        option5player = NULL;
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:4]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:4]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        option5player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option5player.delegate = self;
        [option5player play];
        
        [opa5 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}


-(IBAction)option6AudioPlay:(id)sender
{
    if(option6player != NULL && option6player.isPlaying)
    {
        [option6player stop];
        option6player = NULL;
        [opa6 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:5]valueForKey:@"media"] valueForKey:@"text"]];
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:5]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option6player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option6player.delegate = self;
        [option6player play];
        
        [opa6 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}
-(IBAction)option7AudioPlay:(id)sender
{
    if(option7player != NULL && option7player.isPlaying)
    {
        [option7player stop];
        option7player = NULL;
        [opa7 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:6]valueForKey:@"media"] valueForKey:@"text"]];
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:6]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option7player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option7player.delegate = self;
        [option7player play];
        
        [opa7 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
    }
    
}
-(IBAction)option8AudioPlay:(id)sender
{
    
    if(option8player != NULL && option8player.isPlaying)
    {
        [option8player stop];
        option8player = NULL;
        [opa8 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else{
        [self clickMcaAudioPlay];
        NSString *imageFilePath;
        //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:7]valueForKey:@"media"] valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:7]valueForKey:@"media"] valueForKey:@"text"]];
        imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: imageFilePath];
        
        option8player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        option8player.delegate = self;
        [option8player play];
        [opa8 setImage:[UIImage imageNamed:@"o_pause.png"] forState:UIControlStateNormal];
        
    }
    
}


-(void)clickMcaAudioPlay
{
    if(audioPlayer != NULL && audioPlayer.isPlaying)
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }
    
    
    if(option1player != NULL)
    {
        [option1player stop];
        option1player = NULL;
    }
    if(option2player != NULL)
    {
        [option2player stop];
        option2player = NULL;
    }
    if(option3player != NULL)
    {
        [option3player stop];
        option3player = NULL;
    }
    if(option4player != NULL)
    {
        [option4player stop];
        option4player = NULL;
    }
    if(option5player != NULL)
    {
        [option5player stop];
        option5player = NULL;
    }
    if(option6player != NULL)
    {
        [option6player stop];
        option6player = NULL;
    }
    if(option7player != NULL)
    {
        [option7player stop];
        option7player = NULL;
    }
    if(option8player != NULL)
    {
        [option8player stop];
        option8player = NULL;
    }
    [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa5 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa6 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa7 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa8 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    
}





-(void)updateMCQTimer
{
    globalTotalSec --;
    int lMin = globalTotalSec/60;
    globalMin = [[NSString alloc]initWithFormat:@"%02d",lMin];
    int lSec = globalTotalSec%60;
    globalSec = [[NSString alloc]initWithFormat:@"%02d",lSec];
    globalTimer.text = [[NSString alloc]initWithFormat:@"%@:%@",globalMin,globalSec];
    float val =  (float)((float)(globalCalTotalSec-globalTotalSec)/(float)globalCalTotalSec);;
    [timerProgressView setProgress:val];
    if(globalTotalSec <= 0){
        [MCQTimer invalidate];
        MCQTimer = NULL;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270,150)];
        customView.backgroundColor = [UIColor clearColor];
        
        
        
        UIImage* imgMyImage = [UIImage imageNamed:@"clock.png"];
        UIImageView* ivMyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(customView.frame.size.width/2 -45, 15,90, 90)];
        [ivMyImageView setImage:imgMyImage];
        [customView addSubview:ivMyImageView];
        
        UILabel * times= [[UILabel alloc]initWithFrame:CGRectMake(0, 130,customView.frame.size.width,30)];
        times.text = @"Time's up !";
        times.textAlignment = NSTextAlignmentCenter;
        times.font = [UIFont systemFontOfSize:20];
        [customView addSubview:times];
        
        [alertController.view addSubview:customView];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"SUBMIT" alter:@"Submit"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [self clickSubmit];
            
            
            
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:^{}];
        
        
        
        
        
    }
}

-(void)createJsonandAddObject :(NSString *) assessId question:(NSString *)quesId  startTime :(NSString *)startTime endTime :(NSString *)endTtime Answer:(NSString *)answeId essayAnswer :(NSString *)essay av_media_files :(NSString *)file skill_id :(NSString *)skill_id
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:assessId forKey:@"test_uniqid"];
    [dic setValue:quesId forKey:@"ques_uniqid"];
    
    
    if([endTtime longLongValue] > 0 &&  [startTime longLongValue] >0 && ([endTtime longLongValue] - [startTime longLongValue]) > 0)
    {
        
        double count = ([endTtime longLongValue] - [startTime longLongValue]);
        double interval = count/(double)1000;
        [dic setValue:[[NSString alloc]initWithFormat:@"%f",ceil(interval)] forKey:@"date_ms"];
        
        
    }
    else
    {
        [dic setValue:@"0" forKey:@"date_ms"];
    }
    [dic setValue:answeId forKey:@"ans_uniqid"];
    [dic setValue:essay forKey:@"essay_answer"];
    [dic setValue:file forKey:@"av_media_files"];
    [dic setValue:skill_id forKey:@"skill_id"];
    [dic setValue:[[NSString alloc] initWithFormat:@"%d",[appDelegate.engineObj getAttemptCounter]+1] forKey:@"attempt_id"];
    
    
    [jsonArr addObject:dic];
    
    
}

-(void)calculateAnswerAndMakeJson
{
    answerableQuestion =0;
    for (NSDictionary *obj in quesArr) {
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
    jsonArr = [[NSMutableArray alloc]init];
    totalCorrectAns = 0;
    NSMutableArray * coins = [[NSMutableArray alloc]init];
    for ( NSDictionary * calObj in ansTrackArray) {
        if([[calObj valueForKey:@"type"]isEqualToString:@"mttt"] || [[calObj valueForKey:@"type"]isEqualToString:@"mtti"] || [[calObj valueForKey:@"type"]isEqualToString:@"mtii"])
        {
            BOOL flag = TRUE;;
            for(int i=0;i< [[calObj valueForKey:@"left"]count] ;i++)
            {
                NSDictionary * obj = (NSDictionary * )[[calObj valueForKey:@"right"] objectAtIndex:i];
                if([[obj valueForKey:@"position"]intValue] == i+1)
                {
                    
                }
                else{
                    flag = FALSE;
                    break;
                }
            }
            if(flag)
            {
                totalCorrectAns++;
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"] ];
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                if(self.type == 3)
                    [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                else
                    [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                [coins addObject:dict];
                
            }
            else
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
            }
            
            
            
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"mmc"])
        {
            
            bool option = false;
            NSMutableString * ansStr = [[NSMutableString alloc]init];
            NSArray *Arr =  [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
            for(int i=0; i<[Arr count];i++){
                NSDictionary * obj =  [Arr objectAtIndex:i] ;
                NSString *opt = [[NSString alloc]initWithFormat:@"option%d",i+1];
                if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"] )
                {
                    
                    if(i>0) [ansStr appendString:@", "];
                    
                    [ansStr appendString:[[ obj valueForKey:@"content"] valueForKey:@"text"]];
                    
                    if([[calObj valueForKey:opt]intValue] == 1)
                    {
                        
                    }
                    else
                    {
                        option = true;
                    }
                }
                else if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"false"] && [[calObj valueForKey:opt]intValue] == 0 )
                {
                    
                }
                else if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"false"] && [calObj valueForKey:opt] == NULL )
                {
                    
                }
                else
                {
                    option = true;
                    //break;
                }
            }
            if(!option)
            {
                
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                totalCorrectAns++;
                
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                if(self.type == 3)
                    [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                else
                    [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                [coins addObject:dict];
                
            }
            else{
                
                
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                
                
                
            }
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"mc"]||[[calObj valueForKey:@"type"]isEqualToString:@"mci"]||[[calObj valueForKey:@"type"]isEqualToString:@"mca"])
        {
            if([calObj valueForKey:@"ansObj"] != NULL)
            {
                NSDictionary * obj =  [calObj valueForKey:@"ansObj"];
                if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
                {
                    [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                    totalCorrectAns++;
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                    [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                    if(self.type == 3)
                        [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                    else
                        [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                    
                    [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                    [coins addObject:dict];
                    //break;
                }
                else{
                    [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                }
            }
            else{
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
            }
            
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"dd"])
        {
            NSArray * labels = [calObj valueForKey:@"option"];
            NSMutableString * strMessage = [[NSMutableString alloc]init];
            for (NSString * str in labels) {
                [strMessage appendFormat:@"%@ ",str];
            }
            
            NSArray * anslabels = [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
            NSMutableString * strAnsMessage = [[NSMutableString alloc]init];
            for (NSString * str in [[anslabels valueForKey:@"content"]valueForKey:@"text"]) {
                [strAnsMessage appendFormat:@"%@ ",str];
            }
            
            if([strAnsMessage isEqualToString:strMessage])
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                totalCorrectAns++;
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                if(self.type == 3)
                    [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                else
                    [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                [coins addObject:dict];
            }
            else
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
            }
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"pw"])
        {
            bool flag = false;
            for (NSDictionary *obj  in (NSArray *)[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"]) {
                if([[[obj valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                    if([[calObj valueForKey:@"option"] isEqualToString:[[obj valueForKey:@"content"] valueForKey:@"text"]])
                    {
                        flag = true;
                        [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                        totalCorrectAns++;
                        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                        [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                        [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                        [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                        [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                        if(self.type == 3)
                            [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                        else
                            [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                        
                        [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                        [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                        [coins addObject:dict];
                        break;
                    }
                }
            }
            if(!flag){
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
            }
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"ifb"])
        {
            
            NSArray * QuesOptionArr;
            NSArray * filledOptionArr = [calObj valueForKey:@"option"];
            
            
            if([[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]] && [[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"] count] > 0){
                QuesOptionArr = [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
            }
            else
            {
                NSDictionary * _option = [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
                QuesOptionArr = [[NSArray alloc]initWithObjects:_option, nil];
            }
            
            
            
            
            BOOL quesFlag = TRUE;
            for (int i =0; i < [QuesOptionArr count];i++)
            {
                
                NSString *trimmed1 = [[filledOptionArr objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSString * dataStr = [[QuesOptionArr objectAtIndex:i] valueForKey:@"text"];
                NSArray * arr = [dataStr componentsSeparatedByString:@"##"];
                BOOL flag = TRUE;
                for (NSString * str in arr)
                {
                    if([[str uppercaseString]isEqualToString:[trimmed1 uppercaseString]])
                    {
                        flag = FALSE;
                        break;
                    }
                }
                if(flag)
                {
                    [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                    quesFlag = FALSE;
                    break;
                }
            }
            
            if( quesFlag )
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                totalCorrectAns++;
                
                
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                if(self.type == 3)
                    [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                else
                    [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                [coins addObject:dict];
                
                
                
            }
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"fb"])
        {
            
            
            NSArray * QuesOptionArr;
            NSArray * filledOptionArr = [calObj valueForKey:@"option"];
            
            
            if([[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]] && [[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"] count] > 0){
                QuesOptionArr = [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
            }
            else
            {
                NSDictionary * _option = [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
                QuesOptionArr = [[NSArray alloc]initWithObjects:_option, nil];
            }
            
            
            
            
            BOOL quesFlag = TRUE;
            for (int i =0; i < [QuesOptionArr count];i++)
            {
                
                NSString *trimmed1 = [[filledOptionArr objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                NSString * dataStr = [[QuesOptionArr objectAtIndex:i] valueForKey:@"text"];
                NSArray * arr = [dataStr componentsSeparatedByString:@"##"];
                BOOL flag = TRUE;
                for (NSString * str in arr)
                {
                    if([[str uppercaseString]isEqualToString:[trimmed1 uppercaseString]])
                    {
                        flag = FALSE;
                        break;
                    }
                }
                if(flag)
                {
                    [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                    quesFlag = FALSE;
                    break;
                }
            }
            
            if( quesFlag )
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:@"" av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                totalCorrectAns++;
                
                
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                if(self.type == 3)
                    [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                else
                    [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                
                [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                [coins addObject:dict];
            }
            
            
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"es"])
        {
            [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:[calObj valueForKey:@"option"] av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
        }
        else if([[calObj valueForKey:@"type"]isEqualToString:@"ra"])
        {
            if([[[[calObj valueForKey:@"object"] valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1)
            {
                
                if([calObj valueForKey:@"score"] != NULL && [[[[calObj valueForKey:@"score"]valueForKey:@"RESP"] valueForKey:@"overall_score"]intValue] > 70)
                {
                    
                    [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"1" essayAnswer:[calObj valueForKey:@"option"] av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                    totalCorrectAns++;
                    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:appDelegate.courseCode forKey:DATABASE_COINS_COURSECODE];
                    [dict setValue:appDelegate.topicId forKey:DATABASE_COINS_TOPICID];
                    [dict setValue:appDelegate.chapterId forKey:DATABASE_COINS_CAHPTERID];
                    [dict setValue:self.assessnetUid forKey:DATABASE_COINS_COMPONANTID];
                    if(self.type == 3)
                        [dict setValue:@"3" forKey:DATABASE_COINS_COMPONANTTYPE];
                    else
                        [dict setValue:@"4" forKey:DATABASE_COINS_COMPONANTTYPE];
                    
                    [dict setValue:[calObj valueForKey:@"quesId"] forKey:DATABASE_COINS_COMPONANTDATA];
                    [dict setValue:@"1" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                    [coins addObject:dict];
                }
            }
            else if([[[[calObj valueForKey:@"object"] valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0)
            {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:[calObj valueForKey:@"option"] av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
            }
            else{
                
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:[calObj valueForKey:@"option"] av_media_files:@"" skill_id : [calObj valueForKey:@"skill_id"]];
                
            }
        }
        
        else if([[calObj valueForKey:@"type"]isEqualToString:@"av"])
        {
            
            for (NSString * str  in [calObj valueForKey:@"option"]) {
                [self createJsonandAddObject:_assessnetUid question:[calObj valueForKey:@"quesId"] startTime:[calObj valueForKey:@"startTime"] endTime:[calObj valueForKey:@"endTime"] Answer:@"0" essayAnswer:@"" av_media_files:str skill_id : [calObj valueForKey:@"skill_id"]];
            }
            
        }
        
    }
    
    [appDelegate.engineObj insertCoins:coins];
    [self b_syncCoinsData];
    
}

-(void)addOrReplace : (NSMutableDictionary *)obj
{
    if ([ansTrackArray containsObject:obj])
    {
    }
    else{
        [ansTrackArray addObject:obj];
    }
}

-(NSMutableDictionary *)createDictionaryifNot :(NSDictionary *) quesObj type:(NSString *)type  Time:(NSString * )duration
{
    bool flag = FALSE;
    NSMutableDictionary * obj;
    NSString * _quesId = [quesObj valueForKey:@"uniqid"];
    for ( NSMutableDictionary * lObj in ansTrackArray) {
        if([[lObj valueForKey:@"quesId"]isEqualToString:_quesId])
        {
            obj = lObj;
            flag = TRUE;
        }
    }
    if(!flag){
        obj = [[NSMutableDictionary alloc]init];
        [obj setValue:_quesId forKey:@"quesId"];
        [obj setValue:[[[quesObj valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"] forKey:@"type"];
        [obj setValue:quesObj forKey:@"object"];
        [obj setValue:duration forKey:@"startTime"];
        [obj setValue:@"0" forKey:@"endTime"];
        [obj setValue:@"0" forKey:@"isSumitAnswer"];
        [obj setValue:@"0" forKey:@"random"];
        [obj setValue:[[NSString alloc]initWithFormat:@"%@",[[quesObj valueForKey:@"skill"] valueForKey:@"id"]] forKey:@"skill_id"];
        
        //[obj setValue:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]] forKey:@"time"];
    }
    else
    {
        [obj setValue:duration forKey:@"endTime"];
    }
    return obj;
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
    
    
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            // Microphone enabled code
        }
        else {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@""
                                         message:@"Please enable Mic permission from setting."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            int duration = 3; // duration in seconds
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
                [self clickBack];
            });
            
            return;
        }
    }];
    
    
//    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//
//    if(status == AVAuthorizationStatusAuthorized) { // authorized
//        NSLog(@"camera authorized");
//    }
//    else if(status == AVAuthorizationStatusDenied){ // denied
//        if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                // Will get here on both iOS 7 & 8 even though camera permissions weren't required
//                // until iOS 8. So for iOS 7 permission will always be granted.
//
//                NSLog(@"DENIED");
//
//                if (granted) {
//                    // Permission has been granted. Use dispatch_async for any UI updating
//                    // code because this block may be executed in a thread.
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //[self doStuff];
//                    });
//                } else {
//                    // Permission has been denied.
//                    UIAlertController * alert = [UIAlertController
//                                                 alertControllerWithTitle:@""
//                                                 message:@"Please go to Settings and enable the camera for this app to use this feature."
//                                                 preferredStyle:UIAlertControllerStyleAlert];
//
//
//                    [self presentViewController:alert animated:YES completion:nil];
//
//
//
//                    int duration = 2; // duration in seconds
//
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                        [alert dismissViewControllerAnimated:YES completion:nil];
//                        [self clickBack];
//                    });
//                }
//            }];
//        }
//    }
//    else if(status == AVAuthorizationStatusRestricted){ // restricted
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:@""
//                                     message:@"Please go to Settings and enable the camera for this app to use this feature."
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//
//        [self presentViewController:alert animated:YES completion:nil];
//
//
//
//        int duration = 2; // duration in seconds
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [alert dismissViewControllerAnimated:YES completion:nil];
//            [self clickBack];
//        });
//    }
//    else if(status == AVAuthorizationStatusNotDetermined){ // not determined
//
//        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//            if(granted){ // Access has been granted ..do something
//                NSLog(@"camera authorized");
//            } else { // Access denied ..do something
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:@""
//                                             message:@"Please go to Settings and enable the camera for this app to use this feature."
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//
//                [self presentViewController:alert animated:YES completion:nil];
//
//
//
//                int duration = 2; // duration in seconds
//
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                    [alert dismissViewControllerAnimated:YES completion:nil];
//                    //[self clickBack];
//                });
//            }
//        }];
//    }
    
    
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.TopicName];
        lbl.font = NAVIGATIONTITLEUPFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEDOWNFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
        
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
    else if([UISTANDERD isEqualToString:@"PRODUCT3"])
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentLeft;
        [bar addSubview:lblquiz];
        
        
        
        UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
        branding.image = [UIImage imageNamed:@"LogowithText.png"];
        branding.contentMode = UIViewContentModeScaleAspectFit;
        [bar addSubview:branding];
        
        
//        UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
//        UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
//        img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        [hamburgBtn setImage:img1 forState:UIControlStateNormal];
//        hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
//        [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
//        [bar addSubview:hamburgBtn];
        
        
    }
    else
    {
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.cusTitleName];
        lblquiz.font = NAVIGATIONTITLEFONT;
        lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lblquiz.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lblquiz];
    }
    
   
    
    if([UISTANDERD isEqualToString:@"PRODUCT3"])
    {
        
        backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
        UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [backBtn setImage:img forState:UIControlStateNormal];
        backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
        
    }
    else
    {
        backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        
    }
    
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    
    style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -30.0f;
    
    
    
    quesRand = FALSE;
    optRand = FALSE;
    sanaAttemptCounter = 0;
    rightAnsFBSpace  = @"_____";
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error: nil];
    
    isNextClick = FALSE;
    isPreClick = FALSE;
    phoneDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    numberofChar =0;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        numberofChar =70;
    }
    else
    {
        numberofChar =35;
    }
    
    isShowTransscript = FALSE;
    leftArr = [[NSMutableArray alloc]init];
    rightArr =  [[NSMutableArray alloc]init];
    totalCorrectAns = 0;
    isRecording = FALSE;
    isAudioRecording =FALSE;
    fileArray = [[NSMutableArray alloc]init];
    
    
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:self.scnUid forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",self.assessnetUid] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.type] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]] forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
    questionCounter = 0;
    AVCounter =0;
    selectedDragArr = [[NSMutableArray alloc]init];
    
    
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    //[navBar setBarTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    ansTrackArray = [[NSMutableArray alloc]init];
    
    //[self.view bringSubviewToFront:navBar];
    timerProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    timerProgressView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
    [[timerProgressView layer]setFrame:CGRectMake(SCREEN_WIDTH-50, 22, 40, 40)];
    [[timerProgressView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
    timerProgressView.trackTintColor = [UIColor whiteColor];
    [timerProgressView setProgress:0.0f];  ///15
    
    [[timerProgressView layer]setCornerRadius:timerProgressView.frame.size.width / 2];
    [[timerProgressView layer]setBorderWidth:3];
    [[timerProgressView layer]setMasksToBounds:TRUE];
    timerProgressView.clipsToBounds = YES;
    globalTimer = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 22, 30, 40)];
    globalTimer.font = [UIFont systemFontOfSize:10];
    if(self.isResumeStart && ISENABLERESUMEQUIZ)
    {
       
        NSMutableDictionary * resumeData = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.assessnetUid]];
        if(resumeData != NULL )
        {
            
            long long val = [[resumeData valueForKey:@"resumeT"] longLongValue];
            [data setValue:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTimeWithResumeTime:val]] forKey:NATIVE_JSON_KEY_STARTTIME];
            g_quizObj = [resumeData valueForKey:@"quizArr"];
            if(g_quizObj != NULL)
            {
                for(NSDictionary * obj in [resumeData valueForKey:@"trackData"])
                {
                  [ansTrackArray addObject:[obj mutableCopy]] ;
                }
                questionCounter = [[resumeData valueForKey:@"quesNo"]intValue];
            }
        }
        else
        {
            if(self.type ==3 ){
                g_quizObj = [appDelegate.engineObj getAssessmentObject:_assessnetUid];
            }
            else
            {
                g_quizObj = [appDelegate.engineObj getMCQObject:_assessnetUid];
            }
        }
    }
    else
    {
        if(self.type ==3 ){
            g_quizObj = [appDelegate.engineObj getAssessmentObject:_assessnetUid];
        }
        else
        {
            g_quizObj = [appDelegate.engineObj getMCQObject:_assessnetUid];
        }
    }
    
    
    
    
    NSDictionary * obj =   [[g_quizObj valueForKey:@"assess"]valueForKey:@"delivery"];
    NSString * time = [[obj valueForKey:@"max_minutes"]valueForKey:@"text"];
    quesRand = [[[obj valueForKey:@"quesRand"]valueForKey:@"text"]boolValue];
    optRand  = [[[obj valueForKey:@"ansRand"]valueForKey:@"text"]boolValue];
    
    isShowFeedback =[[[obj valueForKey:@"showFeedback"]valueForKey:@"text"]boolValue];
    quizAddtionalProperty = [appDelegate.engineObj getQuizOrAssementData: self.assessnetUid:self.type];
    if([[[g_quizObj valueForKey:@"assess"]valueForKey:@"question"] isKindOfClass:[NSArray class]]){
        NSArray * local_arr_quesArr = [[g_quizObj valueForKey:@"assess"]valueForKey:@"question"];
        if(self.type ==3 ){
            if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] > 1)
            {
                quesArr = [[NSMutableArray alloc]init];
                NSString * mapStr  = [quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_NO_SKILL_QUES];
                
                NSData *objectData1 = [mapStr dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * mapObj  = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:objectData1 options:NSJSONReadingMutableContainers
                                                                                            error:nil];
                
                NSMutableArray * tempskillwithCount =  [[NSMutableArray alloc]init];
                if(self.isRemediation)
                {
                    [tempskillwithCount addObject:self.skillObj];
                }
                else
                {
                    NSString * str = (NSString *) [quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_SKILLS];
                    NSData *objectData = [str dataUsingEncoding:NSUTF8StringEncoding];
                    NSArray * skillArr  = (NSArray *) [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers
                                                                                        error:nil];
                    
                    
                    for (NSDictionary *skillObj in skillArr) {
                        NSMutableDictionary * tempObj = [[NSMutableDictionary alloc]init];
                        [tempObj setValue:[skillObj valueForKey:@"skill_id"] forKey:@"skill_id"];
                        
                        NSDictionary * obj = (NSDictionary *)[mapObj valueForKey:[[NSString alloc]initWithFormat:@"%@",[skillObj valueForKey:@"skill_id"]]];
                        
                        [tempObj setValue:[obj valueForKey:@"qCount"] forKey:@"quesCount"];
                        [tempObj setValue:[obj valueForKey:@"skill_name"] forKey:@"skill_name"];
                        [tempObj setValue:@"0" forKey:@"counter"];
                        [tempskillwithCount addObject:tempObj];
                        
                    }
                }
                
                for (NSDictionary * obj in local_arr_quesArr) {
                    
                    for (NSDictionary *skillObj in tempskillwithCount) {
                        if([[[obj valueForKey:@"skill"]valueForKey:@"id"] intValue] == [[skillObj valueForKey:@"skill_id"]intValue]){
                            if([[skillObj valueForKey:@"counter"]intValue] >= [[skillObj valueForKey:@"quesCount"]intValue] )
                            {
                                break;
                            }
                            [quesArr addObject:obj];
                            int count = [[skillObj valueForKey:@"counter"]intValue];
                            [skillObj setValue:[[NSString alloc]initWithFormat:@"%d",++count] forKey:@"counter"];
                            
                        }
                        
                        
                    }
                    if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_NO_SKILL_QUES] intValue] == [quesArr count]  )
                    {
                        break;
                    }
                    
                }
            }
            else
            {
                quesArr =  [[NSMutableArray alloc]initWithArray:local_arr_quesArr];
            }
            
        }
        else
        {
            quesArr =  [[NSMutableArray alloc]initWithArray:local_arr_quesArr];
            
        }
        
    }else if([[[g_quizObj valueForKey:@"assess"]valueForKey:@"question"] isKindOfClass:[NSDictionary class]]){
        quesArr = [[NSMutableArray alloc]initWithObjects:[[g_quizObj valueForKey:@"assess"]valueForKey:@"question"], nil];
    }else{
        quesArr = [[NSMutableArray alloc]init];
    }
    
    
    
    
    
    
    
    if(quesRand)
    {
        NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:quesArr];
        quesArr =[self randomOptionArr:tmpArray:NO];
    }
    if([quesArr count] <= 0 )
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"No Quiz available."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        int duration = 2; // duration in seconds
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
            [self clickBack];
        });
        
        return;
    }
    if([time integerValue] == 0)
    {
        isGlobalTimer = NO;
    }
    else
    {
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
        {
            isGlobalTimer = NO;
        }
        else
        {
            isGlobalTimer = YES;
            globalTotalSec = [time intValue]*60;
            globalCalTotalSec = globalTotalSec;
            int lMin = globalTotalSec/60;
            globalMin = [[NSString alloc]initWithFormat:@"%02d",lMin];
            int lSec = globalTotalSec%60;
            globalSec = [[NSString alloc]initWithFormat:@"%02d",lSec];
            globalTimer.text = [[NSString alloc]initWithFormat:@"%@:%@",globalMin,globalSec];
            [bar addSubview:timerProgressView];
            [bar addSubview:globalTimer];
        }
    }
    backGView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    backGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGView];
    
    inputView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,11 , SCREEN_WIDTH, backGView.frame.size.height-71)];
    inputView.backgroundColor = [UIColor whiteColor];
    [backGView addSubview:inputView];
    
    
    if([[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"] != NULL){
        instructionView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
        instructionView.backgroundColor = [UIColor whiteColor];
        backInsImgView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, instructionView.frame.size.height/3)];
        insImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, backInsImgView.frame.size.height)];
        
        if([[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"] != NULL &&  ![[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"]isEqualToString:@""] && [[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"] != NULL &&  ![[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"false"] )
        {
            NSLog(@"Image and text Both");
            
            NSString *imageFilePath;
            //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
            imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            insImgView.image =[UIImage imageWithContentsOfFile: imageFilePath];
            insImgView.contentMode = UIViewContentModeScaleAspectFit;
            UILabel * instructionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, (instructionView.frame.size.height/3)+5,instructionView.frame.size.width, 60)];
            instructionLbl.textAlignment = NSTextAlignmentCenter;
            instructionLbl.font = [UIFont systemFontOfSize:30];
            instructionLbl.textColor  = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            instructionLbl.text = @"Instructions";
            [instructionView addSubview:instructionLbl];
            instext = [[UITextView alloc]initWithFrame:CGRectMake(10,(instructionView.frame.size.height/3)+60,instructionView.frame.size.width-20 ,instructionView.frame.size.height-((instructionView.frame.size.height/3)+125) )];
            instext.editable = FALSE;
            NSString* newString = [[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            
            NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            
            NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" style=\"font-size:13px;\" color=\"#4e4e4e\">%@</font></div>",newString1];
            NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                    initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                    options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                    documentAttributes: nil
                                                    error: nil
                                                    ];
            instext.attributedText = attributedString;
            
            instext.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            instext.textAlignment = NSTextAlignmentLeft;
            [instructionView addSubview:instext];
            
            insGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(openInsZoomView:)];
            insGasture.numberOfTapsRequired =1;
            [backInsImgView addGestureRecognizer:insGasture];
            [backInsImgView addSubview:insImgView];
            [instructionView addSubview:backInsImgView];
            
        }
        else if([[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"] != NULL &&  [[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"]isEqualToString:@""] && [[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"] != NULL &&  ![[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"false"] )
        {
            NSLog(@"Only Image");
            
            NSString *imageFilePath;
            //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
            
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"text"]];
            imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            insImgView.image =[UIImage imageWithContentsOfFile: imageFilePath];
            
            
            insGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(openInsZoomView:)];
            insGasture.numberOfTapsRequired =1;
            [backInsImgView addGestureRecognizer:insGasture];
            [backInsImgView addSubview:insImgView];
            [instructionView addSubview:backInsImgView];
            
        }
        else if([[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"] != NULL &&  ![[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"]isEqualToString:@""] && [[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"] != NULL &&  [[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"false"] )
        {
            UILabel * instructionLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,instructionView.frame.size.width, 60)];
            instructionLbl.textAlignment = NSTextAlignmentCenter;
            instructionLbl.font = [UIFont systemFontOfSize:30];
            instructionLbl.textColor  = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            instructionLbl.text = @"Instructions";
            [instructionView addSubview:instructionLbl];
            instext = [[UITextView alloc]initWithFrame:CGRectMake(10,70,instructionView.frame.size.width-20 ,instructionView.frame.size.height-130 )];
            instext.editable = FALSE;
            NSString* newString = [[[[[g_quizObj valueForKey:@"assess"]valueForKey:@"instruction"]valueForKey:@"content"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            
            NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
            NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"4\">%@</font></div>",newString1];
            NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                    initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                    options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                    documentAttributes: nil
                                                    error: nil
                                                    ];
            instext.attributedText = attributedString;
            instext.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            instext.textAlignment = NSTextAlignmentLeft;
            [instructionView addSubview:instext];
            
            
            
        }
        else
        {
            
            instructionView.hidden = TRUE;
            if(isGlobalTimer)
                MCQTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                            target:self
                                                          selector:@selector(updateMCQTimer)
                                                          userInfo:nil
                                                           repeats:YES];
            
            
            
        }
        insStartBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/10),instructionView.frame.size.height-50,8*(SCREEN_WIDTH/10) ,40 )];
        insStartBtn.layer.cornerRadius = 20; // this value vary as per your desire
        insStartBtn.clipsToBounds = YES;
        [insStartBtn setTitle:@"Start" forState:UIControlStateNormal];
        insStartBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        insStartBtn.titleLabel.font = BUTTONFONT;
        [insStartBtn addTarget:self
                        action:@selector(clickStart:)
              forControlEvents:UIControlEventTouchUpInside];
        
        insStartBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
        [instructionView addSubview:insStartBtn];
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 37, insStartBtn.frame.size.width, 3)];
        lineView1.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR alpha:1.0];
        [insStartBtn addSubview:lineView1];
        [self.view addSubview:instructionView];
        
    }else
    {
        if(isGlobalTimer)
            MCQTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateMCQTimer)
                                                      userInfo:nil
                                                       repeats:YES];
        
    }
    
 //   if(self.type ==19 )
//    {
//
//       showPopUp = [[UIView alloc]initWithFrame:CGRectMake(2,SCREEN_HEIGHT-(SCREEN_HEIGHT/4)-70, SCREEN_WIDTH-4, SCREEN_HEIGHT/4)];
//        [showPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#aae9fa" alpha:1.0]];
//        UIView * uppershowPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, showPopUp.frame.size.width, 3*(showPopUp.frame.size.height/10))] ;
//        uppershowPopUp.backgroundColor = [self getUIColorObjectFromHexString:@"#7AE0FB" alpha:1.0];
//        [showPopUp addSubview:uppershowPopUp];
//        rWImage = [[UIImageView alloc]initWithFrame:CGRectMake(showPopUp.frame.size.width/2-20, 3*(showPopUp.frame.size.height/10)-20, 40, 40)];
//        [showPopUp addSubview:rWImage];
//        answer =[[UITextView alloc]initWithFrame:CGRectMake(2,4*(showPopUp.frame.size.height/10) ,showPopUp.frame.size.width-4 ,6*(showPopUp.frame.size.height/10) -5)];
//        answer.textAlignment = NSTextAlignmentCenter;
//        answer.font = [UIFont systemFontOfSize:15];
//        answer.editable = FALSE;
//        answer.backgroundColor = [UIColor clearColor];
//        [showPopUp addSubview:answer];
//        showPopUp.hidden = TRUE;
//        [self.view addSubview:showPopUp];
//    }
    
    
    backProgressView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    l1 = [[UILabel alloc]initWithFrame:CGRectMake(backProgressView.frame.size.width-60,3, 60, 14)];
    l1.text = [[NSMutableString alloc]initWithFormat:@"%lu of %lu",(unsigned long)questionCounter + 1 ,(unsigned long)[quesArr count] ];
    l1.font = [UIFont boldSystemFontOfSize:12.0];
    l1.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    l1.textAlignment  = NSTextAlignmentCenter;
    [backProgressView addSubview:l1 ];
    progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,10,backProgressView.frame.size.width-70, 8)];
    progressView.trackTintColor = [self getUIColorObjectFromHexString:QUIZPROGRESSTRACKBARCOLOR alpha:1.0];
    if([quesArr count] > 0 ){
        
        float val =  (float)((float)(questionCounter+1)/(float)[quesArr count]);;
        progressView.progress =val;
        
    }
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    progressView.transform = transform;
    progressView.progressTintColor =   [self getUIColorObjectFromHexString:QUIZPROGRESSBARCOLOR alpha:1.0];
    [backProgressView addSubview:progressView ];
    [backGView addSubview:backProgressView];
    
    
    
    
    
    
    
    
    
    [self renderUI];
    
    
    
}

-(IBAction)clickStart:(id)sender
{
    if(isGlobalTimer)
        MCQTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(updateMCQTimer)
                                                  userInfo:nil
                                                   repeats:YES];
    [instructionView removeFromSuperview];
}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    if ([textView.text isEqualToString:@""]) {
//        textView.text = @"  Fill in the blank.";
//        textView.textColor = [UIColor lightGrayColor]; //optional
//    }
//    [textView resignFirstResponder];
//}

-(IBAction)clickShowAnswer:(id)sender
{
    
    
    [self stopAllMeadia];
    if(esTextView != NULL)
        [esTextView resignFirstResponder];
    
    
    NSMutableDictionary *currentQuesObj = [self createDictionaryifNot:globalDictionary type:@"" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [currentQuesObj setValue:@"1" forKey:@"isSumitAnswer"];
    NSString * rightAns;
    if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
    {
        NSMutableArray * fbAns = [ibfbView getAnswerArray] ;
        [currentQuesObj setObject:fbAns forKey:@"option"];
    }
    else if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
    {
        NSMutableArray * fbAns = [fbView getAnswerArray] ;
        [currentQuesObj setObject:fbAns forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"])
    {
        [currentQuesObj setObject:esTextView.text forKey:@"option"];
    }
    else if([[[globalDictionary valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1  && [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
    {
        [currentQuesObj setObject:SanaResp forKey:@"score"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"dd"])
    {
        NSArray * arr =  dottedBox.allTags;
        [currentQuesObj setObject:arr forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"pw"])
    {
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mttt"])
    {
        [currentQuesObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [currentQuesObj setObject:[rightArr  mutableCopy] forKey:@"right"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtii"])
    {
        [currentQuesObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [currentQuesObj setObject:[rightArr  mutableCopy] forKey:@"right"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtti"])
    {
        
        [currentQuesObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [currentQuesObj setObject:[rightArr  mutableCopy]forKey:@"right"];
    }
    
    [self addOrReplace:currentQuesObj];
    NSDictionary * calObj = currentQuesObj;
    
    
    if([[calObj valueForKey:@"type"]isEqualToString:@"mttt"] || [[calObj valueForKey:@"type"]isEqualToString:@"mtti"] || [[calObj valueForKey:@"type"]isEqualToString:@"mtii"])
    {
        
        leftTableView.userInteractionEnabled = FALSE;
        rightTableView.userInteractionEnabled = FALSE;
        
        BOOL flag = TRUE;
        NSArray * _rightArr = [calObj valueForKey:@"right"];
        for(int i=0;i< [_rightArr count];i++)
        {
            NSDictionary * obj = (NSDictionary * )[rightArr objectAtIndex:i];
            if([[obj valueForKey:@"position"]intValue] == i+1)
            {
                
            }
            else{
                flag = FALSE;
                break;
            }
        }
        if(flag)
        {
            totalCorrectAns++;
            rightDrawFlag = 1;
            [self showFeedback:@"": TRUE : [calObj valueForKey:@"type"]];
            
        }
        else
        {
            rightDrawFlag = 2;
            [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
        }
        [leftTableView reloadData];
        [rightTableView reloadData];
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"mc"] )
    {
        
        
        op1.userInteractionEnabled  = FALSE;
        op2.userInteractionEnabled  = FALSE;
        op3.userInteractionEnabled  = FALSE;
        op4.userInteractionEnabled  = FALSE;
        op5.userInteractionEnabled  = FALSE;
        op6.userInteractionEnabled  = FALSE;
        op7.userInteractionEnabled  = FALSE;
        op8.userInteractionEnabled  = FALSE;
        
        
        UIView * v  = (UIView *)[scrollView viewWithTag:1000];
        UIView * tv=  (UIView *)[v viewWithTag:1001];
        UIImageView * iv = (UIImageView *) [v viewWithTag:1002];
        
        UIView * wv;
        UIView * twv;
        UIImageView * iwv;
        
        if([[calObj valueForKey:@"type"]isEqualToString:@"mc"])
        {
            
            if(textView.tag  == 101)
            {
                CALayer * lay1 = [textView layer];
                twv =textView;
                wv = [twv superview];
                textView.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            
            if(textView1.tag  == 101)
            {
                CALayer * lay1 = [textView1 layer];
                twv =textView1;
                wv = [twv superview];
                textView1.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(textView2.tag  == 101)
            {
                CALayer * lay1 = [textView2 layer];
                twv =textView2;
                wv = [twv superview];
                textView2.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(textView3.tag  == 101)
            {
                CALayer * lay1 = [textView3 layer];
                twv =textView3;
                wv = [twv superview];
                textView3.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(textView4.tag  == 101)
            {
                CALayer * lay1 = [textView4 layer];
                twv =textView4;
                wv = [twv superview];
                textView4.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(textView5.tag  == 101)
            {
                CALayer * lay1 = [textView5 layer];
                twv =textView5;
                wv = [twv superview];
                textView5.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(textView6.tag  == 101)
            {
                CALayer * lay1 = [textView6 layer];
                twv =textView6;
                wv = [twv superview];
                textView6.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(textView7.tag  == 101)
            {
                CALayer * lay1 = [textView7 layer];
                twv =textView7;
                wv = [twv superview];
                textView7.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            CALayer * lay1 = [tv layer];
            tv.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(tv.frame.size.width-20, tv.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [tv addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(wv.frame.size.width-20, wv.frame.size.height/2-7, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [wv addSubview:wrongImg];
            
        }
        else
        {
            
            if(text.tag  == 101)
            {
                
                wv = op1 ;
                twv = text;
                iwv = cirImg;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text1.tag  == 101)
            {
                wv = op2 ;
                twv = text1;
                iwv = cirImg1;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            if(text2.tag  == 101)
            {
                wv = op3 ;
                twv = text2;
                iwv = cirImg2;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text3.tag  == 101)
            {
                wv = op4 ;
                twv = text3;
                iwv = cirImg3;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text4.tag  == 101)
            {
                wv = op5 ;
                twv = text4;
                iwv = cirImg4;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text5.tag  == 101)
            {
                wv = op6 ;
                twv = text5;
                iwv = cirImg5;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(text6.tag  == 101)
            {
                wv = op7 ;
                twv = text6;
                iwv = cirImg6;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text7.tag  == 101)
            {
                wv = op8 ;
                twv = text7;
                iwv = cirImg7;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                UILabel *lbl = (UILabel *)[[twv subviews]objectAtIndex:0];
                lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            
            
            iv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
            CALayer * lay3 = [v layer];
            tv.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
            UILabel *lbl = (UILabel *)[[tv subviews]objectAtIndex:0];
            lbl.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            [lay3 setMasksToBounds:YES];
            [lay3 setCornerRadius:5.0];
            
            [lay3 setBorderWidth:2.0];
            [lay3 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(tv.frame.size.width-20, tv.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [tv addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(twv.frame.size.width-20, twv.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [twv addSubview:wrongImg];
            
        }
        
        
        
        if([calObj valueForKey:@"ansObj"] != NULL)
        {
            NSDictionary * obj =  [calObj valueForKey:@"ansObj"];
            if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                totalCorrectAns++;
                [self showFeedback:[obj valueForKey:@"uniqid"] :TRUE :[calObj valueForKey:@"type"]];
            }
            else{
               [self showFeedback:[obj valueForKey:@"uniqid"] :FALSE : [calObj valueForKey:@"type"]];
            }
        }
        else
        {
            [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
        }
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"mci"] || [[calObj valueForKey:@"type"]isEqualToString:@"mca"] )
    {
        
        
        op1.userInteractionEnabled  = FALSE;
        op2.userInteractionEnabled  = FALSE;
        op3.userInteractionEnabled  = FALSE;
        op4.userInteractionEnabled  = FALSE;
        op5.userInteractionEnabled  = FALSE;
        op6.userInteractionEnabled  = FALSE;
        op7.userInteractionEnabled  = FALSE;
        op8.userInteractionEnabled  = FALSE;
        
        
        UIView * v  = (UIView *)[scrollView viewWithTag:1000];
        UILabel * tv=  (UILabel *)[v viewWithTag:1001];
        UIImageView * iv = (UIImageView *) [v viewWithTag:1002];
        
        UIView * wv;
        UILabel * twv;
        UIImageView * iwv;
        
        if([[calObj valueForKey:@"type"]isEqualToString:@"mc"])
        {
            
            if(text.tag  == 101)
            {
                CALayer * lay1 = [text layer];
                twv =text;
                wv = [twv superview];
                text.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            
            if(text1.tag  == 101)
            {
                CALayer * lay1 = [text1 layer];
                twv =text1;
                wv = [twv superview];
                text1.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(text2.tag  == 101)
            {
                CALayer * lay1 = [text2 layer];
                twv =text2;
                wv = [twv superview];
                text2.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text3.tag  == 101)
            {
                CALayer * lay1 = [text3 layer];
                twv =text3;
                wv = [twv superview];
                text3.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text4.tag  == 101)
            {
                CALayer * lay1 = [text4 layer];
                twv =text4;
                wv = [twv superview];
                text4.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text5.tag  == 101)
            {
                CALayer * lay1 = [text5 layer];
                twv =text5;
                wv = [twv superview];
                text5.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(text6.tag  == 101)
            {
                CALayer * lay1 = [text6 layer];
                twv =text6;
                wv = [twv superview];
                text6.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text7.tag  == 101)
            {
                CALayer * lay1 = [text7 layer];
                twv =text7;
                wv = [twv superview];
                text7.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            CALayer * lay1 = [tv layer];
            tv.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(tv.frame.size.width-20, tv.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [tv addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(wv.frame.size.width-20, wv.frame.size.height/2-7, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [wv addSubview:wrongImg];
            
        }
        else
        {
            
            if(text.tag  == 101)
            {
                
                wv = op1 ;
                twv = text;
                iwv = cirImg;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text1.tag  == 101)
            {
                wv = op2 ;
                twv = text1;
                iwv = cirImg1;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            if(text2.tag  == 101)
            {
                wv = op3 ;
                twv = text2;
                iwv = cirImg2;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text3.tag  == 101)
            {
                wv = op4 ;
                twv = text3;
                iwv = cirImg3;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text4.tag  == 101)
            {
                wv = op5 ;
                twv = text4;
                iwv = cirImg4;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text5.tag  == 101)
            {
                wv = op6 ;
                twv = text5;
                iwv = cirImg5;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            if(text6.tag  == 101)
            {
                wv = op7 ;
                twv = text6;
                iwv = cirImg6;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            if(text7.tag  == 101)
            {
                wv = op8 ;
                twv = text7;
                iwv = cirImg7;
                
                iwv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [wv layer];
                twv.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
                twv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            
            
            iv.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
            CALayer * lay3 = [v layer];
            tv.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
            tv.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            [lay3 setMasksToBounds:YES];
            [lay3 setCornerRadius:5.0];
            
            [lay3 setBorderWidth:2.0];
            [lay3 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(tv.frame.size.width-20, tv.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [tv addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(twv.frame.size.width-20, twv.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [twv addSubview:wrongImg];
            
        }
        
        
        
        if([calObj valueForKey:@"ansObj"] != NULL)
        {
            NSDictionary * obj =  [calObj valueForKey:@"ansObj"];
            if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                totalCorrectAns++;
                [self showFeedback:[obj valueForKey:@"uniqid"] :TRUE :[calObj valueForKey:@"type"]];
            }
            else{
               [self showFeedback:[obj valueForKey:@"uniqid"] :FALSE : [calObj valueForKey:@"type"]];
            }
        }
        else
        {
            [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
        }
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"mmc"])
    {
        
        op1.userInteractionEnabled  = FALSE;
        op2.userInteractionEnabled  = FALSE;
        op3.userInteractionEnabled  = FALSE;
        op4.userInteractionEnabled  = FALSE;
        op5.userInteractionEnabled  = FALSE;
        op6.userInteractionEnabled  = FALSE;
        op7.userInteractionEnabled  = FALSE;
        op8.userInteractionEnabled  = FALSE;
        
        
        if(textView.tag  == 101)
        {
            CALayer * lay1 = [textView layer];
            textView.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView.frame.size.width-20, textView.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView addSubview:wrongImg];
            
            
        }
        
        if(textView1.tag  == 101)
        {
            CALayer * lay1 = [textView1 layer];
            textView1.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView1.frame.size.width-20, textView1.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView1 addSubview:wrongImg];
        }
        if(textView2.tag  == 101)
        {
            CALayer * lay1 = [textView2 layer];
            textView2.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView2.frame.size.width-20, textView2.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView2 addSubview:wrongImg];
        }
        
        if(textView3.tag  == 101)
        {
            CALayer * lay1 = [textView3 layer];
            textView3.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView3.frame.size.width-20, textView3.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView3 addSubview:wrongImg];
        }
        
        if(textView4.tag  == 101)
        {
            CALayer * lay1 = [textView4 layer];
            textView4.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView4.frame.size.width-20, textView4.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView4 addSubview:wrongImg];
        }
        
        if(textView5.tag  == 101)
        {
            CALayer * lay1 = [textView5 layer];
            textView5.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView5.frame.size.width-20, textView5.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView5 addSubview:wrongImg];
        }
        if(textView6.tag  == 101)
        {
            CALayer * lay1 = [textView6 layer];
            textView6.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView6.frame.size.width-20, textView6.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView6 addSubview:wrongImg];
        }
        
        if(textView7.tag  == 101)
        {
            CALayer * lay1 = [textView7 layer];
            textView7.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView7.frame.size.width-20, textView7.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [textView7 addSubview:wrongImg];
        }
        
        
        
        
        
        
        
        if(op8.tag == 1000)
        {
            CALayer * lay1 = [textView7 layer];
            textView7.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView7.frame.size.width-20, textView7.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView7 addSubview:rightImg];
            
            
        }
        if(op7.tag == 1000)
        {
            CALayer * lay1 = [textView6 layer];
            textView6.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView6.frame.size.width-20, textView6.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView6 addSubview:rightImg];
            
        }
        if(op6.tag == 1000)
        {
            CALayer * lay1 = [textView5 layer];
            textView5.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView5.frame.size.width-20, textView5.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView5 addSubview:rightImg];
        }
        if(op5.tag == 1000)
        {
            CALayer * lay1 = [textView4 layer];
            textView4.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView4.frame.size.width-20, textView4.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView4 addSubview:rightImg];
        }
        if(op4.tag == 1000)
        {
            CALayer * lay1 = [textView3 layer];
            textView3.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView3.frame.size.width-20, textView3.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView3 addSubview:rightImg];
        }
        if(op3.tag == 1000)
        {
            CALayer * lay1 = [textView2 layer];
            textView2.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView2.frame.size.width-20, textView2.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView2 addSubview:rightImg];
        }
        if(op2.tag == 1000)
        {
            CALayer * lay1 = [textView1 layer];
            textView1.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView1.frame.size.width-20, textView1.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView1 addSubview:rightImg];
        }
        if(op1.tag == 1000)
        {
            CALayer * lay1 = [textView layer];
            textView.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(textView.frame.size.width-20, textView.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [textView addSubview:rightImg];
        }
        
        
        bool option = false;
        NSMutableString * ansStr = [[NSMutableString alloc]init];
        NSArray *Arr =  [[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"];
        for(int i=0; i<[Arr count];i++){
            NSDictionary * obj =  [Arr objectAtIndex:i] ;
            NSString *opt = [[NSString alloc]initWithFormat:@"option%d",i+1];
            if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"] )
            {
                
                if(i>0) [ansStr appendString:@", "];
                
                [ansStr appendString:[[ obj valueForKey:@"content"] valueForKey:@"text"]];
                
                if([[calObj valueForKey:opt]intValue] == 1)
                {
                    
                }
                else
                {
                    option = true;
                }
            }
            else if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"false"] && [[calObj valueForKey:opt]intValue] == 0 )
            {
                
            }
            else if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"false"] && [calObj valueForKey:opt] == NULL )
            {
                
            }
            else
            {
                option = true;
                //break;
            }
        }
        if(!option)
        {
            totalCorrectAns++;
            rightAns = ansStr;
            [self showFeedback:@"": TRUE : [calObj valueForKey:@"type"]];
            
        }
        else{
            
            rightAns =[[NSString alloc]initWithFormat:[appDelegate.langObj get:@"MCQ_RIGHT_ANS_HAI_S" alter:@"Correct answers are: %@"], ansStr];
            [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
        }
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"dd"])
    {
        
        dottedBox.userInteractionEnabled = FALSE;
        ddBox.userInteractionEnabled = FALSE;
        NSArray * labels = dottedBox.allTags;
        
        NSMutableString * strMessage = [[NSMutableString alloc]init];
        for (NSString * str in labels) {
            [strMessage appendFormat:@"%@ ",str];
        }
        
        
        NSArray * _anslabels = [[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"];
        
        NSArray *arrayToSort = _anslabels ;
        NSComparisonResult (^sortBlock)(NSDictionary* ,NSDictionary* ) = ^(NSDictionary * obj1, NSDictionary * obj2)
        {
            if ([[[obj1 valueForKey:@"position"]valueForKey:@"text"]intValue] > [[[obj2 valueForKey:@"position"]valueForKey:@"text"]intValue])
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([[[obj1 valueForKey:@"position"]valueForKey:@"text"]intValue] < [[[obj2 valueForKey:@"position"]valueForKey:@"text"]intValue])
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray * anslabels = [arrayToSort sortedArrayUsingComparator:sortBlock];
        
        
        
        NSMutableString * strAnsMessage = [[NSMutableString alloc]init];
        for (NSString * str in [[anslabels valueForKey:@"content"]valueForKey:@"text"]) {
            [strAnsMessage appendFormat:@"%@ ",str];
        }
        
        if([strAnsMessage isEqualToString:strMessage])
        {
            totalCorrectAns++;
            [self showFeedback:@"": TRUE : [calObj valueForKey:@"type"]];
            TTGTextTagConfig *config = dottedBox.defaultConfig;
            config.textFont = HEADERSECTIONTITLEFONT;
            config.textColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            config.selectedTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            
            config.backgroundColor = [UIColor whiteColor];
            config.selectedBackgroundColor = [UIColor whiteColor];
            
            dottedBox.horizontalSpacing = 6.0;
            dottedBox.verticalSpacing = 8.0;
            
            config.borderColor = [UIColor lightGrayColor];
            config.selectedBorderColor = [UIColor lightGrayColor];
            config.borderWidth = 1;
            config.selectedBorderWidth = 1;
            
            config.shadowColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            config.shadowOffset = CGSizeMake(0, 0.3);
            config.shadowOpacity = 0.3f;
            config.shadowRadius = 0.5f;
            
            config.cornerRadius = 7;
            
            config.enableGradientBackground = YES;
            config.gradientBackgroundStartColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            config.selectedGradientBackgroundStartColor =  [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            config.gradientBackgroundEndColor =  [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            config.selectedGradientBackgroundEndColor =  [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            config.gradientBackgroundStartPoint =CGPointMake(0, 0);
            config.gradientBackgroundEndPoint = CGPointMake(1, 1);
        }
        else
        {
            [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
            TTGTextTagConfig *config = dottedBox.defaultConfig;
            config.textFont = HEADERSECTIONTITLEFONT;
            config.textColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            config.selectedTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            
            config.backgroundColor = [UIColor whiteColor];
            config.selectedBackgroundColor = [UIColor whiteColor];
            
            dottedBox.horizontalSpacing = 6.0;
            dottedBox.verticalSpacing = 8.0;
            
            config.borderColor = [UIColor lightGrayColor];
            config.selectedBorderColor = [UIColor lightGrayColor];
            config.borderWidth = 1;
            config.selectedBorderWidth = 1;
            
            config.shadowColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            config.shadowOffset = CGSizeMake(0, 0.3);
            config.shadowOpacity = 0.3f;
            config.shadowRadius = 0.5f;
            
            config.cornerRadius = 7;
            
            config.enableGradientBackground = YES;
            config.gradientBackgroundStartColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            config.selectedGradientBackgroundStartColor =  [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            config.gradientBackgroundEndColor =  [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            config.selectedGradientBackgroundEndColor =  [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            config.gradientBackgroundStartPoint =CGPointMake(0, 0);
            config.gradientBackgroundEndPoint = CGPointMake(1, 1);
            
            UITextView * rightAns = [[UITextView alloc]initWithFrame:CGRectMake(dottedBox.frame.origin.x, dottedBox.frame.origin.y+dottedBox.frame.size.height+10,dottedBox.frame.size.width , dottedBox.frame.size.height+10)];
            rightAns.font = HEADERSECTIONTITLEFONT;
            //            rightAns.numberOfLines = 3;
            //            rightAns.lineBreakMode =  NSLineBreakByWordWrapping;
            rightAns.text = [[NSString alloc]initWithFormat:@"Correct answer is: %@",strAnsMessage];
            rightAns.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
            rightAns.editable = FALSE;
            [scrollView addSubview:rightAns];
            
        }
        [dottedBox reload];
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"pw"])
    {
        slopt1.userInteractionEnabled = FALSE;
        slopt2.userInteractionEnabled = FALSE;
        slopt3.userInteractionEnabled = FALSE;
        slopt4.userInteractionEnabled = FALSE;
        
        bool flag = false;
        for (NSDictionary *obj  in (NSArray *)[[[calObj valueForKey:@"object"] valueForKey:@"answers"]valueForKey:@"answer"]) {
            if([[[obj valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                if([[calObj valueForKey:@"option"] isEqualToString:[[obj valueForKey:@"content"] valueForKey:@"text"]])
                {
                    flag = true;
                    totalCorrectAns++;
                    [self showFeedback:@"": TRUE : [calObj valueForKey:@"type"]];
                    
                    rightAns = [[obj valueForKey:@"content"] valueForKey:@"text"];
                    CALayer * lay1 = [globalBtn layer];
                    globalBtn.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(globalBtn.frame.size.width-20, 10, 10,10 )];
                    rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                    [globalBtn addSubview:rightImg];
                    break;
                    
                    
                }
            }
        }
        if(!flag){
           [self showFeedback:@"": FALSE : [calObj valueForKey:@"type"]];
            
            CALayer * lay1 = [globalBtn layer];
            globalBtn.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(globalBtn.frame.size.width-20, 10, 10,10 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [globalBtn addSubview:wrongImg];
            
            int counter =0;
            for (counter =0;counter < [[[[calObj valueForKey:@"object"] valueForKey:@"random_options"]valueForKey:@"option"] count]; counter++) {
                NSDictionary *obj  = [[[[calObj valueForKey:@"object"] valueForKey:@"random_options"]valueForKey:@"option"] objectAtIndex:counter];
                int position = [[obj valueForKey:@"position"]intValue];
                //counter++;
                if(position >0)
                    break;
                
            }
            
            
            
            if(counter == 0)
            {
                CALayer * lay1 = [slopt1 layer];
                slopt1.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(slopt1.frame.size.width-20, 10, 10,10 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [slopt1 addSubview:rightImg];
            }
            if(counter ==1)
            {
                CALayer * lay1 = [slopt2 layer];
                slopt2.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(slopt2.frame.size.width-20, 10, 10,10 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [slopt2 addSubview:rightImg];
            }
            if(counter ==2)
            {
                CALayer * lay1 = [slopt3 layer];
                slopt3.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(slopt3.frame.size.width-20, 10, 10,10 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [slopt3 addSubview:rightImg];
            }
            if(counter ==3)
            {
                CALayer * lay1 = [slopt4 layer];
                slopt4.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(slopt4.frame.size.width-20, 10, 10,10 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [slopt4 addSubview:rightImg];
            }
            
        }
        else
        {
           [self showFeedback:@"": TRUE : [calObj valueForKey:@"type"]];
        }
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"ifb"])
    {
        int height = [ibfbView showRightWrongAnswerUI];
        
        NSString* newString = [[[globalDictionary valueForKey:@"content"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
        NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
        NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
        NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
        NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
        NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
        NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",questionView.font.pointSize,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
            
        NSError *error;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?=(_{3,}))(_{3,})+"
                                                                               options:nil
                                                                                 error:&error];
        NSString *str2 = [regex stringByReplacingMatchesInString:str
                                                         options:nil
                                                           range:NSMakeRange(0, [str length])
                                                    withTemplate:rightAnsFBSpace];
        
        NSArray *arr = [str2 componentsSeparatedByString:rightAnsFBSpace];
        NSArray * QuesOptionArr;
       if([[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]] && [[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"] count] > 0){
           QuesOptionArr = [[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"];
       }
       else
       {
           NSDictionary * _option = [[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"];
           QuesOptionArr = [[NSArray alloc]initWithObjects:_option, nil];
       }
        NSMutableString * convert =  [[NSMutableString alloc]init];
        
        if([arr count] >1)
        {
           int i =0;
           for (NSString  * str  in arr) {
               
                   [convert appendFormat:@"%@",str];
               if(i < [QuesOptionArr count]){
                   NSString * dataStr = [[QuesOptionArr objectAtIndex:i] valueForKey:@"text"];
                   NSArray * Ans_arr = [dataStr componentsSeparatedByString:@"##"];
                   [convert appendFormat:@"<u style=\"color:%@\">%@</u>  ",RIGHT_SELECTION_OURLINECOLOR,[Ans_arr objectAtIndex:0]];
               }
               else
               {
                   if([arr count]-1 > i)
                     [convert appendFormat:@"_____"];
               }
              i++;
        }
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [convert dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                error: nil
                                                ];
        questionView.attributedText = attributedString;
        
        }
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+height);
        footerView.frame = CGRectMake(0, scrollView.contentSize.height-60, scrollView.frame.size.width,60);
        
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"fb"])
    {
        int height = 0;
        if([[calObj valueForKey:@"object"]valueForKey:@"is_random_match"] != NULL && [[[calObj valueForKey:@"object"]valueForKey:@"is_random_match"]valueForKey:@"text"] != NULL && [[[[calObj valueForKey:@"object"]valueForKey:@"is_random_match"]valueForKey:@"text"]isEqualToString:@"1"]  )
            height = [fbView showRamdomRightWrongAnswerUI];
        else
            height = [fbView showRightWrongAnswerUI];
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+height);
        footerView.frame = CGRectMake(0, scrollView.contentSize.height-60, scrollView.frame.size.width,60);
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"es"])
    {
        
        UITextView * rightAns = [[UITextView alloc]initWithFrame:CGRectMake(areaTxt.frame.origin.x, areaTxt.frame.origin.y+areaTxt.frame.size.height+30,areaTxt.frame.size.width , 25)];
        rightAns.font = HEADERSECTIONTITLEFONT;
        rightAns.editable = FALSE;
        rightAns.text = [[NSString alloc]initWithFormat:@"Your answer is submitted"];
        rightAns.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
        [scrollView addSubview:rightAns];
        
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"correct_answer" ofType:@"mp3" inDirectory:nil];
        NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
        NSError * err;
        AVAudioPlayer * NextPrevPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:videoURL error:&err];
        
        [NextPrevPlayer play];
        //rightAns = @"Your answer is submitted.";
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"ra"])
    {
        
        if([[[[calObj valueForKey:@"object"] valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1  && [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            if(SanaResp != NULL && [[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=90)
            {
                
                totalCorrectAns++;
                rightAns = @"Perfect, native-like.  well done!";
                
            }
            else if(SanaResp != NULL &&[[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=70)
            {
                totalCorrectAns++;
                rightAns = @"Good & Intelligible! To improve your score, keep practicing";
            }
            else if(SanaResp != NULL &&[[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=56)
            {
                rightAns = @"It sounds ok.";
            }
            else if(SanaResp != NULL &&[[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] < 56)
            {
                
                rightAns =@"That doesn’t sound good!";
            }
            else
            {
                
                rightAns =@"That doesn’t sound good!";
            }
            
        }
        else if([[[[calObj valueForKey:@"object"] valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0  && [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"correct_answer" ofType:@"mp3" inDirectory:nil];
            NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
            NSError * err;
            AVAudioPlayer * NextPrevPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:videoURL error:&err];
            
            [NextPrevPlayer play];
            
            UITextView * rightAns = [[UITextView alloc]initWithFrame:CGRectMake(30, recordStop.frame.origin.y+recordStop.frame.size.height+10,SCREEN_WIDTH-60 , 25)];
            rightAns.font = HEADERSECTIONTITLEFONT;
            rightAns.editable = FALSE;
            rightAns.text = [[NSString alloc]initWithFormat:@"Your answer is submitted"];
            rightAns.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
            [scrollView addSubview:rightAns];
            
        }
        else
        {
            
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"correct_answer" ofType:@"mp3" inDirectory:nil];
            NSURL *videoURL=[[NSURL alloc] initFileURLWithPath:filePath];
            NSError * err;
            AVAudioPlayer * NextPrevPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:videoURL error:&err];
            
            [NextPrevPlayer play];
            rightAns = @"Your answer is submitted.";
            
        }
        
    }
    
    if(![[calObj valueForKey:@"type"]isEqualToString:@"mttt"]&&![[calObj valueForKey:@"type"]isEqualToString:@"mtti"]&&![[calObj valueForKey:@"type"]isEqualToString:@"mtii"]){
        mcqSubmitBtn.hidden = TRUE;
    }
    else{
        
        CALayer * lay1 = [lop1 layer];
        
        [lay1 setBorderWidth:3.0];
        [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#DBC6C6" alpha:1.0] CGColor]];
        lop1.backgroundColor = [self getUIColorObjectFromHexString:@"#DBC6C6" alpha:0.5];
        
        CALayer * lay2 = [lop2 layer];
        [lay2 setBorderWidth:3.0];
        [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#F8E2AD" alpha:1.0] CGColor]];
        lop2.backgroundColor = [self getUIColorObjectFromHexString:@"#F8E2AD" alpha:0.5];
        
        
        CALayer * lay3 = [lop3 layer];
        [lay3 setBorderWidth:3.0];
        
        [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#F7AA9F" alpha:1.0] CGColor]];
        lop3.backgroundColor = [self getUIColorObjectFromHexString:@"#F7AA9F" alpha:0.5];
        
        CALayer * lay4 = [lop4 layer];
        [lay4 setBorderWidth:3.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#E4CAE7" alpha:1.0] CGColor]];
        lop4.backgroundColor = [self getUIColorObjectFromHexString:@"#E4CAE7" alpha:0.5];
        
        
        CALayer * lay5 = [rop1 layer];
        [lay5 setBorderWidth:3.0];
        [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#DBC6C6" alpha:1.0] CGColor]];
        rop1.backgroundColor = [self getUIColorObjectFromHexString:@"#DBC6C6" alpha:0.5];
        
        CALayer * lay6 = [rop2 layer];
        [lay6 setBorderWidth:3.0];
        [lay6 setBorderColor:[[self getUIColorObjectFromHexString:@"#F8E2AD" alpha:1.0] CGColor]];
        rop2.backgroundColor = [self getUIColorObjectFromHexString:@"#F8E2AD" alpha:0.5];
        
        
        CALayer * lay7 = [rop3 layer];
        [lay7 setBorderWidth:3.0];
        [lay7 setBorderColor:[[self getUIColorObjectFromHexString:@"#F7AA9F" alpha:1.0] CGColor]];
        rop3.backgroundColor = [self getUIColorObjectFromHexString:@"#F7AA9F" alpha:0.5];
        
        
        CALayer * lay8 = [rop4 layer];
        [lay8 setBorderWidth:3.0];
        [lay8 setBorderColor:[[self getUIColorObjectFromHexString:@"#E4CAE7" alpha:1.0] CGColor]];
        rop4.backgroundColor = [self getUIColorObjectFromHexString:@"#E4CAE7" alpha:0.5];
    }
    contiBtn.hidden = FALSE;
    [self resumeQuiz];
    
}

- (void) moviePlayBackDidFinish1:(NSNotification*)notification

{
    
    backGCameraView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGCameraView.backgroundColor = [UIColor clearColor];
    PlayerFotterView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH,150)];
    PlayerFotterView1.userInteractionEnabled = TRUE;
    
    tapIns1 =[[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-105, SCREEN_WIDTH, 15)];
    tapIns1.text = @"Tap to start";
    tapIns1.textAlignment = NSTextAlignmentCenter;
    tapIns1.font = [UIFont systemFontOfSize:11];
    tapIns1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:tapIns1];
    
    remaingText1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-85, SCREEN_WIDTH, 40)];
    remaingText1.text = @"Time remaining";
    remaingText1.textAlignment = NSTextAlignmentCenter;
    remaingText1.font = [UIFont systemFontOfSize:11];
    remaingText1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:remaingText1];
    
    minute1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-60, SCREEN_WIDTH, 40)];
    minute1.textAlignment = NSTextAlignmentCenter;
    minute1.font = [UIFont systemFontOfSize:18];
    minute1.text = @"00:00";
    minute1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:minute1];
    
    recordStop1 = [[UIButton alloc]initWithFrame:CGRectMake(PlayerFotterView1.frame.size.width/2 - 40, PlayerFotterView1.frame.size.height/2-20, 80, 80)];
    [recordStop1 setImage:[UIImage imageNamed:@"CameraEnable_Ani.png"] forState:UIControlStateNormal];
    recordStop1.enabled =  TRUE;
    [recordStop1 addTarget:self
                    action:@selector(clickCameraStartPlay:)
          forControlEvents:UIControlEventTouchUpInside];
    [PlayerFotterView1 addSubview:recordStop1];
    [backGCameraView addSubview:PlayerFotterView1];
    
    
    NSDictionary * objDictionary = [QuesAVArr objectAtIndex:AVCounter];
    NSString * str = [[objDictionary valueForKey:@"time_limit"]valueForKey:@"text"] ;
    totaltime = [str integerValue];
    if(totaltime <= 0) totaltime = 5;
    int min = totaltime/60;
    int second = totaltime%60;
    NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
    minute1.text = time;
    [PlayerFotterView1 setBackgroundColor:[self getUIColorObjectFromHexString:@"000000" alpha:0.2]];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerObj = [[UIImagePickerController alloc] init];
        pickerObj.delegate = (id)self;
        pickerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerObj.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        pickerObj.allowsEditing = NO;
        pickerObj.showsCameraControls = NO;
        pickerObj.toolbarHidden = YES;
        pickerObj.cameraViewTransform = CGAffineTransformScale(pickerObj.cameraViewTransform, 1.0,  1.0); //1.0000);//
        pickerObj.cameraOverlayView = backGCameraView;
        pickerObj.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [self.view addSubview:pickerObj.view];
    }
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSError *error;
    if([CLASS_NAME isEqualToString:@"wiley"]){
      if(popup.hidden)popup.hidden = FALSE;
    }
    tapIns1.text = @"Tap to Start";
    NSString * str = [[NSString alloc]initWithFormat:@"records"];
    NSString *dataPath = [phoneDocumentDirectory stringByAppendingPathComponent:str];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
    
    NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
    NSString *lTempPath;
    if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
    {
        lTempPath = [[NSString alloc]initWithFormat:@"%@_%@_%@.mp4",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
    }
    else
    {
        lTempPath = [[NSString alloc]initWithFormat:@"%@_%@_%@_%d.mp4",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"],AVCounter+1];
    }
    NSString *tempPath = [phoneDocumentDirectory stringByAppendingFormat:@"/%@/%@",llTempPath,lTempPath];
    [fileArray addObject:lTempPath];
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    BOOL success = [videoData writeToFile:tempPath atomically:NO];
    
    [pickerObj.view removeFromSuperview];
    pickerObj = NULL;
    if(QuesAVArr == NULL || AVCounter == [QuesAVArr count] -1 )
    {
        
        
        if(self.type == 3){
            NSMutableDictionary *avObj = [self createDictionaryifNot:globalDictionary type:@"av" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            
            [avObj setObject:fileArray forKey:@"option"];
            [self addOrReplace:avObj];
        }
        else
        {
            NSMutableDictionary *avObj = [self createDictionaryifNot:globalDictionary type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            
            [avObj setObject:fileArray forKey:@"option"];
            [self addOrReplace:avObj];
        }
        
        AVCounter = 0;
        if([quesArr count]-1 <= questionCounter)
        {
            
            if(self.type == 3){
                [self clickSubmit];
            }
            else
            {
                [self enableQuizBtn];
            }
            return;
        }
        else{
            
            if(self.type == 3){
                [self clickNext];
            }
            else
            {
                [self enableQuizBtn];
            }
            return;
        }
    }
    
    
    NSDictionary * objDictionary = [QuesAVArr objectAtIndex:++AVCounter];
    answerUid = [objDictionary valueForKey:@"uniqid"];
    [same removeFromSuperview];
    [movieView removeFromSuperview];
    if([[[objDictionary valueForKey:@"content_type"]valueForKey:@"text"] isEqualToString:@"audio"])
    {
        same = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
        QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,same.frame.size.width,same.frame.size.height)];
        same.backgroundColor = [UIColor clearColor];
        [same addSubview:QuesImg];
        QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
        QuesImg.contentMode = UIViewContentModeScaleAspectFit;
        [inputView addSubview:same];
        
        
        //audioPath = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
        audioPath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [recordAVStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
        reAudioPlayer = NULL;
        if(reAudioPlayer == NULL)
        {
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            reAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL  error:nil];
        }
        [reAudioPlayer setDelegate:self];
        [reAudioPlayer play];
        
    }
    else
    {
        
        movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
        [inputView addSubview:movieView];
        
        if(recVideoPlayer == NULL)
        {
            
            recVideoPlayer = [[AVPlayerViewController alloc] init];
            recVideoPlayer.showsPlaybackControls = YES;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish1:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        }
//        minute.hidden = TRUE;
//        remaingText.hidden = TRUE;
        [recordAVStop setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
        
        NSString *FilePath;
        //FilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
        
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
//        FilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        NSString *HTMLData =[NSString stringWithFormat:@"file:///%@",FilePath];
        
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        playVideo = [[AVPlayer alloc] initWithURL:fileURL];
        recVideoPlayer.player = playVideo;
        [recVideoPlayer.player play];
        
        //recVideoPlayer.contentURL = [[NSURL alloc]initFileURLWithPath:FilePath];
        //[recVideoPlayer prepareToPlay];
        
        UIView *invisible = [[UIView alloc]initWithFrame:CGRectMake(movieView.frame.size.width-100,movieView.frame.size.height-50 , 100, 50)];
        
        invisible.backgroundColor = [UIColor clearColor];
        [recVideoPlayer.view addSubview:invisible];
        recVideoPlayer.view.frame = movieView.bounds;
        [movieView addSubview:recVideoPlayer.view];
        
    }
    
}

-(void)readAssessmentNetworkResponse:(NSNotification *) notification
{
    NSString * str = [[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
    totaltime = [str integerValue];
    if(totaltime <= 0) totaltime = 5;
    int min = totaltime/60;
    int second = totaltime%60;
    NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
    minute.text = time;
    if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SANAAUDIOUPLOAD])
    {
        NSMutableDictionary *uiResponse = [[NSMutableDictionary alloc] init];
        if(![[[notification object] valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
        {
            [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
            //[uiResponse setValue:DATANULL forKey:UIMSG];
        }
        else
        {
             if(![[[[notification object]valueForKey:@"data"]valueForKey:@"res"]isEqualToString:@"false"])
             {
                [uiResponse setValue:SUCCESS forKey:UIRESPONSERESULT];
                NSString * str = [[[notification object]valueForKey:@"data"]valueForKey:@"res"];
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                [uiResponse setValue:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] forKey:UIRESPONSE];
            }
            else
            {
               [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
            }
        }
        SanaResp = uiResponse;
        if([uiResponse valueForKey:UIRESPONSERESULT] == NULL ||  [[uiResponse valueForKey:UIRESPONSERESULT]isEqualToString:FAILURE] )
        {
            [self hideGlobalProgress];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Could not hear you properly. Please retry." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
                
                footerView.hidden = FALSE;
                mcqSubmitBtn.hidden = TRUE;
                contiBtn.hidden = FALSE;
                [self clickShowAnswer:self];
                
            });
            
        }
        else
        {
           NSDictionary * resObj = [[uiResponse valueForKey:@"RESP"] valueForKey:@"text_score"];
            dispatch_async(dispatch_get_main_queue(), ^{
            sanaScoLbl.text = [[NSString alloc]initWithFormat:@"%0.1d%%",[[resObj valueForKey:@"quality_score"]intValue]];
            if([[resObj valueForKey:@"quality_score"]intValue] >=70)
            {
                sanaScoLbl.textColor = [UIColor greenColor];
                sanaScoreIns.text = @"Perfect, native-like.  well done!";
            }
            else if([[resObj valueForKey:@"quality_score"]intValue] >=70)
            {
                sanaScoLbl.textColor = [UIColor greenColor];
                sanaScoreIns.text =@"Good &amp; Intelligible! To improve your score, keep practicing";
            }
            else if([[resObj valueForKey:@"quality_score"]intValue] >=56 )
            {
                
                sanaScoLbl.textColor = [UIColor yellowColor];
                sanaScoreIns.text =@"It sounds ok, there is room for improvement! Try again, click on the underlined words to learn the right pronunciation";
            }
            else if([[resObj valueForKey:@"quality_score"]intValue] >=56 )
            {
                
                sanaScoLbl.textColor = [UIColor yellowColor];
                //sanaScoreIns.text =@"Good &amp; Intelligible! To improve your score, keep practicing";
            }
            else if([[resObj valueForKey:@"quality_score"]intValue] <= 55 && [[resObj valueForKey:@"quality_score"]intValue] >=50 )
            {
                sanaScoLbl.textColor = [UIColor redColor];
                sanaScoreIns.text =@"That doesn’t sound good! Try again, click on the underlined words to learn the right pronunciation";
            }
            else if([[resObj valueForKey:@"quality_score"]intValue] < 50)
            {
                sanaScoLbl.textColor = [UIColor redColor];
            }
            });
            
            wordSANAArr = [resObj valueForKey:@"word_score_list"];
            
            NSArray * wordArr = wordSANAArr;
            NSMutableString * dynamicDta = [[NSMutableString alloc]initWithString:@""];
            
            for (int wordC = 0; wordC < [wordArr count]; wordC++) {
                NSDictionary * wordObj = [wordArr objectAtIndex:wordC];
                if([[wordObj valueForKey:@"quality_score"]intValue] >= 70)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor green\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"quality_score"]intValue] >= 56)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor yellow\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"quality_score"]intValue] >= 54)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor yellow\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                    if([[resObj valueForKey:@"quality_score"]intValue] >=56 && [[resObj valueForKey:@"quality_score"]intValue] <= 69)
                    {
                        sanaScoreIns.text =@"It sounds ok, there is room for improvement! Try again to improve your score";
                    }
                    else if([[resObj valueForKey:@"quality_score"]intValue] <= 55 )
                    {
                        sanaScoreIns.text =@"That doesn’t sound good! Try again to improve your score";
                    }
                    
                    
                }
                else if([[wordObj valueForKey:@"quality_score"]intValue] < 40)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"quality_score"]intValue] >= 1)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d');\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"quality_score"]intValue] == 0)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d');\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                
                NSArray * arrPhonem  = [wordObj valueForKey:@"phone_score_list"];
                for (int phonemC =0 ; phonemC < [arrPhonem count] ; phonemC++) {
                    NSDictionary * phonemObj = [arrPhonem objectAtIndex:phonemC];
                    if([[phonemObj valueForKey:@"quality_score"]intValue] >= 70)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase grey\">"];
                    }
                    else if([[phonemObj valueForKey:@"quality_score"]intValue] >= 56)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase yellow\">"];
                    }
                    else if([[phonemObj valueForKey:@"quality_score"]intValue] >= 1)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase red\">"];
                    }
                    else if([[phonemObj valueForKey:@"quality_score"]intValue] == 0)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase red\">"];
                    }
                    
                    if(phonemC == [arrPhonem count]-1)
                        [dynamicDta appendFormat:@"%@</span>",[phonemObj valueForKey:@"phone"]];
                    else
                        [dynamicDta appendFormat:@"%@-</span>",[phonemObj valueForKey:@"phone"]];
                }
                [dynamicDta appendString:@"</div>"];
                
            }
            
            NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style>.underline {color: #d81e11!important;text-decoration:underline!important;}.grey{color: #808080;}.green{color:#118616}.yellow{color:#FFC107}.red{color:#d81e11}.fontColor{font-size:20px;margin-right: 10px;display: inline-block;width: auto;text-align: left;}.phrase{font-size:10px;text-align:left; position: relative;top: 0px; padding: 0px 5px;}</style><div style=\"text-align: center;\">%@</div></body></html>",dynamicDta];
            [self hideGlobalProgress];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sanaLbl loadHTMLString:strHtml baseURL:nil];
                footerView.hidden = FALSE;
                mcqSubmitBtn.hidden = TRUE;
                contiBtn.hidden = FALSE;
                [self clickShowAnswer:self];
            });
            
        }
        
        
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readBaseNetworkResponse:)
                                                 name:B_SERVICE_SYNCMCQ
     
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readAssessmentNetworkResponse:)
                                                 name:SERVICE_SANAAUDIOUPLOAD
     
                                               object:nil];
    
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWillHide)
    //                                                 name:UIKeyboardWillHideNotification
    //                                               object:nil];
    
    UITapGestureRecognizer *keyboardtap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(dismissKeyboard)];
    
    
    [self.view addGestureRecognizer:keyboardtap];
    
    
}
-(void)dismissKeyboard {
    [esTextView resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self
    //                                                    name:UIKeyboardWillHideNotification
    //                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:B_SERVICE_SYNCMCQ object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_SANAAUDIOUPLOAD object:nil];
    
    
    
}


#define kOFFSET_FOR_KEYBOARD 200.0



-(void)keyboardWillShow {
    
    //    if(isOpenKey)return;
    //    isOpenKey = TRUE;
    if(audioPlayer!= NULL && audioPlayer.isPlaying )
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }
    
    if(videoViewPlayer != NULL)
        [videoViewPlayer.player pause];
    //
    //
    //
    //    if(esTextView != NULL && esTextView.text.length <= 0)
    //        esTextView.text = @"Fill in the blank.";
    //    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,scrollView.contentSize.height+kOFFSET_FOR_KEYBOARD);
}

//-(void)keyboardWillHide {
//    isOpenKey = FALSE;
//    if(esTextView != NULL && esTextView.text.length <= 0)
//        esTextView.text = @"Fill in the blank.";
//    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,scrollView.contentSize.height-kOFFSET_FOR_KEYBOARD);
//}


//-(void)keyboardWillShow {
//    if(audioPlayer!= NULL && audioPlayer.isPlaying )
//    {
//        [audioPlayer pause];
//        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
//    }
//
//    if(videoViewPlayer != NULL)
//        [videoViewPlayer.player pause];
//
//
//
//    if(esTextView != NULL && esTextView.text.length <= 0)
//        esTextView.text = @"Fill in the blank.";
//    if (inputView.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (inputView.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)keyboardWillHide {
//
//
//    if(esTextView != NULL && esTextView.text.length <= 0)
//        esTextView.text = @"Fill in the blank.";
//
//    if (inputView.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (inputView.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}



- (void)textViewDidBeginEditing:(UITextView *)textView {
    //    if  (inputView.frame.origin.y >= 0)
    //    {
    //        [self setViewMovedUp:YES];
    //    }
    
    if ([textView.text isEqualToString:@"Fill in the blank."]) {
        textView.text = @"";
        textView.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]; //optional
    }
    [textView becomeFirstResponder];
    
}




-(void)setViewMovedUp:(BOOL)movedUp
{
    NSInteger upVal = 100.0;
    if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
    {
        upVal = 200.0;
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"] )
    {
        upVal = 200.0;
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"])
    {
        upVal = 200.0;
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"false"])
    {
        upVal = 160.0;
    }
    else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"false"])
    {
        if(questionView.frame.size.height >= 220.0)
        {
            upVal = 200.0;
        }
        else{
            upVal = 200.0;
        }
    }
    else
    {
        upVal = 100.0;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    CGRect rect = inputView.frame;
    if (movedUp)
    {
        rect.origin.y -= upVal;
        rect.size.height += upVal;
        backProgressView.hidden = TRUE;
    }
    else
    {
        rect.origin.y += upVal;
        rect.size.height -= upVal;
        
    }
    inputView.frame = rect;
    [UIView commitAnimations];
    if (!movedUp)
    {
        backProgressView.hidden = FALSE;
    }
}

-(void)clickPrevManually
{
    if(isPreClick) return;
    isPreClick = TRUE;
    [self clickPrev];
    isPreClick = FALSE;
}

-(void)clickPrev
{
    
    AVCounter = 0;
    QuesAVArr = NULL;
    
    [self stopAllMeadia];
    if(esTextView != NULL)
        [esTextView resignFirstResponder];
    
    
    NSMutableDictionary *globalQuizObj = [self createDictionaryifNot:globalDictionary type:@"ifb" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]] ];
    
    
    
    if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
    {
        NSMutableArray * fbAns = [ibfbView getAnswerArray] ;
        [globalQuizObj setObject:fbAns forKey:@"option"];
        
    }
    else if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
    {
        
        NSMutableArray * fbAns = [fbView getAnswerArray] ;
        [globalQuizObj setObject:fbAns forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"])
    {
         
        [globalQuizObj setObject:esTextView.text forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
    {
       
        [globalQuizObj setObject:SanaResp forKey:@"score"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"dd"])
    {
        NSArray * arr =  dottedBox.allTags;
        [globalQuizObj setObject:arr forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"pw"])
    {
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mttt"])
    {
       
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy] forKey:@"right"];
       
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtii"])
    {
        
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy] forKey:@"right"];
       
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtti"])
    {
        
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy]forKey:@"right"];
        
    }
    
    [self addOrReplace:globalQuizObj];
    
    questionCounter --;
    l1.text = [[NSString alloc]initWithFormat:@"%d of %lu",questionCounter+1,(unsigned long)[quesArr count]];
    if([quesArr count] > 0 ){
        
        float val =  (float)((float)(questionCounter+1)/(float)[quesArr count]);
        progressView.progress =val;
        
    }
    
    [self renderUI];
    
    
}

-(void)clickSubmit
{
    if(ISENABLERESUMEQUIZ)
    {
        [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.assessnetUid]];
        [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.scnUid]];
        
    }
    
    [self finalClickSubmit];
}

-(void)finalClickSubmit
{
    AVCounter = 0;
    QuesAVArr = NULL;
    [self stopAllMeadia];
    if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
    {
        NSMutableDictionary *fbObj = [self createDictionaryifNot:globalDictionary type:@"ifb" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        
        NSMutableArray * fbAns = [[ibfbView getAnswerArray] mutableCopy];
        [fbObj setObject:fbAns forKey:@"option"];
        [self addOrReplace:fbObj];
        
        
    }
    else if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
    {
        NSMutableDictionary *fbObj = [self createDictionaryifNot:globalDictionary type:@"fb" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        NSMutableArray * fbAns = [[fbView getAnswerArray] mutableCopy];
        [fbObj setObject:fbAns forKey:@"option"];
        [self addOrReplace:fbObj];
        
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"])
    {
        NSMutableDictionary *esObj = [self createDictionaryifNot:globalDictionary type:@"es" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        
        [esObj setObject:esTextView.text forKey:@"option"];
        [self addOrReplace:esObj];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"dd"])
    {
        NSArray * arr =  dottedBox.allTags;
        NSMutableDictionary *esObj = [self createDictionaryifNot:globalDictionary type:@"dd" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        [esObj setObject:arr forKey:@"option"];
        [self addOrReplace:esObj];
    }
    
    [self stopAllMeadia];
    if(MCQTimer != NULL){
        [MCQTimer invalidate];
        MCQTimer = NULL;
    }
    
    [self calculateAnswerAndMakeJson];
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"])
    {
        if(self.type != 3 || self.isRemediation){
            if(!self.isRemediation )
            {
                [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
                if(answerableQuestion != 0 && (totalCorrectAns*100)/answerableQuestion >= appDelegate.chapter_quiz_passing_score){
                    [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                }
                else
                {
                    [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                }
                //[data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                [data setValue: [[NSString alloc] initWithFormat:@"%d",totalCorrectAns]forKey:NATIVE_JSON_KEY_USAGESCORE];
                
                [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", totalCorrectAns] :[[NSString alloc]initWithFormat:@"coins_%@", self.assessnetUid]];
                int val = (totalCorrectAns*100)/answerableQuestion;
                [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", val] :[[NSString alloc]initWithFormat:@"percent_%@", self.assessnetUid]];
                
                NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
                [jsonResponse setValue:jsonArr forKey:@"param"];
                [jsonResponse setValue:self.assessnetUid forKey:@"edgeId"];
                [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",[appDelegate.engineObj getAttemptCounter]+1] forKey:@"attempt_id"];
                [jsonResponse setValue:appDelegate.courseCode forKey:@"course_code"];
                [jsonResponse setValue:appDelegate.coursePack forKey:@"package_code"];
                [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%@",[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE]] forKey:@"type_of_test"];
                
                [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",totalCorrectAns] forKey:@"score"];
                
                if([appDelegate.engineObj setPracticeOrAssissmentData:jsonResponse  edgeId:[[NSString alloc]initWithFormat:@"%@", self.assessnetUid]:appDelegate.coursePack])
                {
                    if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
                            [appDelegate.engineObj setTracktableData:data];
                }
                
                [self b_getAssessMCQDataService];
            }
            
            SUMMARYSCREENCALSS * meproObj = [[SUMMARYSCREENCALSS alloc]initWithNibName:SUMMARYSCREENXIB bundle:nil];
            meproObj.selectedLevel =  self.selectedLevel;
            meproObj.quizName = self.cusTitleName;
            meproObj.trackArr = jsonArr;
            meproObj.testOBj  = self.testOBj;
            meproObj.trackOriginalArr = ansTrackArray;
            meproObj.quesArray = quesArr;
            meproObj.TopicName = self.TopicName;
            meproObj.isRemediation =  self.isRemediation;
            meproObj.duration = [[NSString alloc]initWithFormat:@"%lld",[[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue]];
            meproObj.correctAns = [[NSString alloc] initWithFormat:@"%d",totalCorrectAns];
            meproObj.chapterId = self.scnUid;
            [self.navigationController pushViewController:meproObj animated:TRUE];
        }
        else
        {
            
            [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
            int quesScore = (totalCorrectAns*100)/answerableQuestion;
            int quesType = [[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue];
            if(answerableQuestion != 0 && quesScore >= appDelegate.quiz_passing_percentage && quesType == 1)
            {
                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            if(answerableQuestion != 0 && quesScore >= appDelegate.quiz_passing_percentage && quesType == 2)
            {
                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else if(answerableQuestion != 0 && quesScore >= appDelegate.review_passing_percentage && quesType == 3)
            {
                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else if(answerableQuestion != 0 && quesScore >= appDelegate.level_passing_score && quesType == 4)
            {
                [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            else
            {
                [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
            }
            [data setValue: [[NSString alloc] initWithFormat:@"%d",totalCorrectAns]forKey:NATIVE_JSON_KEY_USAGESCORE];
            
            [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", totalCorrectAns] :[[NSString alloc]initWithFormat:@"coins_%@", self.assessnetUid]];
            int val = (totalCorrectAns*100)/answerableQuestion;
            [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", val] :[[NSString alloc]initWithFormat:@"percent_%@", self.assessnetUid]];
            
            double spent =( [[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue])/1000;
            [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%f",spent]:[[NSString alloc]initWithFormat:@"ttl_time_sp_%@", self.assessnetUid]];
            [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", totalCorrectAns] :[[NSString alloc]initWithFormat:@"ttl_correct_%@", self.assessnetUid]];
            [appDelegate setUserDefaultData:[[NSString alloc]initWithFormat:@"%d", answerableQuestion] :[[NSString alloc]initWithFormat:@"no_of_ques_%@", self.assessnetUid]];
            
            
            NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
            [jsonResponse setValue:jsonArr forKey:@"param"];
            [jsonResponse setValue:self.assessnetUid forKey:@"edgeId"];
            [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",totalCorrectAns] forKey:@"score"];
            [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",[appDelegate.engineObj getAttemptCounter]+1] forKey:@"attempt_id"];
            [jsonResponse setValue:appDelegate.courseCode forKey:@"course_code"];
            [jsonResponse setValue:appDelegate.coursePack forKey:@"package_code"];
            [jsonResponse setValue:[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] forKey:@"type_of_test"];
            
            if([appDelegate.engineObj setPracticeOrAssissmentData:jsonResponse  edgeId:[[NSString alloc]initWithFormat:@"%@", self.assessnetUid]:appDelegate.coursePack])
            {
                if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] ){
                    if(!self.isRemediation)
                    {
                        [appDelegate.engineObj setTracktableData:data];
                        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
                    }
                }
            }
            
            [self b_getAssessMCQDataService];
            
            
            MeProQuizReport * meproObj = [[MeProQuizReport alloc]initWithNibName:@"MeProQuizReport" bundle:nil];
            meproObj.selectedLevel =  self.selectedLevel;
            meproObj.quizName = self.cusTitleName;
            meproObj.trackArr = jsonArr;
            meproObj.testOBj  = self.testOBj;
            //meproObj.trackOriginalArr = ansTrackArray;
            meproObj.quesArray = quesArr;
            meproObj.TopicName = self.TopicName;
            
            meproObj.duration = [[NSString alloc]initWithFormat:@"%lld",[[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue]];
            meproObj.correctAns = [[NSString alloc] initWithFormat:@"%d",totalCorrectAns];
            [self.navigationController pushViewController:meproObj animated:TRUE];
        }
    }
    else
    {
        [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
        int quesScore = 0;
        if(answerableQuestion > 0 ){
           quesScore = ceil((totalCorrectAns*100)/answerableQuestion);
        }
        
        if(quesScore >= appDelegate.chapter_quiz_passing_score && self.type != 3)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if(quesScore >= appDelegate.quiz_passing_percentage && self.type == 3)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else
        {
            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        

        [data setValue: [[NSString alloc] initWithFormat:@"%d",totalCorrectAns]forKey:NATIVE_JSON_KEY_USAGESCORE];
        
        NSMutableDictionary * jsonResponse = [[NSMutableDictionary alloc]init];
        [jsonResponse setValue:jsonArr forKey:@"param"];
        [jsonResponse setValue:self.assessnetUid forKey:@"edgeId"];
        [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",totalCorrectAns] forKey:@"score"];
        
        [jsonResponse setValue:[[NSString alloc] initWithFormat:@"%d",[appDelegate.engineObj getAttemptCounter]+1] forKey:@"attempt_id"];
        [jsonResponse setValue:appDelegate.courseCode forKey:@"course_code"];
        [jsonResponse setValue:appDelegate.coursePack forKey:@"package_code"];
        [jsonResponse setValue:[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] forKey:@"type_of_test"];
        
        [appDelegate.engineObj setPracticeOrAssissmentData:jsonResponse  edgeId:[[NSString alloc]initWithFormat:@"%@", self.assessnetUid]:appDelegate.coursePack];
        [self b_getAssessMCQDataService];
        
        if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
        {
            [appDelegate.engineObj setTracktableData:data];
            [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
            
        }
         
          SUMMARYSCREENCALSS * pteObj = [[SUMMARYSCREENCALSS alloc]initWithNibName:SUMMARYSCREENXIB bundle:nil];
            pteObj.selectedLevel =  self.selectedLevel;
            pteObj.quizName = self.cusTitleName;
            pteObj.trackArr = jsonArr;
            pteObj.quesArray = quesArr;
            pteObj.testOBj  = self.testOBj;
            pteObj.TopicName = self.TopicName;
            pteObj.trackOriginalArr = ansTrackArray;
            pteObj.isRemediation =  self.isRemediation;
            pteObj.duration = [[NSString alloc]initWithFormat:@"%lld",[[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue]];
            pteObj.correctAns = [[NSString alloc] initWithFormat:@"%d",totalCorrectAns];
            pteObj.chapterId = self.scnUid;
            [self.navigationController pushViewController:pteObj animated:TRUE];

    }
    
}

-(void)stopAllMeadia
{
    if(videoViewPlayer != NULL)
    {
        [videoViewPlayer.player pause];
        //[videoViewPlayer stop];
        videoViewPlayer = NULL;
    }
    
    if(audioPlayer != NULL && audioPlayer.isPlaying)
    {
        [audioPlayer pause];
        //[audioPlayer stop];
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        
        //AudioTimerLnbl =
    }
    if(audioPlayer != NULL)
    {
     audioPlayer = NULL;
     [expertAudioTimer invalidate];
     expertAudioTimer = NULL;
    }
    
    if(reAudioPlayer != NULL && reAudioPlayer.isPlaying)
    {
        [reAudioPlayer pause];
        [recordStop setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        
    }
    if(reAudioPlayer != NULL)
      reAudioPlayer = NULL;
    
    if(avrecorder != NULL && isAudioRecording)
    {
        [avrecorder stop];
        isAudioRecording = FALSE;
        avrecorder = NULL;
    }
    if(avrecorder != NULL)
    {
        isAudioRecording = FALSE;
        avrecorder = NULL;
    }
    if(sana_recorder != NULL && isAudioRecording)
    {
        [sana_recorder stop];
        isAudioRecording = FALSE;
        sana_recorder = NULL;
    }
    if(sana_recorder != NULL)
    {
        isAudioRecording = FALSE;
        sana_recorder = NULL;
    }
    if(recorder != NULL && isAudioRecording)
    {
        [recorder stop];
        isAudioRecording = FALSE;
        recorder = NULL;
    }
    if(recorder != NULL)
    {
        isAudioRecording = FALSE;
        recorder = NULL;
    }
    
    if(recVideoPlayer != NULL )
    {
        [recVideoPlayer.player pause];
        //[recVideoPlayer stop];
        recVideoPlayer = NULL;
    }
    if(option1player != NULL)
    {
        [option1player pause];
        [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        option1player = NULL;
    }
    if(option2player != NULL)
    {
        [option2player pause];
        [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        option2player = NULL;
    }
    if(option3player != NULL)
    {
        [option3player pause];
        [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        option3player = NULL;
    }
    if(option4player != NULL)
    {
        [option4player pause];
        [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
        option4player = NULL;
    }
    if(recordingTimer != NULL)
    {
        [recordingTimer invalidate];
        recordingTimer = NULL;
    }
    
}


-(void)clickNextManually
{
    if(isNextClick) return;
    
    isNextClick = TRUE;
    
    
    
    if(self.type != 3 ){
        [inputView setUserInteractionEnabled:TRUE];
        mcqSubmitBtn.hidden = FALSE;
        [self disableQuizBtn];
        //if(showPopUp!= NULL)showPopUp.hidden = TRUE;
        contiBtn.hidden = TRUE;
        
    }
    
    
    if([quesArr count]-1 <= questionCounter)
    {
        [self clickSubmit];
        
    }
    else{
        
        [self clickNext];
        
    }
    isNextClick = FALSE;
    
}

-(void)clickNext
{
   
    
    AVCounter = 0;
    QuesAVArr = NULL;
    [self stopAllMeadia];
    
    if(esTextView != NULL)
        [esTextView resignFirstResponder];
    
    
    NSMutableDictionary *globalQuizObj = [self createDictionaryifNot:globalDictionary type:@"" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]] ];
    
    
    if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
    {
        NSMutableArray * fbAns = [[ibfbView getAnswerArray] mutableCopy];
        [globalQuizObj setObject:fbAns forKey:@"option"];
        
    }
    else if( [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
    {
        
        NSMutableArray * fbAns = [fbView getAnswerArray] ;
        [globalQuizObj setObject:fbAns forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"])
    {
        [globalQuizObj setObject:esTextView.text forKey:@"option"];
        
    }
    else if([[[globalDictionary valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1  && [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
    {
        [globalQuizObj setObject:SanaResp forKey:@"score"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"dd"])
    {
        NSArray * arr =  dottedBox.allTags;
        [globalQuizObj setObject:arr forKey:@"option"];
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"pw"])
    {
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mttt"])
    {
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy] forKey:@"right"];
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtii"])
    {
        
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy] forKey:@"right"];
        
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtti"])
    {
         
        [globalQuizObj setObject:[leftArr  mutableCopy] forKey:@"left"];
        [globalQuizObj setObject:[rightArr  mutableCopy]forKey:@"right"];
        
    }
    
    
    [self addOrReplace:globalQuizObj];
    
    
    questionCounter ++;
    
    l1.text = [[NSString alloc]initWithFormat:@"%d of %lu",questionCounter+1,(unsigned long)[quesArr count]];
    if([quesArr count] > 0 ){
        float val =  (float)((float)(questionCounter+1)/(float)[quesArr count]);
        progressView.progress =val;
    }
    
    [self renderUI];
    
    
    
}

-(void)loadFotterView
{
    if(questionCounter == 0 )
    {
        next.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        next.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        next.enabled = TRUE;
        
        prev.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
        prev.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_DISABLE_COLOR alpha:1.0];
        
        
        prev.enabled = FALSE;
        
        
    }
    else if (questionCounter == [quesArr count]-1 )
    {
        next.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
        next.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_DISABLE_COLOR alpha:1.0];
        next.enabled = FALSE;
        
        prev.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        prev.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        prev.enabled = TRUE;
        
    }
    else
    {
        next.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        next.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        next.enabled = TRUE;
        
        prev.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        prev.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        prev.enabled = TRUE;
    }
}

-(void)checkMMCQ :(NSDictionary *) obj
{
    if([[obj valueForKey:@"option1"]intValue] == 1|| [[obj valueForKey:@"option2"]intValue] == 1|| [[obj valueForKey:@"option3"]intValue] == 1
       || [[obj valueForKey:@"option4"]intValue] == 1|| [[obj valueForKey:@"option5"]intValue] == 1|| [[obj valueForKey:@"option6"]intValue] == 1
       || [[obj valueForKey:@"option7"]intValue] == 1|| [[obj valueForKey:@"option8"]intValue] == 1)
    {
        [self enableQuizBtn];
        
    }
    else
    {
        [self disableQuizBtn];
    }
}

- (void)optMTouchClick:(UITapGestureRecognizer *)optTouchClick
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    if([obj valueForKey:@"option1"] != NULL && [[obj valueForKey:@"option1"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option1"];
        [obj setObject:@"" forKey:@"ansObj1"];
        textView.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay1 = [textView layer];
        [lay1 setMasksToBounds:YES];
        [lay1 setCornerRadius:20.0];
        
        // You can even add a border
        [lay1 setBorderWidth:1.0];
        [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op1.tag != 1000)
        {
            op1.tag = 0;
            cirImg.tag = 0;
            textView.tag = 0;
        }
        
        
    }
    else
    {
        [obj setObject:@"1" forKey:@"option1"];
        [obj setObject:op1.ansObj forKey:@"ansObj1"];
        cirImg.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay1 = [textView layer];
        textView.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay1 setMasksToBounds:YES];
        [lay1 setCornerRadius:20.0];
        
        // You can even add a border
        [lay1 setBorderWidth:1.0];
        [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op1.tag != 1000)
        {
            op1.tag = 100;
            cirImg.tag = 102;
            textView.tag = 101;
            
            
        }
        
    }
    [self addOrReplace:obj];
    
    [self checkMMCQ:obj];
    
    // [self clickMcType];
    
    
    
}
- (void)optMTouchClick1:(UITapGestureRecognizer *)optTouchClick1
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    
    if([obj valueForKey:@"option2"] != NULL && [[obj valueForKey:@"option2"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option2"];
        [obj setObject:@"" forKey:@"ansObj2"];
        textView1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg1.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay2 = [textView1 layer];
        [lay2 setMasksToBounds:YES];
        [lay2 setCornerRadius:20.0];
        
        // You can even add a border
        [lay2 setBorderWidth:1.0];
        [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op2.tag != 1000)
        {
            op2.tag = 0;
            cirImg1.tag = 0;
            textView1.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option2"];
        [obj setObject:op2.ansObj forKey:@"ansObj2"];
        cirImg1.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay2 = [textView1 layer];
        textView1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay2 setMasksToBounds:YES];
        [lay2 setCornerRadius:20.0];
        
        // You can even add a border
        [lay2 setBorderWidth:1.0];
        [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op2.tag != 1000)
        {
            op2.tag = 100;
            cirImg1.tag = 102;
            textView1.tag = 101;
            
            
        }
        
        
    }
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
    
    
}
- (void)optMTouchClick2:(UITapGestureRecognizer *)optTouchClick2
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    
    if([obj valueForKey:@"option3"] != NULL && [[obj valueForKey:@"option3"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option3"];
        [obj setObject:@"" forKey:@"ansObj3"];
        textView2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg2.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay3 = [textView2 layer];
        [lay3 setMasksToBounds:YES];
        [lay3 setCornerRadius:20.0];
        
        // You can even add a border
        [lay3 setBorderWidth:1.0];
        [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op3.tag != 1000)
        {
            op3.tag = 0;
            cirImg2.tag = 0;
            textView2.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option3"];
        [obj setObject:op3.ansObj forKey:@"ansObj3"];
        cirImg2.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay3 = [textView2 layer];
        textView2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay3 setMasksToBounds:YES];
        [lay3 setCornerRadius:20.0];
        
        // You can even add a border
        [lay3 setBorderWidth:1.0];
        [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op3.tag != 1000)
        {
            op3.tag = 100;
            cirImg2.tag = 102;
            textView2.tag = 101;
            
            
        }
        
    }
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
}
- (void)optMTouchClick3:(UITapGestureRecognizer *)optTouchClick3
{
    
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    
    if([obj valueForKey:@"option4"] != NULL && [[obj valueForKey:@"option4"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option4"];
        [obj setObject:@"" forKey:@"ansObj4"];
        textView3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg3.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay4 = [textView3 layer];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op4.tag != 1000)
        {
            op4.tag = 0;
            cirImg3.tag = 0;
            textView3.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option4"];
        [obj setObject:op4.ansObj forKey:@"ansObj4"];
        cirImg3.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay4 = [textView3 layer];
        textView3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        
        // You can even add a border
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op4.tag != 1000)
        {
            op4.tag = 100;
            cirImg3.tag = 102;
            textView3.tag = 101;
            
            
        }
        
    }
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
}
- (void)optMTouchClick4:(UITapGestureRecognizer *)optTouchClick4
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    if([obj valueForKey:@"option5"] != NULL && [[obj valueForKey:@"option5"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option5"];
        [obj setObject:@"" forKey:@"ansObj5"];
        textView4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg4.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay5 = [textView4 layer];
        [lay5 setMasksToBounds:YES];
        [lay5 setCornerRadius:20.0];
        [lay5 setBorderWidth:1.0];
        [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op5.tag != 1000)
        {
            op5.tag = 0;
            cirImg4.tag = 0;
            textView4.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option5"];
        [obj setObject:op5.ansObj forKey:@"ansObj5"];
        cirImg4.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay4 = [textView4 layer];
        textView4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        
        // You can even add a border
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op5.tag != 1000)
        {
            op5.tag = 100;
            cirImg4.tag = 102;
            textView4.tag = 101;
            
            
        }
        
    }
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
}

- (void)optMTouchClick5:(UITapGestureRecognizer *)optTouchClick5
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    if([obj valueForKey:@"option6"] != NULL && [[obj valueForKey:@"option6"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option6"];
        [obj setObject:@"" forKey:@"ansObj6"];
        textView5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg5.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay5 = [textView5 layer];
        [lay5 setMasksToBounds:YES];
        [lay5 setCornerRadius:20.0];
        [lay5 setBorderWidth:1.0];
        [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op6.tag != 1000)
        {
            op6.tag = 0;
            cirImg5.tag = 0;
            textView5.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option6"];
        [obj setObject:op6.ansObj forKey:@"ansObj6"];
        cirImg5.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay4 = [textView5 layer];
        textView5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        
        // You can even add a border
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op6.tag != 1000)
        {
            op6.tag = 100;
            cirImg5.tag = 102;
            textView5.tag = 101;
            
            
        }
        
    }
    
    
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
}
- (void)optMTouchClick6:(UITapGestureRecognizer *)optTouchClick6
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    if([obj valueForKey:@"option7"] != NULL && [[obj valueForKey:@"option7"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option7"];
        [obj setObject:@"" forKey:@"ansObj7"];
        textView6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg6.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay5 = [textView6 layer];
        [lay5 setMasksToBounds:YES];
        [lay5 setCornerRadius:20.0];
        [lay5 setBorderWidth:1.0];
        [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op7.tag != 1000)
        {
            op7.tag = 0;
            cirImg6.tag = 0;
            textView6.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option7"];
        [obj setObject:op7.ansObj forKey:@"ansObj7"];
        cirImg6.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay4 = [textView6 layer];
        textView6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        
        // You can even add a border
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op7.tag != 1000)
        {
            op7.tag = 100;
            cirImg6.tag = 102;
            textView6.tag = 101;
            
            
        }
        
    }
    
    
    
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
}

- (void)optMTouchClick7:(UITapGestureRecognizer *)optTouchClick7
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mmc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    if([obj valueForKey:@"option8"] != NULL && [[obj valueForKey:@"option8"]intValue] == 1 )
    {
        [obj setObject:@"0" forKey:@"option8"];
        [obj setObject:@"" forKey:@"ansObj8"];
        
        textView7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        cirImg7.image = [UIImage imageNamed:@"TikButton-blank.png"];
        CALayer * lay5 = [textView7 layer];
        [lay5 setMasksToBounds:YES];
        [lay5 setCornerRadius:20.0];
        [lay5 setBorderWidth:1.0];
        [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        if(op8.tag != 1000)
        {
            op8.tag = 0;
            cirImg7.tag = 0;
            textView7.tag = 0;
        }
    }
    else
    {
        [obj setObject:@"1" forKey:@"option8"];
        [obj setObject:op8.ansObj forKey:@"ansObj8"];
        cirImg7.image = [UIImage imageNamed:@"TikButton.png"];
        CALayer * lay4 = [textView7 layer];
        textView7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
        [lay4 setMasksToBounds:YES];
        [lay4 setCornerRadius:20.0];
        
        // You can even add a border
        [lay4 setBorderWidth:1.0];
        [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        if(op8.tag != 1000)
        {
            op8.tag = 100;
            cirImg7.tag = 102;
            textView7.tag = 101;
            
            
        }
        
    }
    [self addOrReplace:obj];
    [self checkMMCQ:obj];
    
}



- (void)optTouchClick:(UITapGestureRecognizer *)optTouchClick
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:@"1" forKey:@"option"];
    [obj setObject:op1.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    [self clickMcType];
    
    
    if(op1.tag != 1000)
    {
        op1.tag = 100;
        cirImg.tag = 102;
        textView.tag = 101;
        
        
    }
    
    cirImg.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay1 = [textView layer];
    textView.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:20.0];
    
    // You can even add a border
    [lay1 setBorderWidth:1.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}
- (void)optTouchClick1:(UITapGestureRecognizer *)optTouchClick1
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];;
    
    [obj setObject:@"2" forKey:@"option"];
    [obj setObject:op2.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    
    [self clickMcType];
    
    
    if(op2.tag != 1000)
    {
        op2.tag = 100;
        cirImg1.tag = 102;
        textView1.tag = 101;
        
        
    }
    
    cirImg1.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay2 = [textView1 layer];
    textView1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:20.0];
    
    // You can even add a border
    [lay2 setBorderWidth:1.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}
- (void)optTouchClick2:(UITapGestureRecognizer *)optTouchClick2
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"3" forKey:@"option"];
    [obj setObject:op3.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    
    [self clickMcType];
    if(op3.tag != 1000)
    {
        op3.tag = 100;
        cirImg2.tag = 102;
        textView2.tag = 101;
        
        
    }
    
    cirImg2.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay3 = [textView2 layer];
    textView2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:20.0];
    
    // You can even add a border
    [lay3 setBorderWidth:1.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}
- (void)optTouchClick3:(UITapGestureRecognizer *)optTouchClick3
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"4" forKey:@"option"];
    [obj setObject:op4.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    
    [self clickMcType];
    if(op4.tag != 1000)
    {
        op4.tag = 100;
        cirImg3.tag = 102;
        textView3.tag = 101;
        
        
    }
    
    cirImg3.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay4 = [textView3 layer];
    textView3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:20.0];
    
    // You can even add a border
    [lay4 setBorderWidth:1.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}
- (void)optTouchClick4:(UITapGestureRecognizer *)optTouchClick4
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"5" forKey:@"option"];
    
    [obj setObject:op5.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    
    [self clickMcType];
    if(op5.tag != 1000)
    {
        op5.tag = 100;
        cirImg4.tag = 102;
        textView4.tag = 101;
        
        
    }
    
    cirImg4.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay5 = [textView4 layer];
    textView4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay5 setMasksToBounds:YES];
    [lay5 setCornerRadius:20.0];
    [lay5 setBorderWidth:1.0];
    [lay5 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}

- (void)optTouchClick5:(UITapGestureRecognizer *)optTouchClick5
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"6" forKey:@"option"];
    [obj setObject:op6.ansObj forKey:@"ansObj"];
    
    [self addOrReplace:obj];
    [self clickMcType];
    if(op6.tag != 1000)
    {
        op6.tag = 100;
        cirImg5.tag = 102;
        textView5.tag = 101;
        
        
    }
    
    cirImg5.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay6 = [textView5 layer];
    textView5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay6 setMasksToBounds:YES];
    [lay6 setCornerRadius:20.0];
    
    // You can even add a border
    [lay6 setBorderWidth:1.0];
    [lay6 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}
- (void)optTouchClick6:(UITapGestureRecognizer *)optTouchClick6
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"7" forKey:@"option"];
    [obj setObject:op7.ansObj forKey:@"ansObj"];
    
    [self addOrReplace:obj];
    
    [self clickMcType];
    if(op7.tag != 1000)
    {
        op7.tag = 100;
        cirImg6.tag = 102;
        textView6.tag = 101;
        
        
    }
    
    cirImg6.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay7 = [textView6 layer];
    textView6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay7 setMasksToBounds:YES];
    [lay7 setCornerRadius:20.0];
    
    // You can even add a border
    [lay7 setBorderWidth:1.0];
    [lay7 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}

- (void)optTouchClick7:(UITapGestureRecognizer *)optTouchClick7
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mc" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"8" forKey:@"option"];
    [obj setObject:op8.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    
    [self clickMcType];
    if(op8.tag != 1000)
    {
        op8.tag = 100;
        cirImg7.tag = 102;
        textView7.tag = 101;
        
        
    }
    cirImg7.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay8 = [textView7 layer];
    textView7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay8 setMasksToBounds:YES];
    [lay8 setCornerRadius:20.0];
    [lay8 setBorderWidth:1.0];
    [lay8 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}

-(void)clickMcType
{
    [self enableQuizBtn];
    
    textView7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg7.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay8 = [textView7 layer];
    [lay8 setMasksToBounds:YES];
    [lay8 setCornerRadius:20.0];
    
    // You can even add a border
    [lay8 setBorderWidth:1.0];
    [lay8 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg6.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay7 = [textView6 layer];
    [lay7 setMasksToBounds:YES];
    [lay7 setCornerRadius:20.0];
    
    // You can even add a border
    [lay7 setBorderWidth:1.0];
    [lay7 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg5.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay6 = [textView5 layer];
    [lay6 setMasksToBounds:YES];
    [lay6 setCornerRadius:20.0];
    
    // You can even add a border
    [lay6 setBorderWidth:1.0];
    [lay6 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg4.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay5 = [textView4 layer];
    [lay5 setMasksToBounds:YES];
    [lay5 setCornerRadius:20.0];
    
    // You can even add a border
    [lay5 setBorderWidth:1.0];
    [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg3.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay4 = [textView3 layer];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:20.0];
    
    // You can even add a border
    [lay4 setBorderWidth:1.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    
    
    textView1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg1.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay2 = [textView1 layer];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:20.0];
    
    // You can even add a border
    [lay2 setBorderWidth:1.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg2.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay3 = [textView2 layer];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:20.0];
    
    // You can even add a border
    [lay3 setBorderWidth:1.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    textView.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay1 = [textView layer];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:20.0];
    
    // You can even add a border
    [lay1 setBorderWidth:1.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    if(op1.tag != 1000)
    {
        op1.tag = 0;
        cirImg.tag = 0;
        textView.tag = 0;
        
        
    }
    if(op2.tag != 1000)
    {
        op2.tag = 0;
        cirImg1.tag = 0;
        textView1.tag = 0;
        
        
    }
    if(op3.tag != 1000)
    {
        op3.tag = 0;
        cirImg2.tag = 0;
        textView2.tag = 0;
        
        
    }
    if(op4.tag != 1000)
    {
        op4.tag = 0;
        cirImg3.tag = 0;
        textView3.tag = 0;
        
        
    }
    if(op5.tag != 1000)
    {
        op5.tag = 0;
        cirImg4.tag = 0;
        textView4.tag = 0;
        
        
    }
    if(op6.tag != 1000)
    {
        op6.tag = 0;
        cirImg5.tag = 0;
        textView5.tag = 0;
        
        
    }
    if(op7.tag != 1000)
    {
        op7.tag = 0;
        cirImg6.tag = 0;
        textView6.tag = 0;
        
        
    }
    if(op8.tag != 1000)
    {
        op8.tag = 0;
        cirImg7.tag = 0;
        textView7.tag = 0;
        
        
    }
    
    
    
}








- (void)optImageTouchClick:(UITapGestureRecognizer *)optTouchClick
{
    
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"1" forKey:@"option"];
    [obj setObject:op1.ansObj forKey:@"ansObj"];
    
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op1.tag != 1000)
    {
        op1.tag = 100;
        cirImg.tag = 102;
        text.tag = 101;
        
        
    }
    
    cirImg.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay1 = [op1 layer];
    text.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay1 setBorderWidth:2.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
    
}
- (void)optImageTouchClick3:(UITapGestureRecognizer *)optTouchClick3
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"4" forKey:@"option"];
    [obj setObject:op4.ansObj forKey:@"ansObj"];
    
    
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op4.tag != 1000)
    {
        op4.tag = 100;
        cirImg3.tag = 102;
        text3.tag = 101;
        
        
    }
    
    cirImg3.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    
    CALayer * lay4 = [op4 layer];
    text3.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    text3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:5.0];
    
    // You can even add a border
    [lay4 setBorderWidth:2.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
    
}
- (void)optImageTouchClick1:(UITapGestureRecognizer *)optTouchClick1
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];;
    
    [obj setObject:@"2" forKey:@"option"];
    [obj setObject:op2.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op2.tag != 1000)
    {
        op2.tag = 100;
        cirImg1.tag = 102;
        text1.tag = 101;
        
        
    }
    cirImg1.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay2 = [op2 layer];
    text1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:5.0];
    
    // You can even add a border
    [lay2 setBorderWidth:2.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
}
- (void)optImageTouchClick2:(UITapGestureRecognizer *)optTouchClick2
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [obj setObject:@"3" forKey:@"option"];
    [obj setObject:op3.ansObj forKey:@"ansObj"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op3.tag != 1000)
    {
        op3.tag = 100;
        cirImg2.tag = 102;
        text2.tag = 101;
        
        
    }
    cirImg2.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay3 = [op3 layer];
    text2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text2.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:5.0];
    
    // You can even add a border
    [lay3 setBorderWidth:2.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
    
    
    
}
- (void)optImageTouchClick4:(UITapGestureRecognizer *)optTouchClick
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op5.ansObj forKey:@"ansObj"];
    [obj setObject:@"5" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op5.tag != 1000)
    {
        op5.tag = 100;
        cirImg4.tag = 102;
        text4.tag = 101;
        
        
    }
    cirImg4.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay1 = [op5 layer];
    text4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text4.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay1 setBorderWidth:2.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
    
}
- (void)optImageTouchClick5:(UITapGestureRecognizer *)optTouchClick3
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op6.ansObj forKey:@"ansObj"];
    [obj setObject:@"6" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op6.tag != 1000)
    {
        op6.tag = 100;
        cirImg5.tag = 102;
        text5.tag = 101;
        
        
    }
    cirImg5.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay4 = [op6 layer];
    text5.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    text5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:5.0];
    [lay4 setBorderWidth:2.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
    
}
- (void)optImageTouchClick6:(UITapGestureRecognizer *)optTouchClick1
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];;
    [obj setObject:op7.ansObj forKey:@"ansObj"];
    [obj setObject:@"7" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op7.tag != 1000)
    {
        op7.tag = 100;
        cirImg6.tag = 102;
        text6.tag = 101;
        
        
    }
    cirImg6.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay2 = [op7 layer];
    text6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text6.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:5.0];
    [lay2 setBorderWidth:2.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    
}
- (void)optImageTouchClick7:(UITapGestureRecognizer *)optTouchClick2
{
    
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mci" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op8.ansObj forKey:@"ansObj"];
    [obj setObject:@"8" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op8.tag != 1000)
    {
        op8.tag = 100;
        cirImg7.tag = 102;
        text7.tag = 101;
        
        
    }
    cirImg7.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay3 = [op8 layer];
    text7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text7.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:5.0];
    [lay3 setBorderWidth:2.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
}








- (void)optAudioTouchClick:(UITapGestureRecognizer *)optTouchClick
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op1.ansObj forKey:@"ansObj"];
    [obj setObject:@"1" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op1.tag != 1000)
    {
        op1.tag = 100;
        cirImg.tag = 102;
        text.tag = 101;
        
        
    }
    cirImg.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay1 = [op1 layer];
    text.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:5.0];
    [lay1 setBorderWidth:2.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
}

- (void)optAudioTouchClick1:(UITapGestureRecognizer *)optTouchClick1
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];;
    [obj setObject:op2.ansObj forKey:@"ansObj"];
    [obj setObject:@"2" forKey:@"option"];
    
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op2.tag != 1000)
    {
        op2.tag = 100;
        cirImg1.tag = 102;
        text1.tag = 101;
        
        
    }
    cirImg1.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay2 = [op2 layer];
    text1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:5.0];
    [lay2 setBorderWidth:2.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    //Do stuff here...
}
- (void)optAudioTouchClick2:(UITapGestureRecognizer *)optTouchClick2
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op3.ansObj forKey:@"ansObj"];
    [obj setObject:@"3" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op3.tag != 1000)
    {
        op3.tag = 100;
        cirImg2.tag = 102;
        text2.tag = 101;
        
        
    }
    
    cirImg2.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay3 = [op3 layer];
    text2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text2.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:5.0];
    [lay3 setBorderWidth:2.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    //Do stuff here...
}
- (void)optAudioTouchClick3:(UITapGestureRecognizer *)optTouchClick3
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op4.ansObj forKey:@"ansObj"];
    [obj setObject:@"4" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op4.tag != 1000)
    {
        op4.tag = 100;
        cirImg3.tag = 102;
        text3.tag = 101;
        
        
    }
    cirImg3.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay4 = [op4 layer];
    text3.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    text3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:5.0];
    [lay4 setBorderWidth:2.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    //Do stuff here...
}
- (void)optAudioTouchClick4:(UITapGestureRecognizer *)optTouchClick4
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op5.ansObj forKey:@"ansObj"];
    [obj setObject:@"5" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op5.tag != 1000)
    {
        op5.tag = 100;
        cirImg4.tag = 102;
        text4.tag = 101;
        
        
    }
    cirImg4.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay1 = [op5 layer];
    text4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text4.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:5.0];
    [lay1 setBorderWidth:2.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
}

- (void)optAudioTouchClick5:(UITapGestureRecognizer *)optTouchClick5
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];;
    [obj setObject:op6.ansObj forKey:@"ansObj"];
    [obj setObject:@"6" forKey:@"option"];
    
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op6.tag != 1000)
    {
        op6.tag = 100;
        cirImg5.tag = 102;
        text5.tag = 101;
        
        
    }
    cirImg5.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay2 = [op6 layer];
    text5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text5.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:5.0];
    [lay2 setBorderWidth:2.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    //Do stuff here...
}
- (void)optAudioTouchClick6:(UITapGestureRecognizer *)optTouchClick6
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op7.ansObj forKey:@"ansObj"];
    [obj setObject:@"7" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op7.tag != 1000)
    {
        op7.tag = 100;
        cirImg6.tag = 102;
        text6.tag = 101;
        
        
    }
    cirImg6.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay3 = [op7 layer];
    text6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    text6.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:5.0];
    [lay3 setBorderWidth:2.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    //Do stuff here...
}
- (void)optAudioTouchClick7:(UITapGestureRecognizer *)optTouchClick7
{
    NSMutableDictionary * obj = [self createDictionaryifNot:globalDictionary type:@"mca" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    [obj setObject:op8.ansObj forKey:@"ansObj"];
    [obj setObject:@"8" forKey:@"option"];
    [self addOrReplace:obj];
    [self clickMcaMciType];
    if(op8.tag != 1000)
    {
        op8.tag = 100;
        cirImg7.tag = 102;
        text7.tag = 101;
        
        
    }
    cirImg7.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
    CALayer * lay4 = [op8 layer];
    text7.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    text7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:5.0];
    [lay4 setBorderWidth:2.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    //Do stuff here...
}

-(void)clickMcaMciType
{
    [self enableQuizBtn];
    
    
    text7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text7.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg7.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay8 = [op8 layer];
    [lay8 setMasksToBounds:YES];
    [lay8 setCornerRadius:5.0];
    [lay8 setBorderWidth:2.0];
    [lay8 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    text6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text6.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg6.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay7 = [op7 layer];
    [lay7 setMasksToBounds:YES];
    [lay7 setCornerRadius:5.0];
    [lay7 setBorderWidth:2.0];
    [lay7 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    text5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text5.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg5.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay6 = [op6 layer];
    [lay6 setMasksToBounds:YES];
    [lay6 setCornerRadius:5.0];
    [lay6 setBorderWidth:2.0];
    [lay6 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    text4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text4.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg4.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay5 = [op5 layer];
    [lay5 setMasksToBounds:YES];
    [lay5 setCornerRadius:5.0];
    [lay5 setBorderWidth:2.0];
    [lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    text3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text3.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg3.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay4 = [op4 layer];
    [lay4 setMasksToBounds:YES];
    [lay4 setCornerRadius:5.0];
    [lay4 setBorderWidth:2.0];
    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    text2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text2.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg2.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay3 = [op3 layer];
    [lay3 setMasksToBounds:YES];
    [lay3 setCornerRadius:5.0];
    [lay3 setBorderWidth:2.0];
    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    text1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text1.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg1.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay2 = [op2 layer];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:5.0];
    [lay2 setBorderWidth:2.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    
    text.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    text.textColor = [self getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
    CALayer * lay1 = [op1 layer];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:5.0];
    [lay1 setBorderWidth:2.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    if(op1.tag != 1000)
    {
        op1.tag = 0;
        cirImg.tag = 0;
        text.tag = 0;
        
        
    }
    if(op2.tag != 1000)
    {
        op2.tag = 0;
        cirImg1.tag = 0;
        text1.tag = 0;
        
        
    }
    if(op3.tag != 1000)
    {
        op3.tag = 0;
        cirImg2.tag = 0;
        text2.tag = 0;
        
        
    }
    if(op4.tag != 1000)
    {
        op4.tag = 0;
        cirImg3.tag = 0;
        text3.tag = 0;
        
        
    }
    if(op5.tag != 1000)
    {
        op5.tag = 0;
        cirImg4.tag = 0;
        text4.tag = 0;
        
        
    }
    if(op6.tag != 1000)
    {
        op6.tag = 0;
        cirImg5.tag = 0;
        text5.tag = 0;
        
        
    }
    if(op7.tag != 1000)
    {
        op7.tag = 0;
        cirImg6.tag = 0;
        text6.tag = 0;
        
        
    }
    if(op8.tag != 1000)
    {
        op8.tag = 0;
        cirImg7.tag = 0;
        text7.tag = 0;
        
        
    }
    
    
}


-(BOOL)checkLastPosition
{
    UIView * obj = (UIView *)leftArr.lastObject;
    UIView * obj1 = (UIView *)rightArr.lastObject;
    
    if(obj.tag == obj1.tag )
        return TRUE;
    else
        return FALSE;
}


-(void)updateTimer
{
    
    totaltime --;
    int min = totaltime/60;
    int second = totaltime%60;
    NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
    minute.text = time;
    minute1.text = time;
    if(totaltime <= 0){
        [recordingTimer invalidate];
        recordingTimer = NULL;
        [self clickStartPlay:self];
    }
    
    
}

-(void)updateAVTimer
{
    
    totaltime --;
    int min = totaltime/60;
    int second = totaltime%60;
    NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
    minute.text = time;
    minute1.text = time;
    if(totaltime <= 0){
        [recordingTimer invalidate];
        recordingTimer = NULL;
        [self clickAVStartPlay:self];
    }
    
    
}

-(IBAction)clickAVStartPlay:(id)sender

{
    if (avrecorder != NULL &&  !avrecorder.recording && !isAudioRecording )
    {
        tapIns.text = @"Tap to Stop";
        //[recorder prepareToRecord];
        [avrecorder record];
        footerView.hidden = TRUE;
        isAudioRecording= TRUE;
        minute.hidden = FALSE;
        remaingText.hidden = FALSE;
        [recordAVStop setImage:[UIImage imageNamed:@"RecordingAble_Ani.png"] forState:UIControlStateNormal];
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateAVTimer)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    else if(avrecorder != NULL && isAudioRecording)
    {
        [avrecorder stop];
        tapIns.text = @"Tap to Start";
        
        if(recordingTimer != NULL){
            [recordingTimer invalidate];
            recordingTimer = NULL;
            
            
        }
        
        
    }
    
    
    
    else if (!isRecording)
    {
        tapIns1.text = @"Tap to stop";
        footerView.hidden = TRUE;
        isRecording = TRUE;
        [pickerObj startVideoCapture];
        
        [recordStop1 setImage:[UIImage imageNamed:@"RecordingAble_Ani.png"] forState:UIControlStateNormal];
        
        
        
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateAVTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        
    }
    else
    {
        tapIns1.text = @"Tap to Start";
        footerView.hidden = FALSE;
        isRecording = FALSE;
        [recordingTimer invalidate];
        recordingTimer = NULL;
        [pickerObj stopVideoCapture];
        [recordStop1 setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
        [recordStop setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
        recordStop.enabled = FALSE;
    }
    
}


-(IBAction)clickCameraStartPlay:(id)sender
{
    if(videoViewPlayer != NULL)
        [videoViewPlayer.player pause];
    
    if (!isRecording)
    {
        tapIns1.text = @"Tap to stop";
        footerView.hidden = TRUE;
        isRecording = TRUE;
        [pickerObj startVideoCapture];
        
        [recordStop1 setImage:[UIImage imageNamed:@"RecordingAble_Ani.png"] forState:UIControlStateNormal];
        
        
        
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        
    }
    else
    {
        tapIns1.text = @"Tap to Start";
        
        footerView.hidden = FALSE;
        isRecording = FALSE;
        [recordingTimer invalidate];
        recordingTimer = NULL;
        [pickerObj stopVideoCapture];
        
        [recordStop1 setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
        [recordStop setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
        
        recordStop.enabled = FALSE;
    }
}

-(IBAction)clickStartPlay:(id)sender

{
    if(audioPlayer!= NULL && audioPlayer.isPlaying )
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:APP_QUIZ_EXPERT_ICON] forState:UIControlStateNormal];
        
        
    }
    
    if(videoViewPlayer != NULL)
        [videoViewPlayer.player pause];
    
    
    
    if (recorder != NULL &&  !recorder.recording && !isAudioRecording )
    {
        tapIns.text = @"Tap to Stop";
        //[recorder prepareToRecord];
        [recorder record];
        //footerView.hidden = TRUE;
        isAudioRecording= TRUE;
        minute.hidden = FALSE;
        remaingText.hidden = FALSE;
        [recordStop setImage:[UIImage imageNamed:APP_QUIZ_PAUSE_ICON] forState:UIControlStateNormal];
        
        
        recordingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    else if(recorder != NULL && isAudioRecording)
    {
        [recorder stop];
        if(recordingTimer != NULL){
            [recordingTimer invalidate];
            recordingTimer = NULL;
            
            
        }
        
        
    }
}


-(IBAction)expertPlayPause:(id)sender
{
    
    
    if(isAudioRecording || sanaAudioPlayer.isPlaying)return;
    
    if(audioPlayer.isPlaying)
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        
    }
    else if(audioPlayer == NULL  )
    {
        // audioPath = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
        audioPath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSError *err;
        
         NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&err];
        [audioPlayer setDelegate:self];
        
        [audioPlayer play];
        [audioBtn setImage:[UIImage imageNamed:@"PauseIcon.png"] forState:UIControlStateNormal];
        
        expertAudioTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateAudioPlayer) userInfo:nil repeats:YES];
        
        
    }
    else
    {
        [audioPlayer play];
        [audioBtn setImage:[UIImage imageNamed:@"PauseIcon.png"] forState:UIControlStateNormal];
        
        
    }
    
}

-(void)updateAudioPlayer
{
    float totalTime = audioPlayer.duration ;
    float currentTime = audioPlayer.currentTime ;
    AudioTimerLnbl.text = [self covertIntoHrMinSec:(totalTime-currentTime)];
    NSLog(@" Capturing Time :%f ::: %f ",totalTime,currentTime );
    timerProgressAudioView.progress = (float )((float)currentTime/(float)totalTime);
    if(totalTime == currentTime){
        [expertAudioTimer invalidate];
        //audioPlayer = NULL;
        expertAudioTimer = NULL;
        //timerProgressAudioView.progress = 0.0;
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }
    
}


-(IBAction)sanaExpertPlayPause:(id)sender
{
    
    
    
    if(isAudioRecording || audioPlayer.isPlaying )return;
    
    if(sanaAudioPlayer.isPlaying)
    {
        [sanaAudioPlayer pause];
        [audioSanaBtn setImage:[UIImage imageNamed:@"MEPro_expert.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        //audioPath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
        
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
        audioPath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        sanaAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL  error:nil];
        [sanaAudioPlayer setDelegate:self];
        [sanaAudioPlayer play];
        [audioSanaBtn setImage:[UIImage imageNamed:@"MEPro_pause.png"] forState:UIControlStateNormal];
    }
}




-(IBAction)playPause:(id)sender

{
    
    if(isAudioRecording)return;
    
    if(audioPlayer.isPlaying)
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:APP_QUIZ_EXPERT_ICON] forState:UIControlStateNormal];
        
        
    }
    else
    {
        [audioPlayer play];
        [audioBtn setImage:[UIImage imageNamed:APP_QUIZ_PAUSE_ICON] forState:UIControlStateNormal];
        
    }
    
    if(option1player != NULL)
    {
        [option1player stop];
        option1player = NULL;
    }
    
    if(option2player != NULL)
    {
        [option2player stop];
        option2player = NULL;
    }
    if(option3player != NULL)
    {
        [option3player stop];
        option3player = NULL;
    }
    if(option4player != NULL)
    {
        [option4player stop];
        option4player = NULL;
    }
    [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    
}
-(void)shopPopInstruction :(UITapGestureRecognizer *)gasture
{
    
    
    NSString * str = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"];
    NSString * titletxt = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"title"]valueForKey:@"text"];
    NSString *path;
    
    
    
    SampleAnswer * saObj = [[SampleAnswer alloc]initWithNibName:@"SampleAnswer" bundle:nil];
    if([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"] )
    {
        // path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"] valueForKey:@"text"]];
        NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"] valueForKey:@"text"]];
        path =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
    }
    else
    {
        path =@"";
    }
    
    if(![titletxt isEqual:[NSNull null]]&&![titletxt isEqualToString:@""]&&![titletxt length]<=0 )
    {
        saObj.title = titletxt;
    }
    else
    {
        saObj.title = @"Read the instruction below.";
    }
    
    
    saObj.path = path;
    saObj.sampleText = str;
    saObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:saObj animated:NO completion:nil];
}


-(int)checkOrder:(int)order
{
    if([[[globalDictionary valueForKey:@"audio"]valueForKey:@"order"]intValue] == order && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"audio"] valueForKey:@"is_filled"]isEqualToString:@"true"])
    {
        return 1; //  image and Audio
    }
    else if([[[globalDictionary valueForKey:@"audio"]valueForKey:@"order"]intValue] == order && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"audio"] valueForKey:@"is_filled"]isEqualToString:@"false"])
    {
        return 2; // only image
    }
    else if([[[globalDictionary valueForKey:@"audio"]valueForKey:@"order"]intValue] == order && [[[globalDictionary valueForKey:@"audio"] valueForKey:@"is_filled"]isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"false"])
    {
        return 3; // only audio
    }
    else if([[[globalDictionary valueForKey:@"instruction"]valueForKey:@"order"]intValue] == order && [[globalDictionary valueForKey:@"instruction"] valueForKey:@"text"])
    {
        return 4; //  instruction
    }
    else if([[[globalDictionary valueForKey:@"content"]valueForKey:@"order"]intValue] == order )
    {
        return 5; //  Question content
    }
    else
    {
        return 0;
    }
    
    
    
}

-(NSMutableArray *)randomddOptionArr :(NSMutableArray *)arr
{
    NSMutableArray * optArr = nil;
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:arr];
    int n = arc4random() % [tmpArray count];
    if(n == 0) n = 1;
    [tmpArray exchangeObjectAtIndex:0 withObjectAtIndex:n];
    optArr = [NSMutableArray arrayWithArray:tmpArray];
    
    return optArr;
}


-(NSMutableArray *)randomOptionArr :(NSMutableArray *)arr :(BOOL)isForcely
{
    NSMutableArray * optArr = nil;
    if(optRand || isForcely)
    {
        NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:arr];
        int n = arc4random() % [tmpArray count];
        if(n == 0) n = 1;
        [tmpArray exchangeObjectAtIndex:0 withObjectAtIndex:n];
        optArr = [NSMutableArray arrayWithArray:tmpArray];
    }
    else
    {
        optArr = [NSMutableArray arrayWithArray:arr];
    }
    return optArr;
}
-(NSString *)addPrefixUrl:(NSString *)url
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *videoUrl = [documentsDirectory stringByAppendingPathComponent:url];
    NSMutableString * path = [[NSMutableString alloc]init];
    [path appendFormat:@"%@",videoUrl];
    
    
    if (![path hasSuffix:@".MOV"])
    {
        NSMutableString * pathwithMOV = [[NSMutableString alloc]initWithString:path];
        [pathwithMOV appendFormat:@".MOV"];
        [appDelegate renameFileWithName:path toName:pathwithMOV];
        return pathwithMOV;
        
    }
    else{
        return path;
    }
    
    return @"";
}
//-(UITapGestureRecognizer * )addMCTapgasture
//{
//    UITapGestureRecognizer * opmcTouch = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                       action:@selector(multipleChoice_optTouchClick:)];
//    opmcTouch.delegate=self;
//    opmcTouch.numberOfTapsRequired = 1;
//    return opmcTouch;
//}
//- (void)multipleChoice_optTouchClick:(UITapGestureRecognizer *)optTouchClick
//{
//    [mcView multipleChoice_optTouchClick:optTouchClick];
//}
//- (void)textViewDidChange:(UITextView *)textView
//{
//    UIFont *myFont = [UIFont systemFontOfSize:14];
//    CGSize size =   [self sizeOfText:textView.text widthOfTextView:TextviewWidth withFont:myFont];
//    NSLog(@"Height : %f", size.height);
//}
//
//-(CGSize)sizeOfText:(NSString *)textToMesure widthOfTextView:(CGFloat)width withFont:(UIFont*)font
//{
//    CGSize ts = [textToMesure sizeWithFont:font constrainedToSize:CGSizeMake(width-20.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//    return ts;
//}


-(CGSize)sizeOfText:(NSString *)textToMesure widthOfTextView:(CGFloat)width withFont:(UIFont*)font
{
    CGSize ts = [textToMesure sizeWithFont:font constrainedToSize:CGSizeMake(width-20.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return ts;
}


-(void)renderUI
{
    
    
    
    rightDrawFlag = 0;
    [inputView removeFromSuperview];
    inputView = NULL;
    inputView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,20 , SCREEN_WIDTH, backGView.frame.size.height-20)];
    inputView.backgroundColor = [UIColor whiteColor];
    [backGView addSubview:inputView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    
    quesNo = [[UILabel alloc]init];
    quesNo.font = TEXTTITLEFONT;
    quesNo.textAlignment = NSTextAlignmentRight;
    questionView = [[UITextView alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH-20,0)];
    questionView.editable = FALSE;
    questionView.font = TEXTTITLEFONT;
    questionView.scrollEnabled = FALSE;
    scrollView = [[UIScrollView alloc]init];
    //questionView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    [inputView addSubview:scrollView];
    [scrollView addSubview:quesNo];
    [scrollView addSubview:questionView];
    //questionView.contentInset = UIEdgeInsetsMake(-6.0,-1.0,0,0.0);
    
    if(questionCounter < 0 && [quesArr count] <= questionCounter )
    {
        [self clickBack];
    }
    NSDictionary * question = [quesArr objectAtIndex:questionCounter];
    globalDictionary = question;
    NSMutableDictionary * globalTrackQuizObj =  [self createDictionaryifNot:question type:@"" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    
    [self addOrReplace:globalTrackQuizObj];
    
    if(isShowFeedback)
    {
        feedbackArray = [[question valueForKey:@"feedbacks"]valueForKey:@"feedback"];
    }
    
    NSString* newString = [[[question valueForKey:@"content"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
    NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
    NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
    NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
    NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
    
    NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
    
    
    
    
    NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",questionView.font.pointSize,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
//    NSString *str1 = [[NSString alloc]initWithFormat:@"<!DOCTYPE html><head><link rel='stylesheet' type='text/css' href='https://stg.adurox.com/css/bootstrap.min.css'/></head><body>%@</body></html>",str ];
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:TEXTTITLEFONT}
                                            documentAttributes: nil
                                            error: nil
                                            ];
    
    
    
    questheight1 = 0;
    questionView.attributedText = attributedString;
     questheight1 = [self quesHeightForText:attributedString font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-20 :[brCounter count]];
    questionView.scrollEnabled = FALSE;
    
    //quesNo.text = [[NSString alloc]initWithFormat:@"%d. ",questionCounter+1];
    if(![[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"av"])
    {
        
        if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
            [scrollView addSubview:movieView];
            
            videoViewPlayer = NULL;
            
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
            
            
            
            
            //NSString * videoURL = [[NSURL alloc]initFileURLWithPath:__path];
            NSURL *videoURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            
            
            videoViewPlayer = [[AVPlayerViewController alloc] init];
            videoViewPlayer.exitsFullScreenWhenPlaybackEnds = TRUE;
            
            AVAsset *videoAsset = [AVURLAsset assetWithURL:videoURL];

            // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
            AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
            AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
                                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];

            // 3 - Video track
            AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
            [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                                 atTime:kCMTimeZero error:nil];
            
            AVAsset *audioAsset = [AVAsset assetWithURL:videoURL];
            NSError *err;
            //Create mutable composition of audio type
             AVMutableCompositionTrack *audioTrack = [mixComposition    addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
           if([[audioAsset tracksWithMediaType:AVMediaTypeAudio] count]>0)
              [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration)
              ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:&err];
            

            // 4 - Subtitle track
            
            
            if([question valueForKey:@"vtt"] != NULL && [[[question valueForKey:@"vtt"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
            {
                NSString * __str_path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"vtt"]valueForKey:@"text"]];
               NSString * str_file  = [[NSString alloc] initWithFormat:@"%@",[[question valueForKey:@"vtt"]valueForKey:@"text"]];
               if([appDelegate isResourceAvailable:str_file]){
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                       NSString *documentsDirectory = [paths objectAtIndex:0];
                       NSString *file_srt_url = [documentsDirectory stringByAppendingPathComponent:str_file];
                NSURL * _file_srt_url = [[NSURL alloc] initFileURLWithPath:file_srt_url];
                AVURLAsset *subtitleAsset = [AVURLAsset assetWithURL:_file_srt_url];

           
                if([[subtitleAsset tracksWithMediaType:AVMediaTypeText] count]>0)
                [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                                   ofTrack:[[subtitleAsset tracksWithMediaType:AVMediaTypeText] objectAtIndex:0]
                                    atTime:kCMTimeZero error:nil];
               }
          }
            // 5 - Set up player
            AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
            

            videoViewPlayer.showsPlaybackControls = YES;
            videoViewPlayer.player = playVideo;
            //playVideo.
            playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
            //playVideo.closedCaptionDisplayEnabled = YES;
                
            
            
            
            
            
            videoViewPlayer.view.frame = movieView.bounds;
            [movieView addSubview:videoViewPlayer.view];
            [playVideo play];
            
            
            
            
            
            
            
            
            
            
            
            
//            videoViewPlayer = [[AVPlayerViewController alloc] init];
//            videoViewPlayer.showsPlaybackControls = YES;
//            videoViewPlayer.player = playVideo;
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
//
//             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//            playVideo = [[AVPlayer alloc] initWithURL:fileURL];
//            videoViewPlayer.player = playVideo;
//            [videoViewPlayer.player play];
//            NSLog(@"error: %@", playVideo.error);
//            videoViewPlayer.view.frame = movieView.bounds;
//            [movieView addSubview:videoViewPlayer.view];
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 + questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
            }
            else
            {
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height);
            }
            
            
            
        }
        else if([[[question valueForKey:@"video_link"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
            [scrollView addSubview:movieView];
            
            
            
            WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
            webConfig.preferences.javaScriptEnabled = true;
            webConfig.mediaPlaybackRequiresUserAction = true;
            webConfig.allowsInlineMediaPlayback = true;
            //webConfig.mediaTypesRequiringUserActionForPlayback = [];
            
            
            WKWebView * youTube = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width,movieView.frame.size.height) configuration:webConfig];
            youTube.UIDelegate = self;
            youTube.navigationDelegate = self ;
            youTube.scrollView.delegate = self;
            youTube.scrollView.bounces = false;
            youTube.scrollView.bouncesZoom = false;
            youTube.scrollView.bounces = false;
            youTube.scrollView.pinchGestureRecognizer.enabled = FALSE;
            NSString * __path = [[question valueForKey:@"video_link"]valueForKey:@"text"];
            
            
            NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
            
            
            //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\"><iframe src=\"%@\" frameborder=\"0\" playsinline=true></div></body></html>",__path];
            [youTube loadHTMLString:strHtml baseURL:nil];
            [movieView addSubview:youTube];
            
            
            
            
            
//            videoViewPlayer = NULL;
//
//
//
//
//
//
//            //NSString * videoURL = [[NSURL alloc]initFileURLWithPath:__path];
//            NSURL *videoURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//
//
//
//            videoViewPlayer = [[AVPlayerViewController alloc] init];
//            videoViewPlayer.exitsFullScreenWhenPlaybackEnds = TRUE;
//
//            AVAsset *videoAsset = [AVURLAsset assetWithURL:videoURL];
//
//            // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
//            AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
//            AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
//                                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];
//
//            // 3 - Video track
//            AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
//                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
//            [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
//                                ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
//                                 atTime:kCMTimeZero error:nil];
//
//            AVAsset *audioAsset = [AVAsset assetWithURL:videoURL];
//            NSError *err;
//            //Create mutable composition of audio type
//             AVMutableCompositionTrack *audioTrack = [mixComposition    addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
//           if([[audioAsset tracksWithMediaType:AVMediaTypeAudio] count]>0)
//              [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration)
//              ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:&err];
//
//
//            // 4 - Subtitle track
//
//
//            if([question valueForKey:@"vtt"] != NULL && [[[question valueForKey:@"vtt"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//            {
//                NSString * __str_path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"vtt"]valueForKey:@"text"]];
//               NSString * str_file  = [[NSString alloc] initWithFormat:@"%@",[[question valueForKey:@"vtt"]valueForKey:@"text"]];
//               if([appDelegate isResourceAvailable:str_file]){
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//                       NSString *documentsDirectory = [paths objectAtIndex:0];
//                       NSString *file_srt_url = [documentsDirectory stringByAppendingPathComponent:str_file];
//                NSURL * _file_srt_url = [[NSURL alloc] initFileURLWithPath:file_srt_url];
//                AVURLAsset *subtitleAsset = [AVURLAsset assetWithURL:_file_srt_url];
//
//
//                if([[subtitleAsset tracksWithMediaType:AVMediaTypeText] count]>0)
//                [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
//                                   ofTrack:[[subtitleAsset tracksWithMediaType:AVMediaTypeText] objectAtIndex:0]
//                                    atTime:kCMTimeZero error:nil];
//               }
//          }
//            // 5 - Set up player
//            AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
//
//
//            videoViewPlayer.showsPlaybackControls = YES;
//            videoViewPlayer.player = playVideo;
//            //playVideo.
//            playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
//            //playVideo.closedCaptionDisplayEnabled = YES;
//
//
//
//
//
//
//            videoViewPlayer.view.frame = movieView.bounds;
//            [movieView addSubview:videoViewPlayer.view];
//            [playVideo play];
            
            
            
            
            
            
            
            
            
            
            
            
//            videoViewPlayer = [[AVPlayerViewController alloc] init];
//            videoViewPlayer.showsPlaybackControls = YES;
//            videoViewPlayer.player = playVideo;
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
//
//             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//            playVideo = [[AVPlayer alloc] initWithURL:fileURL];
//            videoViewPlayer.player = playVideo;
//            [videoViewPlayer.player play];
//            NSLog(@"error: %@", playVideo.error);
//            videoViewPlayer.view.frame = movieView.bounds;
//            [movieView addSubview:videoViewPlayer.view];
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 + questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
            }
            else
            {
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height);
            }
            
            
            
        }
        else if([[[question valueForKey:@"link_embeded_code"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
            [scrollView addSubview:movieView];
            
            
            WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
            webConfig.preferences.javaScriptEnabled = true;
            webConfig.mediaPlaybackRequiresUserAction = true;
            webConfig.allowsInlineMediaPlayback = true;
            //webConfig.mediaTypesRequiringUserActionForPlayback = [];
            WKWebView * youTube = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, movieView.frame.size.width,movieView.frame.size.height) configuration:webConfig];
            youTube.UIDelegate = self;
            youTube.navigationDelegate = self ;
            youTube.scrollView.delegate = self;
            youTube.scrollView.bounces = false;
            youTube.scrollView.bouncesZoom = false;
            youTube.scrollView.bounces = false;
            
           
            youTube.scrollView.pinchGestureRecognizer.enabled = FALSE;
            NSString * __path = [[question valueForKey:@"link_embeded_code"]valueForKey:@"text"];
            
            NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
            
            //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\">%@</div></body></html>",__path];
            [youTube loadHTMLString:strHtml baseURL:nil];
            [movieView addSubview:youTube];
            
            
            
            
//            videoViewPlayer = NULL;
//
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
//
//
//
//
//            //NSString * videoURL = [[NSURL alloc]initFileURLWithPath:__path];
//            NSURL *videoURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//
//
//
//
//
//            videoViewPlayer = [[AVPlayerViewController alloc] init];
//            videoViewPlayer.exitsFullScreenWhenPlaybackEnds = TRUE;
//
//            AVAsset *videoAsset = [AVURLAsset assetWithURL:videoURL];
//
//            // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
//            AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
//            AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
//                                                                                      preferredTrackID:kCMPersistentTrackID_Invalid];
//
//            // 3 - Video track
//            AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
//                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
//            [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
//                                ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
//                                 atTime:kCMTimeZero error:nil];
//
//            AVAsset *audioAsset = [AVAsset assetWithURL:videoURL];
//            NSError *err;
//            //Create mutable composition of audio type
//             AVMutableCompositionTrack *audioTrack = [mixComposition    addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
//           if([[audioAsset tracksWithMediaType:AVMediaTypeAudio] count]>0)
//              [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero,videoAsset.duration)
//              ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:&err];
//
//
//            // 4 - Subtitle track
//
//
//            if([question valueForKey:@"vtt"] != NULL && [[[question valueForKey:@"vtt"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
//            {
//                NSString * __str_path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"vtt"]valueForKey:@"text"]];
//               NSString * str_file  = [[NSString alloc] initWithFormat:@"%@",[[question valueForKey:@"vtt"]valueForKey:@"text"]];
//               if([appDelegate isResourceAvailable:str_file]){
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//                       NSString *documentsDirectory = [paths objectAtIndex:0];
//                       NSString *file_srt_url = [documentsDirectory stringByAppendingPathComponent:str_file];
//                NSURL * _file_srt_url = [[NSURL alloc] initFileURLWithPath:file_srt_url];
//                AVURLAsset *subtitleAsset = [AVURLAsset assetWithURL:_file_srt_url];
//
//
//                if([[subtitleAsset tracksWithMediaType:AVMediaTypeText] count]>0)
//                [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
//                                   ofTrack:[[subtitleAsset tracksWithMediaType:AVMediaTypeText] objectAtIndex:0]
//                                    atTime:kCMTimeZero error:nil];
//               }
//          }
//            // 5 - Set up player
//            AVPlayer *playVideo = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
//
//
//            videoViewPlayer.showsPlaybackControls = YES;
//            videoViewPlayer.player = playVideo;
//            //playVideo.
//            playVideo.appliesMediaSelectionCriteriaAutomatically = YES;
//            //playVideo.closedCaptionDisplayEnabled = YES;
//
//
//
//
//
//
//            videoViewPlayer.view.frame = movieView.bounds;
//            [movieView addSubview:videoViewPlayer.view];
//            [playVideo play];
            
            
            
            
            
            
            
            
            
            
            
            
//            videoViewPlayer = [[AVPlayerViewController alloc] init];
//            videoViewPlayer.showsPlaybackControls = YES;
//            videoViewPlayer.player = playVideo;
//            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
//
//             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//            playVideo = [[AVPlayer alloc] initWithURL:fileURL];
//            videoViewPlayer.player = playVideo;
//            [videoViewPlayer.player play];
//            NSLog(@"error: %@", playVideo.error);
//            videoViewPlayer.view.frame = movieView.bounds;
//            [movieView addSubview:videoViewPlayer.view];
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 + questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
            }
            else
            {
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height);
            }
            
            
            
        }
        else if([[[question valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1  &&  [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            int local_height = 0;
            int uiVal = [self checkOrder:1];
            
            if(uiVal == 1)
            {
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                scriptbtn.font = TEXTTITLEFONT;
                
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                
                local_height = inputView.frame.size.height/3 + local_height;
                
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, local_height, SCREEN_WIDTH, 40)];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                {
                   [scrollView addSubview:control_view];
                   //[self expertPlayPause:self];
                }
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                
                local_height = 60 + local_height;
                
            }
            else if(uiVal == 2)
            {
                same = [[UIView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,same.frame.size.width,same.frame.size.height)];
                same.backgroundColor = [UIColor clearColor];
                [same addSubview:QuesImg];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                
                
                gasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(openZoomView:)];
                gasture.numberOfTapsRequired =1;
                
                [same addGestureRecognizer:gasture];
                [scrollView addSubview:same];
                local_height = local_height + inputView.frame.size.height/3;
                 
            }
            else if (uiVal == 3)
            {
                
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.font = TEXTTITLEFONT;
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                
                
                
                
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                local_height = inputView.frame.size.height/3 + local_height;
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, local_height, SCREEN_WIDTH, 40)];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                {
                   [scrollView addSubview:control_view];
                   //[self expertPlayPause:self];
                }
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                
                local_height = local_height + 60;
                
                
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = TEXTTITLEFONT;
                instructionView.scrollEnabled = FALSE;
                [scrollView addSubview:instructionView];
                
                NSString* newString = [[[question valueForKey:@"instruction"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                
                NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString1];
                NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                         initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                         documentAttributes: nil
                                                         error: nil
                                                         ];
                instructionView.attributedText = _attributedString;
                int  local_questheight1 = [self cus_heightForText:_attributedString font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
                instructionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, local_questheight1);
                local_height = local_questheight1 + local_height;
                
            }
            else if(uiVal == 5)
            {
                questionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, questheight1);
                local_height = questheight1 + local_height;
            }
            
            
            uiVal = [self checkOrder:2];
            
            if(uiVal == 1)
            {
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                scriptbtn.font = TEXTTITLEFONT;
                
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                local_height = inputView.frame.size.height/3 + local_height;
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, local_height, SCREEN_WIDTH, 40)];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                {
                    [scrollView addSubview:control_view];
                    //[self expertPlayPause:self];
                 }
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                
                local_height = local_height +60;
                
                
                
            }
            else if(uiVal == 2)
            {
                same = [[UIView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,same.frame.size.width,same.frame.size.height)];
                same.backgroundColor = [UIColor clearColor];
                [same addSubview:QuesImg];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                
                
                gasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(openZoomView:)];
                gasture.numberOfTapsRequired =1;
                
                [same addGestureRecognizer:gasture];
                [scrollView addSubview:same];
                local_height = local_height + inputView.frame.size.height/3;
            
            }
            else if (uiVal == 3)
            {
                
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.font = TEXTTITLEFONT;
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                
                
                
                
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                 local_height = inputView.frame.size.height/3 + local_height;
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, 40)];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                {
                   [scrollView addSubview:control_view];
                   //[self expertPlayPause:self];
                }
                
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
               
                local_height = local_height +60;
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = TEXTTITLEFONT;
                instructionView.scrollEnabled = FALSE;
                [scrollView addSubview:instructionView];
                
                NSString* newString = [[[question valueForKey:@"instruction"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                
                NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString1];
                NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                         initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                         documentAttributes: nil
                                                         error: nil
                                                         ];
                instructionView.attributedText = _attributedString;
                int  local_questheight1 = [self cus_heightForText:_attributedString font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
                instructionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, local_questheight1);
                local_height = local_questheight1 + local_height;
                
            }
            else if(uiVal == 5)
            {
                questionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, questheight1);
                local_height = questheight1 + local_height;
            }
            
            uiVal = [self checkOrder:3];
            
            if(uiVal == 1)
            {
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                scriptbtn.font = TEXTTITLEFONT;
                
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                local_height = inputView.frame.size.height/3 + local_height;
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, local_height, SCREEN_WIDTH, 40)];
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                 {
                    [scrollView addSubview:control_view];
                    //[self expertPlayPause:self];
                 }
                
                
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                
                local_height = local_height +60;
                
                
            }
            else if(uiVal == 2)
            {
                same = [[UIView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,same.frame.size.width,same.frame.size.height)];
                same.backgroundColor = [UIColor clearColor];
                [same addSubview:QuesImg];
                NSString *imageFilePath;
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                
                
                gasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(openZoomView:)];
                gasture.numberOfTapsRequired =1;
                
                [same addGestureRecognizer:gasture];
                [scrollView addSubview:same];
                local_height = local_height + inputView.frame.size.height/3;
                
                
                
            }
            else if (uiVal == 3)
            {
                
                scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,local_height, 90, 35)];
                scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
                scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                scriptbtn.textColor = [UIColor whiteColor];
                scriptbtn.font = TEXTTITLEFONT;
                scriptbtn.textAlignment = NSTextAlignmentCenter;
                scriptbtn.text = @"⇧ Transcript";
                [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
                CALayer * _lay1 = [scriptbtnView layer];
                [_lay1 setMasksToBounds:YES];
                [_lay1 setCornerRadius:5.0];
                
                
                
                
                transG =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(showTransTouchClick:)];
                [scriptbtnView addGestureRecognizer:transG];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, local_height,SCREEN_WIDTH,inputView.frame.size.height/3)];
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                local_height = inputView.frame.size.height/3 + local_height;
                
                UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, 40)];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                 [control_view addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15

                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [control_view addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                
                //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [control_view addSubview:audioBtn];
                
                if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                {
                   [scrollView addSubview:control_view];
                   //[self expertPlayPause:self];
                }
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                
                local_height = local_height +60;
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = TEXTTITLEFONT;
                instructionView.scrollEnabled = FALSE;
                [scrollView addSubview:instructionView];
                
                NSString* newString = [[[question valueForKey:@"instruction"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString2 = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
                
                NSString* newString3 = [newString2 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                
                NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString1];
                NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                         initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                         options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                         documentAttributes: nil
                                                         error: nil
                                                         ];
                instructionView.attributedText = _attributedString;
                int  local_questheight1 = [self cus_heightForText:_attributedString font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
                instructionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, local_questheight1);
                local_height = local_questheight1 + local_height;
                
            }
            else if(uiVal == 5)
            {
                questionView.frame = CGRectMake(10,local_height, SCREEN_WIDTH-20, questheight1);
                local_height = local_height + questheight1 ;
            }
    
            questheight1 = local_height ;
            
            scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,questheight1);
        }
        else if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[question valueForKey:@"image"] valueForKey:@"is_filled"]isEqualToString:@"true"] )
        {
            
            
//            audioView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
//            [scrollView addSubview:audioView];
//            audioViewPlayer = NULL;
//            audioViewPlayer = [[AVPlayerViewController alloc] init];
//            audioViewPlayer.showsPlaybackControls = YES;
//
//            NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"audio"]valueForKey:@"text"]];
//
//             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//            audioVideo = [[AVPlayer alloc] initWithURL:fileURL];
//            audioViewPlayer.player = audioVideo;
//            [audioViewPlayer.player play];
//            NSLog(@"error: %@", audioVideo.error);
//            audioViewPlayer.view.frame = audioView.bounds;
//            [audioView addSubview:audioViewPlayer.view];
            
            
            
            
            
            scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,50, 90, 35)];
            scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
            scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            scriptbtn.textColor = [UIColor whiteColor];
            scriptbtn.textAlignment = NSTextAlignmentCenter;
            scriptbtn.text = @"⇧ Transcript";
            scriptbtn.font = TEXTTITLEFONT;
            
            [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            CALayer * _lay1 = [scriptbtnView layer];
            [_lay1 setMasksToBounds:YES];
            [_lay1 setCornerRadius:5.0];
            
            transG = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(showTransTouchClick:)];
            [scriptbtnView addGestureRecognizer:transG];
            
            
            
            
            
            
            QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
            NSString *imageFilePath;
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
            
            imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
            QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:QuesImg];
            
            
            UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, 40)];
            
            
            AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
            AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
            AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
            AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
             [control_view addSubview:AudioTimerLnbl];
            timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
            [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
            [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
            timerProgressAudioView.trackTintColor = [UIColor whiteColor];
            [timerProgressAudioView setProgress:0.0f];  ///15

            [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
            [[timerProgressAudioView layer]setBorderWidth:1];
            [[timerProgressAudioView layer]setMasksToBounds:TRUE];
            timerProgressAudioView.clipsToBounds = YES;
            [control_view addSubview:timerProgressAudioView];
            audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
            
            
            //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
            
            //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
            
            [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
            [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
            [control_view addSubview:audioBtn];
            
            if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
            {
               [scrollView addSubview:control_view];
               //[self expertPlayPause:self];
            }
            
            if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                [scriptbtnView addSubview:scriptbtn];
                [inputView addSubview:scriptbtnView];
            }
            
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3+60, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 +  questheight1;
            questheight1 = questheight1 +60;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,30,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height );
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
                
                
            }
            else
            {
                
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height);
            }
            
            
            
            
            
        }
        else if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
        {
            same = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
            //QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
            QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,same.frame.size.width,same.frame.size.height)];
            same.backgroundColor = [UIColor clearColor];
            [same addSubview:QuesImg];
            NSString *imageFilePath;
            //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
            
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"image"]valueForKey:@"text"]];
            imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            QuesImg.image =[UIImage imageWithContentsOfFile: imageFilePath];
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            
            
            gasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(openZoomView:)];
            gasture.numberOfTapsRequired =1;
            
            [same addGestureRecognizer:gasture];
            [scrollView addSubview:same];
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 +  questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height);
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
            }
            else
            {
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height );
            }
            
            
        }
        else if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[question valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
        {
            
            scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,50, 90, 35)];
            scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
            scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            scriptbtn.textColor = [UIColor whiteColor];
            scriptbtn.font = TEXTTITLEFONT;
            scriptbtn.textAlignment = NSTextAlignmentCenter;
            scriptbtn.text = @"⇧ Transcript";
            [scriptbtnView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
            CALayer * _lay1 = [scriptbtnView layer];
            [_lay1 setMasksToBounds:YES];
            [_lay1 setCornerRadius:5.0];
            
            
            
            
            transG =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(showTransTouchClick:)];
            [scriptbtnView addGestureRecognizer:transG];
            QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
            
            QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
            
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:QuesImg];
            

            
            
            UIView * control_view = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, 40)];
                       
                       
                       AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
                       AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
                       AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                       AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                       AudioTimerLnbl.font = HEADERSECTIONTITLEFONT;
                        [control_view addSubview:AudioTimerLnbl];
                       timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                       timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                       [[timerProgressAudioView layer]setFrame:CGRectMake(60, 17, control_view.frame.size.width-110, 5)];
                       [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                       timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                       [timerProgressAudioView setProgress:0.0f];  ///15

                       [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                       [[timerProgressAudioView layer]setBorderWidth:1];
                       [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                       timerProgressAudioView.clipsToBounds = YES;
                       [control_view addSubview:timerProgressAudioView];
                       audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(control_view.frame.size.width-50, 5, 30, 30)];
                       
                       
                       //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
                       
                       //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
                       
                       [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                       //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                       [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                       [control_view addSubview:audioBtn];
            
                    if([appDelegate isResourceAvailable:[[question valueForKey:@"audio"]valueForKey:@"text"]])
                    {
                       [scrollView addSubview:control_view];
                       //[self expertPlayPause:self];
                    }
            
            
            if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                [scriptbtnView addSubview:scriptbtn];
                [inputView addSubview:scriptbtnView];
            }
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3+60, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 +  questheight1;
            questheight1 =  questheight1 +60;
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1 ,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0,0 , SCREEN_WIDTH, inputView.frame.size.height);
                [scrollView addSubview:popup];
                
                questheight1 =  questheight1 +30;
            }
            else
            {
                
                scrollView.frame = CGRectMake(0,0, SCREEN_WIDTH, inputView.frame.size.height );
            }
            
            
            
            
        }
        else if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[question valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
        {
            quesNo.frame = CGRectMake(1, 2, 20, 25);
            questionView.frame = CGRectMake(10,0, SCREEN_WIDTH-20, questheight1);
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
                [popup addSubview:i_icon];
                UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(shopPopInstruction:)];
                [popup addGestureRecognizer:tapPopup];
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height-2);
                [scrollView addSubview:popup];
                questheight1 = questheight1 +30;
                
            }
            else
            {
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
            }
            
        }
        else
        {
            
            
        }
        
        
        
        
        if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ct"])
        {
            NSArray * ctquestionArr = [[question valueForKey:@"questions"]valueForKey:@"question"];
            NSLog(@"%@",ctquestionArr);
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mttt"])
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"right"] valueForKey:@"option"]];
            
            rightArr = [self randomOptionArr:tmpArray :YES];
            
            leftArr = [[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"left"] valueForKey:@"option"];
            leftTableView = [[UITableView alloc]init];
            leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [scrollView addSubview:leftTableView];
            rightTableView = [[DragAndDropTableView alloc]init];
            rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollView addSubview:rightTableView];
            
            //selectedIndexPath = -1;
            leftTableView.delegate = self;
            leftTableView.dataSource = self;
            
            rightTableView.delegate = self;
            rightTableView.dataSource = self;
            
            rightTableView.scrollEnabled = false;
            leftTableView.scrollEnabled = false;
            //
            [rightTableView setFrame:CGRectMake(scrollView.frame.size.width/2, questheight1, scrollView.frame.size.width/2,scrollView.frame.size.height-questheight1 )];
            
            
            [leftTableView setFrame:CGRectMake(0, questheight1, scrollView.frame.size.width/2, scrollView.frame.size.height-questheight1)];
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+[leftArr count]*100);
            scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,inputView.frame.size.height );
            [self enableQuizBtn];
            
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtti"])
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"right"] valueForKey:@"option"]];
            
            rightArr = [self randomOptionArr:tmpArray:YES];
            
            leftArr = [[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"left"] valueForKey:@"option"];
            leftTableView = [[UITableView alloc]init];
            leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollView addSubview:leftTableView];
            
            
            rightTableView = [[DragAndDropTableView alloc]init];
            rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollView addSubview:rightTableView];
            
            //selectedIndexPath = -1;
            leftTableView.delegate = self;
            leftTableView.dataSource = self;
            
            rightTableView.delegate = self;
            rightTableView.dataSource = self;
            
            rightTableView.scrollEnabled = false;
            leftTableView.scrollEnabled = false;
            [rightTableView setFrame:CGRectMake(scrollView.frame.size.width/2, questheight1, scrollView.frame.size.width/2,scrollView.frame.size.height-questheight1 )];
            
            
            [leftTableView setFrame:CGRectMake(0, questheight1, scrollView.frame.size.width/2, scrollView.frame.size.height-questheight1)];
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+[leftArr count]*100);
            scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,inputView.frame.size.height );
            [self enableQuizBtn];
            
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtii"])
        {
            NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"right"] valueForKey:@"option"]];
            rightArr =[self randomOptionArr:tmpArray:YES];
            
            
            leftArr = [[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"left"] valueForKey:@"option"];
            
            leftTableView = [[UITableView alloc]init];
            leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollView addSubview:leftTableView];
            
            
            rightTableView = [[DragAndDropTableView alloc]init];
            rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [scrollView addSubview:rightTableView];
            
            leftTableView.delegate = self;
            leftTableView.dataSource = self;
            
            rightTableView.delegate = self;
            rightTableView.dataSource = self;
            
            rightTableView.scrollEnabled = false;
            leftTableView.scrollEnabled = false;
            [rightTableView setFrame:CGRectMake(scrollView.frame.size.width/2, questheight1, scrollView.frame.size.width/2,scrollView.frame.size.height-questheight1 )];
            
            
            [leftTableView setFrame:CGRectMake(0, questheight1, scrollView.frame.size.width/2, scrollView.frame.size.height-questheight1)];
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+[leftArr count]*100);
            scrollView.frame = CGRectMake(0, 0, scrollView.frame.size.width,inputView.frame.size.height );
            
            [self enableQuizBtn];
            
            
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mci"])
        {
            
            NSArray * _optArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            NSArray * optArr  = [self randomOptionArr:_optArr:NO];
            
            
            
            NSDictionary * option1Dict = [optArr objectAtIndex:0];
            
            op1 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
            op1.ansObj = option1Dict;
            
            CALayer * _lay1 = [op1 layer];
            [_lay1 setMasksToBounds:YES];
            [_lay1 setCornerRadius:5.0];
            [_lay1 setBorderWidth:1.0];
            [_lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            UIImageView *opi1 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op1.frame.size.width-2, op1.frame.size.height)];
            opi1.contentMode = UIViewContentModeScaleAspectFit;
            [op1 addSubview:opi1];
            
            cirImg = [[UIImageView alloc]initWithFrame:CGRectMake(2, op1.frame.size.height-30, 20, 20)];
            text = [[UILabel alloc]initWithFrame:CGRectMake(0, op1.frame.size.height-40, op1.frame.size.width,40)];
            NSString *imageFilePath;
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option1Dict valueForKey:@"media"] valueForKey:@"text"]];
            imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            [opi1 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            
            [scrollView addSubview:op1];
            text.numberOfLines  =2;
            text.font = TEXTTITLEFONT;
            text.textAlignment = NSTextAlignmentLeft;
            text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            
            text.text = [NSString stringWithFormat:@"       %@",[[option1Dict valueForKey:@"content"] valueForKey:@"text"]];
            
            text.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
            CALayer * lay1 = [text layer];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:2.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            [op1 addSubview:text];
            cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
            [op1 addSubview:cirImg];
            
            
            
            
            op1Touch =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optImageTouchClick:)];
            [op1 addGestureRecognizer:op1Touch];
            
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                
            {
                cirImg.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [op1 layer];
                text.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                text.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                
                // You can even add a border
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
            }
            
            
            
            
            NSDictionary * option2Dict = [optArr objectAtIndex:1];
            op2 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1, (scrollView.frame.size.width/2)-15, 150)];
            op2.ansObj = option2Dict;
             CALayer * _lay2 = [op2 layer];
             [_lay2 setMasksToBounds:YES];
             [_lay2 setCornerRadius:5.0];
             [_lay2 setBorderWidth:1.0];
             [_lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
             UIImageView *opi2 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op2.frame.size.width-2, op2.frame.size.height)];
             opi2.contentMode = UIViewContentModeScaleAspectFit;
             [op2 addSubview:opi2];
             text1 = [[UILabel alloc]initWithFrame:CGRectMake(0, op2.frame.size.height-40, op2.frame.size.width, 40)];
             cirImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op2.frame.size.height-30, 20, 20)];
            
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option2Dict valueForKey:@"media"] valueForKey:@"text"]];
            imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            [opi2 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            [scrollView addSubview:op2];
            text1.numberOfLines  =2;
            text1.font = TEXTTITLEFONT;
            text1.textAlignment = NSTextAlignmentLeft;
            text1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            text1.text = [NSString stringWithFormat:@"       %@",[[option2Dict valueForKey:@"content"] valueForKey:@"text"]];
            
            text1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            CALayer * lay2 = [text1 layer];
            [lay2 setMasksToBounds:YES];
            [lay2 setCornerRadius:1.0];
            [lay2 setBorderWidth:1.0];
            [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            
            [op2 addSubview:text1];
            cirImg1.image = [UIImage imageNamed:@"RadioButton.png"];
            [op2 addSubview:cirImg1];
            
            op1Touch1 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optImageTouchClick1:)];
            [op2 addGestureRecognizer:op1Touch1];
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option2Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                
            {
                cirImg1.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [op2 layer];
                text1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                text1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                
                // You can even add a border
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
            }
            
            
            
            questheight1 = questheight1+170;
            
            
            
            
            
            if([optArr count]>2){
                
                NSDictionary * option3Dict = [optArr objectAtIndex:2];
                op3 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op3.ansObj = option3Dict;
                CALayer * _lay3 = [op3 layer];
                [_lay3 setMasksToBounds:YES];
                [_lay3 setCornerRadius:5.0];
                [_lay3 setBorderWidth:1.0];
                [_lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi3 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op3.frame.size.width-2, op3.frame.size.height)];
                opi3.contentMode = UIViewContentModeScaleAspectFit;
                [op3 addSubview:opi3];
                text2 = [[UILabel alloc]initWithFrame:CGRectMake(0, op3.frame.size.height-40, op3.frame.size.width, 40)];
                cirImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op3.frame.size.height-30, 20, 20)];
                
                
                
                
                //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:2]valueForKey:@"media"] valueForKey:@"text"]];
                
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option3Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                
                [opi3 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                // op3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op3];
                
                
                
                
                text2.numberOfLines  =2;
                text2.font = TEXTTITLEFONT;
                text2.textAlignment = NSTextAlignmentLeft;
                text2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text2.text = [NSString stringWithFormat:@"       %@",[[option3Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                
                text2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay3 = [text2 layer];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:2.0];
                [lay3 setBorderWidth:1.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                [op3 addSubview:text2];
                cirImg2.image = [UIImage imageNamed:@"RadioButton.png"];
                [op3 addSubview:cirImg2];
                
                op1Touch2 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick2:)];
                [op3 addGestureRecognizer:op1Touch2];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option3Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg2.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op3 layer];
                    text2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text2.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
            }
            
            
            
            if([optArr count]>3)
            {
                NSDictionary * option4Dict = [optArr objectAtIndex:3];
                op4 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1,(scrollView.frame.size.width/2)-15, 150)];
                op4.ansObj = option4Dict;
                CALayer * _lay4 = [op4 layer];
                [_lay4 setMasksToBounds:YES];
                [_lay4 setCornerRadius:5.0];
                [_lay4 setBorderWidth:1.0];
                [_lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi4 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op4.frame.size.width-2, op4.frame.size.height)];
                opi4.contentMode = UIViewContentModeScaleAspectFit;
                [op4 addSubview:opi4];
                text3 = [[UILabel alloc]initWithFrame:CGRectMake(0, op4.frame.size.height-40, op4.frame.size.width, 40)];
                cirImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op4.frame.size.height-30, 20, 20)];
                
                // imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:3]valueForKey:@"media"] valueForKey:@"text"]];
                
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option4Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [opi4 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op4];
                
                
                
                
                text3.numberOfLines  =2;
                text3.font = TEXTTITLEFONT;
                text3.textAlignment = NSTextAlignmentLeft;
                text3.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text3.text = [NSString stringWithFormat:@"       %@",[[option4Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text3 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op4 addSubview:text3];
                
                cirImg3.image = [UIImage imageNamed:@"RadioButton.png"];
                [op4 addSubview:cirImg3];
                
                
                
                op1Touch3 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick3:)];
                [op4 addGestureRecognizer:op1Touch3];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option4Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg3.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op4 layer];
                    text3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text3.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                }
                
                questheight1 = questheight1+170;
            }
            
            
            
            
            
            
            if([optArr count]>4){
                
                 NSDictionary * option5Dict = [optArr objectAtIndex:4];
                op5 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op5.ansObj = option5Dict;
                CALayer * _lay5 = [op5 layer];
                [_lay5 setMasksToBounds:YES];
                [_lay5 setCornerRadius:5.0];
                [_lay5 setBorderWidth:1.0];
                [_lay5 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi5 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op5.frame.size.width-2, op5.frame.size.height)];
                opi5.contentMode = UIViewContentModeScaleAspectFit;
                [op5 addSubview:opi5];
                cirImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op5.frame.size.height-30, 20, 20)];
                text4 = [[UILabel alloc]initWithFrame:CGRectMake(0, op5.frame.size.height-40, op5.frame.size.width,40)];
                
                
                
                
                
                //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:4]valueForKey:@"media"] valueForKey:@"text"]];
                
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option5Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                //op4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [opi5 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op5];
                
                
                
                
                text4.numberOfLines  =2;
                text4.font = TEXTTITLEFONT;
                text4.textAlignment = NSTextAlignmentLeft;
                text4.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text4.text = [NSString stringWithFormat:@"       %@",[[option5Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text4 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op5 addSubview:text4];
                
                cirImg4.image = [UIImage imageNamed:@"RadioButton.png"];
                [op5 addSubview:cirImg4];
                
                
                
                op1Touch4 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick4:)];
                [op5 addGestureRecognizer:op1Touch4];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option5Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg4.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op5 layer];
                    text4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text4.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                }
                
                
            }
            
            if([optArr count]>5){
                
                NSDictionary * option6Dict = [optArr objectAtIndex:5];
                
                op6 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op6.ansObj = option6Dict;
                CALayer * _lay6 = [op6 layer];
                [_lay6 setMasksToBounds:YES];
                [_lay6 setCornerRadius:5.0];
                [_lay6 setBorderWidth:1.0];
                [_lay6 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi6 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op6.frame.size.width-2, op6.frame.size.height)];
                opi6.contentMode = UIViewContentModeScaleAspectFit;
                [op6 addSubview:opi6];
                text5 = [[UILabel alloc]initWithFrame:CGRectMake(0, op6.frame.size.height-40, op6.frame.size.width, 40)];
                cirImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op6.frame.size.height-30, 20, 20)];
                
                [scrollView addSubview:op6];
                
                
                //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:5]valueForKey:@"media"] valueForKey:@"text"]];
                
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option6Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                //op4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [opi6 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op6];
                
                
                
                
                text5.numberOfLines  =2;
                text5.font = TEXTTITLEFONT;
                text5.textAlignment = NSTextAlignmentLeft;
                text5.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text5.text = [NSString stringWithFormat:@"       %@",[[option6Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text5 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op6 addSubview:text5];
                
                cirImg5.image = [UIImage imageNamed:@"RadioButton.png"];
                [op6 addSubview:cirImg5];
                
                
                
                op1Touch5 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick5:)];
                [op6 addGestureRecognizer:op1Touch5];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option6Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg5.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op6 layer];
                    text5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text5.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                }
                
                questheight1 = questheight1+170;
            }
            
            
            
            
            
            if([optArr count]>6){
                
                NSDictionary * option7Dict = [optArr objectAtIndex:6];
                
                op7 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op7.ansObj = option7Dict;
                
                CALayer * _lay7 = [op7 layer];
                [_lay7 setMasksToBounds:YES];
                [_lay7 setCornerRadius:5.0];
                [_lay7 setBorderWidth:1.0];
                [_lay7 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi7 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op3.frame.size.width-2, op3.frame.size.height)];
                opi7.contentMode = UIViewContentModeScaleAspectFit;
                [op7 addSubview:opi7];
                text6 = [[UILabel alloc]initWithFrame:CGRectMake(0, op7.frame.size.height-25, op7.frame.size.width, 40)];
                cirImg6 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op7.frame.size.height-30, 20, 20)];
                
                
                
                
                //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:6]valueForKey:@"media"] valueForKey:@"text"]];
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option7Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [opi7 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op7];
                
                
                
                
                text6.numberOfLines  =2;
                text6.font = TEXTTITLEFONT;
                text6.textAlignment = NSTextAlignmentLeft;
                text6.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text6.text = [NSString stringWithFormat:@"       %@",[[option7Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text6 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op7 addSubview:text6];
                
                cirImg6.image = [UIImage imageNamed:@"RadioButton.png"];
                [op7 addSubview:cirImg6];
                
                
                
                op1Touch6 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick6:)];
                [op7 addGestureRecognizer:op1Touch6];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option7Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg6.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op7 layer];
                    text6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text6.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                }
                
                
            }
            
            if([optArr count]>7){
                
                NSDictionary * option8Dict = [optArr objectAtIndex:7];
                
                op8 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1,(scrollView.frame.size.width/2)-15, 150)];
                op8.ansObj = option8Dict;
                CALayer * _lay8 = [op8 layer];
                [_lay8 setMasksToBounds:YES];
                [_lay8 setCornerRadius:5.0];
                [_lay8 setBorderWidth:1.0];
                [_lay8 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                UIImageView *opi8 = [[UIImageView alloc]initWithFrame:CGRectMake(1, 1, op4.frame.size.width-2, op4.frame.size.height)];
                opi8.contentMode = UIViewContentModeScaleAspectFit;
                [op8 addSubview:opi8];
                text7 = [[UILabel alloc]initWithFrame:CGRectMake(0, op8.frame.size.height-25, op8.frame.size.width, 40)];
                cirImg7 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op8.frame.size.height-30, 20, 20)];
                
                //imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[optArr objectAtIndex:7]valueForKey:@"media"] valueForKey:@"text"]];
                NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[option8Dict valueForKey:@"media"] valueForKey:@"text"]];
                imageFilePath =  [__path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                
                //op4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [opi8 setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
                [scrollView addSubview:op8];
                
                
                
                
                text7.numberOfLines  =2;
                text7.font = TEXTTITLEFONT;
                text7.textAlignment = NSTextAlignmentLeft;
                text7.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text7.text = [NSString stringWithFormat:@"       %@",[[option8Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text7 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op8 addSubview:text7];
                
                cirImg7.image = [UIImage imageNamed:@"RadioButton.png"];
                [op8 addSubview:cirImg7];
                
                
                
                op1Touch7 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optImageTouchClick7:)];
                [op8 addGestureRecognizer:op1Touch7];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option8Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    cirImg7.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op8 layer];
                    text7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text7.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                }
                
                questheight1 = questheight1 +170;
            }
            
            
            
            
            
            
            
            
            if([optArr count] > 7 && [[[ [optArr objectAtIndex:7] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op8.tag = 1000;
                text7.tag = 1001;
                cirImg7.tag =1002;
            }
            if([optArr count] > 6 && [[[ [optArr objectAtIndex:6] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op7.tag = 1000;
                text6.tag = 1001;
                cirImg6.tag =1002;
            }
            if([optArr count] > 5 && [[[ [optArr objectAtIndex:5] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op6.tag = 1000;
                text5.tag = 1001;
                cirImg5.tag =1002;
            }
            if([optArr count] > 4 && [[[ [optArr objectAtIndex:4] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op5.tag = 1000;
                text4.tag = 1001;
                cirImg4.tag =1002;
            }
            if([optArr count] > 3 && [[[ [optArr objectAtIndex:3] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op4.tag = 1000;
                text3.tag = 1001;
                cirImg3.tag =1002;
            }
            if([optArr count] > 2 && [[[ [optArr objectAtIndex:2] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op3.tag = 1000;
                text2.tag = 1001;
                cirImg2.tag =1002;
            }
            if([optArr count] > 1 && [[[ [optArr objectAtIndex:1] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op2.tag = 1000;
                text1.tag = 1001;
                cirImg1.tag =1002;
            }
            if([optArr count] > 0 && [[[ [optArr objectAtIndex:0] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op1.tag = 1000;
                text.tag = 1001;
                cirImg.tag =1002;
            }
            if([optArr count] % 2 == 0)
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            else
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+170);
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mca"])
        {
          
            NSArray * _optArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            NSArray * optArr  = [self randomOptionArr:_optArr:NO];
            
            NSDictionary * option1Dict = [optArr objectAtIndex:0];
            
            op1 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
            op1.ansObj = option1Dict;
            
            CALayer * _lay1 = [op1 layer];
            [_lay1 setMasksToBounds:YES];
            [_lay1 setCornerRadius:5.0];
            [_lay1 setBorderWidth:1.0];
            [_lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            opa1 = [[UIButton alloc]initWithFrame:CGRectMake(op1.frame.size.width/2 -25, op1.frame.size.height/2 - 25, 50, 50)];
            [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
            [opa1 addTarget:self action:@selector(option1AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
            [op1 addSubview:opa1];
            
            
            
            cirImg = [[UIImageView alloc]initWithFrame:CGRectMake(2, op1.frame.size.height-35, 20, 20)];
            cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
            [scrollView addSubview:op1];
            
            text = [[UILabel alloc]initWithFrame:CGRectMake(2, op1.frame.size.height-40, op1.frame.size.width-4,40)];
            text.numberOfLines =0;
            text.lineBreakMode = NSLineBreakByTruncatingMiddle;
            
            text.font = TEXTTITLEFONT;
            text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            text.textAlignment = NSTextAlignmentLeft;
            text.text = [NSString stringWithFormat:@"      %@",[[option1Dict valueForKey:@"content"] valueForKey:@"text"]];
            
            text.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
            CALayer * lay1 = [text layer];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:2.0];
            
            // You can even add a border
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            
            
            [op1 addSubview:text];
            [op1 addSubview:cirImg];
            
            
            
            
            op1Touch =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optAudioTouchClick:)];
            [op1 addGestureRecognizer:op1Touch];
            
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                
            {
                cirImg.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [op1 layer];
                text.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                text.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                
                // You can even add a border
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            
            
            
            
            
            
            
            
            NSDictionary * option2Dict = [optArr objectAtIndex:1];
            
            op2 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1, (scrollView.frame.size.width/2)-15, 150)];
            op2.ansObj = option2Dict;
            
            CALayer * _lay2 = [op2 layer];
            [_lay2 setMasksToBounds:YES];
            [_lay2 setCornerRadius:5.0];
            [_lay2 setBorderWidth:1.0];
            [_lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            opa2 = [[UIButton alloc]initWithFrame:CGRectMake(op2.frame.size.width/2 -25, op2.frame.size.height/2 - 25, 50, 50)];
            [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
            [opa2 addTarget:self action:@selector(option2AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
            [op2 addSubview:opa2];
            text1 = [[UILabel alloc]initWithFrame:CGRectMake(2, op2.frame.size.height-40, op2.frame.size.width-4, 40)];
            cirImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op2.frame.size.height-35, 20, 20)];
            [scrollView addSubview:op2];
            text1.numberOfLines  =0;
            text1.lineBreakMode = NSLineBreakByTruncatingMiddle;
            text1.font = TEXTTITLEFONT;
            text1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            text1.textAlignment = NSTextAlignmentLeft;
            text1.text = [NSString stringWithFormat:@"      %@",[[option2Dict valueForKey:@"content"] valueForKey:@"text"]];
            
            text1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            CALayer * lay2 = [text1 layer];
            [lay2 setMasksToBounds:YES];
            [lay2 setCornerRadius:1.0];
            [lay2 setBorderWidth:1.0];
            [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
            
            [op2 addSubview:text1];
            
            
            cirImg1.image = [UIImage imageNamed:@"RadioButton.png"];
            [op2 addSubview:cirImg1];
            
            op1Touch1 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optAudioTouchClick1:)];
            [op2 addGestureRecognizer:op1Touch1];
            
            
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option2Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                
            {
                
                cirImg1.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                CALayer * lay3 = [op2 layer];
                text1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                text1.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:5.0];
                
                // You can even add a border
                [lay3 setBorderWidth:2.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                
                
            }
            
            
            questheight1 = questheight1 +170;
            
            
            
            
            
            // op3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            
            if([optArr count]>2){
                
                NSDictionary * option3Dict = [optArr objectAtIndex:2];
                op3 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op3.ansObj = option3Dict;
                CALayer * _lay3 = [op3 layer];
                [_lay3 setMasksToBounds:YES];
                [_lay3 setCornerRadius:5.0];
                [_lay3 setBorderWidth:1.0];
                [_lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa3 = [[UIButton alloc]initWithFrame:CGRectMake(op3.frame.size.width/2 -25, op3.frame.size.height/2 - 25, 50, 50)];
                [opa3 addTarget:self action:@selector(option3AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op3 addSubview:opa3];
                text2 = [[UILabel alloc]initWithFrame:CGRectMake(2, op3.frame.size.height-40, op3.frame.size.width-4, 40)];
                cirImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op3.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op3];
                text2.numberOfLines  =0;
                text2.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text2.font = TEXTTITLEFONT;
                text2.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text2.textAlignment = NSTextAlignmentLeft;
                text2.text = [NSString stringWithFormat:@"      %@",[[option3Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                
                
                text2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay3 = [text2 layer];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:2.0];
                
                // You can even add a border
                [lay3 setBorderWidth:1.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                [op3 addSubview:text2];
                
                
                cirImg2.image = [UIImage imageNamed:@"RadioButton.png"];
                [op3 addSubview:cirImg2];
                
                op1Touch2 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick2:)];
                [op3 addGestureRecognizer:op1Touch2];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option3Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg2.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op3 layer];
                    text2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text2.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
            if([optArr count]>3)
            {
                NSDictionary * option4Dict = [optArr objectAtIndex:3];
                op4 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1,(scrollView.frame.size.width/2)-15, 150)];
                op4.ansObj = option4Dict;
                
                CALayer * _lay4 = [op4 layer];
                [_lay4 setMasksToBounds:YES];
                [_lay4 setCornerRadius:5.0];
                [_lay4 setBorderWidth:1.0];
                [_lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa4 = [[UIButton alloc]initWithFrame:CGRectMake(op4.frame.size.width/2 -25, op4.frame.size.height/2 - 25, 50, 50)];
                [opa4 addTarget:self action:@selector(option4AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op4 addSubview:opa4];
                text3 = [[UILabel alloc]initWithFrame:CGRectMake(2, op4.frame.size.height-40, op4.frame.size.width-4, 40)];
                cirImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op4.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op4];
                
                cirImg3.image = [UIImage imageNamed:@"RadioButton.png"];
                
                
                
                text3.numberOfLines  =0;
                text3.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text3.font = TEXTTITLEFONT;
                text3.textAlignment = NSTextAlignmentLeft;
                text3.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text3.text = [NSString stringWithFormat:@"      %@",[[option4Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text3 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op4 addSubview:text3];
                [op4 addSubview:cirImg3];
                op1Touch3 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick3:)];
                [op4 addGestureRecognizer:op1Touch3];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option4Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg3.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op4 layer];
                    text3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text3.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
                questheight1 = questheight1 +170;
            }
            
            
            if([optArr count]>4)
            {
                NSDictionary * option5Dict = [optArr objectAtIndex:4];
                
                op5 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op5.ansObj = option5Dict;
                
                CALayer * _lay3 = [op5 layer];
                [_lay3 setMasksToBounds:YES];
                [_lay3 setCornerRadius:5.0];
                [_lay3 setBorderWidth:1.0];
                [_lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa5 = [[UIButton alloc]initWithFrame:CGRectMake(op5.frame.size.width/2 -25, op5.frame.size.height/2 - 25, 50, 50)];
                [opa5 addTarget:self action:@selector(option5AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa5 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op5 addSubview:opa5];
                text4 = [[UILabel alloc]initWithFrame:CGRectMake(2, op5.frame.size.height-40, op5.frame.size.width-4, 40)];
                cirImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op5.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op5];
                text4.numberOfLines  =0;
                text4.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text4.font = TEXTTITLEFONT;
                text4.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text4.textAlignment = NSTextAlignmentLeft;
                text4.text = [NSString stringWithFormat:@"      %@",[[option5Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay3 = [text4 layer];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:2.0];
                
                // You can even add a border
                [lay3 setBorderWidth:1.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                [op5 addSubview:text4];
                
                
                cirImg4.image = [UIImage imageNamed:@"RadioButton.png"];
                [op5 addSubview:cirImg4];
                
                op1Touch4 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick4:)];
                [op5 addGestureRecognizer:op1Touch4];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option5Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg4.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op5 layer];
                    text4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text4.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
            if([optArr count]>5){
                
                 NSDictionary * option6Dict = [optArr objectAtIndex:5];
                op6 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1,(scrollView.frame.size.width/2)-15, 150)];
                op6.ansObj = option6Dict;
                
                CALayer * _lay4 = [op6 layer];
                [_lay4 setMasksToBounds:YES];
                [_lay4 setCornerRadius:5.0];
                [_lay4 setBorderWidth:1.0];
                [_lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa6 = [[UIButton alloc]initWithFrame:CGRectMake(op6.frame.size.width/2 -25, op6.frame.size.height/2 - 25, 50, 50)];
                [opa6 addTarget:self action:@selector(option6AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa6 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op6 addSubview:opa6];
                text5 = [[UILabel alloc]initWithFrame:CGRectMake(2, op6.frame.size.height-40, op6.frame.size.width-4, 40)];
                cirImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op6.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op6];
                
                cirImg5.image = [UIImage imageNamed:@"RadioButton.png"];
                
                
                
                text5.numberOfLines  =0;
                text5.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text5.font = TEXTTITLEFONT;
                text5.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text5.textAlignment = NSTextAlignmentLeft;
                text5.text = [NSString stringWithFormat:@"      %@",[[option6Dict valueForKey:@"content"] valueForKey:@"text"]];
               
                text5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text5 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op6 addSubview:text5];
                [op6 addSubview:cirImg5];
                op1Touch5 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick5:)];
                [op6 addGestureRecognizer:op1Touch5];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option6Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg5.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op6 layer];
                    text5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text5.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                questheight1 = questheight1 +170;
                
            }
            
            
            
            if([optArr count]>6){
                
                NSDictionary * option7Dict = [optArr objectAtIndex:6];
                op7 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, (scrollView.frame.size.width/2)-15, 150)];
                op7.ansObj = option7Dict;
                
                CALayer * _lay3 = [op7 layer];
                [_lay3 setMasksToBounds:YES];
                [_lay3 setCornerRadius:5.0];
                [_lay3 setBorderWidth:1.0];
                [_lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa7 = [[UIButton alloc]initWithFrame:CGRectMake(op7.frame.size.width/2 -25, op7.frame.size.height/2 - 25, 50, 50)];
                [opa7 addTarget:self action:@selector(option7AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa7 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op7 addSubview:opa7];
                text6 = [[UILabel alloc]initWithFrame:CGRectMake(2, op7.frame.size.height-40, op7.frame.size.width-4, 40)];
                cirImg6 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op7.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op7];
                text6.numberOfLines  =0;
                text6.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text6.font = TEXTTITLEFONT;
                text6.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text6.textAlignment = NSTextAlignmentLeft;
                text6.text = [NSString stringWithFormat:@"     %@",[[option7Dict valueForKey:@"content"] valueForKey:@"text"]];
               
                text6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay3 = [text6 layer];
                [lay3 setMasksToBounds:YES];
                [lay3 setCornerRadius:2.0];
                
                // You can even add a border
                [lay3 setBorderWidth:1.0];
                [lay3 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                [op7 addSubview:text6];
                
                
                cirImg6.image = [UIImage imageNamed:@"RadioButton.png"];
                [op7 addSubview:cirImg6];
                
                op1Touch6 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick6:)];
                [op7 addGestureRecognizer:op1Touch6];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option7Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg6.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op7 layer];
                    text6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text6.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
            if([optArr count]>7){
                
                NSDictionary * option8Dict = [optArr objectAtIndex:7];
                
                op8 =[[CustomUIView alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/2)+5, questheight1,(scrollView.frame.size.width/2)-15, 130)];
                op8.ansObj = option8Dict;
                CALayer * _lay4 = [op8 layer];
                [_lay4 setMasksToBounds:YES];
                [_lay4 setCornerRadius:5.0];
                [_lay4 setBorderWidth:1.0];
                [_lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                opa8 = [[UIButton alloc]initWithFrame:CGRectMake(op8.frame.size.width/2 -25, op8.frame.size.height/2 - 25, 50, 50)];
                [opa8 addTarget:self action:@selector(option8AudioPlay:) forControlEvents:UIControlEventTouchUpInside];
                [opa8 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
                [op8 addSubview:opa8];
                text7 = [[UILabel alloc]initWithFrame:CGRectMake(2, op8.frame.size.height-40, op8.frame.size.width-4, 40)];
                cirImg7 = [[UIImageView alloc]initWithFrame:CGRectMake(2, op8.frame.size.height-35, 20, 20)];
                [scrollView addSubview:op8];
                
                cirImg7.image = [UIImage imageNamed:@"RadioButton.png"];
                
                
                
                text7.numberOfLines  =0;
                text7.lineBreakMode = NSLineBreakByTruncatingMiddle;
                text7.font = TEXTTITLEFONT;
                text7.textAlignment = NSTextAlignmentLeft;
                text7.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                text7.text = [NSString stringWithFormat:@"     %@",[[option8Dict valueForKey:@"content"] valueForKey:@"text"]];
                
                text7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                CALayer * lay4 = [text7 layer];
                [lay4 setMasksToBounds:YES];
                [lay4 setCornerRadius:2.0];
                
                // You can even add a border
                [lay4 setBorderWidth:1.0];
                [lay4 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
                
                
                
                [op8 addSubview:text7];
                [op8 addSubview:cirImg7];
                op1Touch7 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optAudioTouchClick7:)];
                [op8 addGestureRecognizer:op1Touch7];
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option8Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                    
                {
                    
                    cirImg7.image = [UIImage imageNamed:@"Sel_RadioButton.png"];
                    CALayer * lay3 = [op8 layer];
                    text7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0];
                    text7.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:5.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:2.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    
                    
                }
                
                questheight1 = questheight1 +170;
            }
            
            if([optArr count] > 7 && [[[ [optArr objectAtIndex:7] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op8.tag = 1000;
                text7.tag = 1001;
                cirImg7.tag =1002;
            }
            if([optArr count] > 6 && [[[ [optArr objectAtIndex:6] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op7.tag = 1000;
                text6.tag = 1001;
                cirImg6.tag =1002;
            }
            if([optArr count] > 5 && [[[ [optArr objectAtIndex:5] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op6.tag = 1000;
                text5.tag = 1001;
                cirImg5.tag =1002;
            }
            if([optArr count] > 4 && [[[ [optArr objectAtIndex:4] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op5.tag = 1000;
                text4.tag = 1001;
                cirImg4.tag =1002;
            }
            if([optArr count] > 3 && [[[ [optArr objectAtIndex:3] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op4.tag = 1000;
                text3.tag = 1001;
                cirImg3.tag =1002;
            }
            if([optArr count] > 2 && [[[ [optArr objectAtIndex:2] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op3.tag = 1000;
                text2.tag = 1001;
                cirImg2.tag =1002;
            }
            if([optArr count] > 1 && [[[ [optArr objectAtIndex:1] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op2.tag = 1000;
                text1.tag = 1001;
                cirImg1.tag =1002;
            }
            if([optArr count] > 0 && [[[ [optArr objectAtIndex:0] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op1.tag = 1000;
                text.tag = 1001;
                cirImg.tag =1002;
            }
            
            
            if([optArr count] % 2 == 0)
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            else
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+170);
        }
        
        else if( [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mc"])
        {

            //            mcView = [[mc_AssessmentTemplate alloc]initWithFrame:CGRectMake(0,questheight1,scrollView.frame.size.width,0)];
            //            mcView.userInteractionEnabled = TRUE;
            //            [mcView Create_MCUIWithData:question :obj :scrollView :self :FALSE];
            //            mcView.frame = CGRectMake(0,questheight1,scrollView.frame.size.width,fbView.viewHeight);
            //            [scrollView addSubview:mcView];
            //            questheight1 = questheight1+mcView.viewHeight;
            //            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            //
            
            NSArray * _optArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            NSArray * optArr  = [self randomOptionArr:_optArr:NO];
            
           
            
            
            //  firsr Option
            if([optArr count]>0){
            NSDictionary * option1Dict = [optArr objectAtIndex:0];
            
            op1 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
            op1.ansObj = option1Dict;
            [scrollView addSubview:op1];
            
            cirImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
            cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
            [op1 addSubview:cirImg];
            
            
            
            textView = [self createUILabelMCMMC:[[option1Dict valueForKey:@"content"] valueForKey:@"text"]];
            op1.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView.frame.size.height);
            textView.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            [op1 addSubview:textView];
            

            
             
            
           
            op1Touch = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(optTouchClick:)];
            [op1 addGestureRecognizer:op1Touch];
            
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
            {
                cirImg.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                textView.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                CALayer * lay1 = [textView layer];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            questheight1 = questheight1 +  textView.frame.size.height +10;
        }
            
            
            
             
            
            
            if([optArr count]>1){
           
            NSDictionary * option2Dict = [optArr objectAtIndex:1];
            op2 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
            op2.ansObj = option2Dict;
            [scrollView addSubview:op2];
            
            cirImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
            cirImg1.image = [UIImage imageNamed:@"RadioButton.png"];
            [op2 addSubview:cirImg1];
            
            
                
            textView1 = [self createUILabelMCMMC:[[option2Dict valueForKey:@"content"] valueForKey:@"text"]];
            textView1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            [op2 addSubview:textView1];
            op2.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView1.frame.size.height);
            
            op1Touch1 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optTouchClick1:)];
            [op2 addGestureRecognizer:op1Touch1];
            
            
            if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option2Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
            {
                
                cirImg1.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                CALayer * lay2 = [textView1 layer];
                textView1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            questheight1 = questheight1+textView1.frame.size.height+10;
        }
            
            
            
            if([optArr count]>2){
                NSDictionary * option3Dict = [optArr objectAtIndex:2];
                
                op3 =[[CustomUIView alloc]initWithFrame:CGRectMake(10,questheight1, SCREEN_WIDTH-20, 0)];
                op3.ansObj = option3Dict;
                [scrollView addSubview:op3];
                
                cirImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg2.image = [UIImage imageNamed:@"RadioButton.png"];
                [op3 addSubview:cirImg2];
                
                
                textView2 = [self createUILabelMCMMC:[[option3Dict valueForKey:@"content"] valueForKey:@"text"]];
                op3.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView2.frame.size.height);
                textView2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op3 addSubview:textView2];
                
            
                op1Touch2 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick2:)];
                [op3 addGestureRecognizer:op1Touch2];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option3Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    
                    
                    cirImg2.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay3 = [textView2 layer];
                    textView2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                questheight1 = questheight1+textView2.frame.size.height+10;
            }
            
            
            
            
            
            
            
            if([optArr  count]>3){
                NSDictionary * option4Dict = [optArr objectAtIndex:3];

                op4 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op4.ansObj = option4Dict;
                [scrollView addSubview:op4];
                cirImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg3.image = [UIImage imageNamed:@"RadioButton.png"];
                
                [op4 addSubview:cirImg3];
                
                
                textView3 = [self createUILabelMCMMC:[[option4Dict valueForKey:@"content"] valueForKey:@"text"]];
                op4.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView3.frame.size.height);
                
                textView3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op4 addSubview:textView3];
                
                
                op1Touch3 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick3:)];
                [op4 addGestureRecognizer:op1Touch3];
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option4Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    
                    cirImg3.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay4 = [textView3 layer];
                    textView3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setMasksToBounds:YES];
                    [lay4 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay4 setBorderWidth:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                questheight1 = questheight1+textView3.frame.size.height+10;
            }
            
            
            
            
            if([optArr  count] >4){
                NSDictionary * option5Dict = [optArr objectAtIndex:4];
                op5 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op5.ansObj = option5Dict;
                [scrollView addSubview:op5];
                cirImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg4.image = [UIImage imageNamed:@"RadioButton.png"];
                [op5 addSubview:cirImg4];
                
                textView4 = [self createUILabelMCMMC:[[option5Dict valueForKey:@"content"] valueForKey:@"text"]];
                op5.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView4.frame.size.height);
                
                
                textView4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op5 addSubview:textView4];
                
            
                op1Touch4 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick4:)];
                [op5 addGestureRecognizer:op1Touch4];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option5Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    
                    cirImg4.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay4 = [textView4 layer];
                    textView4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                questheight1 = questheight1+textView4.frame.size.height+10;
            }
            
            
            
            
            
            if([optArr  count] >5){
                NSDictionary * option6Dict = [optArr objectAtIndex:5];
            
                op6 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op6.ansObj = option6Dict;
                [scrollView addSubview:op6];
                cirImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg5.image = [UIImage imageNamed:@"RadioButton.png"];
                [op6 addSubview:cirImg5];
                
                textView5 = [self createUILabelMCMMC:[[option6Dict valueForKey:@"content"] valueForKey:@"text"]];
                op6.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView5.frame.size.height);
                
                
                textView5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op6 addSubview:textView5];
                
                
                
                op1Touch5 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick5:)];
                [op6 addGestureRecognizer:op1Touch5];
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option6Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    cirImg5.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay4 = [textView5 layer];
                    textView5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                questheight1 = questheight1+textView5.frame.size.height+10;
            }
            
            
            
            
            if([optArr  count] >6){
                
                NSDictionary * option7Dict = [optArr objectAtIndex:6];
                
                op7 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op6.ansObj = option7Dict;
                [scrollView addSubview:op7];
                cirImg6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg6.image = [UIImage imageNamed:@"RadioButton.png"];
                [op7 addSubview:cirImg6];
                
                
                textView6 = [self createUILabelMCMMC:[[option7Dict valueForKey:@"content"] valueForKey:@"text"]];
                op7.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView6.frame.size.height);
                
                
                textView6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op7 addSubview:textView6];
                
               
                
                op1Touch6 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick6:)];
                [op7 addGestureRecognizer:op1Touch6];
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option7Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    
                    cirImg6.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay4 = [textView6 layer];
                    textView6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                questheight1 = questheight1+textView6.frame.size.height+10;
            }
            
            
            
            
            
            
            if([optArr  count] >7){
                NSDictionary * option8Dict = [optArr objectAtIndex:6];
                
                
                op8 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op6.ansObj = option8Dict;
                [scrollView addSubview:op8];
                cirImg7 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg7.image = [UIImage imageNamed:@"RadioButton.png"];
                
                
                
                [op8 addSubview:cirImg7];
                
                
                textView7 = [self createUILabelMCMMC:[[option8Dict valueForKey:@"content"] valueForKey:@"text"]];
                op8.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView7.frame.size.height);
                
                textView7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op8 addSubview:textView7];
                
                op1Touch7 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optTouchClick7:)];
                [op8 addGestureRecognizer:op1Touch7];
                
                
                
                
                if([globalTrackQuizObj valueForKey:@"ansObj"] != NULL && [[option8Dict valueForKey:@"uniqid"]isEqualToString:[[globalTrackQuizObj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
                {
                    cirImg7.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
                    CALayer * lay4 = [textView7 layer];
                    textView7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                questheight1 = questheight1+textView7.frame.size.height+10;
            }
            
            
            
            
            if([optArr count] > 7 && [[[ [optArr objectAtIndex:7] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op8.tag = 1000;
                textView7.tag = 1001;
                cirImg7.tag =1002;
            }
            if([optArr count] > 6 && [[[ [optArr objectAtIndex:6] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op7.tag = 1000;
                textView6.tag = 1001;
                cirImg6.tag =1002;
            }
            if([optArr count] > 5 && [[[ [optArr objectAtIndex:5] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op6.tag = 1000;
                textView5.tag = 1001;
                cirImg5.tag =1002;
            }
            if([optArr count] > 4 && [[[ [optArr objectAtIndex:4] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op5.tag = 1000;
                textView4.tag = 1001;
                cirImg4.tag =1002;
            }
            if([optArr count] > 3 && [[[ [optArr objectAtIndex:3] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op4.tag = 1000;
                textView3.tag = 1001;
                cirImg3.tag =1002;
            }
            if([optArr count] > 2 && [[[ [optArr objectAtIndex:2] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op3.tag = 1000;
                textView2.tag = 1001;
                cirImg2.tag =1002;
            }
            if([optArr count] > 1 && [[[ [optArr objectAtIndex:1] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op2.tag = 1000;
                textView1.tag = 1001;
                cirImg1.tag =1002;
            }
            if([optArr count] > 0 && [[[ [optArr objectAtIndex:0] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op1.tag = 1000;
                textView.tag = 1001;
                cirImg.tag =1002;
            }
            
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mmc"])
        {
            
            NSArray * _optArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            NSArray * optArr  = [self randomOptionArr:_optArr:NO];
            
            
            
            
            NSDictionary * option1Dict = [optArr objectAtIndex:0];
            
            op1 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
            op1.ansObj = option1Dict;
            [scrollView addSubview:op1];
            
            cirImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
            cirImg.image = [UIImage imageNamed:@"TikButton-blank.png"];
            [op1 addSubview:cirImg];
            
            
            
            textView = [self createUILabelMCMMC:[[option1Dict valueForKey:@"content"] valueForKey:@"text"]];
            op1.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView.frame.size.height);
            textView.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            [op1 addSubview:textView];
            
            
            
            op1Touch =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optMTouchClick:)];
            [op1 addGestureRecognizer:op1Touch];
            
            if([self matchMMCoptionWithAnswer:option1Dict :globalTrackQuizObj])
            {
                cirImg.image = [UIImage imageNamed:@"TikButton.png"];
                CALayer * lay1 = [textView layer];
                textView.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                
                // You can even add a border
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            questheight1 = questheight1 + textView.frame.size.height + 10;
            
            
            
            
            
            
            
            NSDictionary * option2Dict = [optArr objectAtIndex:1];
            op2 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
            op2.ansObj = option2Dict;
            [scrollView addSubview:op2];
            
            cirImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
            cirImg1.image = [UIImage imageNamed:@"TikButton-blank.png"];
            [op2 addSubview:cirImg1];
            
            textView1 = [self createUILabelMCMMC:[[option2Dict valueForKey:@"content"] valueForKey:@"text"]];
            op2.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView1.frame.size.height);
            
            textView1.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            
            [op2 addSubview:textView1];
            
            
            op1Touch1 =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(optMTouchClick1:)];
            [op2 addGestureRecognizer:op1Touch1];
            
            
            
            
            if([self matchMMCoptionWithAnswer:option2Dict :globalTrackQuizObj])
            {
                
                cirImg1.image = [UIImage imageNamed:@"TikButton.png"];
                CALayer * lay2 = [textView1 layer];
                textView1.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                [lay2 setMasksToBounds:YES];
                [lay2 setCornerRadius:20.0];
                
                // You can even add a border
                [lay2 setBorderWidth:1.0];
                [lay2 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            }
            
            
            questheight1 = questheight1 + textView1.frame.size.height + 10;
            
            //op3.backgroundColor = [UIColor redColor];
            
            if([optArr count]>2){
                
                
                NSDictionary * option3Dict = [optArr objectAtIndex:2];
                
                
                
                op3 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op3.ansObj = option3Dict;
                [scrollView addSubview:op3];
                
                cirImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg2.image = [UIImage imageNamed:@"TikButton-blank.png"];
                [op3 addSubview:cirImg2];
                
                textView2 = [self createUILabelMCMMC:[[option3Dict valueForKey:@"content"] valueForKey:@"text"]];
                op3.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView2.frame.size.height);
                textView2.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op3 addSubview:textView2];
                
                
                op1Touch2 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick2:)];
                [op3 addGestureRecognizer:op1Touch2];
                
                if([self matchMMCoptionWithAnswer:option3Dict :globalTrackQuizObj])
                {
                    
                    cirImg2.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay3 = [textView2 layer];
                    textView2.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay3 setMasksToBounds:YES];
                    [lay3 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay3 setBorderWidth:1.0];
                    [lay3 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
                
            }
            
            questheight1 = questheight1 + textView2.frame.size.height + 10;
            
            if([optArr  count]>3){
                
                NSDictionary * option4Dict = [optArr objectAtIndex:3];
                
                
                op4 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op4.ansObj = option4Dict;
                [scrollView addSubview:op4];
                
                cirImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg3.image = [UIImage imageNamed:@"TikButton-blank.png"];
                [op4 addSubview:cirImg3];
                
                textView3 = [self createUILabelMCMMC:[[option4Dict valueForKey:@"content"] valueForKey:@"text"]];
                op4.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView3.frame.size.height);
                
                textView3.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op4 addSubview:textView3];
                
                
                
                
                op1Touch3 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick3:)];
                [op4 addGestureRecognizer:op1Touch3];
                
                
                
                if([self matchMMCoptionWithAnswer:option4Dict :globalTrackQuizObj])
                {
                    
                    cirImg3.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay4 = [textView3 layer];
                    textView3.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setMasksToBounds:YES];
                    [lay4 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay4 setBorderWidth:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
            }
            
            questheight1 = questheight1 + textView3.frame.size.height + 10;
            
            
            
            if([optArr  count] >4){
                NSDictionary * option5Dict = [optArr objectAtIndex:4];
                op5 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op5.ansObj = option5Dict;
                [scrollView addSubview:op5];
                cirImg4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg4.image = [UIImage imageNamed:@"TikButton-blank.png"];
                [op5 addSubview:cirImg4];
                
                textView4 = [self createUILabelMCMMC:[[option5Dict valueForKey:@"content"] valueForKey:@"text"]];
                op5.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView4.frame.size.height);
                
                
                [op5 addSubview:textView4];
        
                textView4.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                
                op1Touch4 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick4:)];
                [op5 addGestureRecognizer:op1Touch4];
                
                
                
                if([self matchMMCoptionWithAnswer:option5Dict :globalTrackQuizObj])
                {
                    
                    cirImg4.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay4 = [textView4 layer];
                    textView4.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
            }
            
            questheight1 = questheight1 + textView4.frame.size.height + 10;
            
            
            
            
            if([optArr  count] >5){
                
                NSDictionary * option6Dict = [optArr objectAtIndex:5];
                op6 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op6.ansObj = option6Dict;
                [scrollView addSubview:op6];
                cirImg5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg5.image = [UIImage imageNamed:@"TikButton-blank.png"];
                
                
                
                [op6 addSubview:cirImg5];
               
                textView5 = [self createUILabelMCMMC:[[option6Dict valueForKey:@"content"] valueForKey:@"text"]];
                op6.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView5.frame.size.height);
                textView5.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                [op6 addSubview:textView5];
                op1Touch5 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick5:)];
                [op6 addGestureRecognizer:op1Touch5];
                
                if([self matchMMCoptionWithAnswer:option6Dict :globalTrackQuizObj])
                {
                    
                    cirImg5.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay4 = [textView5 layer];
                    textView5.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setMasksToBounds:YES];
                    [lay4 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay4 setBorderWidth:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
            }
            questheight1 = questheight1 + textView5.frame.size.height + 10;
            
            if([optArr  count] >6){
                
                NSDictionary * option7Dict = [optArr objectAtIndex:6];
                
                op7 =[[CustomUIView alloc]initWithFrame:CGRectMake(10,questheight1, SCREEN_WIDTH-20, 0)];
                op7.ansObj = option7Dict;
                [scrollView addSubview:op7];
                cirImg6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg6.image = [UIImage imageNamed:@"TikButton-blank.png"];
                
                
                
                [op7 addSubview:cirImg6];
                
                textView6 = [self createUILabelMCMMC:[[option7Dict valueForKey:@"content"] valueForKey:@"text"]];
                op7.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView6.frame.size.height);
                
                
                textView6.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
               [op7 addSubview:textView6];
                op1Touch6 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick6:)];
                [op7 addGestureRecognizer:op1Touch6];
                
                
                
                if([self matchMMCoptionWithAnswer:option7Dict :globalTrackQuizObj])
                {
                    
                    cirImg6.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay4 = [textView6 layer];
                    textView6.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setMasksToBounds:YES];
                    [lay4 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay4 setBorderWidth:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
            }
            questheight1 = questheight1 + textView6.frame.size.height + 10;
            
            
            
            
           
            if([optArr  count] >7){
                NSDictionary * option8Dict = [optArr objectAtIndex:7];
                op8 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, questheight1, SCREEN_WIDTH-20, 0)];
                op8.ansObj = option8Dict;
                [scrollView addSubview:op8];
                cirImg7 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
                cirImg7.image = [UIImage imageNamed:@"TikButton-blank.png"];
                
                [op8 addSubview:cirImg7];
                
                textView7 = [self createUILabelMCMMC:[[option8Dict valueForKey:@"content"] valueForKey:@"text"]];
                op8.frame = CGRectMake(10, questheight1, SCREEN_WIDTH-20, textView7.frame.size.height);
                
               
    
                textView7.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
                
                [op8 addSubview:textView7];
                op1Touch7 =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(optMTouchClick7:)];
                [op8 addGestureRecognizer:op1Touch7];
                if([self matchMMCoptionWithAnswer:option8Dict :globalTrackQuizObj])
                {
                    
                    cirImg7.image = [UIImage imageNamed:@"TikButton.png"];
                    CALayer * lay4 = [textView7 layer];
                    textView7.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
                    [lay4 setMasksToBounds:YES];
                    [lay4 setCornerRadius:20.0];
                    
                    // You can even add a border
                    [lay4 setBorderWidth:1.0];
                    [lay4 setBorderColor:[[self getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                }
                
                
            }
            questheight1 = questheight1 + textView7.frame.size.height + 10;
            
            
            if([optArr count] > 7 && [[[ [optArr objectAtIndex:7] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op8.tag = 1000;
                textView7.tag = 1001;
                cirImg7.tag =1002;
            }
            if([optArr count] > 6 && [[[ [optArr objectAtIndex:6] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op7.tag = 1000;
                textView6.tag = 1001;
                cirImg6.tag =1002;
            }
            if([optArr count] > 5 && [[[ [optArr objectAtIndex:5] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op6.tag = 1000;
                textView5.tag = 1001;
                cirImg5.tag =1002;
            }
            if([optArr count] > 4 && [[[ [optArr objectAtIndex:4] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op5.tag = 1000;
                textView4.tag = 1001;
                cirImg4.tag =1002;
            }
            if([optArr count] > 3 && [[[ [optArr objectAtIndex:3] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op4.tag = 1000;
                textView3.tag = 1001;
                cirImg3.tag =1002;
            }
            if([optArr count] > 2 && [[[ [optArr objectAtIndex:2] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op3.tag = 1000;
                textView2.tag = 1001;
                cirImg2.tag =1002;
            }
            if([optArr count] > 1 && [[[ [optArr objectAtIndex:1] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                op2.tag = 1000;
                textView1.tag = 1001;
                cirImg1.tag =1002;
            }
            if([optArr count] > 0 && [[[ [optArr objectAtIndex:0] valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                //right ++;
                op1.tag = 1000;
                textView.tag = 1001;
                cirImg.tag =1002;
            }
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
            
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"dd"])
        {
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"dd" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            
            dottedBox = [[TTGTextTagCollectionView alloc]initWithFrame:CGRectMake(20, questheight1, SCREEN_WIDTH-40, 100)];
            dottedBox.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            dottedBox.delegate =  self;
            [scrollView addSubview:dottedBox];
            
            
            
            ddBox =  [[TTGTextTagCollectionView alloc]initWithFrame:CGRectMake(20, questheight1 +120 , dottedBox.frame.size.width,100)];
            ddBox.delegate = self;
            [scrollView addSubview:ddBox];
            
            NSArray * optArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            if([optArr count]  > 2){
                optArr =[self randomddOptionArr:optArr];
            }
            else
            {
                optArr = [[NSArray alloc]init];
            }
            
            
            ddBoxArr = [[NSMutableArray alloc]init];
            for (NSDictionary * obj in optArr) {
                [ddBoxArr addObject:[[obj valueForKey:@"content"] valueForKey:@"text"]];
                
            }
            
            
            //TTGTextTagConfig * con = [[TTGTextTagConfig alloc]init];
            
            TTGTextTagConfig *config = dottedBox.defaultConfig;
            config.textFont = HEADERSECTIONTITLEFONT;
            config.textColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            config.selectedTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            
            config.backgroundColor = [UIColor whiteColor];
            config.selectedBackgroundColor = [UIColor whiteColor];
            
            dottedBox.horizontalSpacing = 6.0;
            dottedBox.verticalSpacing = 8.0;
            
            config.borderColor = [UIColor lightGrayColor];
            config.selectedBorderColor = [UIColor lightGrayColor];
            config.borderWidth = 1;
            config.selectedBorderWidth = 1;
            
            config.shadowColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            config.shadowOffset = CGSizeMake(0, 0.3);
            config.shadowOpacity = 0.3f;
            config.shadowRadius = 0.5f;
            
            config.cornerRadius = 7;
            
            config.enableGradientBackground = YES;
            config.gradientBackgroundStartColor = [UIColor whiteColor];
            config.selectedGradientBackgroundStartColor = [UIColor whiteColor];
            config.gradientBackgroundEndColor = [UIColor whiteColor];
            config.selectedGradientBackgroundEndColor = [UIColor whiteColor];
            config.gradientBackgroundStartPoint =CGPointMake(0, 0);
            config.gradientBackgroundEndPoint = CGPointMake(1, 1);
            
            
            
            
            
            // Style2
            
            config = ddBox.defaultConfig;
            
            config.textFont = HEADERSECTIONTITLEFONT;
            config.textColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            config.selectedTextColor = [UIColor colorWithRed:0.18 green:0.19 blue:0.22 alpha:1.00];
            
            config.backgroundColor = [UIColor whiteColor];
            config.selectedBackgroundColor = [UIColor whiteColor];
            
            dottedBox.horizontalSpacing = 6.0;
            dottedBox.verticalSpacing = 8.0;
            
            config.borderColor = [UIColor lightGrayColor];
            config.selectedBorderColor = [UIColor lightGrayColor];
            config.borderWidth = 1;
            config.selectedBorderWidth = 1;
            
            
            config.shadowColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            config.shadowOffset = CGSizeMake(0, 0.3);
            config.shadowOpacity = 0.3f;
            config.shadowRadius = 0.5f;
            
            config.cornerRadius = 7;
            
            config.enableGradientBackground = YES;
            config.gradientBackgroundStartColor = [UIColor whiteColor];
            config.selectedGradientBackgroundStartColor = [UIColor whiteColor];
            config.gradientBackgroundEndColor = [UIColor whiteColor];
            config.selectedGradientBackgroundEndColor = [UIColor whiteColor];
            config.gradientBackgroundStartPoint =CGPointMake(0, 0);
            config.gradientBackgroundEndPoint = CGPointMake(1, 1);
            
            
            [ddBox addTags:ddBoxArr];
            [dottedBox reload];
            
            
            dottedBox.frame = CGRectMake(20, questheight1, SCREEN_WIDTH-40, ddBox.contentSize.height);
            ddBox.frame = CGRectMake(20, questheight1+ddBox.contentSize.height+20, dottedBox.frame.size.width,ddBox.contentSize.height);
            
            questheight1 = questheight1 +2*(ddBox.contentSize.height) +40;
            
            CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
            yourViewBorder.strokeColor = [UIColor grayColor].CGColor;
            yourViewBorder.fillColor = nil;
            yourViewBorder.lineDashPattern = @[@5, @5];
            yourViewBorder.frame = dottedBox.bounds;
            yourViewBorder.path = [UIBezierPath bezierPathWithRect:dottedBox.bounds].CGPath;
            [yourViewBorder setCornerRadius:20.0];
            
            [dottedBox.layer addSublayer:yourViewBorder];
            
            
            // dottedBox
            
            
            
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
            
        }
        else if( [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"pw"])
        {
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"pw" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            
            
            pwdottedBox = [[UIView alloc]initWithFrame:CGRectMake(20, questheight1+10, SCREEN_WIDTH-40, 100)];
            pwdottedBox.backgroundColor = [self getUIColorObjectFromHexString:@"#EAEBED" alpha:1.0];
            [scrollView addSubview:pwdottedBox];
            CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
            yourViewBorder.strokeColor = [UIColor grayColor].CGColor;
            yourViewBorder.fillColor = nil;
            yourViewBorder.lineDashPattern = @[@5, @5];
            yourViewBorder.frame = pwdottedBox.bounds;
            yourViewBorder.path = [UIBezierPath bezierPathWithRect:pwdottedBox.bounds].CGPath;
            [yourViewBorder setCornerRadius:20.0];
            [pwdottedBox.layer addSublayer:yourViewBorder];
            
            
            
            
            
            //NSMutableDictionary * lPwObj = [self createDictionaryifNot:globalDictionary type:@"pw" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            
            
            pwopt1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, pwdottedBox.frame.size.width/2-10, pwdottedBox.frame.size.height/2-10)];
            pwopt1.titleLabel.font = TEXTTITLEFONT;
            [pwopt1 setBackgroundColor:[self getUIColorObjectFromHexString:@"##FFFFFF" alpha:1.0]];
            [pwopt1 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            if([[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:0]valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                globalBtn = pwopt1;
                if([obj valueForKey:@"option"] != NULL && ![[obj valueForKey:@"option"]isEqualToString:@""] )
                {
                    [pwopt1 setBackgroundColor:[self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0]];
                    [pwopt1 setTitle:[obj valueForKey:@"option"] forState:UIControlStateNormal];
                }
            }
            else
            {
                [pwopt1 setTitle:[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:0]valueForKey:@"content"] valueForKey:@"text"] forState:UIControlStateNormal];
            }
            
            
            
            
            
            
            [pwdottedBox addSubview:pwopt1];
            
            
            pwopt2 = [[UIButton alloc]initWithFrame:CGRectMake(pwdottedBox.frame.size.width/2+5, 5, pwdottedBox.frame.size.width/2-10, pwdottedBox.frame.size.height/2-10)];
            [pwopt2 setBackgroundColor:[self getUIColorObjectFromHexString:@"##FFFFFF" alpha:1.0]];
            pwopt2.titleLabel.font = TEXTTITLEFONT;
            [pwdottedBox addSubview:pwopt2];
            [pwopt2 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            
            if([[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:1]valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                globalBtn = pwopt2;
                [pwopt2 setTitle:@"" forState:UIControlStateNormal];
                [pwopt2 setBackgroundColor:[self getUIColorObjectFromHexString:@"#A9A3A3" alpha:1.0]];
                if([obj valueForKey:@"option"] != NULL && ![[obj valueForKey:@"option"]isEqualToString:@""] )
                {
                    [pwopt2 setBackgroundColor:[self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0]];
                    [pwopt2 setTitle:[obj valueForKey:@"option"] forState:UIControlStateNormal];
                }
            }
            else
            {
                
                [pwopt2 setTitle:[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:1]valueForKey:@"content"] valueForKey:@"text"] forState:UIControlStateNormal];
            }
            
            
            pwopt3 = [[UIButton alloc]initWithFrame:CGRectMake(5, pwdottedBox.frame.size.height/2+5, pwdottedBox.frame.size.width/2-10, pwdottedBox.frame.size.height/2-10)];
            pwopt3.titleLabel.font = TEXTTITLEFONT;
            [pwopt3 setBackgroundColor:[self getUIColorObjectFromHexString:@"##FFFFFF" alpha:1.0]];
            [pwopt3 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            if([[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:2]valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                globalBtn = pwopt3;
                [pwopt3 setTitle:@"" forState:UIControlStateNormal];
                [pwopt3 setBackgroundColor:[self getUIColorObjectFromHexString:@"#A9A3A3" alpha:1.0]];
                if([obj valueForKey:@"option"] != NULL && ![[obj valueForKey:@"option"]isEqualToString:@""] )
                {
                    [pwopt3 setBackgroundColor:[self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0]];
                    [pwopt3 setTitle:[obj valueForKey:@"option"] forState:UIControlStateNormal];
                }
            }
            else
            {
                [pwopt3 setTitle:[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:2]valueForKey:@"content"] valueForKey:@"text"] forState:UIControlStateNormal];
            }
            [pwdottedBox addSubview:pwopt3];
            
            
            
            pwopt4 = [[UIButton alloc]initWithFrame:CGRectMake(pwdottedBox.frame.size.width/2+5, pwdottedBox.frame.size.height/2+5, pwdottedBox.frame.size.width/2-10, pwdottedBox.frame.size.height/2-10)];
            pwopt4.titleLabel.font = TEXTTITLEFONT;
            [pwopt4 setBackgroundColor:[self getUIColorObjectFromHexString:@"##FFFFFF" alpha:1.0]];
            [pwopt4 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            if([[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:3]valueForKey:@"content"] valueForKey:@"is_filled"]isEqualToString:@"false"]){
                globalBtn = pwopt4;
                [pwopt4 setTitle:@"" forState:UIControlStateNormal];
                [pwopt4 setBackgroundColor:[self getUIColorObjectFromHexString:@"#A9A3A3" alpha:1.0]];
                
                
                if([obj valueForKey:@"option"] != NULL && ![[obj valueForKey:@"option"]isEqualToString:@""] )
                {
                    [pwopt4 setBackgroundColor:[self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0]];
                    [pwopt4 setTitle:[obj valueForKey:@"option"] forState:UIControlStateNormal];
                }
                
            }
            else
            {
                [pwopt4 setTitle:[[[[[question valueForKey:@"answers"]valueForKey:@"answer"]objectAtIndex:3]valueForKey:@"content"] valueForKey:@"text"] forState:UIControlStateNormal];
            }
            [pwdottedBox addSubview:pwopt4];
            
            
            
            
            
            
            pwBox =  [[UIView alloc]initWithFrame:CGRectMake(20,questheight1+120, SCREEN_WIDTH-40,100)];
            [scrollView addSubview:pwBox];
            
            
            slopt1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, pwBox.frame.size.width/2-10, pwBox.frame.size.height/2-10)];
            [slopt1 setBackgroundColor:[self getUIColorObjectFromHexString:@"#F0F0E4" alpha:1.0]];
            slopt1.titleLabel.font = TEXTTITLEFONT;
            [slopt1 setTitle:[[[[question valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:0]valueForKey:@"text"]  forState:UIControlStateNormal];
            
            
            
            slopt1.tag = 1;
            [slopt1 addTarget:self action:@selector(pwOptionClick:) forControlEvents:UIControlEventTouchUpInside];
            [slopt1 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            [pwBox addSubview:slopt1];
            
            
            
            
            
            
            slopt2 = [[UIButton alloc]initWithFrame:CGRectMake(pwBox.frame.size.width/2+5, 5, pwBox.frame.size.width/2-10, pwBox.frame.size.height/2-10)];
            [slopt2 setBackgroundColor:[self getUIColorObjectFromHexString:@"#F0F0E4" alpha:1.0]];
            slopt2.titleLabel.font = TEXTTITLEFONT;
            [slopt2 setTitle:[[[[question valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:1]valueForKey:@"text"] forState:UIControlStateNormal];
            slopt2.tag = 2;
            [slopt2 addTarget:self action:@selector(pwOptionClick:) forControlEvents:UIControlEventTouchUpInside];
            [slopt2 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
            [pwBox addSubview:slopt2];
            
            if([[[question valueForKey:@"random_options"]valueForKey:@"option"] count]>2){
                slopt3 = [[UIButton alloc]initWithFrame:CGRectMake(5, pwBox.frame.size.height/2+5, pwBox.frame.size.width/2-10, pwBox.frame.size.height/2-10)];
                [slopt3 setBackgroundColor:[self getUIColorObjectFromHexString:@"#F0F0E4" alpha:1.0]];
                slopt3.titleLabel.font = TEXTTITLEFONT;
                [slopt3 setTitle:[[[[question valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:2]valueForKey:@"text"] forState:UIControlStateNormal];
                slopt3.tag = 3;
                [slopt3 addTarget:self action:@selector(pwOptionClick:) forControlEvents:UIControlEventTouchUpInside];
                [slopt3 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
                [pwBox addSubview:slopt3];
            }
            
            if([[[question valueForKey:@"random_options"]valueForKey:@"option"] count]>3){
                slopt4 = [[UIButton alloc]initWithFrame:CGRectMake(pwBox.frame.size.width/2+5, pwdottedBox.frame.size.height/2+5, pwBox.frame.size.width/2-10, pwBox.frame.size.height/2-10)];
                slopt4.titleLabel.font = TEXTTITLEFONT;
                [slopt4 setTitle:[[[[question valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:3]valueForKey:@"text"] forState:UIControlStateNormal];
                [slopt4 setBackgroundColor:[self getUIColorObjectFromHexString:@"#F0F0E4" alpha:1.0]];
                [slopt4 setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
                slopt4.tag = 4;
                [slopt4 addTarget:self action:@selector(pwOptionClick:) forControlEvents:UIControlEventTouchUpInside];
                [pwBox addSubview:slopt4];
            }
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+200);
            
        }
        else if( [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"])
        {
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"es" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            int i = 0;
            if([[question valueForKey:@"sample1"]valueForKey:@"text"] != NULL && ![[[NSString alloc]initWithFormat:@"%@",[[question valueForKey:@"sample1"]valueForKey:@"text"]] isEqualToString:@""])
            {
                i++;
            }
            
            if([[question valueForKey:@"sample2"]valueForKey:@"text"] != NULL && ![[[NSString alloc]initWithFormat:@"%@",[[question valueForKey:@"sample2"]valueForKey:@"text"]] isEqualToString:@""])
            {
                i++;
            }
            if(i>0)
            {
                
                
                 sampleAnswerView = [[UIView alloc]initWithFrame:CGRectMake(0, questheight1, scrollView.frame.size.width, 40)];
                //questionView.backgroundColor = [UIColor redColor];
                
                sampleText = [[UILabel alloc]initWithFrame:CGRectMake(sampleAnswerView.frame.size.width-80, 7, 80, 25)];
                sampleText.text = @"Sample Answer";
                sampleText.textColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
                sampleText.font = [UIFont systemFontOfSize:10];
                [sampleAnswerView addSubview:sampleText];
                floaButtonView = [[UIButton alloc]initWithFrame:CGRectMake(sampleAnswerView.frame.size.width-107, 7, 25, 25)];
                [floaButtonView setImage:[UIImage imageNamed:@"sample_icon"] forState:UIControlStateNormal];
                sampleText.text = @"Sample Answer";
                
                [floaButtonView addTarget:self
                                   action:@selector(ShowSampleAns:)
                         forControlEvents:UIControlEventTouchUpInside];
                
                
                [sampleAnswerView addSubview:floaButtonView];
            }
            
            
            
            if(![UISTANDERD isEqualToString:@"PRODUCT3"]){
                [scrollView addSubview:sampleAnswerView];
                questheight1 = questheight1+40;
            }
            
            
            areaTxt = [[UIView alloc]initWithFrame:CGRectMake(20, questheight1, scrollView.frame.size.width-40,130)];
            [scrollView addSubview:areaTxt];
            [[areaTxt layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
            [[areaTxt layer] setBorderWidth:2.0];
            [[areaTxt layer] setCornerRadius:15];
            
            esTextView = [[UITextView alloc]initWithFrame:CGRectMake(3, 3, areaTxt.frame.size.width-6 , areaTxt.frame.size.height-5)];
            esTextView.delegate = self;
            esTextView.autocorrectionType = UITextAutocorrectionTypeNo;
            
            
            
            
            [areaTxt addSubview:esTextView];
            
            questheight1 = questheight1+140;
            
            minLength = [[UILabel alloc]initWithFrame:CGRectMake(20, questheight1 , (SCREEN_WIDTH-40)/2, 25)];
            minLength.textAlignment = NSTextAlignmentLeft;
            minLength.font = HEADERSECTIONTITLEFONT;
            minLength.textColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            NSString * msg  = @"Characters";
            if([[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"check_limit"] valueForKey:@"text"]isEqualToString:@"word"] )
            {
                msg = @"Words";
            }
            
                
            minLength.text = [[NSString alloc]initWithFormat:@"Min. %@ :%@",msg,[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"min_length"] valueForKey:@"text"]];
            [scrollView addSubview:minLength];
            
            total =[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, questheight1, (SCREEN_WIDTH-40)/2, 25)];
            total.textAlignment = NSTextAlignmentRight;
            total.font = HEADERSECTIONTITLEFONT;
            total.textColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            total.text = [[NSString alloc]initWithFormat:@"%@/%@",@"0",[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"]];
            [scrollView addSubview:total];
            
            //NSMutableDictionary *esObj = [self createDictionaryifNot:globalDictionary type:@"es" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            if([obj valueForKey:@"option"] != NULL)
            {
                esTextView.text = [obj valueForKey:@"option"];
            }
            questheight1 = questheight1+30;
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
            
        }
        else if( [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
        {
            
            NSMutableDictionary *obj = [self createDictionaryifNot:globalDictionary type:@"ifb" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            
            ibfbView = [[ifb_AssessmentTemplate alloc]initWithFrame:CGRectMake(0,questheight1,scrollView.frame.size.width,0)];
            [ibfbView Create_ifbUIWithData:question :obj :scrollView :self :FALSE];
            ibfbView.frame = CGRectMake(0,questheight1,scrollView.frame.size.width,ibfbView.viewHeight);
            [scrollView addSubview:ibfbView];
            questheight1 = questheight1+ibfbView.viewHeight;
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
        }
        else if( [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
        {
            
            NSMutableDictionary *obj = [self createDictionaryifNot:globalDictionary type:@"fb" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            
            fbView = [[fb_AssessmentTemplate alloc]initWithFrame:CGRectMake(0,questheight1,scrollView.frame.size.width,0)];
            [fbView Create_fbUIWithData:question :obj :scrollView :self :FALSE];
            fbView.frame = CGRectMake(0,questheight1,scrollView.frame.size.width,fbView.viewHeight);
            [scrollView addSubview:fbView];
            questheight1 = questheight1+fbView.viewHeight;
            //scrollView.backgroundColor = [UIColor redColor];
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
            
        }
        
        else if([[[question valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 1  &&  [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            popup.hidden = TRUE;
            
            if([question valueForKey:@"popup"] != nil && (![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) && [[[question valueForKey:@"evaluation_subtype"] valueForKey:@"text"]intValue] != 3   )
            {
                WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
                sanaLbl = [[WKWebView alloc] initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH,scrollView.frame.size.height-(scrollView.frame.size.height-120)) configuration:theConfiguration];
                sanaLbl.UIDelegate = self;
                sanaLbl.navigationDelegate = self ;
                sanaLbl.scrollView.delegate = self;
                sanaLbl.scrollView.bounces = false;
                sanaLbl.scrollView.bouncesZoom = false;
                sanaLbl.scrollView.bounces = false;
                sanaLbl.scrollView.pinchGestureRecognizer.enabled = FALSE;
                NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style>.underline {color: #d81e11!important;text-decoration:underline!important;}.grey{color: #808080;}.green{color:#118616}.yellow{color:#FFC107}.red{color:#d81e11}.fontColor{font-size:20px;margin-right: 10px;display: inline-block;width: auto;text-align: left;}.phrase{font-size:10px;text-align:left; position: relative;top: 0px; padding: 0px 5px;}</style><div style=\"font-size:20px;\">%@</div></body></html>",[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]];
                [sanaLbl loadHTMLString:strHtml baseURL:nil];
                
                NSUInteger numberOfOccurrences = [[[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] componentsSeparatedByString:@"\n"] count] - 1;
                
                int sanatextHeight = (int) (([[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] length]/numberofChar)+2+numberOfOccurrences)*80;
                sanaLbl.frame = CGRectMake(0, questheight1, SCREEN_WIDTH,sanatextHeight);
                [scrollView addSubview:sanaLbl];
                
                questheight1 = questheight1 +sanatextHeight+10;
                
            }
            else
            {
                WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
                sanaLbl = [[WKWebView alloc] initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH,scrollView.frame.size.height-(scrollView.frame.size.height-120)) configuration:theConfiguration];
                sanaLbl.UIDelegate = self;
                sanaLbl.navigationDelegate = self ;
                sanaLbl.scrollView.delegate = self;
                sanaLbl.scrollView.bounces = false;
                sanaLbl.scrollView.bouncesZoom = false;
                sanaLbl.scrollView.bounces = false;
                sanaLbl.scrollView.pinchGestureRecognizer.enabled = FALSE;
                NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style>.underline {color: #d81e11!important;text-decoration:underline!important;}.grey{color: #808080;}.green{color:#118616}.yellow{color:#FFC107}.red{color:#d81e11}.fontColor{font-size:20px;margin-right: 10px;display: inline-block;width: auto;text-align: left;}.phrase{font-size:10px;text-align:left; position: relative;top: 0px; padding: 0px 5px;}</style><div style=\"font-size:20px;\">%@</div></body></html>",@""];
                [sanaLbl loadHTMLString:strHtml baseURL:nil];
                
                NSUInteger numberOfOccurrences = [[[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] componentsSeparatedByString:@"\n"] count] - 1;
                
                int sanatextHeight =  (int)(([[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] length]/numberofChar)+2+numberOfOccurrences)*80;
                sanaLbl.frame = CGRectMake(0, questheight1, SCREEN_WIDTH,sanatextHeight);
                [scrollView addSubview:sanaLbl];
                
                questheight1 = questheight1 +sanatextHeight+10;
                
            }
            
            
            
            
            
            
            sanaScoreIns = [[UILabel alloc]initWithFrame:CGRectMake(10,scrollView.frame.size.height-45,scrollView.frame.size.width-20, 20)];
            sanaScoreIns.font = [UIFont boldSystemFontOfSize:10.0];
            sanaScoreIns.textAlignment = NSTextAlignmentCenter;
            sanaScoreIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            sanaScoreIns.text = @"";
            //[scrollView addSubview:sanaScoreIns];
            
            
            
            UIImageView * sanaScoreView = [[UIImageView alloc]initWithFrame:CGRectMake((2*(scrollView.frame.size.width/3))+(scrollView.frame.size.width/6)-40,questheight1, 80, 80)];
            sanaScoreView.image = [UIImage imageNamed:@"MEPro_score-circle.png"];
            sanaScoLbl = [[UILabel alloc]initWithFrame:CGRectMake(15,25,sanaScoreView.frame.size.width-30, 25)];
            sanaScoLbl.font = [UIFont boldSystemFontOfSize:18.0];
            sanaScoLbl.textAlignment = NSTextAlignmentCenter;
            sanaScoLbl.text = @"";
            [sanaScoreView addSubview:sanaScoLbl];
            [scrollView addSubview:sanaScoreView];
            
            UILabel * listen = [[UILabel alloc]initWithFrame:CGRectMake((2*(scrollView.frame.size.width/3))+(scrollView.frame.size.width/6)-50,questheight1+90,sanaScoreView.frame.size.width+20, 25)];
            listen.font =  HEADERSECTIONTITLEFONT;
            listen.textAlignment = NSTextAlignmentCenter;
            listen.text = @"score";
            listen.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [scrollView addSubview:listen];
            
            
            if([question valueForKey:@"popup"] != nil && (![[[[question valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]isEqualToString:@""]) && [[[question valueForKey:@"evaluation_subtype"] valueForKey:@"text"]intValue] != 2 )
            {
                
                audioSanaBtn = [[UIButton alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/6)-40,questheight1, 80, 80)];
                [audioSanaBtn setImage:[UIImage imageNamed:@"MEPro_expert.png"] forState:UIControlStateNormal];
                [audioSanaBtn addTarget:self action:@selector(sanaExpertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioSanaBtn];
                
                UILabel * recored = [[UILabel alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/6)-50,questheight1+90,audioSanaBtn.frame.size.width+20, 25)];
                recored.font = HEADERSECTIONTITLEFONT;
                recored.textAlignment = NSTextAlignmentCenter;
                recored.text = @"Listen";
                recored.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [scrollView addSubview:recored];
                
                
            }
            else
            {
                audioSanaBtn = [[UIButton alloc]initWithFrame:CGRectMake((scrollView.frame.size.width/6)-40,questheight1, 80, 80)];
                [audioSanaBtn setImage:[UIImage imageNamed:@"MEPro_expert-disable.png"] forState:UIControlStateNormal];
                audioSanaBtn.enabled = FALSE;
                [audioSanaBtn addTarget:self action:@selector(sanaExpertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioSanaBtn];
            }
            
            tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollView.frame.size.height-200, SCREEN_WIDTH, 20)];
            tapIns.text = @"Tap to start";
            tapIns.textAlignment = NSTextAlignmentCenter;
            tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            tapIns.font = TEXTTITLEFONT;
            //[scrollView addSubview:tapIns];
            
            
            remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollView.frame.size.height-180, SCREEN_WIDTH, 20)];
            remaingText.text = @"Time remaining";
            remaingText.textAlignment = NSTextAlignmentCenter;
            remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            remaingText.font = TEXTTITLEFONT;
            //[scrollView addSubview:remaingText];
            
            minute = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollView.frame.size.height-160, SCREEN_WIDTH, 20)];
            minute.textAlignment = NSTextAlignmentCenter;
            //[scrollView addSubview:minute];
            minute.font = [UIFont systemFontOfSize:18];
            minute.text = @"00:00";
            minute.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            
            
            NSString * str = [[[[question valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
            
            totaltime = [str integerValue];
            if(totaltime <= 0) totaltime = 5;
            localProgress =0;
            int min = totaltime/60;
            int second = totaltime%60;
            NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
            minute.text = time;
            progressView4 = [[UAProgressView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2-40, questheight1, 80, 80)];
            [progressView4 setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
            recordSanaStop = [[UIButton alloc]init];
            recordSanaStop.frame = CGRectMake(0, 0, 80, 80);
            [recordSanaStop addTarget:self action:@selector(holdDown) forControlEvents:UIControlEventTouchDown];
            [recordSanaStop addTarget:self action:@selector(holdRelease) forControlEvents:UIControlEventTouchUpInside];
            [recordSanaStop setImage:[UIImage imageNamed:@"MEPro_record.png"] forState:UIControlStateNormal];
            progressView4.centralView = recordSanaStop;
            [scrollView addSubview:progressView4];
            if([[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
            {
                
                [recordSanaStop setImage:[UIImage imageNamed:@"MEPro_record.png"] forState:UIControlStateNormal];
                recordSanaStop.enabled =  TRUE;
                UILabel * recored = [[UILabel alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2-50,questheight1+90,progressView4.frame.size.width+20, 25)];
                recored.font = HEADERSECTIONTITLEFONT;
                recored.textAlignment = NSTextAlignmentCenter;
                recored.text = @"Hold to record";
                recored.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                [scrollView addSubview:recored];
            }
            
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1+130);
        }
        else if([[[question valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0 && [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            if([CLASS_NAME isEqualToString:@"wiley"]){
              if(!popup.hidden)popup.hidden = TRUE;
            }
            questheight1 =  questheight1+30;
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            tapIns.text = @"Tap to start";
            tapIns.textAlignment = NSTextAlignmentCenter;
            tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            tapIns.font = TEXTTITLEFONT;
            [scrollView addSubview:tapIns];
            
            questheight1 =  questheight1+20;
            remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            remaingText.text = @"Time remaining";
            remaingText.textAlignment = NSTextAlignmentCenter;
            remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            remaingText.font = TEXTTITLEFONT;
            [scrollView addSubview:remaingText];
            
            questheight1 =  questheight1+20;
            
            minute = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            minute.textAlignment = NSTextAlignmentCenter;
            [scrollView addSubview:minute];
            minute.font = [UIFont systemFontOfSize:18];
            minute.text = @"00:00";
            minute.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            
            
            NSString * str = [[[[question valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
            
            totaltime = [str integerValue];
            if(totaltime <= 0) totaltime = 5;
            int min = totaltime/60;
            int second = totaltime%60;
            NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
            minute.text = time;
            
            questheight1 =  questheight1+30;
            recordStop = [[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2 - 40, questheight1, 80, 80)];
            [scrollView addSubview:recordStop];
            
            if([[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
            {
                
                [recordStop addTarget:self
                               action:@selector(clickStartPlay:)
                     forControlEvents:UIControlEventTouchUpInside];
                
                [recordStop setImage:[UIImage imageNamed:APP_QUIZ_RECORD_ICON] forState:UIControlStateNormal];
               
                
                NSError *error;
                NSError * err;
                
                NSString * str = [[NSString alloc]initWithFormat:@"records"];
                NSString *dataPath = [phoneDocumentDirectory stringByAppendingPathComponent:str];
                if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
                    [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
                
                NSString *strUser = [[NSString alloc]initWithFormat:@"%@_%@_%@",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
                
                NSString *trimmedString = [strUser stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
                [record_Word appendFormat:@".wav"];
                NSArray *pathComponents = [NSArray arrayWithObjects:
                                           dataPath,
                                           record_Word,
                                           nil];
                NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
                audioPath = outputFileURL.absoluteString;
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
                [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
                [settings setValue: [NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];//8000.0
                
                [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
                
                [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
                recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&err];
                recorder.delegate = self;
                recorder.meteringEnabled = YES;
                [recorder prepareToRecord];
                recordStop.enabled =  TRUE;
                
            }
            else
            {
                
                [recordStop addTarget:self
                               action:@selector(OpenCamera)
                     forControlEvents:UIControlEventTouchUpInside];
                [recordStop setImage:[UIImage imageNamed:@"CameraEnable_Ani.png"] forState:UIControlStateNormal];
            }
            questheight1 =  questheight1+100;
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
        }
        else if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
           if([CLASS_NAME isEqualToString:@"wiley"]){
              if(!popup.hidden)popup.hidden = TRUE;
            }
            
            questheight1 =  questheight1+60;
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            tapIns.text = @"Tap to start";
            tapIns.textAlignment = NSTextAlignmentCenter;
            tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            tapIns.font = TEXTTITLEFONT;
            [scrollView addSubview:tapIns];
            
            questheight1 =  questheight1+20;
            remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            remaingText.text = @"Time remaining";
            remaingText.textAlignment = NSTextAlignmentCenter;
            remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            remaingText.font = TEXTTITLEFONT;
            [scrollView addSubview:remaingText];
            
            questheight1 =  questheight1+20;
            
            minute = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            minute.textAlignment = NSTextAlignmentCenter;
            [scrollView addSubview:minute];
            minute.font = [UIFont systemFontOfSize:18];
            minute.text = @"00:00";
            minute.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            
            
            NSString * str = [[[[question valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
            
            totaltime = [str integerValue];
            if(totaltime <= 0) totaltime = 5;
            int min = totaltime/60;
            int second = totaltime%60;
            NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
            minute.text = time;
            
            questheight1 =  questheight1+30;
            recordStop = [[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2 - 40, questheight1, 80, 80)];
            [scrollView addSubview:recordStop];
            
            if([[[[[question valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
            {
                
                [recordStop addTarget:self
                               action:@selector(clickStartPlay:)
                     forControlEvents:UIControlEventTouchUpInside];
                
                [recordStop setImage:[UIImage imageNamed:APP_QUIZ_RECORD_ICON] forState:UIControlStateNormal];
                
                
                NSError *error;
                NSError * err;
                
                NSString * str = [[NSString alloc]initWithFormat:@"records"];
                NSString *dataPath = [phoneDocumentDirectory stringByAppendingPathComponent:str];
                if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
                    [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
                
                NSString *strUser = [[NSString alloc]initWithFormat:@"%@_%@_%@",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
                
                NSString *trimmedString = [strUser stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
                [record_Word appendFormat:@".wav"];
                NSArray *pathComponents = [NSArray arrayWithObjects:
                                           dataPath,
                                           record_Word,
                                           nil];
                NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
                audioPath = outputFileURL.absoluteString;
                NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
                [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
                [settings setValue: [NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];//8000.0
                
                [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
                
                [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
                recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&err];
                recorder.delegate = self;
                recorder.meteringEnabled = YES;
                [recorder prepareToRecord];
                recordStop.enabled =  TRUE;
                
            }
            else
            {
                
                [recordStop addTarget:self
                               action:@selector(OpenCamera)
                     forControlEvents:UIControlEventTouchUpInside];
                [recordStop setImage:[UIImage imageNamed:@"CameraEnable_Ani.png"] forState:UIControlStateNormal];
            }
            questheight1 =  questheight1+100;
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, questheight1);
        }
        
    }
    else
    {
        scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height);
        
        NSMutableDictionary *  obj = [self createDictionaryifNot:question type:@"av" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        [self addOrReplace:obj];
        quesNo.frame = CGRectMake(1, 2, 20, 25);
        questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
        questheight1 = inputView.frame.size.height/3 + questheight1;
        if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
        {
            popup = [[UIView alloc]init];
            popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
            UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
            [i_icon setImage:[UIImage imageNamed:@"sampleAnswer.png"]];
            [popup addSubview:i_icon];
            UITapGestureRecognizer * tapPopup = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(shopPopInstruction:)];
            [popup addGestureRecognizer:tapPopup];
            //scrollView.frame = CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, inputView.frame.size.height-(inputView.frame.size.height/3));
            [scrollView addSubview:popup];
            questheight1 = questheight1+30;
        }
        else
        {
            scrollView.frame = CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, inputView.frame.size.height-(inputView.frame.size.height/3));
            
        }
        questheight1 = questheight1+30;
        AVCounter = 0;
        QuesAVArr = NULL;
        tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        tapIns.text = @"Tap to start";
        tapIns.textAlignment = NSTextAlignmentCenter;
        tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        tapIns.font = TEXTTITLEFONT;
        [scrollView addSubview:tapIns];
        questheight1 = questheight1+20;
        remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        remaingText.text = @"Time remaining";
        remaingText.hidden = TRUE;
        remaingText.textAlignment = NSTextAlignmentCenter;
        remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        remaingText.font = TEXTTITLEFONT;
        [scrollView addSubview:remaingText];
        questheight1  = questheight1+20;
        
        minute = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        //minute.hidden = TRUE;
        minute.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:minute];
        minute.font = [UIFont systemFontOfSize:18];
        minute.text = @"00:00";
        minute.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        questheight1  = questheight1+30;
        if([[[question valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]]){
            QuesAVArr = [[question valueForKey:@"answers"]valueForKey:@"answer"] ;
        }else if([[[question valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSDictionary class]]){
            QuesAVArr = [[NSArray alloc]initWithObjects:[[question valueForKey:@"answers"]valueForKey:@"answer"], nil];
        }else{
            
        }
        
        recordAVStop = [[UIButton alloc]initWithFrame:CGRectMake(scrollView.frame.size.width/2 - 40, questheight1, 80, 80)];
        recordAVStop.enabled =  FALSE;
        [scrollView addSubview:recordAVStop];
        NSDictionary * objDictionary = [QuesAVArr objectAtIndex:AVCounter];
        NSString * str = [[objDictionary valueForKey:@"time_limit"]valueForKey:@"text"] ;
        
        totaltime = [str integerValue];
        if(totaltime <= 0) totaltime = 5;
        int min = totaltime/60;
        int second = totaltime%60;
        NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
        minute.text = time;
        
        answerUid = [objDictionary valueForKey:@"uniqid"];
        if([[[objDictionary valueForKey:@"content_type"]valueForKey:@"text"] isEqualToString:@"audio"])
        {
            [recordAVStop addTarget:self
                             action:@selector(clickAVStartPlay:)
                   forControlEvents:UIControlEventTouchUpInside];
            same = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
            QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,same.frame.size.width,same.frame.size.height)];
            same.backgroundColor = [UIColor clearColor];
            [same addSubview:QuesImg];
            
            QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            
            
            gasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                               action:@selector(openZoomView:)];
            gasture.numberOfTapsRequired =1;
            [scrollView addSubview:same];
            
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
            audioPath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            reAudioPlayer = NULL;
            if(reAudioPlayer == NULL)
            {
                NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                reAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL  error:nil];
            }
            [reAudioPlayer setDelegate:self];
            [reAudioPlayer play];
            [recordAVStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
            
            
            
            
        }
        else
        {
            movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
            [scrollView addSubview:movieView];
            
            if(recVideoPlayer == NULL)
            {
                recVideoPlayer = [[AVPlayerViewController alloc] init];
                recVideoPlayer.showsPlaybackControls = YES;
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish1:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
            }
            
            NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
//            NSString * FilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//            NSString *HTMLData =[NSString stringWithFormat:@"file:///%@",FilePath];
            
             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            playVideo = [[AVPlayer alloc] initWithURL:fileURL];
            recVideoPlayer.player = playVideo;
            [recVideoPlayer.player play];
            
            //recVideoPlayer.contentURL = [[NSURL alloc]initFileURLWithPath:FilePath];
            //[recVideoPlayer prepareToPlay];
            
            UIView *invisible = [[UIView alloc]initWithFrame:CGRectMake(movieView.frame.size.width-100,movieView.frame.size.height-50 , 100, 50)];
            
            invisible.backgroundColor = [UIColor clearColor];
            [recVideoPlayer.view addSubview:invisible];
            recVideoPlayer.view.frame = movieView.bounds;
            [movieView addSubview:recVideoPlayer.view];
            [recordAVStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
            
            
            
            
            
        }
        
    }
    
    
    
    
    
//    if(scrollView.contentSize.height <= inputView.frame.size.height-80)
//    {
//        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height-60, scrollView.frame.size.width,60)];
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, inputView.frame.size.height);
//        //scrollView.scrollEnabled = FALSE;
//    }
//    else
//    {
        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, scrollView.contentSize.height+10, scrollView.frame.size.width,60)];
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height + 60);
 //   }
    
    
    
    
    footerView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:footerView];
    if(self.type == 3)
    {
        prev = [[UIButton alloc]initWithFrame:CGRectMake(13, 15, (SCREEN_WIDTH-75)/3, UIBUTTONHEIGHT)];
        prev.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        prev.clipsToBounds = YES;
        [prev addTarget:self
                 action:@selector(clickPrevManually)
       forControlEvents:UIControlEventTouchUpInside];
        [prev setTitle:[appDelegate.langObj get:@"BACK" alter:@"Back"] forState:UIControlStateNormal];
        prev.titleLabel.font = BUTTONFONT;
        prev.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        prev.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        [footerView addSubview:prev];
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(37+(SCREEN_WIDTH-75)/3, 15, (SCREEN_WIDTH-75)/3,UIBUTTONHEIGHT)];
        submit.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        submit.clipsToBounds = YES;
        submit.titleLabel.font = BUTTONFONT;
        [submit setTitle:[appDelegate.langObj get:@"SUBMIT" alter:@"Submit"] forState:UIControlStateNormal];
        [submit addTarget:self
                   action:@selector(clickSubmit)
         forControlEvents:UIControlEventTouchUpInside];
        submit.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUD_COLOR alpha:1.0];
        submit.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0];
        [footerView addSubview:submit];
        
        
        next = [[UIButton alloc]initWithFrame:CGRectMake(62+2*((SCREEN_WIDTH-75)/3), 15, (SCREEN_WIDTH-75)/3,UIBUTTONHEIGHT)];
        next.layer.cornerRadius = BUTTONROUNDRECT;
        next.clipsToBounds = YES;
        [next addTarget:self
                 action:@selector(clickNextManually)
       forControlEvents:UIControlEventTouchUpInside];
        next.titleLabel.font = BUTTONFONT;
        next.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
        [next setTitle:[appDelegate.langObj get:@"NEXT" alter:@"Next"] forState:UIControlStateNormal];
        next.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_DISABLE_COLOR alpha:1.0];
        next.enabled = FALSE;
        [footerView addSubview:next];
        
        
        [self loadFotterView];
        
    }
    else
    {
        
        
        
        mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
       [mcqSubmitBtn.layer setMasksToBounds:YES];
       [mcqSubmitBtn.layer setCornerRadius:BUTTONROUNDRECT];
       mcqSubmitBtn.clipsToBounds = YES;
       [mcqSubmitBtn setTitle:[appDelegate.langObj get:@"SUBMIT" alter:@"Submit"] forState:UIControlStateNormal];
        mcqSubmitBtn.titleLabel.textColor = [UIColor whiteColor];
        mcqSubmitBtn.hidden = FALSE;
        mcqSubmitBtn.titleLabel.font = BUTTONFONT;
        mcqSubmitBtn.enabled =  FALSE;
        [mcqSubmitBtn addTarget:self
                         action:@selector(clickShowAnswer:)
               forControlEvents:UIControlEventTouchUpInside];
        [self disableQuizBtn];
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, mcqSubmitBtn.frame.size.width, 3)];
        [mcqSubmitBtn addSubview:lineView];
        
        [footerView addSubview:mcqSubmitBtn];
        
        contiBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
         [contiBtn.layer setMasksToBounds:YES];
        [contiBtn.layer setCornerRadius:BUTTONROUNDRECT];
            contiBtn.clipsToBounds = YES;
        
        [contiBtn setTitle:[appDelegate.langObj get:@"CONTINUE" alter:@"Continue"] forState:UIControlStateNormal];
        contiBtn.titleLabel.textColor = [UIColor whiteColor];
        contiBtn.hidden = TRUE;
        contiBtn.titleLabel.font = BUTTONFONT;
        [contiBtn addTarget:self
                     action:@selector(clickNextManually)
           forControlEvents:UIControlEventTouchUpInside];
        
        contiBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 37, contiBtn.frame.size.width, 3)];
        lineView1.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR alpha:1.0];
        [contiBtn addSubview:lineView1];
        [footerView addSubview:contiBtn];
    }
    
    
    //scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height + 60);
    [self loadFotterView];
    
    NSString * resumeStrEssay = [appDelegate getUserDefaultData:@"essayResumeText"];
    if([[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"] && resumeStrEssay.length > 0)
    {
        esTextView.text = resumeStrEssay;
        [self textViewDidChange:esTextView];
        
    }
    
}
-(NSAttributedString *)convertOptionHTMLAttibute:(NSString *)text
{
    NSString* newString = [text stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
    NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
    NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
    NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];

    NSString * str = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style>.spanPadding{margin-left: 10px;}</style><span class=\"spanPadding\" style=\"font-size:%fpx; font-family:%@;  color:%@;\">%@</span></body></html>",TEXTTITLEFONT.pointSize,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString7];
   NSAttributedString *attrText = [[NSAttributedString alloc]
                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                    options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSParagraphStyleAttributeName:style}
                                            documentAttributes: nil
                                            error: nil
                                            ];
    return attrText;

}


-(void)OpenCamera
{
    
    if(audioPlayer!= NULL && audioPlayer.isPlaying )
    {
        [audioPlayer pause];
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }
    
    if(videoViewPlayer != NULL)
        [videoViewPlayer.player pause];
    
    backGCameraView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backGCameraView.backgroundColor = [UIColor clearColor];
    PlayerFotterView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-150, SCREEN_WIDTH,150)];
    [PlayerFotterView1 setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.2]];
    PlayerFotterView1.userInteractionEnabled = TRUE;
    
    
    tapIns1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-105, SCREEN_WIDTH, 20)];
    tapIns1.text = @"Tap to start";
    tapIns1.textAlignment = NSTextAlignmentCenter;
    tapIns1.font = TEXTTITLEFONT;
    tapIns1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:tapIns1];
    
    
    
    remaingText1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-85, SCREEN_WIDTH, 40)];
    remaingText1.text = @"Time remaining";
    remaingText1.textAlignment = NSTextAlignmentCenter;
    remaingText1.font = TEXTTITLEFONT;
    remaingText1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:remaingText1];
    
    minute1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-60, SCREEN_WIDTH, 40)];
    minute1.textAlignment = NSTextAlignmentCenter;
    minute1.font = [UIFont systemFontOfSize:18];
    minute1.text = @"00:00";
    minute1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:minute1];
    
    recordStop1 = [[UIButton alloc]initWithFrame:CGRectMake(PlayerFotterView1.frame.size.width/2 - 40, PlayerFotterView1.frame.size.height/2-20, 80, 80)];
    
    [recordStop1 setImage:[UIImage imageNamed:@"CameraEnable_Ani.png"] forState:UIControlStateNormal];
    recordStop1.enabled =  TRUE;
    [recordStop1 addTarget:self
                    action:@selector(clickCameraStartPlay:)
          forControlEvents:UIControlEventTouchUpInside];
    
    [PlayerFotterView1 addSubview:recordStop1];
    [backGCameraView addSubview:PlayerFotterView1];
    
    NSString * str = [[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
    
    totaltime = [str integerValue];
    if(totaltime <= 0) totaltime = 5;
    int min = totaltime/60;
    int second = totaltime%60;
    NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
    minute1.text = time;
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerObj = [[UIImagePickerController alloc] init];
        pickerObj.delegate = (id)self;
        pickerObj.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerObj.cameraDevice=UIImagePickerControllerCameraDeviceFront;
        pickerObj.allowsEditing = NO;
        pickerObj.showsCameraControls = NO;
        pickerObj.toolbarHidden = YES;
        pickerObj.cameraViewTransform = CGAffineTransformScale(pickerObj.cameraViewTransform, 1.0,  1.0); //1.0000);//
        pickerObj.cameraOverlayView = backGCameraView;
        pickerObj.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        [self.view addSubview:pickerObj.view];
    }
}





- (void)scrollViewWillBeginDecelerating:(UIScrollView *)_scrollView{
    CGPoint mScrollPosition = [scrollView.panGestureRecognizer velocityInView:scrollView];
    
    if(_scrollView == scrollView){
        if (mScrollPosition.y > 0.0f){
            //NSLog(@"going down");
            scrollView.layer.borderWidth = 1;
            scrollView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0].CGColor;
        }
        else if (mScrollPosition.y < 0.0f){
            //NSLog(@"going up");
            scrollView.layer.borderWidth = 1;
            scrollView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0].CGColor;
            
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView;
{
    if(_scrollView == scrollView){
        
        // NSLog(@"going stable");
        scrollView.layer.borderWidth = 0;
        scrollView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0].CGColor;
        
        
        
    }
}

- (void)pwOptionClick:(UIButton*)button
{
    
    [self enableQuizBtn];
    NSMutableDictionary * pwObj = [self createDictionaryifNot:globalDictionary type:@"pw" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
    NSLog(@"Button %ld clicked.", (long int)[button tag]);
    [globalBtn setBackgroundColor:[self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0]];
    if((long int)[button tag] == 1)
    {
        
        
        [pwObj setObject:globalDictionary forKey:@"object"];
        [pwObj setValue:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:0]valueForKey:@"text"] forKey:@"option"];
        [self addOrReplace:pwObj];
        
        
        [globalBtn setTitle:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:0]valueForKey:@"text"] forState:UIControlStateNormal];
    }
    else if((long int)[button tag] == 2)
    {
        //[globalBtn setBackgroundColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
        [pwObj setValue:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:1]valueForKey:@"text"] forKey:@"option"];
        [self addOrReplace:pwObj];
        [globalBtn setTitle:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:1]valueForKey:@"text"] forState:UIControlStateNormal];
    }
    else if((long int)[button tag] == 3)
    {
        //[globalBtn setBackgroundColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
        [pwObj setValue:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:2]valueForKey:@"text"] forKey:@"option"];
        [self addOrReplace:pwObj];
        [globalBtn setTitle:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:2]valueForKey:@"text"] forState:UIControlStateNormal];
    }
    else if((long int)[button tag] == 4)
    {
        //[globalBtn setBackgroundColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
        [pwObj setValue:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:3]valueForKey:@"text"] forKey:@"option"];
        [self addOrReplace:pwObj];
        [globalBtn setTitle:[[[[globalDictionary valueForKey:@"random_options"]valueForKey:@"option"]objectAtIndex:3]valueForKey:@"text"] forState:UIControlStateNormal];
    }
    
    
    
    
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    
    if(player == reAudioPlayer)
    {
        NSDictionary * objDictionary = [QuesAVArr objectAtIndex:AVCounter];
        NSString * str = [[objDictionary valueForKey:@"time_limit"]valueForKey:@"text"] ;
        totaltime = [str integerValue];
        if(totaltime <= 0) totaltime = 5;
        int min = totaltime/60;
        int second = totaltime%60;
        NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
        minute.text = time;
        minute1.text = time;
        minute.hidden = FALSE;
        remaingText.hidden = FALSE;
        
        [reAudioPlayer stop];
        reAudioPlayer = NULL;
        
        QuesImg.image = [UIImage imageNamed:@"AudioPlaceholder.png"];
        [recordAVStop setImage:[UIImage imageNamed:@"MicEnable_Ani.png"] forState:UIControlStateNormal];
        
        NSString *strUser = [[NSString alloc]initWithFormat:@"records/%@_%@_%@_%d",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"],AVCounter+1];
        NSError * err;
        NSString *trimmedString = [strUser stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
        [record_Word appendFormat:@".wav"];
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                   record_Word,
                                   nil];
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        audioPath = outputFileURL.absoluteString;
        
        
        
        NSError *error;
        
        NSString * _str = [[NSString alloc]initWithFormat:@"records"];
        NSString *dataPath = [phoneDocumentDirectory stringByAppendingPathComponent:_str];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
        
        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
        [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [settings setValue: [NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];//8000.0
        
        [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
        
        [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
        avrecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&err];
        avrecorder.delegate = self;
        avrecorder.meteringEnabled = YES;
        [avrecorder prepareToRecord];
        recordAVStop.enabled =  TRUE;
        
        
    }
    else if(player == sanaAudioPlayer){
        
        
        [audioSanaBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
         NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        sanaAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        [sanaAudioPlayer setDelegate:self];
        [audioSanaBtn setImage:[UIImage imageNamed:@"MEPro_expert.png"] forState:UIControlStateNormal];
        
    }
    else if(player == audioPlayer){
        
        [expertAudioTimer invalidate];
        audioPlayer = NULL;
        expertAudioTimer = NULL;
        timerProgressAudioView.progress = 0.0;
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        
        
//        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
//        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//        [audioPlayer setDelegate:self];
        
    }
    else if(player == option1player){
        
        [opa1 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else if(player == option2player){
        
        [opa2 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }else if(player == option3player){
        
        [opa3 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    else if(player == option4player){
        
        [opa4 setImage:[UIImage imageNamed:@"o_play.png"] forState:UIControlStateNormal];
    }
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView == questionView ){
        UIFont *myFont = TEXTTITLEFONT;
        CGSize size =   [self sizeOfText:textView.text widthOfTextView:textView.frame.size.width withFont:myFont];
        NSLog(@"Height : %f", size.height);
    }
    
    if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ifb"])
    {
        
        if(ibfbView != NULL && [ibfbView enableQuizButton])
        {
            [self enableQuizBtn];
        }
        else
        {
            [self disableQuizBtn];
        }
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"fb"])
    {
        if(fbView != NULL && [fbView enableQuizButton])
        {
            [self enableQuizBtn];
        }
        else
        {
            [self disableQuizBtn];
        }
    }
    else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"es"]){
        
//        if([textView.text length] == 0)
//        {
//            [self disableQuizBtn];
//        }
//        else
//        {
           if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"check_limit"]valueForKey:@"text"]isEqualToString:@"word"] )
            {



                NSRegularExpression *testExpression = [NSRegularExpression regularExpressionWithPattern:@"[!._,@? ]"
                                                                                                options:NSRegularExpressionCaseInsensitive error:nil];
                NSString *trimmedStr = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                //return;
                NSArray *words = [testExpression matchesInString:trimmedStr
                                                           options:0
                                                             range:NSMakeRange(0, [trimmedStr length])];
                NSLog(@"%@",words);
                int wordCount =0;
                if([trimmedStr isEqualToString:@""])
                 wordCount= [words count];
                else
                 wordCount= [words count]+1;
                
                int wordMinLimit = [[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"min_length"] valueForKey:@"text"] intValue];
                
                int wordMaxLimit = [[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"] intValue];

                total.text = [[NSString alloc]initWithFormat:@"%d/%@",wordCount,[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"]];
                
                if(wordCount >= wordMinLimit &&  wordMaxLimit >= [words count])
                {
                    
                    [appDelegate setUserDefaultData:textView.text :@"essayResumeText"];
                    [self enableQuizBtn];
                }
                else
                {
                    [self disableQuizBtn];
                }
                
            }
            else
            {
                total.text = [[NSString alloc]initWithFormat:@"%d/%@",[textView.text length],[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"]];
                
                if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"min_length"] valueForKey:@"text"] integerValue] <= [textView.text length] && [[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"] integerValue] >= [textView.text length] )
                    {
                        [appDelegate setUserDefaultData:textView.text :@"essayResumeText"];
                        [self enableQuizBtn];
                    }
                    else
                    {
                        [self disableQuizBtn];
                    }
            }
            
       // }
    
    }
    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)Ltext
{
//    if(textView == esTextView){
//        NSLog(@"text Length %ld",[esTextView.text length]);
//        NSLog(@"text Length %ld",[Ltext length]);
//        if([textView.text length] == 0)
//        {
//            if([textView.text length] != 0)
//            {
//                return YES;
//            }
//        }
//        else if([textView.text length] + [Ltext length] > [[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"] integerValue])
//        {
//
//            return NO;
//        }
//        total.text = [[NSString alloc]initWithFormat:@"%d/%@",[textView.text length],[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"max_length"] valueForKey:@"text"]];
//    }
    return YES;
}


-(IBAction)ClickTryAgain:(id)sender
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:@"Under development."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    int duration = 2; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
    return;
    
    // }
}


-(void)resumeQuiz
{
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    if(ISENABLERESUMEQUIZ)
    {
        [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.assessnetUid]];
        [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.scnUid]];
        [appDelegate setUserDefaultData:@"" :@"essayResumeText"];
        
        if(questionCounter >= 0 && [quesArr count] > questionCounter )
        {
            
            NSMutableDictionary * resumeQuizData = [[NSMutableDictionary alloc]init];
            [resumeQuizData setValue:g_quizObj forKey:@"quizArr"];
            
            long long resumeT =  [[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue];
            
            [resumeQuizData setValue:[[NSString alloc]initWithFormat:@"%lld",resumeT] forKey:@"resumeT"];
            [resumeQuizData setValue:self.cusTitleName forKey:@"quizName"];
            
            
            
            if([ansTrackArray count] > 0)
            {
               
                NSDictionary * lastObj = [ansTrackArray lastObject];
                if([[lastObj valueForKey:@"isSumitAnswer"] intValue] == 1)
                {
                    [resumeQuizData setValue:[[NSString alloc]initWithFormat:@"%d",questionCounter+1] forKey:@"quesNo"];
                }
                else
                {
                    [ansTrackArray removeLastObject];
                    [resumeQuizData setValue:[[NSString alloc]initWithFormat:@"%d",questionCounter] forKey:@"quesNo"];
                }
             }
            
            
            
            
            [resumeQuizData setValue:ansTrackArray forKey:@"trackData"];
            [appDelegate setUserDefaultData:resumeQuizData :[[NSString alloc]initWithFormat:@"ques_%@",self.assessnetUid]];
            [appDelegate setUserDefaultData:resumeQuizData :[[NSString alloc]initWithFormat:@"ques_%@",self.scnUid]];
            
            
            
        }
    }
}




-(void)clickBack
{
    
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    
    if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
    [appDelegate.engineObj setTracktableData:data];
    
    
    

    
    [self stopAllMeadia];
    if(MCQTimer != NULL){
        [MCQTimer invalidate];
        MCQTimer = NULL;
    }
    if(self.isRemediation)
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
    else if([UISTANDERD isEqualToString:@"PRODUCT2"] &&  self.type == 21)
    {
        NSArray *array = [self.navigationController viewControllers];
        
        for (int i = 0 ; i <array.count; i++){
            UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
            if([viewCObj isKindOfClass:[MeProComponent class]]){
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                return;
            }
        }
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else if(self.type == 21)
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
    
    else if([UISTANDERD isEqualToString:@"PRODUCT2"] && self.type == 3)
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSDictionary * wordOBj = [wordSANAArr objectAtIndex:[message intValue]];
    [self showSanaScorePopup:wordOBj];
    completionHandler();
    
    
}



-(void)showSanaScorePopup :(NSDictionary *)wordOBj
{
    phoneme_scores = [wordOBj valueForKey:@"phone_score_list"];
    sanaScoreView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:sanaScoreView];
    [sanaScoreView bringSubviewToFront:self.view];
    
    sanaScoreView.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.5];
    
    UIView *sanaScoreViewPopup = [[UIView alloc]initWithFrame:CGRectMake(20,sanaScoreView.frame.size.height/4, sanaScoreView.frame.size.width-40, 210)];
    sanaScoreViewPopup.layer.cornerRadius = 10;
    sanaScoreViewPopup.layer.masksToBounds = true;
    sanaScoreViewPopup.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [sanaScoreView addSubview:sanaScoreViewPopup];
    
    UIView * playView = [[UIView alloc]initWithFrame:CGRectMake(5, 5,sanaScoreViewPopup.frame.size.width-10,20)];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [img setImage:[UIImage imageNamed:@"MPheadphone.png"]];
    [playView addSubview:img];
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, playView.frame.size.width-50,20)];
    lbl.text = [wordOBj valueForKey:@"word"];
    lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    lbl.font = [UIFont boldSystemFontOfSize:13.0];
    [playView addSubview:lbl];
    [sanaScoreViewPopup addSubview:playView];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play_sound)];
    [recognizer setNumberOfTapsRequired:1];
    playView.userInteractionEnabled = true;
    [playView addGestureRecognizer:recognizer];
    
    
    UIView * cell_view  = [[UIView alloc]initWithFrame:CGRectMake(0, 25,sanaScoreViewPopup.frame.size.width,35)];
    [sanaScoreViewPopup addSubview:cell_view];
    //
    UILabel * score = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell_view.frame.size.width/3,25)];
    score.text =@"Score";
    score.font = HEADERSECTIONTITLEFONT;
    score.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    score.textAlignment = NSTextAlignmentLeft;
    
    [cell_view addSubview:score];
    //
    UILabel *ipa = [[UILabel alloc]initWithFrame:CGRectMake(cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
    ipa.textAlignment = NSTextAlignmentLeft;
    ipa.text =@"IPA";
    ipa.font = HEADERSECTIONTITLEFONT;
    ipa.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [cell_view addSubview:ipa];
    //
    UILabel *soundLike = [[UILabel alloc]initWithFrame:CGRectMake(2*cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
    soundLike.textAlignment = NSTextAlignmentLeft;
    soundLike.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    soundLike.text =@"Sounded Like";
    soundLike.font = HEADERSECTIONTITLEFONT;
    [cell_view addSubview:soundLike];
    
    
    
    sanatable  = [[UITableView alloc]initWithFrame:CGRectMake(0,55,sanaScoreViewPopup.frame.size.width,150)];
    sanatable.separatorStyle = UITableViewCellSeparatorStyleNone;
    sanatable.delegate = self;
    sanatable.dataSource = self;
    [sanaScoreViewPopup addSubview:sanatable];
    
    
    
    
    
    utterance = [AVSpeechUtterance speechUtteranceWithString:[wordOBj valueForKey:@"word"]];
    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-45, sanaScoreView.frame.size.height/4, 20, 20)];
    
    [crossbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage* T_img =  [UIImage imageNamed:@"popup_close.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [crossbtn setImage:T_img forState:UIControlStateNormal];
    crossbtn.imageView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    [crossbtn addTarget:self action:@selector(hideSanaScorePopup) forControlEvents:UIControlEventTouchUpInside];
    [sanaScoreView addSubview:crossbtn];
    
    
}
-(void)play_sound
{
    AVSpeechSynthesizer *syn = [[AVSpeechSynthesizer alloc] init];
    [syn speakUtterance:utterance];
    
    
}
-(void)hideSanaScorePopup
{
    if(sanaScoreView != NULL)
    {
        [sanaScoreView removeFromSuperview];
        sanaScoreView = NULL;
    }
}


- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)_avrecorder successfully:(BOOL)flag
{
    
    if([CLASS_NAME isEqualToString:@"wiley"]){
      if(popup.hidden)popup.hidden = FALSE;
    }
    
    tapIns.text = @"Tap to Start";
    isAudioRecording = FALSE;
//    minute.hidden = TRUE;
//    remaingText.hidden = TRUE;
    
    
    
    
    if(avrecorder == _avrecorder )
    {
        recordAVStop.enabled = FALSE;
        [recordAVStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
        avrecorder = NULL;
        
        NSString *llTempPath;
        llTempPath = [[NSString alloc]initWithFormat:@"%@_%@_%@_%d.wav",[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],_assessnetUid,[globalDictionary valueForKey:@"uniqid"],AVCounter+1];
        [fileArray addObject:llTempPath];
        NSMutableDictionary *avObj = [self createDictionaryifNot:globalDictionary type:@"av" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        [avObj setObject:globalDictionary forKey:@"object"];
        [avObj setObject:fileArray forKey:@"option"];
        [self addOrReplace:avObj];
        
        
        
        if(QuesAVArr == nil || AVCounter == [QuesAVArr count] -1 )
        {
            AVCounter = 0;
            
            if([quesArr count]-1 <= questionCounter)
            {
                
                if(self.type == 3){
                    [self clickSubmit];
                }
                else
                {
                    [self stopAllMeadia];
                    [self enableQuizBtn];
                }
                
                
                return;
            }
            else{
                if(self.type == 3){
                    [self clickNext];
                }
                else
                {
                    [self stopAllMeadia];
                    [self enableQuizBtn];
                }
                return;
            }
        }
        if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"av"])
        {
            NSDictionary * objDictionary = [QuesAVArr objectAtIndex:++AVCounter];
            answerUid = [objDictionary valueForKey:@"uniqid"];
            if([[[objDictionary valueForKey:@"content_type"]valueForKey:@"text"] isEqualToString:@"audio"])
            {
                [same removeFromSuperview];
                [movieView removeFromSuperview];
                same = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
                QuesImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,same.frame.size.width,same.frame.size.height)];
                same.backgroundColor = [UIColor clearColor];
                [same addSubview:QuesImg];
                
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:same];
                
                NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
                
                audioPath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [recordAVStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
                
                reAudioPlayer = NULL;
                if(reAudioPlayer == NULL)
                {
                    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    reAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL  error:nil];
                }
                [reAudioPlayer setDelegate:self];
                [reAudioPlayer play];
                
            }
            else
            {
                [same removeFromSuperview];
                [movieView removeFromSuperview];
                movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 2,SCREEN_WIDTH,inputView.frame.size.height/3)];
                [scrollView addSubview:movieView];
                
                if(recVideoPlayer == NULL)
                {
                    
                    recVideoPlayer = [[AVPlayerViewController alloc] init];
                    recVideoPlayer.showsPlaybackControls = YES;
                    
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish1:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
                    
                    
                    
                    
                    
                }
//                minute.hidden = TRUE;
//                remaingText.hidden = TRUE;
                [recordAVStop setImage:[UIImage imageNamed:@"CameraDisable.png"] forState:UIControlStateNormal];
                
                NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[objDictionary valueForKey:@"content_path"]valueForKey:@"text"]];
//                NSString * FilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//                NSString *HTMLData =[NSString stringWithFormat:@"file:///%@",FilePath];
                NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                playVideo = [[AVPlayer alloc] initWithURL:fileURL];
                recVideoPlayer.player = playVideo;
                [recVideoPlayer.player play];
                
                //recVideoPlayer.contentURL = [[NSURL alloc]initFileURLWithPath:FilePath];
                //[recVideoPlayer prepareToPlay];
                
                UIView *invisible = [[UIView alloc]initWithFrame:CGRectMake(movieView.frame.size.width-100,movieView.frame.size.height-50 , 100, 50)];
                
                invisible.backgroundColor = [UIColor clearColor];
                [recVideoPlayer.view addSubview:invisible];
                recVideoPlayer.view.frame = movieView.bounds;
                [movieView addSubview:recVideoPlayer.view];
                
            }
        }
        
    }
    else if(recorder == _avrecorder )
    {
        
        recordStop.enabled = FALSE;
        [recordStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
        recorder = NULL;
        NSString *llTempPath;
        llTempPath = [[NSString alloc]initWithFormat:@"%@_%@_%@.wav",[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
        [fileArray addObject:llTempPath];
        NSMutableDictionary *avObj = [self createDictionaryifNot:globalDictionary type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        [avObj setObject:fileArray forKey:@"option"];
        [self addOrReplace:avObj];
//        //footerView.hidden = FALSE;
//        mcqSubmitBtn.hidden = FALSE;
//        contiBtn.hidden = TRUE;
//        //[self clickShowAnswer:self];
        [self enableQuizBtn];
        
    }
    else if(sana_recorder == _avrecorder )
    {
        //recordSanaStop.enabled = FALSE;
        [recordSanaStop setImage:[UIImage imageNamed:@"MEPro_record.png"] forState:UIControlStateNormal];
        NSMutableDictionary *requestObj = [[NSMutableDictionary alloc] init];
        [requestObj setValue:SERVICE_SANAAUDIOUPLOAD forKey:@"SERVICE"];
        NSMutableString * file = [[NSMutableString alloc]initWithFormat:@"%@.wav",[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:_avrecorder.url.path];
        NSMutableDictionary * resData;
        if(data.length > 4096){
            [self showGlobalProgress];
            [appDelegate.engineObj.networkObj sendRequestToSANAASyncAduro:SANAVOICEAPI data:data method:@"POST" : [[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] : [appDelegate.global_userInfo valueForKey:DATABASE_TOKEN]: @"wav" : file:requestObj];
        }
        else
        {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Could not hear you properly. Please retry." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            NSString * str = [[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"] valueForKey:@"time_limit"]valueForKey:@"text"] ;
            
            totaltime = [str integerValue];
            if(totaltime <= 0) totaltime = 5;
            int min = totaltime/60;
            int second = totaltime%60;
            NSString * time = [[NSString alloc]initWithFormat:@"%02d:%02d",min,second];
            minute.text = time;
        }
        
        NSString *llTempPath;
        llTempPath = [[NSString alloc]initWithFormat:@"%@_%@_%@.wav",[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
        [fileArray addObject:llTempPath];
        NSMutableDictionary *avObj = [self createDictionaryifNot:globalDictionary type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
        [avObj setObject:fileArray forKey:@"option"];
        [self addOrReplace:avObj];
        //        footerView.hidden = FALSE;
        //        mcqSubmitBtn.hidden = TRUE;
        //        contiBtn.hidden = FALSE;
        //        [self clickShowAnswer:self];
        
    }
    
    
    
    
    
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected tagConfig:(TTGTextTagConfig *)config {
    //[NSString stringWithFormat:@"Tap tag: %@, at: %ld, selected: %d", tagText, (long) index, selected];
    
    if(textTagCollectionView == dottedBox){
        [dottedBox removeTag:tagText];
        [ddBox addTag:tagText];
    }else
    {
        [ddBox removeTag:tagText];
        [dottedBox addTag:tagText];
    }
    [dottedBox reload];
    [ddBox reload];
    if([dottedBox.allTags count] == [ddBoxArr count]){
        [self enableQuizBtn];
    }
    else
    {
        [self disableQuizBtn];
    }
    //dottedBox.frame = CGRectMake(20, questheight1+10, SCREEN_WIDTH-40, 100);
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView updateContentSize:(CGSize)contentSize {
    NSLog(@"text tag collection: %@ new content size: %@", textTagCollectionView, NSStringFromCGSize(contentSize));
    
}



#pragma mark UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return @"";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == sanatable)
    {
        return [phoneme_scores count];
    }
    else
    {
        return leftArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    UIView * cell_view;
    UILabel * textLbl;
    UIImageView *imgView;
    UIImageView *half_imgView;
    UILabel * score,*ipa,*soundLike;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        if(tableView == sanatable)
        {
            cell_view = [[UIView alloc]initWithFrame:CGRectMake(5, 5,cell.contentView.frame.size.width,35)];
        }
        else
        {
            cell_view = [[UIView alloc]initWithFrame:CGRectMake(5, 5,(scrollView.frame.size.width/2)-10,90)];
            //cell_view = [[UIView alloc]initWithFrame:CGRectMake(5, 5,(scrollView.frame.size.width/2)-10,90)];
        }
        //cell_view.backgroundColor = [UIColor redColor];
        cell_view.tag = 1;
        
        [cell.contentView addSubview:cell_view];
        
        textLbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, cell_view.frame.size.width-35, cell_view.frame.size.height)];
        textLbl.numberOfLines = 3;
        textLbl.lineBreakMode = NSLineBreakByWordWrapping;
        textLbl.tag = 2;
        [cell_view addSubview:textLbl];
        
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,cell_view.frame.size.width-10, cell_view.frame.size.height)];
        imgView.tag = 3;
        [cell_view addSubview:imgView];
        
        
        
        score = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, cell_view.frame.size.width/3,25)];
        score.textAlignment = NSTextAlignmentLeft;
        score.tag = 4;
        [cell_view addSubview:score];
        
        ipa = [[UILabel alloc]initWithFrame:CGRectMake(cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
        ipa.textAlignment = NSTextAlignmentLeft;
        ipa.tag = 5;
        [cell_view addSubview:ipa];
        
        soundLike = [[UILabel alloc]initWithFrame:CGRectMake(2*cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
        soundLike.tag = 6;
        soundLike.textAlignment = NSTextAlignmentLeft;
        [cell_view addSubview:soundLike];
        
        half_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,cell_view.frame.size.width-10, cell_view.frame.size.height)];
        half_imgView.tag = 7;
        [cell_view addSubview:half_imgView];
        
        
    }
    else
    {
        cell_view = (UIView*)[cell.contentView viewWithTag:1];
        if(tableView == sanatable)
        {
            cell_view.frame = CGRectMake(5, 5,cell.contentView.frame.size.width,35);
        }
        else
        {
            cell_view.frame = CGRectMake(5, 5,(scrollView.frame.size.width/2)-10,90);
            //cell_view = [[UIView alloc]initWithFrame:CGRectMake(5, 5,(scrollView.frame.size.width/2)-10,90)];
        }
        textLbl = (UILabel*)[cell_view viewWithTag:2];
        imgView = (UIImageView*)[cell_view viewWithTag:3];
        score = (UILabel*)[cell_view viewWithTag:4];
        ipa = (UILabel*)[cell_view viewWithTag:5];
        soundLike = (UILabel*)[cell_view viewWithTag:6];
        half_imgView = (UIImageView*)[cell_view viewWithTag:7];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    if(tableView == sanatable)
    {
        cell.userInteractionEnabled = NO;
        cell_view.layer.borderColor = [UIColor whiteColor].CGColor;
        cell_view.layer.borderWidth = 1.0f;
        cell_view.frame = CGRectMake(5, 5,cell.contentView.frame.size.width,35);
        NSDictionary * obj = [phoneme_scores objectAtIndex:indexPath.row];
        score.hidden = FALSE;
        ipa.hidden = FALSE;
        soundLike.hidden = FALSE;
        half_imgView.hidden = TRUE;
        
        score.text = [[NSString alloc]initWithFormat:@"%d",[[obj valueForKey:@"quality_score"]intValue] ];
        
        ipa.text = [obj valueForKey:@"phone"];
        if([[obj valueForKey:@"sound_most_like"] isEqual:[NSNull null]])
           soundLike.text = @"";
        else
           soundLike.text = [obj valueForKey:@"sound_most_like"];
            
        score.font = HEADERSECTIONTITLEFONT;
        ipa.font = HEADERSECTIONTITLEFONT;
        soundLike.font = HEADERSECTIONTITLEFONT;
        
        if([[obj valueForKey:@"quality_score"]intValue] >= 80)
        {
            
            score.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            
        }
        else if ([[obj valueForKey:@"quality_score"]intValue] >= 51 && [[obj valueForKey:@"quality_score"]intValue] <= 79)
        {
            score.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
        }
        else if ([[obj valueForKey:@"quality_score"]intValue] >= 1 && [[obj valueForKey:@"quality_score"]intValue] <= 50)
        {
            score.textColor = [self getUIColorObjectFromHexString:@"#d81e11" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#d81e11" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#d81e11" alpha:1.0];
        }
        else
        {
            score.textColor = [self getUIColorObjectFromHexString:@"#808080" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#808080" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#808080" alpha:1.0];
        }
        
        
    }
    else
    {
        cell.userInteractionEnabled = YES;
        // cell_view.frame = CGRectMake(5, 5,(scrollView.frame.size.width/2)-10,90);
        
        score.hidden = TRUE;
        ipa.hidden = TRUE;
        soundLike.hidden = TRUE;
        textLbl.hidden = FALSE;
        imgView.hidden = FALSE;
        cell_view.hidden = FALSE;
        cell_view.layer.borderColor = [self getUIColorObjectFromHexString:@"#eeeeee" alpha:1.0 ].CGColor;
        if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mttt"])
        {
            
            imgView.hidden = TRUE;
            textLbl.font = HEADERSECTIONTITLEFONT;
            textLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            if(tableView == leftTableView){
                //textLbl.frame =
                
                half_imgView.frame = CGRectMake(cell_view.frame.size.width-20, 35,20,20);
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Left.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-10,90);
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMinXMinYCorner;
                cell_view.clipsToBounds = YES;
                textLbl.text = [[leftArr objectAtIndex:indexPath.row] valueForKey:@"text"];
            }
            else
            {
                cell_view.frame = CGRectMake(0, 5,scrollView.frame.size.width/2-5,90);
                cell_view.layer.borderWidth = 1;
                half_imgView.frame = CGRectMake(0, 35,20,20);
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Right.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    
                }
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMaxXMaxYCorner| kCALayerMaxXMinYCorner;
                cell_view.clipsToBounds = YES;
                
                textLbl.text = [[rightArr objectAtIndex:indexPath.row] valueForKey:@"text"];
            }
        }
        else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtii"])
        {
            textLbl.hidden = TRUE;
            if(tableView == leftTableView){
                
                
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Left.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-10,90);
                    
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                half_imgView.frame = CGRectMake(cell_view.frame.size.width-20, 35,20,20);
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMinXMinYCorner;
                cell_view.clipsToBounds = YES;
                
                //                NSString * imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                
                NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                NSString * imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [imgView setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            }
            else
            {
                cell_view.frame = CGRectMake(0, 5,scrollView.frame.size.width/2-5,90);
                cell_view.layer.borderWidth = 1;
                half_imgView.frame = CGRectMake(0, 35,20,20);
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Right.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    
                }
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMaxXMaxYCorner| kCALayerMaxXMinYCorner;
                cell_view.clipsToBounds = YES;
                
                //NSString * imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                NSString * imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [imgView setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            }
        }
        else if([[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"mtti"])
        {
            textLbl.font = HEADERSECTIONTITLEFONT;
            textLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            if(tableView == leftTableView){
                
                
                half_imgView.frame = CGRectMake(cell_view.frame.size.width-20, 35,20,20);
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Left.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-10,90);
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    cell_view.frame = CGRectMake(10, 5,scrollView.frame.size.width/2-5,90);
                }
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMinXMinYCorner;
                cell_view.clipsToBounds = YES;
                
                textLbl.text = [[leftArr objectAtIndex:indexPath.row] valueForKey:@"text"];
            }
            else
            {
                cell_view.frame = CGRectMake(0, 5,scrollView.frame.size.width/2-5,90);
                
                cell_view.layer.borderWidth = 1;
                half_imgView.frame = CGRectMake(0, 35,20,20);
                UIImage * T_img =  [UIImage imageNamed:@"MePro_Right.png"];
                T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                if(rightDrawFlag == 0){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#36bbe1" alpha:1.0]];
                    
                }
                else if(rightDrawFlag == 1){
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#89c63b" alpha:1.0]];
                    
                }
                else
                {
                    [half_imgView setTintColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0]];
                    
                }
                half_imgView.image =T_img;
                cell_view.layer.borderWidth = 1;
                cell_view.layer.cornerRadius = 10;
                cell_view.layer.maskedCorners = kCALayerMaxXMaxYCorner| kCALayerMaxXMinYCorner;
                cell_view.clipsToBounds = YES;
                //NSString * imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                
                NSString * _path = [phoneDocumentDirectory stringByAppendingPathComponent:[[rightArr objectAtIndex:indexPath.row]valueForKey:@"text"]];
                NSString * imageFilePath =  [_path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [imgView setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
            }
            
        }
        
    }
    return cell;
}




#pragma mark -

#pragma mark UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleNone;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == sanatable)
        return 35;
    else
        return 100;
}


#pragma mark -


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark DragAndDropTableViewDataSource


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    UITableViewCell *cell = (UITableViewCell *)[leftTableView cellForRowAtIndexPath:destinationIndexPath];
    cell.backgroundColor = [self getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    
    UITableViewCell *cell1 = (UITableViewCell *)[leftTableView cellForRowAtIndexPath:sourceIndexPath];
    cell1.backgroundColor = [UIColor clearColor];
    
    [leftTableView setContentOffset:rightTableView.contentOffset animated:true];
    
    [self enableQuizBtn];
}

-(void)tableView:(UITableView *)tableView willBeginDraggingCellAtIndexPath:(NSIndexPath *)indexPath placeholderImageView:(UIImageView *)placeHolderImageView
{
    // this is the place to edit the snapshot of the moving cell
    // add a shadow
    placeHolderImageView.layer.shadowOpacity =.3;
    placeHolderImageView.layer.shadowRadius = 1;
}

-(void)tableView:(DragAndDropTableView *)tableView didEndDraggingCellAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)toIndexPath placeHolderView:(UIImageView *)placeholderImageView
{
    UITableViewCell *cell1 = (UITableViewCell *)[leftTableView cellForRowAtIndexPath:toIndexPath];
    cell1.backgroundColor = [UIColor clearColor];
    
    
    if(sourceIndexPath != nil &&   toIndexPath != nil){
        
        [tableView beginUpdates];
        [rightArr exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:toIndexPath.row];
        [tableView endUpdates];
    }
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)_scrollView{
    
    leftTableView.frame  = CGRectMake(0,questheight1, leftTableView.frame.size.width,scrollView.contentOffset.y + scrollView.frame.size.height-questheight1);
    
    rightTableView.frame = CGRectMake(scrollView.frame.size.width/2,questheight1, rightTableView.frame.size.width,scrollView.contentOffset.y + scrollView.frame.size.height-questheight1);
    //scrollView.contentOffset= CGPointMake(0, questheight1);
    // rightTableView.scrollEnabled = FALSE;
    // rightTableView.userInteractionEnabled = FALSE;
    if(_scrollView == scrollView){
        rightTableView.scrollEnabled  = (scrollView.contentOffset.y >= scrollView.frame.size.height- rightTableView.frame.origin.y);
        //rightTableView.scrollEnabled = FALSE;
        //rightTableView.userInteractionEnabled = FALSE;
    }
    
    
    if(_scrollView == rightTableView){
        rightTableView.scrollEnabled  = (scrollView.contentOffset.y > 0);
        //rightTableView.scrollEnabled = TRUE;
        //rightTableView.userInteractionEnabled = TRUE;
        if(_scrollView == leftTableView)
        {
            rightTableView.contentOffset = _scrollView.contentOffset;
            [rightTableView setContentSize:CGSizeMake(rightTableView.frame.size.width, _scrollView.contentSize.height)];
            
        }
        else
        {
            leftTableView.contentOffset = _scrollView.contentOffset;
            [leftTableView setContentSize:CGSizeMake(leftTableView.frame.size.width, _scrollView.contentSize.height)];
            
        }
    }
    
}


- (void)holdDown
{
    [audioPlayer stop];
    [sanaAudioPlayer stop];
    [sanaTimer invalidate];
    NSLog(@"hold release");
    isAudioRecording = FALSE;
    localProgress =0;
    [progressView4 setProgress:localProgress];
    if(sana_recorder != NULL && isAudioRecording)
    {
        [sana_recorder stop];
    }
    sana_recorder = NULL;
    NSLog(@"hold down");
    if (sana_recorder == NULL &&  !sana_recorder.recording && !isAudioRecording )
    {
        NSError *error;
        NSError * err;
        
        NSString * str = [[NSString alloc]initWithFormat:@"records"];
        NSString *dataPath = [phoneDocumentDirectory stringByAppendingPathComponent:str];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])//Check
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Will Create folder
        
        NSString *strUser = [[NSString alloc]initWithFormat:@"%@_%@_%@",[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]];
        
        NSString *trimmedString = [strUser stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        NSMutableString * record_Word = [[NSMutableString alloc] initWithString:trimmedString];
        [record_Word appendFormat:@".wav"];
        NSArray *pathComponents = [NSArray arrayWithObjects:
                                   dataPath,
                                   record_Word,
                                   nil];
        
        NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
        audioPath = outputFileURL.absoluteString;
        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
        [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [settings setValue: [NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];//8000.0
        
        [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
        [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
        sana_recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:settings error:&err];
        sana_recorder.delegate = self;
        sana_recorder.meteringEnabled = YES;
        [sana_recorder prepareToRecord];
        
        [sana_recorder record];
        footerView.hidden = TRUE;
        isAudioRecording= TRUE;
        [recordSanaStop setImage:[UIImage imageNamed:@"MEPro_pause.png"] forState:UIControlStateNormal];
        
        sanaTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    }
    
    
}

- (void)holdRelease
{
    [sanaTimer invalidate];
    NSLog(@"hold release");
    if(sana_recorder != NULL && isAudioRecording)
    {
        [sana_recorder stop];
        //recorder = NULL;
        localProgress =0;
        [progressView4 setProgress:localProgress];
    }
}

- (void)updateProgress:(NSTimer *)timer {
    CGFloat t = (CGFloat)((CGFloat)1.0 / (CGFloat)(totaltime*20));
    localProgress = localProgress +t;
    if(localProgress > 1)
    {
        localProgress =0;
        [sanaTimer invalidate];
        if(sana_recorder != NULL && isAudioRecording)
        {
            [sana_recorder stop];
        }
    }
    [progressView4 setProgress:localProgress];
}


-(void)enableQuizBtn
{
    mcqSubmitBtn.enabled =  TRUE;
    mcqSubmitBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    lineView.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR alpha:1.0];
}

-(void)disableQuizBtn
{
    mcqSubmitBtn.enabled =  FALSE;
    mcqSubmitBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
    lineView.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_BUTTON_BACKGROUND_DISABLE_COLOR alpha:1.0];
}


-(void)showFeedback:(NSString *)ansId :(BOOL)isTrue :(NSString *)quesType
{
    if(!isShowFeedback) return;
    NSString * text;
    if([quesType isEqualToString:@"mc"]||[quesType isEqualToString:@"mca"]||[quesType isEqualToString:@"mci"])
    {
        text = [self getFeedbackfromAnserId:[[NSString alloc]initWithFormat:@"fb_%@",ansId]];
    }
    else
    {
        if(isTrue)
            text = [self getFeedbackfromAnserId:[[NSString alloc]initWithFormat:@"fb_%@",@"true"]];
        else
            text = [self getFeedbackfromAnserId:[[NSString alloc]initWithFormat:@"fb_%@",@"false"]];
    }
    
    
    if(text == nil || [text isEqualToString:@""])return;
    
    //NSString * text  = [[[feedbackArray objectAtIndex:0] valueForKey:@"content"] valueForKey:@"text"];
    answerFeedbackUi = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2-60)];
    UIView * headerView =  [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,40)];
    UIImageView * rightImage  =  [[UIImageView alloc]initWithFrame:CGRectMake(5, 12, 15, 15)];
    rightImage.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *lbltext = [[UILabel alloc]initWithFrame:CGRectMake(25,0, SCREEN_WIDTH-25,40)];
    UILabel *desctxt = [[UILabel alloc]initWithFrame:CGRectMake(25,40, SCREEN_WIDTH-25,answerFeedbackUi.frame.size.height-20)];
    
    NSAttributedString *attrText3 = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style,NSFontAttributeName : TEXTTITLEFONT}];
    desctxt.attributedText  = attrText3;
    desctxt.numberOfLines =0;
    desctxt.lineBreakMode = NSLineBreakByWordWrapping;
    desctxt.font = TEXTTITLEFONT;
    desctxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    //    CGSize expectedLabelSize3 = [attrText3.string sizeWithFont:desctxt.font
    //                                             constrainedToSize:desctxt.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    //    int height3 = expectedLabelSize3.height +30;
    int height3 = [self cus_heightForText:attrText3 font:desctxt.font withinWidth:desctxt.frame.size.width] +MC_MMC_TEST_TOP_BOTTOM_PADDING;
    
    if(isTrue)
    {
        answerFeedbackUi.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:0.5];
        headerView.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
        lbltext.text = @"Correct";
        lbltext.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
        rightImage.image = [UIImage imageNamed:@"G_Right.png"];
        
    }
    else
    {
        answerFeedbackUi.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:0.5];
        headerView.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
        lbltext.text = @"Incorrect";
        lbltext.textColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0];
        rightImage.image = [UIImage imageNamed:@"G_Wrong.png"];
        //rightImage.frame = CGRectMake(5, 12, 15, 15);
    }
    
    desctxt.frame = CGRectMake(25,40,SCREEN_WIDTH-20, height3);
    answerFeedbackUi.frame = CGRectMake(0,scrollView.contentSize.height-90,SCREEN_WIDTH, height3+50);
    
    [answerFeedbackUi addSubview:desctxt];
    [headerView addSubview:lbltext];
    [headerView addSubview:rightImage];
    [answerFeedbackUi addSubview:headerView];
    [scrollView addSubview:answerFeedbackUi];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+height3+20);
    footerView.frame = CGRectMake(0, scrollView.contentSize.height-60, scrollView.frame.size.width,60);
    
}

-(NSString *)getFeedbackfromAnserId :(NSString *)uid
{
    if([uid isEqualToString:@"fb_true"] && [feedbackArray count] > 0 && ![[[feedbackArray objectAtIndex:0] valueForKey:@"content"] isEqual:[NSNull null]])
    {
        return [[[feedbackArray objectAtIndex:0] valueForKey:@"content"]valueForKey:@"text"];
    }
    else if([uid isEqualToString:@"fb_false"] && [feedbackArray count] > 1 && ![[[feedbackArray objectAtIndex:1] valueForKey:@"content"] isEqual:[NSNull null]])
    {
        return [[[feedbackArray objectAtIndex:1] valueForKey:@"content"]valueForKey:@"text"];
    }
    
    for (NSDictionary* obj in feedbackArray) {
        
        if([[obj valueForKey:@"uniqid"]isEqualToString:uid] && ![[obj valueForKey:@"content"] isEqual:[NSNull null]])
        {
            return [[obj valueForKey:@"content"]valueForKey:@"text"];
        }
    }
    return @"";
}

-(CGFloat)quesHeightForText:(NSAttributedString *)text font:(UIFont*)font withinWidth:(CGFloat)width :(int)count {
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat f_height = rect.size.height;
    if(f_height > 14) return f_height;
    else return 14.0;
    
}



-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    CGFloat f_height = ceilf(height / font.lineHeight) * font.lineHeight;
    if(f_height > 15) return f_height;
    else return 15.0;
    
}

-(CGFloat)cus_heightForText:(NSAttributedString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGFloat f_height = rect.size.height;
    if(f_height > 14) return f_height;
    else return 14.0;
    
}


-(UIView *)createUILabelMCMMC:(NSString *)htmlText
{
    NSAttributedString *attrText = [self convertOptionHTMLAttibute:htmlText];
    int height = [self cus_heightForText:attrText font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-75]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
    
    UIView * _view = [[UIView alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-50,height)];
    CALayer * lay1 = [_view layer];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:20.0];
    [lay1 setBorderWidth:1.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    
    UILabel *copyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _view.frame.size.width-25, _view.frame.size.height)];
    copyLabel.numberOfLines = 0 ;
    copyLabel.font  = TEXTTITLEFONT;
    copyLabel.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    copyLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    copyLabel.textAlignment = NSTextAlignmentLeft;
    copyLabel.attributedText = attrText;
    [_view addSubview:copyLabel];
    return _view;
}

-(BOOL)matchMMCoptionWithAnswer:(NSDictionary *)optionObj  :(NSDictionary *)ansObj
{
    if([ansObj valueForKey:@"ansObj1"] != NULL && [[ansObj valueForKey:@"option1"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj1"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj2"] != NULL && [[ansObj valueForKey:@"option2"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj2"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj3"] != NULL && [[ansObj valueForKey:@"option3"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj3"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj4"] != NULL && [[ansObj valueForKey:@"option4"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj4"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj5"] != NULL && [[ansObj valueForKey:@"option5"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj5"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj6"] != NULL && [[ansObj valueForKey:@"option6"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj6"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj7"] != NULL && [[ansObj valueForKey:@"option7"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj7"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else if([ansObj valueForKey:@"ansObj8"] != NULL && [[ansObj valueForKey:@"option8"] isEqualToString:@"1"] && [[optionObj valueForKey:@"uniqid"]isEqualToString:[[ansObj valueForKey:@"ansObj8"]valueForKey:@"uniqid"]])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
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
        str = [[NSString alloc]initWithFormat:@"%02d:%02dm",min,sec];
    }
    else
    {
        str = [[NSString alloc]initWithFormat:@"%02dhr %02dmin %02ds",hr,min,sec];
    }
    return str;
}




@end



