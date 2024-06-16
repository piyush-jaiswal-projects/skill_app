//
//  QTComponanat.m
//  InterviewPrep
//
//  Created by Amit Gupta on 25/09/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "QTComponanat.h"
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
#import "CustomUIView.h"
#import "QTSummaryReport.h"






#define SELECTION_BG_COLOR  @"#ebf8fc"
#define SELECTION_OURLINECOLOR @"#36bbe1"

#define WRONG_SELECTION_BG_COLOR  @"#fdeeef"
#define WRONG_SELECTION_OURLINECOLOR @"#ed5565"

#define RIGHT_SELECTION_BG_COLOR  @"#e7f4d8"
#define RIGHT_SELECTION_OURLINECOLOR @"#89c63b"

#define MC_MMC_TEST_TOP_BOTTOM_PADDING 25



@interface QTComponanat ()<WKUIDelegate,WKNavigationDelegate,TTGTextTagCollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,DragAndDropTableViewDataSource,DragAndDropTableViewDelegate,UIGestureRecognizerDelegate>
{
    AVPlayerViewController * reviewVideoViewPlayer;
    AVPlayerViewController * modalVideoViewPlayer;
    AVPlayerViewController * expertVideoViewPlayer;
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
    
        UITextView * answer;
        UIImageView * rWImage;
        UIView * showPopUp;
    UIButton * reviewBtn;
    
    
    BOOL expertPlayStat;
    UIImageView * expertBtnImg;
    BOOL modalPlayStat;
    UIImageView * modalBtnImg;
    BOOL reviewPlayStat;
    UIImageView * reviewBtnImg;
    
    UIView * questionAudioView;
    UIView * questionModalAudioView;
    UIView * AnswerAudioView;
    
    
}
//@property (strong, nonatomic) LSFloatingActionMenu *actionMenu;
@end

@implementation QTComponanat


- (IBAction)ShowSampleAns:(UIButton *)sender {
    if([sampleText.text isEqualToString:@"Close"])
    {
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
        [obj setValue:_assessnetUid forKey:@"assessId"];
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
            
            
            
            int duration = 2; // duration in seconds
            
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
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -10.0f;
    
    
    
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
    else if ([[[globalDictionary valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0  && [[[[globalDictionary valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
    {
        UIImage * img = [UIImage imageNamed:@"vocabulary_playGrey120x120.png"];
        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        recordStop.tintColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
        [recordStop setImage:img forState:UIControlStateNormal];
        recordStop.enabled =  TRUE;
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
    else if([[calObj valueForKey:@"type"]isEqualToString:@"mc"] || [[calObj valueForKey:@"type"]isEqualToString:@"mci"] || [[calObj valueForKey:@"type"]isEqualToString:@"mca"] )
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
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(v.frame.size.width-20, v.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [v addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(wv.frame.size.width-20, wv.frame.size.height/2-8, 15,15 )];
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
            
            
            
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(v.frame.size.width-20, v.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [v addSubview:rightImg];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(wv.frame.size.width-20, wv.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [wv addSubview:wrongImg];
            
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
        
        
        if(text.tag  == 101)
        {
            CALayer * lay1 = [text layer];
            text.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text.frame.size.width-20, text.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text addSubview:wrongImg];
            
            
        }
        
        if(text1.tag  == 101)
        {
            CALayer * lay1 = [text1 layer];
            text1.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text1.frame.size.width-20, text1.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text1 addSubview:wrongImg];
        }
        if(text2.tag  == 101)
        {
            CALayer * lay1 = [text2 layer];
            text2.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text2.frame.size.width-20, text2.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text2 addSubview:wrongImg];
        }
        
        if(text3.tag  == 101)
        {
            CALayer * lay1 = [text3 layer];
            text3.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text3.frame.size.width-20, text3.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text3 addSubview:wrongImg];
        }
        
        if(text4.tag  == 101)
        {
            CALayer * lay1 = [text4 layer];
            text4.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text4.frame.size.width-20, text4.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text4 addSubview:wrongImg];
        }
        
        if(text5.tag  == 101)
        {
            CALayer * lay1 = [text5 layer];
            text5.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text5.frame.size.width-20, text5.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text5 addSubview:wrongImg];
        }
        if(text6.tag  == 101)
        {
            CALayer * lay1 = [text6 layer];
            text6.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text6.frame.size.width-20, text6.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text6 addSubview:wrongImg];
        }
        
        if(text7.tag  == 101)
        {
            CALayer * lay1 = [text7 layer];
            text7.backgroundColor = [self getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(text7.frame.size.width-20, text7.frame.size.height/2-8, 15,15 )];
            wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [text7 addSubview:wrongImg];
        }
        
        
        
        
        
        
        
        if(op8.tag == 1000)
        {
            CALayer * lay1 = [text7 layer];
            text7.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text7.frame.size.width-20, text7.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text7 addSubview:rightImg];
            
            
        }
        if(op7.tag == 1000)
        {
            CALayer * lay1 = [text6 layer];
            text6.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text6.frame.size.width-20, text6.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text6 addSubview:rightImg];
            
        }
        if(op6.tag == 1000)
        {
            CALayer * lay1 = [text5 layer];
            text5.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text5.frame.size.width-20, text5.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text5 addSubview:rightImg];
        }
        if(op5.tag == 1000)
        {
            CALayer * lay1 = [text4 layer];
            text4.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text4.frame.size.width-20, text4.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text4 addSubview:rightImg];
        }
        if(op4.tag == 1000)
        {
            CALayer * lay1 = [text3 layer];
            text3.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text3.frame.size.width-20, text3.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text3 addSubview:rightImg];
        }
        if(op3.tag == 1000)
        {
            CALayer * lay1 = [text2 layer];
            text2.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text2.frame.size.width-20, text2.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text2 addSubview:rightImg];
        }
        if(op2.tag == 1000)
        {
            CALayer * lay1 = [text1 layer];
            text1.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text1.frame.size.width-20, text1.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text1 addSubview:rightImg];
        }
        if(op1.tag == 1000)
        {
            CALayer * lay1 = [text layer];
            text.backgroundColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
            [lay1 setMasksToBounds:YES];
            [lay1 setCornerRadius:20.0];
            [lay1 setBorderWidth:1.0];
            [lay1 setBorderColor:[[self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(text.frame.size.width-20, text.frame.size.height/2-8, 15,15 )];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [text addSubview:rightImg];
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
            config.textFont = [UIFont systemFontOfSize:12.0f];
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
            config.textFont = [UIFont systemFontOfSize:12.0f];
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
            rightAns.font = [UIFont systemFontOfSize:12.0];
            //            rightAns.numberOfLines = 3;
            //            rightAns.lineBreakMode =  NSLineBreakByWordWrapping;
            rightAns.text = [[NSString alloc]initWithFormat:@"Correct answer is: %@",strAnsMessage];
            rightAns.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
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
        NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",13.0,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
            
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
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+height+20);
        footerView.frame = CGRectMake(0, scrollView.contentSize.height-60, scrollView.frame.size.width,60);
        
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"fb"])
    {
        int height = [fbView showRightWrongAnswerUI];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+height+20);
        footerView.frame = CGRectMake(0, scrollView.contentSize.height-60, scrollView.frame.size.width,60);
        
    }
    else if([[calObj valueForKey:@"type"]isEqualToString:@"es"])
    {
        
        UITextView * rightAns = [[UITextView alloc]initWithFrame:CGRectMake(areaTxt.frame.origin.x, areaTxt.frame.origin.y+areaTxt.frame.size.height+30,areaTxt.frame.size.width , 20)];
        rightAns.font = [UIFont systemFontOfSize:12.0];
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
            
//            UITextView * rightAns = [[UITextView alloc]initWithFrame:CGRectMake(30, recordStop.frame.origin.y+recordStop.frame.size.height+10,SCREEN_WIDTH-60 , 20)];
//            rightAns.font = [UIFont systemFontOfSize:12.0];
//
//            rightAns.textColor = [self getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
//            [scrollView addSubview:rightAns];
            
            showPopUp.hidden = FALSE;
            rWImage.image = [UIImage imageNamed:@"right"];
            answer.text = [[NSString alloc]initWithFormat:@"Your answer is submitted"];
            
            
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
//    if([CLASS_NAME isEqualToString:@"wiley"]){
//      if(popup.hidden)popup.hidden = FALSE;
//    }
     if(isRecording)
     {
         [self clickCameraStartPlay:self];
     }
    videoViewPlayer.showsPlaybackControls = NO;
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
        minute.hidden = TRUE;
        remaingText.hidden = TRUE;
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
            [uiResponse setValue:SUCCESS forKey:UIRESPONSERESULT];
            [uiResponse setValue:[[notification object]valueForKey:@"data"] forKey:UIRESPONSE];
        }
        SanaResp = uiResponse;
        if([SanaResp valueForKey:@"RESP"] == NULL ||  [[SanaResp valueForKey:@"RESP"]valueForKey:@"errors"] != NULL  )
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
            dispatch_async(dispatch_get_main_queue(), ^{
            sanaScoLbl.text = [[NSString alloc]initWithFormat:@"%@%%",[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]];
            if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=70)
            {
                sanaScoLbl.textColor = [UIColor greenColor];
                sanaScoreIns.text = @"Perfect, native-like.  well done!";
            }
            else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=70)
            {
                sanaScoLbl.textColor = [UIColor greenColor];
                sanaScoreIns.text =@"Good &amp; Intelligible! To improve your score, keep practicing";
            }
            else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=56 )
            {
                
                sanaScoLbl.textColor = [UIColor yellowColor];
                sanaScoreIns.text =@"It sounds ok, there is room for improvement! Try again, click on the underlined words to learn the right pronunciation";
            }
            else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=56 )
            {
                
                sanaScoLbl.textColor = [UIColor yellowColor];
                //sanaScoreIns.text =@"Good &amp; Intelligible! To improve your score, keep practicing";
            }
            else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] <= 55 && [[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=50 )
            {
                sanaScoLbl.textColor = [UIColor redColor];
                sanaScoreIns.text =@"That doesn’t sound good! Try again, click on the underlined words to learn the right pronunciation";
            }
            else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] < 50)
            {
                sanaScoLbl.textColor = [UIColor redColor];
            }
            });
            wordSANAArr = [[SanaResp valueForKey:@"RESP"]valueForKey:@"word_scores"];
            
            NSArray * wordArr = wordSANAArr;
            NSMutableString * dynamicDta = [[NSMutableString alloc]initWithString:@""];
            
            for (int wordC = 0; wordC < [wordArr count]; wordC++) {
                NSDictionary * wordObj = [wordArr objectAtIndex:wordC];
                if([[wordObj valueForKey:@"score"]intValue] >= 70)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor green\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"score"]intValue] >= 56)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor yellow\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"score"]intValue] >= 54)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"fontColor yellow\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                    if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] >=56 && [[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] <= 69)
                    {
                        sanaScoreIns.text =@"It sounds ok, there is room for improvement! Try again to improve your score";
                    }
                    else if([[[SanaResp valueForKey:@"RESP"]valueForKey:@"overall_score"]intValue] <= 55 )
                    {
                        sanaScoreIns.text =@"That doesn’t sound good! Try again to improve your score";
                    }
                    
                    
                }
                else if([[wordObj valueForKey:@"score"]intValue] < 40)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d')\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"score"]intValue] >= 1)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d');\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                else if([[wordObj valueForKey:@"score"]intValue] == 0)
                {
                    [dynamicDta appendFormat:@"<div onclick=\"alert('%d');\" class=\"underline fontColor red\">",wordC];
                    [dynamicDta appendFormat:@"%@<div style=\"clear:both; overflow:hidden;\"></div>",[wordObj valueForKey:@"word"]];
                    
                }
                
                NSArray * arrPhonem  = [wordObj valueForKey:@"phoneme_scores"];
                for (int phonemC =0 ; phonemC < [arrPhonem count] ; phonemC++) {
                    NSDictionary * phonemObj = [arrPhonem objectAtIndex:phonemC];
                    if([[phonemObj valueForKey:@"score"]intValue] >= 70)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase grey\">"];
                    }
                    else if([[phonemObj valueForKey:@"score"]intValue] >= 56)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase yellow\">"];
                    }
                    else if([[phonemObj valueForKey:@"score"]intValue] >= 1)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase red\">"];
                    }
                    else if([[phonemObj valueForKey:@"score"]intValue] == 0)
                    {
                        [dynamicDta appendString:@"<span class=\"phrase red\">"];
                    }
                    
                    if(phonemC == [arrPhonem count]-1)
                        [dynamicDta appendFormat:@"%@</span>",[phonemObj valueForKey:@"phoneme"]];
                    else
                        [dynamicDta appendFormat:@"%@-</span>",[phonemObj valueForKey:@"phoneme"]];
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
         
            QTSummaryReport * pteObj = [[QTSummaryReport alloc]initWithNibName:@"QTSummaryReport" bundle:nil];
            pteObj.selectedLevel =  self.selectedLevel;
            pteObj.quizName = self.cusTitleName;
            pteObj.trackArr = jsonArr;
            pteObj.quesArray = quesArr;
            pteObj.testOBj  = self.testOBj;
            pteObj.TopicName = self.TopicName;
            pteObj.assessnetUid = self.assessnetUid;
    
            NSMutableArray * arr = [[NSMutableArray alloc]init];
            for (NSDictionary * obj  in ansTrackArray) {
                if([[obj valueForKey:@"type"] isEqualToString:@"ra"])
                    [arr addObject:obj];
            }
            pteObj.trackOriginalArr = arr;
            pteObj.isRemediation =  self.isRemediation;
            pteObj.duration = [[NSString alloc]initWithFormat:@"%lld",[[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] - [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue]];
            pteObj.correctAns = [[NSString alloc] initWithFormat:@"%d",totalCorrectAns];
            pteObj.chapterId = self.scnUid;
            [self.navigationController pushViewController:pteObj animated:TRUE];
    
}

-(void)stopAllMeadia
{
    if(modalVideoViewPlayer != NULL)
    {
        [modalVideoViewPlayer.player pause];
    }
    
    if(expertVideoViewPlayer != NULL)
    {
        [expertVideoViewPlayer.player pause];
    }
    
    if(reviewVideoViewPlayer != NULL)
    {
        [reviewVideoViewPlayer.player pause];
    }
    
    
    
    
    
    if(videoViewPlayer != NULL)
    {
        [videoViewPlayer.player pause];
        //[videoViewPlayer stop];
        //videoViewPlayer = NULL;
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
        if(showPopUp!= NULL)showPopUp.hidden = TRUE;
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

//- (void)optMTouchClick:(UITapGestureRecognizer *)optTouchClick
//
//- (void)optMTouchClick1:(UITapGestureRecognizer *)optTouchClick1
//
//- (void)optMTouchClick2:(UITapGestureRecognizer *)optTouchClick2
//
//- (void)optMTouchClick3:(UITapGestureRecognizer *)optTouchClick3
//
//- (void)optMTouchClick4:(UITapGestureRecognizer *)optTouchClick4
//
//
//- (void)optMTouchClick5:(UITapGestureRecognizer *)optTouchClick5
//
//- (void)optMTouchClick6:(UITapGestureRecognizer *)optTouchClick6
//
//
//- (void)optMTouchClick7:(UITapGestureRecognizer *)optTouchClick7
//
//
//
//
//- (void)optTouchClick:(UITapGestureRecognizer *)optTouchClick
//
//- (void)optTouchClick1:(UITapGestureRecognizer *)optTouchClick1
//
//- (void)optTouchClick2:(UITapGestureRecognizer *)optTouchClick2
//
//- (void)optTouchClick3:(UITapGestureRecognizer *)optTouchClick3
//
//- (void)optTouchClick4:(UITapGestureRecognizer *)optTouchClick4
//
//
//- (void)optTouchClick5:(UITapGestureRecognizer *)optTouchClick5
//
//- (void)optTouchClick6:(UITapGestureRecognizer *)optTouchClick6
//
//
//- (void)optTouchClick7:(UITapGestureRecognizer *)optTouchClick7
//
//
//-(void)clickMcType
//
//
//
//
//
//
//
//
//
//- (void)optImageTouchClick:(UITapGestureRecognizer *)optTouchClick
//
//- (void)optImageTouchClick3:(UITapGestureRecognizer *)optTouchClick3
//
//- (void)optImageTouchClick1:(UITapGestureRecognizer *)optTouchClick1
//
//- (void)optImageTouchClick2:(UITapGestureRecognizer *)optTouchClick2
//
//- (void)optImageTouchClick4:(UITapGestureRecognizer *)optTouchClick
//
//- (void)optImageTouchClick5:(UITapGestureRecognizer *)optTouchClick3
//
//- (void)optImageTouchClick6:(UITapGestureRecognizer *)optTouchClick1
//
//- (void)optImageTouchClick7:(UITapGestureRecognizer *)optTouchClick2
//
//
//- (void)optAudioTouchClick:(UITapGestureRecognizer *)optTouchClick
//
//
//- (void)optAudioTouchClick1:(UITapGestureRecognizer *)optTouchClick1
//
//- (void)optAudioTouchClick2:(UITapGestureRecognizer *)optTouchClick2
//
//- (void)optAudioTouchClick3:(UITapGestureRecognizer *)optTouchClick3
//
//- (void)optAudioTouchClick4:(UITapGestureRecognizer *)optTouchClick4
//
//
//- (void)optAudioTouchClick5:(UITapGestureRecognizer *)optTouchClick5
//
//- (void)optAudioTouchClick6:(UITapGestureRecognizer *)optTouchClick6
//
//- (void)optAudioTouchClick7:(UITapGestureRecognizer *)optTouchClick7
//
//
//-(void)clickMcaMciType



-(BOOL)checkLastPosition
{
    UIView * obj = (UIView *)leftArr.lastObject;
    UIView * obj1 = (UIView *)rightArr.lastObject;
    
    if(obj.tag == obj1.tag )
        return TRUE;
    else
        return FALSE;
}
-(void) hideProgressCamera
{
    [self hideGlobalProgress];
}
-(void)QTupdateTimer
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
        [self clickCameraStartPlay:self];
    }
    
    
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
                                                        selector:@selector(QTupdateTimer)
                                                        userInfo:nil
                                                         repeats:YES];
        [self showGlobalProgress];
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(hideProgressCamera)
                                                        userInfo:nil
                                                         repeats:NO];
        
        
    }
    else
    {
        [self showGlobalProgress];
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(hideProgressCamera)
                                                        userInfo:nil
                                                         repeats:NO];
        
        tapIns.frame = CGRectMake(tapIns.frame.origin.x, recordStop.frame.origin.y+75, SCREEN_WIDTH, 20);
        tapIns.text = @"";
        remaingText.hidden = TRUE;
        minute.hidden = TRUE;
        footerView.hidden = FALSE;
        footerView.frame = CGRectMake(0, scrollView.contentSize.height-140, scrollView.frame.size.width,60);
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height-60);
        isRecording = FALSE;
        [recordingTimer invalidate];
        recordingTimer = NULL;
        recordStop.hidden = TRUE;
        [pickerObj stopVideoCapture];
        
        [recordStop1 setImage:[UIImage imageNamed:@"CameraEnable_Ani.png"] forState:UIControlStateNormal];
        
        [recordStop setImage:nil forState:UIControlStateNormal];
        
//        UIImage * img = [UIImage imageNamed:@"vocabulary_playGrey120x120.png"];
//        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        recordStop.tintColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
//        [recordStop setImage:img forState:UIControlStateNormal];
        
        [recordStop removeTarget:self action:@selector(OpenCamera) forControlEvents:UIControlEventTouchUpInside];
        
//        [recordStop addTarget:self
//                  action:@selector(showCurrentVideoAudioSummary)
//        forControlEvents:UIControlEventTouchUpInside];
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
        
        expertAudioTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateAudioPlayer) userInfo:nil repeats:YES];
        
        
    }
    else
    {
        [audioPlayer play];
        [audioBtn setImage:[UIImage imageNamed:@"PauseIcon.png"] forState:UIControlStateNormal];
        
        
    }
    
}

-(void)updateAudioPlayer
{
    int totalTime = audioPlayer.duration ;
    int currentTime = audioPlayer.currentTime ;
    AudioTimerLnbl.text = [self covertIntoHrMinSec:(totalTime-currentTime)];
    NSLog(@" Capturing Time :%d ::: %d ",totalTime,currentTime );
    timerProgressAudioView.progress = (float )((float)currentTime/(float)totalTime);
    if(totalTime == currentTime){
        [expertAudioTimer invalidate];
        audioPlayer = NULL;
        expertAudioTimer = NULL;
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
    quesNo.font = [UIFont systemFontOfSize:13];
    quesNo.textAlignment = NSTextAlignmentRight;
    questionView = [[UITextView alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH-20,0)];
    questionView.editable = FALSE;
    questionView.hidden = FALSE;
    questionView.font = TEXTTITLEFONT;
    questionView.scrollEnabled = FALSE;
    scrollView = [[UIScrollView alloc]init];
    //questionView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    [inputView addSubview:scrollView];
    [scrollView addSubview:quesNo];
    [scrollView addSubview:questionView];
    //questionView.contentInset = UIEdgeInsetsMake(-6.0,-1.0,0,0.0);
    
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
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:questionView.font}
                                            documentAttributes: nil
                                            error: nil
                                            ];
    questheight1 = 0;
    
    questionView.attributedText = attributedString;
     questheight1 = [self quesHeightForText:attributedString font:[UIFont systemFontOfSize:13] withinWidth:SCREEN_WIDTH-20 :[brCounter count]];
    questionView.scrollEnabled = FALSE;
    
    //quesNo.text = [[NSString alloc]initWithFormat:@"%d. ",questionCounter+1];
    if(![[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"av"])
    {
        
        if([[[question valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
            [scrollView addSubview:movieView];
            videoViewPlayer = NULL;
            videoViewPlayer = [[AVPlayerViewController alloc] init];
            videoViewPlayer.showsPlaybackControls = YES;
            videoViewPlayer.player = playVideo;
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"video"]valueForKey:@"text"]];
            
             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            playVideo = [[AVPlayer alloc] initWithURL:fileURL];
            videoViewPlayer.player = playVideo;
            [videoViewPlayer.player play];
            NSLog(@"error: %@", playVideo.error);
            videoViewPlayer.view.frame = movieView.bounds;
            [movieView addSubview:videoViewPlayer.view];
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 + questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
                
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
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2 -25, local_height+QuesImg.frame.size.height/2 -25, 50, 50)];
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                local_height = inputView.frame.size.height/3 + local_height;
                
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
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
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, local_height+ QuesImg.frame.size.height/2-50, 100, 100)];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                local_height = inputView.frame.size.height/3 + local_height;
                
                
                
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = [UIFont systemFontOfSize:13];
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
                int  local_questheight1 = [self heightForText:_attributedString.string font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
                
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
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                
                
                
                //                audioBtn = NULL;
                //                if(audioBtn == NULL)
                //                    audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2 -25, local_height+QuesImg.frame.size.height/2 -25, 50, 50)];
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                local_height = inputView.frame.size.height/3 + local_height;
                
                
                
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
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
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, local_height+ QuesImg.frame.size.height/2-50, 100, 100)];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                local_height = inputView.frame.size.height/3 + local_height;
                
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = [UIFont systemFontOfSize:13];
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
                int  local_questheight1 = [self heightForText:_attributedString.string font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
                
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
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                
                
                
                //                audioBtn = NULL;
                //                if(audioBtn == NULL)
                //                    audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2 -25, local_height+QuesImg.frame.size.height/2 -25, 50, 50)];
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                
                
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
                local_height = inputView.frame.size.height/3 + local_height;
                
                
                
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
                scriptbtn.font = [UIFont systemFontOfSize:13];
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
                
                QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
                QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
                
                QuesImg.contentMode = UIViewContentModeScaleAspectFit;
                [scrollView addSubview:QuesImg];
                
                
                AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(10, local_height + QuesImg.frame.size.height-30, 50, 20)];
                AudioTimerLnbl.textAlignment  = NSTextAlignmentLeft;
                AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
                AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
                [scrollView addSubview:AudioTimerLnbl];
                timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
                timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
                [[timerProgressAudioView layer]setFrame:CGRectMake(60, local_height +QuesImg.frame.size.height-22, QuesImg.frame.size.width-100, 5)];
                [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
                timerProgressAudioView.trackTintColor = [UIColor whiteColor];
                [timerProgressAudioView setProgress:0.0f];  ///15
                
                [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
                [[timerProgressAudioView layer]setBorderWidth:1];
                [[timerProgressAudioView layer]setMasksToBounds:TRUE];
                timerProgressAudioView.clipsToBounds = YES;
                [scrollView addSubview:timerProgressAudioView];
                audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-35, local_height + QuesImg.frame.size.height-35, 30, 30)];
                
                //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, local_height+ QuesImg.frame.size.height/2-50, 100, 100)];
                
                [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
                //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
                [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:audioBtn];
                if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                    [scriptbtnView addSubview:scriptbtn];
                    [inputView addSubview:scriptbtnView];
                }
                local_height = inputView.frame.size.height/3 + local_height;
                
                
            }
            else if(uiVal == 4)
            {
                UITextView * instructionView = [[UITextView alloc]initWithFrame:CGRectMake(10,local_height, SCREEN_WIDTH-20, 0)];
                instructionView.editable = FALSE;
                instructionView.font = [UIFont systemFontOfSize:13];
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
                int  local_questheight1 = [self heightForText:_attributedString.string font:instructionView.font withinWidth:instructionView.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
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
            scriptbtn.font = [UIFont systemFontOfSize:13];
            
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
            QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:QuesImg];
            
            
            AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, QuesImg.frame.size.height-30, 60, 20)];
            AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
            AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
            AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
             [scrollView addSubview:AudioTimerLnbl];
            timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
            [[timerProgressAudioView layer]setFrame:CGRectMake(60, QuesImg.frame.size.height-22, QuesImg.frame.size.width-110, 5)];
            [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
            timerProgressAudioView.trackTintColor = [UIColor whiteColor];
            [timerProgressAudioView setProgress:0.0f];  ///15

            [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
            [[timerProgressAudioView layer]setBorderWidth:1];
            [[timerProgressAudioView layer]setMasksToBounds:TRUE];
            timerProgressAudioView.clipsToBounds = YES;
            [scrollView addSubview:timerProgressAudioView];
            audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-50, QuesImg.frame.size.height-35, 30, 30)];
            
            
            //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
            
            //[audioBtn setImage:[UIImage imageNamed:@"Play.gif"] forState:UIControlStateNormal];
            
            [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            //[audioBtn performSelector:@selector(playPause) withObject:NO afterDelay:0.0];
            [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:audioBtn];
            
            
            if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                [scriptbtnView addSubview:scriptbtn];
                [inputView addSubview:scriptbtnView];
            }
            
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3 + 2, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3+2, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 +  questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,30,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
                [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
            
            
            
//                        audioView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,inputView.frame.size.height/3)];
//                        [scrollView addSubview:audioView];
//                        audioViewPlayer = NULL;
//                        audioViewPlayer = [[AVPlayerViewController alloc] init];
//                        audioViewPlayer.showsPlaybackControls = YES;
//
//                        NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[question valueForKey:@"audio"]valueForKey:@"text"]];
//
//                         NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//                        audioVideo = [[AVPlayer alloc] initWithURL:fileURL];
//                        audioViewPlayer.player = audioVideo;
//                        [audioViewPlayer.player play];
//                        NSLog(@"error: %@", audioVideo.error);
//                        audioViewPlayer.view.frame = audioView.bounds;
//                        [audioView addSubview:audioViewPlayer.view];
            
            
            
            scriptbtnView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50,50, 90, 35)];
            scriptbtn = [[UILabel alloc]initWithFrame:CGRectMake(0,-4, 90, 35)];
            scriptbtn.backgroundColor = [self getUIColorObjectFromHexString:@"#5dc9e6" alpha:1.0];
            scriptbtn.textColor = [UIColor whiteColor];
            scriptbtn.font = [UIFont systemFontOfSize:13];
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
            
            QuesImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
            QuesImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
            
            QuesImg.contentMode = UIViewContentModeScaleAspectFit;
            [scrollView addSubview:QuesImg];
            
            AudioTimerLnbl  = [[UILabel alloc]initWithFrame:CGRectMake(0, QuesImg.frame.size.height-30, 60, 20)];
            AudioTimerLnbl.textAlignment  = NSTextAlignmentCenter;
            AudioTimerLnbl.text = [self covertIntoHrMinSec:0];
            AudioTimerLnbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            AudioTimerLnbl.font = [UIFont systemFontOfSize:12.0];
             [scrollView addSubview:AudioTimerLnbl];
            timerProgressAudioView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
            timerProgressAudioView.progressTintColor = [self getUIColorObjectFromHexString:@"#ff8592" alpha:1.0];
            [[timerProgressAudioView layer]setFrame:CGRectMake(60, QuesImg.frame.size.height-22, QuesImg.frame.size.width-110, 5)];
            [[timerProgressAudioView layer]setBorderColor:[self getUIColorObjectFromHexString:@"#ed5565" alpha:1.0].CGColor];
            timerProgressAudioView.trackTintColor = [UIColor whiteColor];
            [timerProgressAudioView setProgress:0.0f];  ///15

            [[timerProgressAudioView layer]setCornerRadius:timerProgressAudioView.frame.size.height / 2];
            [[timerProgressAudioView layer]setBorderWidth:1];
            [[timerProgressAudioView layer]setMasksToBounds:TRUE];
            timerProgressAudioView.clipsToBounds = YES;
            [scrollView addSubview:timerProgressAudioView];
            audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width-50, QuesImg.frame.size.height-35, 30, 30)];
            
            //audioBtn = [[UIButton alloc]initWithFrame:CGRectMake(QuesImg.frame.size.width/2-50, QuesImg.frame.size.height/2-50, 100, 100)];
            
            [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            [audioBtn addTarget:self action:@selector(expertPlayPause:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:audioBtn];
            if([[[question valueForKey:@"audio_transcript"]valueForKey:@"is_filled"]isEqualToString:@"true"]){
                [scriptbtnView addSubview:scriptbtn];
                [inputView addSubview:scriptbtnView];
            }
            
            quesNo.frame = CGRectMake(1, inputView.frame.size.height/3+ 2, 20, 25);
            questionView.frame = CGRectMake(10,inputView.frame.size.height/3, SCREEN_WIDTH-20, questheight1);
            questheight1 = inputView.frame.size.height/3 +  questheight1;
            
            if([question valueForKey:@"popup"] != nil && ([[[[question valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"]isEqualToString:@"true"] || ![[[[question valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
            {
                popup = [[UIView alloc]init];
                popup.frame = CGRectMake(inputView.frame.size.width-30, questheight1,25,30);
                UIImageView *i_icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 25, 25)];
                [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
                [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
                scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, inputView.frame.size.height-2);
            }
            
        }
        else
        {
            
            
        }
        
        if([[[question valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0 && [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
        {
            if(!popup.hidden)popup.hidden = TRUE;
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            tapIns.text = @"Tap to start";
            tapIns.textAlignment = NSTextAlignmentCenter;
            tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            tapIns.font = [UIFont systemFontOfSize:13];
            [scrollView addSubview:tapIns];
            
            questheight1 =  questheight1+20;
            remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            remaingText.text = @"Time remaining";
            remaingText.textAlignment = NSTextAlignmentCenter;
            remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            remaingText.font = [UIFont systemFontOfSize:13];
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
           
            if(!popup.hidden)popup.hidden = TRUE;
            questheight1 =  questheight1+60;
            NSMutableDictionary * obj = [self createDictionaryifNot:question type:@"ra" Time:[[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]];
            [self addOrReplace:obj];
            tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            tapIns.text = @"Tap to start";
            tapIns.textAlignment = NSTextAlignmentCenter;
            tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            tapIns.font = [UIFont systemFontOfSize:13];
            [scrollView addSubview:tapIns];
            
            questheight1 =  questheight1+20;
            remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
            remaingText.text = @"Time remaining";
            remaingText.textAlignment = NSTextAlignmentCenter;
            remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            remaingText.font = [UIFont systemFontOfSize:13];
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
            [i_icon setImage:[UIImage imageNamed:@"about.png"]];
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
            //scrollView.frame = CGRectMake(0, inputView.frame.size.height/3, SCREEN_WIDTH, inputView.frame.size.height-(inputView.frame.size.height/3));
            
        }
        questheight1 = questheight1+30;
        AVCounter = 0;
        QuesAVArr = NULL;
        tapIns = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        tapIns.text = @"Tap to start";
        tapIns.textAlignment = NSTextAlignmentCenter;
        tapIns.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        tapIns.font = [UIFont systemFontOfSize:13];
        [scrollView addSubview:tapIns];
        questheight1 = questheight1+20;
        remaingText = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        remaingText.text = @"Time remaining";
        remaingText.hidden = TRUE;
        remaingText.textAlignment = NSTextAlignmentCenter;
        remaingText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        remaingText.font = [UIFont systemFontOfSize:13];
        [scrollView addSubview:remaingText];
        questheight1  = questheight1+20;
        
        minute = [[UILabel alloc]initWithFrame:CGRectMake(0, questheight1, SCREEN_WIDTH, 20)];
        minute.hidden = TRUE;
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
//        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, inputView.frame.size.height-30, scrollView.frame.size.width,60)];
//        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, inputView.frame.size.height);
//        //scrollView.scrollEnabled = FALSE;
//    }
//    else
//    {
        footerView = [[UIView alloc]initWithFrame:CGRectMake(0, scrollView.contentSize.height+10, scrollView.frame.size.width,60)];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height + 60);
  //  }
    
    
    
    
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
             if([[[question valueForKey:@"evaluation_type"] valueForKey:@"text"]intValue] == 0 && [[[[question valueForKey:@"format"] valueForKey:@"delivery"]valueForKey:@"text"]isEqualToString:@"ra"])
             {
                 
       
               showPopUp = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-170, SCREEN_WIDTH, 170)];
                [showPopUp setBackgroundColor:[self getUIColorObjectFromHexString:@"#aae9fa" alpha:1.0]];
                UIView * uppershowPopUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, showPopUp.frame.size.width, 10)] ;
                uppershowPopUp.backgroundColor = [self getUIColorObjectFromHexString:@"#7AE0FB" alpha:1.0];
                [showPopUp addSubview:uppershowPopUp];
                rWImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 15, 40, 40)];
                [showPopUp addSubview:rWImage];
                answer =[[UITextView alloc]initWithFrame:CGRectMake(80,15 ,showPopUp.frame.size.width-80 ,40)];
                answer.textAlignment = NSTextAlignmentLeft;
                answer.font = [UIFont systemFontOfSize:15];
                answer.editable = FALSE;
                answer.backgroundColor = [UIColor clearColor];
                [showPopUp addSubview:answer];
                showPopUp.hidden = TRUE;
                [self.view addSubview:showPopUp];
        
        
        
            mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, footerView.frame.size.height - 42, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
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
                 
//                 contiBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, showPopUp.frame.size.height-50, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
//                  [contiBtn.layer setMasksToBounds:YES];
//                 [contiBtn.layer setCornerRadius:BUTTONROUNDRECT];
//                     contiBtn.clipsToBounds = YES;
//
//                 [contiBtn setTitle:[appDelegate.langObj get:@"CONTINUE" alter:@"Continue"] forState:UIControlStateNormal];
//                 contiBtn.titleLabel.textColor = [UIColor whiteColor];
//                 contiBtn.hidden = TRUE;
//                 contiBtn.titleLabel.font = BUTTONFONT;
//                 [contiBtn addTarget:self
//                              action:@selector(clickNextManually)
//                    forControlEvents:UIControlEventTouchUpInside];
//
//                 contiBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
//                 UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 37, contiBtn.frame.size.width, 3)];
//                 lineView1.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_LINE_BACKGROUD_COLOR alpha:1.0];
//                 [contiBtn addSubview:lineView1];
//                 [showPopUp addSubview:contiBtn];
                 
                 
                 
                 reviewBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, showPopUp.frame.size.height-70, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
                  [reviewBtn.layer setMasksToBounds:YES];
                 [reviewBtn.layer setCornerRadius:BUTTONROUNDRECT];
                     reviewBtn.clipsToBounds = YES;
                 
//                 if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]]isEqualToString:@""] ){
//                  [reviewBtn setTitle:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]] forState:UIControlStateNormal];
//                 }
//                 else
//                 {
                    [reviewBtn setTitle:@"Review" forState:UIControlStateNormal];
                // }
                 
                 reviewBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
                 [reviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 reviewBtn.titleLabel.textColor = [UIColor whiteColor];
                 reviewBtn.hidden = FALSE;
                 reviewBtn.titleLabel.font = BUTTONFONT;
                 [reviewBtn addTarget:self
                              action:@selector(showCurrentVideoAudioSummary)
                    forControlEvents:UIControlEventTouchUpInside];
                 
                 //reviewBtn.backgroundColor = [UIColor whiteColor];
                 UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 37, reviewBtn.frame.size.width, 3)];
                 lineView2.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
                 [reviewBtn addSubview:lineView2];
                 [showPopUp addSubview:reviewBtn];
                 
                 
                 
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
    }
    
    
    //scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height + 60);
    [self loadFotterView];
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
    tapIns1.font = [UIFont systemFontOfSize:13];
    tapIns1.textColor = [UIColor whiteColor];
    [PlayerFotterView1 addSubview:tapIns1];
    
    
    
    remaingText1 = [[UILabel alloc]initWithFrame:CGRectMake(0, PlayerFotterView1.frame.size.height/2-85, SCREEN_WIDTH, 40)];
    remaingText1.text = @"Time remaining";
    remaingText1.textAlignment = NSTextAlignmentCenter;
    remaingText1.font = [UIFont systemFontOfSize:13];
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
        
        [audioBtn setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        [audioPlayer setDelegate:self];
        
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
        UIFont *myFont = [UIFont systemFontOfSize:13];
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

-(void)clickBack
{
    
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    
    if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME] longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME] longLongValue] )
    [appDelegate.engineObj setTracktableData:data];
    
    
    if(ISENABLERESUMEQUIZ)
    {
        if(questionCounter > 0)
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
        else
        {
            [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.assessnetUid]];
            [appDelegate deleteUserDefaultData:[[NSString alloc]initWithFormat:@"ques_%@",self.scnUid]];
        }
    }
    
    
    [self stopAllMeadia];
    if(MCQTimer != NULL){
        [MCQTimer invalidate];
        MCQTimer = NULL;
    }
    
   if(self.type != 3)
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
    phoneme_scores = [wordOBj valueForKey:@"phoneme_scores"];
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
    score.font = [UIFont systemFontOfSize:12.0];
    score.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    score.textAlignment = NSTextAlignmentLeft;
    
    [cell_view addSubview:score];
    //
    UILabel *ipa = [[UILabel alloc]initWithFrame:CGRectMake(cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
    ipa.textAlignment = NSTextAlignmentLeft;
    ipa.text =@"IPA";
    ipa.font = [UIFont systemFontOfSize:12.0];
    ipa.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [cell_view addSubview:ipa];
    //
    UILabel *soundLike = [[UILabel alloc]initWithFrame:CGRectMake(2*cell_view.frame.size.width/3, 5, cell_view.frame.size.width/3,25)];
    soundLike.textAlignment = NSTextAlignmentLeft;
    soundLike.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    soundLike.text =@"Sounded Like";
    soundLike.font = [UIFont systemFontOfSize:12.0];
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
    
//    if([CLASS_NAME isEqualToString:@"wiley"]){
//      if(popup.hidden)popup.hidden = FALSE;
//    }
    
    tapIns.text = @"Tap to Start";
    isAudioRecording = FALSE;
    minute.hidden = TRUE;
    remaingText.hidden = TRUE;
    
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
                minute.hidden = TRUE;
                remaingText.hidden = TRUE;
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
        //[recordStop setImage:[UIImage imageNamed:@"MicDisable.png"] forState:UIControlStateNormal];
        tapIns.text = @"";
        tapIns.frame = CGRectMake(tapIns.frame.origin.x, recordStop.frame.origin.y+75, SCREEN_WIDTH, 20);
//        UIImage * img = [UIImage imageNamed:@"vocabulary_playGrey120x120.png"];
//        img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        recordStop.tintColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        [recordStop setImage:nil forState:UIControlStateNormal];
        
//        [recordStop removeTarget:self action:@selector(clickStartPlay:) forControlEvents:UIControlEventTouchUpInside];
//        [recordStop addTarget:self
//                  action:@selector(showCurrentVideoAudioSummary)
//        forControlEvents:UIControlEventTouchUpInside];
        
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
    }else{
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
        
        score.text = [[NSString alloc]initWithFormat:@"%d",[[obj valueForKey:@"score"]intValue] ];
        
        ipa.text = [obj valueForKey:@"phoneme_ipa"];
        soundLike.text = [obj valueForKey:@"sounds_like_ipa"];
        score.font = [UIFont systemFontOfSize:12.0];
        ipa.font = [UIFont systemFontOfSize:12.0];
        soundLike.font = [UIFont systemFontOfSize:12.0];
        
        if([[obj valueForKey:@"score"]intValue] >= 80)
        {
            
            score.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#118616" alpha:1.0];
            
        }
        else if ([[obj valueForKey:@"score"]intValue] >= 51 && [[obj valueForKey:@"score"]intValue] <= 79)
        {
            score.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
            ipa.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
            soundLike.textColor = [self getUIColorObjectFromHexString:@"#FFC107" alpha:1.0];
        }
        else if ([[obj valueForKey:@"score"]intValue] >= 1 && [[obj valueForKey:@"score"]intValue] <= 50)
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
            textLbl.font = [UIFont systemFontOfSize:12.0];
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
            textLbl.font = [UIFont systemFontOfSize:12.0];
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
    
    NSAttributedString *attrText3 = [[NSAttributedString alloc] initWithString:text attributes:@{ NSParagraphStyleAttributeName : style,NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
    desctxt.attributedText  = attrText3;
    desctxt.numberOfLines =0;
    desctxt.lineBreakMode = NSLineBreakByWordWrapping;
    desctxt.font = [UIFont systemFontOfSize:13.0];
    desctxt.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    //    CGSize expectedLabelSize3 = [attrText3.string sizeWithFont:desctxt.font
    //                                             constrainedToSize:desctxt.frame.size lineBreakMode:NSLineBreakByWordWrapping];
    //    int height3 = expectedLabelSize3.height +30;
    int height3 = [self heightForText:attrText3.string font:desctxt.font withinWidth:desctxt.frame.size.width] +MC_MMC_TEST_TOP_BOTTOM_PADDING;
    
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



-(UILabel *)createUILabelMCMMC:(CGRect)rect
{
    UILabel *copyLabel = [[UILabel alloc]initWithFrame:rect];
    copyLabel.numberOfLines = 0 ;
    copyLabel.font  = [UIFont systemFontOfSize:13.0];
    copyLabel.textColor = [self getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
    copyLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    copyLabel.textAlignment = NSTextAlignmentLeft;
    CALayer * lay1 = [copyLabel layer];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:20.0];
    [lay1 setBorderWidth:1.0];
    [lay1 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    return copyLabel;
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

-(void)showCurrentVideoAudioSummary
 {
    if(showPopUp!= NULL)showPopUp.hidden = TRUE;
     UIScrollView * quesSummary = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0 , SCREEN_WIDTH, inputView.frame.size.height)];
     quesSummary.backgroundColor = [UIColor whiteColor];
    [inputView addSubview:quesSummary];
     
     int height = 0;
     UIView * reviewView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
     reviewView.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0];
     UILabel * reviewLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, reviewView.frame.size.width-20, 20)];
     reviewLbl.text = @"Review";
     
     
     
    
     reviewLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     reviewLbl.font = HEADERSECTIONTITLEFONT;
     [reviewView addSubview:reviewLbl];
     [quesSummary addSubview:reviewView];
     height =  height + 30;
     
     
     UIView * quesView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
     quesView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
     UILabel * quesLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesView.frame.size.width-20, 20)];
     if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"STATEMENT_%@",self.assessnetUid]]isEqualToString:@""] ){
         
         quesLbl.text = quesLbl.text = [[NSMutableString alloc]initWithFormat:@"%@:%lu",[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"STATEMENT_%@",self.assessnetUid]],(unsigned long)questionCounter+1];
     }
     else
     {
         quesLbl.text = [[NSMutableString alloc]initWithFormat:@"Question:%lu",(unsigned long)questionCounter+1];
     }
     
     
     quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     quesLbl.font = HEADERSECTIONTITLEFONT;
     [quesView addSubview:quesLbl];
     
     questionAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, quesView.frame.size.width-20, 200)];
     
     
     if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
     {
         
         
         UITapGestureRecognizer * expertTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(startStopExpert:)];
         
         expertTap.numberOfTapsRequired =1;
         [questionAudioView addGestureRecognizer:expertTap];
         
         
         
         
         
         
         
         expertVideoViewPlayer = NULL;
         expertVideoViewPlayer = [[AVPlayerViewController alloc] init];
         expertVideoViewPlayer.showsPlaybackControls = NO;
         
         NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"video"]valueForKey:@"text"]];
          NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
         expertVideoViewPlayer.player = expertPlayVideo;
         NSLog(@"error: %@", expertPlayVideo.error);
         expertVideoViewPlayer.view.frame = questionAudioView.bounds;
         [questionAudioView addSubview:expertVideoViewPlayer.view];
         
         expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
         [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
         [expertBtnImg bringSubviewToFront:questionAudioView];
         expertBtnImg.userInteractionEnabled = YES;
         expertBtnImg.hidden = FALSE;
         [questionAudioView addSubview:expertBtnImg];
         
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;
     }
     else if([[[globalDictionary valueForKey:@"video_link"]valueForKey:@"is_filled"] isEqualToString:@"true"])
     {
         movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionAudioView.frame.size.width,questionAudioView.frame.size.height)];
         [questionAudioView addSubview:movieView];
         
         
         
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
         NSString * __path = [[globalDictionary valueForKey:@"video_link"]valueForKey:@"text"];
         
         
         NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
         
         
         //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\"><iframe src=\"%@\" frameborder=\"0\" playsinline=true></div></body></html>",__path];
         [youTube loadHTMLString:strHtml baseURL:nil];
         [movieView addSubview:youTube];
         
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;
         
         
     
         
         
     }
     else if([[[globalDictionary valueForKey:@"link_embeded_code"]valueForKey:@"is_filled"] isEqualToString:@"true"])
     {
         movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionAudioView.frame.size.width,questionAudioView.frame.size.height)];
         [questionAudioView addSubview:movieView];
         
         
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
         NSString * __path = [[globalDictionary valueForKey:@"link_embeded_code"]valueForKey:@"text"];
         
         NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
         
         //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\">%@</div></body></html>",__path];
         [youTube loadHTMLString:strHtml baseURL:nil];
         [movieView addSubview:youTube];
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;
         
         
      
         
         
         
     }
     else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"] )
     {
         
         UITapGestureRecognizer * expertTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(startStopExpert:)];
         
         expertTap.numberOfTapsRequired =1;
         [questionAudioView addGestureRecognizer:expertTap];
         
         
         
         expertVideoViewPlayer = NULL;
         expertVideoViewPlayer = [[AVPlayerViewController alloc] init];
         expertVideoViewPlayer.showsPlaybackControls = NO;
         
         NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
         UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
         bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
         bgImg.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
         bgImg.contentMode = UIViewContentModeScaleAspectFit;
         [expertVideoViewPlayer.contentOverlayView addSubview:bgImg];
          NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
         expertVideoViewPlayer.player = expertPlayVideo;
         NSLog(@"error: %@", expertPlayVideo.error);
         expertVideoViewPlayer.view.frame = questionAudioView.bounds;
         [questionAudioView addSubview:expertVideoViewPlayer.view];
         expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
         [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
         [expertBtnImg bringSubviewToFront:questionAudioView];
         expertBtnImg.userInteractionEnabled = YES;
         [expertVideoViewPlayer.view addSubview:expertBtnImg];
         
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;
     }
     else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
     {
         UITapGestureRecognizer * expertTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(startStopExpert:)];
         
         expertTap.numberOfTapsRequired =1;
         [questionAudioView addGestureRecognizer:expertTap];
         
         expertVideoViewPlayer = NULL;
         expertVideoViewPlayer = [[AVPlayerViewController alloc] init];
         expertVideoViewPlayer.showsPlaybackControls = NO;
         
         expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
         [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
        
         expertBtnImg.userInteractionEnabled = YES;
         [questionAudioView addSubview:expertBtnImg];
         
         NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"audio"]valueForKey:@"text"]];
         UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
         //bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
         
         NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
         
         bgImg.image =[UIImage imageNamed:imageFilePath];
         bgImg.contentMode = UIViewContentModeScaleAspectFit;
         [expertVideoViewPlayer.contentOverlayView addSubview:bgImg];
          NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
         expertVideoViewPlayer.player = expertPlayVideo;
         expertVideoViewPlayer.showsPlaybackControls = NO;
         //[expertVideoViewPlayer.player play];
         NSLog(@"error: %@", expertPlayVideo.error);
         expertVideoViewPlayer.view.frame = questionAudioView.bounds;
         [questionAudioView addSubview:expertVideoViewPlayer.view];
         
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;
         
     }
     else if([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"] )
     {
        UIImageView *bgImg = [[UIImageView alloc]initWithFrame:questionAudioView.bounds];
         //bgImg.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
         NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
         bgImg.image =[UIImage imageNamed:imageFilePath];
         bgImg.contentMode = UIViewContentModeScaleAspectFit;
         [questionAudioView addSubview:bgImg];
         
         [quesView addSubview:questionAudioView];
         [quesSummary addSubview:quesView];
         height =  height + 250;

     }
     else if ([[[globalDictionary valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"] && [[[globalDictionary valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"])
     {
        [quesView addSubview:questionAudioView];
        [quesSummary addSubview:quesView];
        height =  height + 30;
     }
     
     
     
     
     
     
     UIView *  quesModalView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
     quesModalView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
     UILabel * modalLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, quesModalView.frame.size.width-20, 20)];
     if(![[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]]isEqualToString:@""] ){
         modalLbl.text = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",self.assessnetUid]];
     }
     else
     {
         modalLbl.text = @"Model Answer";
     }
     
     modalLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     modalLbl.font = HEADERSECTIONTITLEBOLDFONT;
     [quesModalView addSubview:modalLbl];
     
     int modalH = 30;
     
      questionModalAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, quesModalView.frame.size.width-20, 200)];
     if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"is_filled"] isEqualToString:@"true"])
         {
             
             UITapGestureRecognizer * modalTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(startStopModal:)];
             
             modalTap.numberOfTapsRequired =1;
             [questionModalAudioView addGestureRecognizer:modalTap];
             
             modalVideoViewPlayer = NULL;
             modalVideoViewPlayer = [[AVPlayerViewController alloc] init];
             modalVideoViewPlayer.showsPlaybackControls = NO;
             NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video"]valueForKey:@"text"]];
//             UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
//             bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
//             bgImg1.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
//             bgImg1.contentMode = UIViewContentModeScaleAspectFit;
//             [modalVideoViewPlayer.contentOverlayView addSubview:bgImg1];
              NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             AVPlayer * modalPlayVideo = [[AVPlayer alloc] initWithURL:fileURL1];
             modalVideoViewPlayer.player = modalPlayVideo;
             //[modalVideoViewPlayer.player play];
             NSLog(@"error: %@", modalPlayVideo.error);
             modalVideoViewPlayer.view.frame = questionModalAudioView.bounds;
             [questionModalAudioView addSubview:modalVideoViewPlayer.view];
             
             modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
             [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
             [modalBtnImg bringSubviewToFront:questionModalAudioView];
             modalBtnImg.userInteractionEnabled = YES;
             modalBtnImg.hidden = FALSE;
             [questionModalAudioView addSubview:modalBtnImg];
             
             [quesModalView addSubview:questionModalAudioView];
             modalH = modalH +210;
         }
     else if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"video_link"]valueForKey:@"is_filled"] isEqualToString:@"true"])
     {
         movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionModalAudioView.frame.size.width,questionModalAudioView.frame.size.height)];
         [questionModalAudioView addSubview:movieView];
         
         
         
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
         NSString * __path = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"video_link"]valueForKey:@"text"];
         
         
         NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
         
         
         //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\"><iframe src=\"%@\" frameborder=\"0\" playsinline=true></div></body></html>",__path];
         [youTube loadHTMLString:strHtml baseURL:nil];
         [movieView addSubview:youTube];
         [quesModalView addSubview:questionModalAudioView];
         modalH = modalH +210;
         
        
     }
     else if([globalDictionary valueForKey:@"popup"] != nil && [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"link_embaded_code"]valueForKey:@"is_filled"] isEqualToString:@"true"])
     {
         movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,questionModalAudioView.frame.size.width,questionModalAudioView.frame.size.height)];
         [questionModalAudioView addSubview:movieView];
         
         
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
         NSString * __path = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"link_embaded_code"]valueForKey:@"text"];
         
         NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><body style=\"margin:0px;padding:0px;\"><script type=\"text/javascript\" src=\"http://www.youtube.com/iframe_api\"></script><script type=\"text/javascript\">function onYouTubeIframeAPIReady(){ytplayer=new YT.Player(\"playerId\",{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id=\"playerId\" type=\"text/html\" width=\"100%%\" height=\"100%%\" src=\"%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1\" frameborder=\"0\"></body></html>",__path];
         
         //NSString * strHtml = [[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><div style=\"font-size:20px;\">%@</div></body></html>",__path];
         [youTube loadHTMLString:strHtml baseURL:nil];
         [movieView addSubview:youTube];
         [quesModalView addSubview:questionModalAudioView];
         modalH = modalH +210;
         
         
   
         
     }
     else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
     {
         
         UITapGestureRecognizer * modalTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(startStopModal:)];
         
         modalTap.numberOfTapsRequired =1;
         [questionModalAudioView addGestureRecognizer:modalTap];
         
            modalVideoViewPlayer = NULL;
            modalVideoViewPlayer = [[AVPlayerViewController alloc] init];
            modalVideoViewPlayer.showsPlaybackControls = NO;
         
             NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
             UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
             bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
             NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
             bgImg1.image =[UIImage imageNamed:imageFilePath];
             bgImg1.contentMode = UIViewContentModeScaleAspectFit;
             [modalVideoViewPlayer.contentOverlayView addSubview:bgImg1];
         
         
         modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
         [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
         [modalBtnImg bringSubviewToFront:questionModalAudioView];
         modalBtnImg.userInteractionEnabled = YES;
         modalBtnImg.hidden = FALSE;
         [questionModalAudioView addSubview:modalBtnImg];
         
             NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             AVPlayer * modalPlayVideo = [[AVPlayer alloc] initWithURL:fileURL1];
             modalVideoViewPlayer.player = modalPlayVideo;
      //[modalVideoViewPlayer.player play];
      NSLog(@"error: %@", modalPlayVideo.error);
      modalVideoViewPlayer.view.frame = questionModalAudioView.bounds;
      [questionModalAudioView addSubview:modalVideoViewPlayer.view];
      [quesModalView addSubview:questionModalAudioView];
             modalH = modalH +210;
         }
    else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"true"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"false"]))
    {
        
        
        UITapGestureRecognizer * modalTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(startStopModal:)];
        
        modalTap.numberOfTapsRequired =1;
        [questionModalAudioView addGestureRecognizer:modalTap];
        
        
        modalVideoViewPlayer = NULL;
        modalVideoViewPlayer = [[AVPlayerViewController alloc] init];
        modalVideoViewPlayer.showsPlaybackControls = NO;
         NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
         UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
         bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
         bgImg1.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
         bgImg1.contentMode = UIViewContentModeScaleAspectFit;
         [modalVideoViewPlayer.contentOverlayView addSubview:bgImg1];
          NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         AVPlayer * modalPlayVideo = [[AVPlayer alloc] initWithURL:fileURL1];
         modalVideoViewPlayer.player = modalPlayVideo;
         //[modalVideoViewPlayer.player play];
         NSLog(@"error: %@", modalPlayVideo.error);
         modalVideoViewPlayer.view.frame = questionModalAudioView.bounds;
         [questionModalAudioView addSubview:modalVideoViewPlayer.view];
        
        modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
        [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
        [modalBtnImg bringSubviewToFront:questionModalAudioView];
        modalBtnImg.userInteractionEnabled = YES;
        modalBtnImg.hidden = FALSE;
        [questionModalAudioView addSubview:modalBtnImg];
        
         [quesModalView addSubview:questionModalAudioView];
            modalH = modalH +210;
        }
     else if([globalDictionary valueForKey:@"popup"] != nil && ([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"is_filled"] isEqualToString:@"false"]) &&([[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"is_filled"] isEqualToString:@"true"]))
     {
             //NSString * __path1 = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
             UIImageView *bgImg1 = [[UIImageView alloc]initWithFrame:questionModalAudioView.bounds];
             bgImg1.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
             NSString * imageFilePath =  [[phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"image"]valueForKey:@"text"]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
             bgImg1.image =[UIImage imageNamed:imageFilePath];
             bgImg1.contentMode = UIViewContentModeScaleAspectFit;
             [modalVideoViewPlayer.contentOverlayView addSubview:bgImg1];
             //NSURL *fileURL1 = [[NSURL alloc] initFileURLWithPath: [__path1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             //AVPlayer * modalPlayVideo = [[AVPlayer alloc] initWithURL:fileURL1];
             //modalVideoViewPlayer.player = modalPlayVideo;
      //[modalVideoViewPlayer.player play];
      //NSLog(@"error: %@", modalPlayVideo.error);
      //modalVideoViewPlayer.view.frame = questionModalAudioView.bounds;
      [questionModalAudioView addSubview:bgImg1];
      [quesModalView addSubview:questionModalAudioView];
             modalH = modalH +210;
         }
      
     
     
     if([globalDictionary valueForKey:@"popup"] != nil && (![[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"]isEqualToString:@""]) )
        {
           UITextView * SampleLbl = [[UITextView alloc]initWithFrame:CGRectMake(10, modalH, quesModalView.frame.size.width-20, 20)];
           
            
            
            

            NSString* newString = [[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
            NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
            //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
            NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
            NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
            NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
            NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
            NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
            
            
            
            
            
            NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:13px;\">%@</font></div>",newString8];
            NSAttributedString *_attributedString = [[NSAttributedString alloc]
                                                     initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                     documentAttributes: nil
                                                     error: nil
                                                     ];
            SampleLbl.attributedText = _attributedString;
            int  local_questheight1 = [self quesHeightForText:_attributedString font:TEXTTITLEFONT withinWidth:SCREEN_WIDTH-20 :[brCounter count]];
           questionView.scrollEnabled = FALSE;
            SampleLbl.scrollEnabled = FALSE;
            
//            int  local_questheight1 = [self heightForText:_attributedString.string font:SampleLbl.font withinWidth:SampleLbl.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
            
            
            
            
            
            
            
            
            
            
//            NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",13.0,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
//            NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                                    initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                    options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:13.0]}
//                                                    documentAttributes: nil
//                                                    error: nil
//                                                    ];
//            questheight1 = 0;
//
//            questionView.attributedText = attributedString;
            
            
            
            
            
            
            
            
            
            
            
            
            
            //int height1 = [self heightForText:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"] font:(UIFont *)HEADERSECTIONTITLEFONT withinWidth:quesModalView.frame.size.width-20];
            
            
            //SampleLbl.text = [[[globalDictionary valueForKey:@"popup"]valueForKey:@"paragraph"]valueForKey:@"text"];
            SampleLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            
            SampleLbl.frame = CGRectMake(10, modalH, quesModalView.frame.size.width-20, local_questheight1);
           // SampleLbl.font = HEADERSECTIONTITLEFONT;
            [quesModalView addSubview:SampleLbl];
             modalH = modalH +local_questheight1 + 10;
        }
     else
       {
         
       }
     if(modalH >30){
       [quesSummary addSubview:quesModalView];
        height =  height + modalH;
     }
     else
     {
       // height =  height + height1+230;
     }
     
     
     
     
     
     
     
     UIView *  answerView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 300)];
     answerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
     UILabel * answerLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, answerView.frame.size.width-20, 20)];
     answerLbl.text = @"Your Response";
     answerLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     answerLbl.font = HEADERSECTIONTITLEBOLDFONT;
     [answerView addSubview:answerLbl];
     
     AnswerAudioView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, answerView.frame.size.width-20, 200)];
     
     
      
     
     UITapGestureRecognizer * reviewTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(startStopReview:)];
     
     reviewTap.numberOfTapsRequired =1;
     [AnswerAudioView addGestureRecognizer:reviewTap];
     
     reviewVideoViewPlayer = NULL;
     reviewVideoViewPlayer = [[AVPlayerViewController alloc] init];
     reviewVideoViewPlayer.showsPlaybackControls = NO;
     
     
     
     
     NSString * __path2;
     NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
     if([[[[[globalDictionary valueForKey:@"answers"]valueForKey:@"answer"]valueForKey:@"content_type"]valueForKey:@"text"]isEqualToString:@"audio"])
     {
         __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.wav",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID ],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]]];
         UIImageView *bgImg2 = [[UIImageView alloc]initWithFrame:AnswerAudioView.bounds];
         bgImg2.backgroundColor = [self getUIColorObjectFromHexString:@"#d1f0fc" alpha:1.0];
         bgImg2.image =[UIImage imageNamed:@"AudioPlaceholder.png"];
         bgImg2.contentMode = UIViewContentModeScaleAspectFit;
         [reviewVideoViewPlayer.contentOverlayView addSubview:bgImg2];
     }
     else
     {
         __path2 = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.mp4",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]]];
         
     }
     
      NSURL *fileURL2 = [[NSURL alloc] initFileURLWithPath: [__path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     AVPlayer * reviewPlayVideo = [[AVPlayer alloc] initWithURL:fileURL2];
     reviewVideoViewPlayer.player = reviewPlayVideo;
     //[reviewVideoViewPlayer.player play];
     NSLog(@"error: %@", reviewPlayVideo.error);
     reviewVideoViewPlayer.view.frame = AnswerAudioView.bounds;
     [AnswerAudioView addSubview:reviewVideoViewPlayer.view];
     
     reviewBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(AnswerAudioView.frame.size.width/2-25, AnswerAudioView.frame.size.height/2-25, 50, 50)];
     [reviewBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
     [reviewBtnImg bringSubviewToFront:AnswerAudioView];
     reviewBtnImg.userInteractionEnabled = YES;
     reviewBtnImg.hidden = FALSE;
     [AnswerAudioView addSubview:reviewBtnImg];
     
     
     [answerView addSubview:AnswerAudioView];
     [quesSummary addSubview:answerView];
     height =  height + 300;
     
     
     
     UIButton * tryAgainBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, height, 8*(SCREEN_WIDTH/10),40)];
      [tryAgainBtn setTitle:@"Try Again" forState:UIControlStateNormal];
      
      
      UIImage * img = [UIImage imageNamed:@"PTEG_TryAgain.png"];
      img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
      [tryAgainBtn setImage:img forState:UIControlStateNormal];
      tryAgainBtn.tintColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
      tryAgainBtn.titleEdgeInsets = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
      [tryAgainBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
     
      [tryAgainBtn setBackgroundColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0]];
      [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
      [quesSummary addSubview:tryAgainBtn];
      
      [tryAgainBtn addTarget:self
                      action:@selector(clickTryAgain)
            forControlEvents:UIControlEventTouchUpInside];
      tryAgainBtn.titleLabel.font = BUTTONFONT;
     tryAgainBtn.layer.borderWidth = 1;
     tryAgainBtn.layer.borderColor = [self getUIColorObjectFromHexString:@"#CACACA" alpha:1.0].CGColor;
      [tryAgainBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0] forState:UIControlStateNormal];
     tryAgainBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
     tryAgainBtn.layer.cornerRadius = 10; // this value vary as per your desire
     tryAgainBtn.clipsToBounds = YES;
     
     
     
      
      height =  height + 60;
      
      UIButton * viewSummaryBtn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, height, 8*(SCREEN_WIDTH/10),40)];
      [viewSummaryBtn setTitle:@"Continue" forState:UIControlStateNormal];
      viewSummaryBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR  alpha:1.0];
      [viewSummaryBtn addTarget:self action:@selector(nextQuestion) forControlEvents:UIControlEventTouchUpInside];
      viewSummaryBtn.titleLabel.font = BUTTONFONT;
      viewSummaryBtn.layer.borderWidth = 1;
      viewSummaryBtn.layer.borderColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor;
       [viewSummaryBtn setTitleColor:[self getUIColorObjectFromHexString:WIDGET_BUTTON_TEXT_COLOR alpha:1.0] forState:UIControlStateNormal];
      viewSummaryBtn.titleLabel.textColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
      viewSummaryBtn.layer.cornerRadius = 10; // this value vary as per your desire
      viewSummaryBtn.clipsToBounds = YES;
      [quesSummary addSubview:viewSummaryBtn];
     
      height =  height + 60;
     
     quesSummary.contentSize = CGSizeMake(quesSummary.frame.size.width, height);
     
 }


-(void)startStopExpert :(id)sender
{
    
    if(expertPlayStat)
    {
        expertPlayStat = FALSE;
        [expertVideoViewPlayer.player pause];
        
        
//        expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
//        [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [expertBtnImg bringSubviewToFront:questionAudioView];
//        expertBtnImg.userInteractionEnabled = YES;
//        expertBtnImg.hidden = FALSE;
//        [questionAudioView addSubview:expertBtnImg];
        
    }
    else
    {
        expertPlayStat = TRUE;
        modalPlayStat = FALSE;
        reviewPlayStat = FALSE;
        
        AVPlayerItem *currentItem = expertVideoViewPlayer.player.currentItem;
        CMTime duration = currentItem.duration;
        CMTime currentTime = currentItem.currentTime;
        NSTimeInterval duTime = CMTimeGetSeconds(duration);
        NSTimeInterval currTime = CMTimeGetSeconds(currentTime);
        
        
        if(duTime == currTime)
        {
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[globalDictionary valueForKey:@"video"]valueForKey:@"text"]];
             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
            expertVideoViewPlayer.player = expertPlayVideo;
            [expertVideoViewPlayer.player play];
            NSLog(@"error: %@", expertPlayVideo.error);
        }
        else
        {
            [expertVideoViewPlayer.player play];
        }
        
        [modalVideoViewPlayer.player pause];
        [reviewVideoViewPlayer.player pause];
        
//        [expertBtnImg removeFromSuperview];
//        [modalBtnImg removeFromSuperview];
//        [reviewBtnImg removeFromSuperview];
          expertBtnImg.hidden = TRUE;
        
        
//        modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
//        [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [modalBtnImg bringSubviewToFront:questionModalAudioView];
//        modalBtnImg.userInteractionEnabled = YES;
//        modalBtnImg.hidden = FALSE;
//        [questionModalAudioView addSubview:modalBtnImg];
        
//        reviewBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(AnswerAudioView.frame.size.width/2-25, AnswerAudioView.frame.size.height/2-25, 50, 50)];
//        [reviewBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [reviewBtnImg bringSubviewToFront:AnswerAudioView];
//        reviewBtnImg.userInteractionEnabled = YES;
//        reviewBtnImg.hidden = FALSE;
//        [AnswerAudioView addSubview:reviewBtnImg];
        
        
        
        
    }
}


-(void)startStopModal :(id)sender
{
    if(modalPlayStat)
    {
        modalPlayStat = FALSE;
        [modalVideoViewPlayer.player pause];
        
//        modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
//        [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [modalBtnImg bringSubviewToFront:questionModalAudioView];
//        modalBtnImg.userInteractionEnabled = YES;
//        modalBtnImg.hidden = FALSE;
//        [questionModalAudioView addSubview:modalBtnImg];
        
        
        
    }
    else
    {
        modalPlayStat  = TRUE;
        expertPlayStat = FALSE;
        reviewPlayStat = FALSE;
        
        AVPlayerItem *currentItem = modalVideoViewPlayer.player.currentItem;
        CMTime duration = currentItem.duration;
        CMTime currentTime = currentItem.currentTime;
        NSTimeInterval duTime = CMTimeGetSeconds(duration);
        NSTimeInterval currTime = CMTimeGetSeconds(currentTime);
        
        
        if(duTime == currTime)
        {
            
            NSString * __path = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
            
             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
            modalVideoViewPlayer.player = expertPlayVideo;
            [modalVideoViewPlayer.player play];
            NSLog(@"error: %@", expertPlayVideo.error);
        }
        else
        {
            [modalVideoViewPlayer.player play];
        }
        
        [modalVideoViewPlayer .player play];
        [expertVideoViewPlayer.player pause];
        [reviewVideoViewPlayer.player pause];
        
//        [expertBtnImg removeFromSuperview];
//        [modalBtnImg removeFromSuperview];
//        [reviewBtnImg removeFromSuperview];
        modalBtnImg.hidden = TRUE;
        
//        reviewBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(AnswerAudioView.frame.size.width/2-25, AnswerAudioView.frame.size.height/2-25, 50, 50)];
//        [reviewBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [reviewBtnImg bringSubviewToFront:AnswerAudioView];
//        reviewBtnImg.userInteractionEnabled = YES;
//        reviewBtnImg.hidden = FALSE;
//        [AnswerAudioView addSubview:reviewBtnImg];
        
//        expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
//        [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [expertBtnImg bringSubviewToFront:questionAudioView];
//        expertBtnImg.userInteractionEnabled = YES;
//        expertBtnImg.hidden = FALSE;
//        [questionAudioView addSubview:expertBtnImg];
        
        
        
    }
}

-(void)startStopReview :(id)sender
{
    if(reviewPlayStat)
    {
        reviewPlayStat = FALSE;
        [reviewVideoViewPlayer.player pause];
        
//        reviewBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(AnswerAudioView.frame.size.width/2-25, AnswerAudioView.frame.size.height/2-25, 50, 50)];
//        [reviewBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [reviewBtnImg bringSubviewToFront:AnswerAudioView];
//        reviewBtnImg.userInteractionEnabled = YES;
//        reviewBtnImg.hidden = FALSE;
//        [AnswerAudioView addSubview:reviewBtnImg];
        
    }
    else
    {
        reviewPlayStat  = TRUE;
        modalPlayStat = FALSE;
        expertPlayStat = FALSE;
        
        AVPlayerItem *currentItem = reviewVideoViewPlayer.player.currentItem;
        CMTime duration = currentItem.duration;
        CMTime currentTime = currentItem.currentTime;
        NSTimeInterval duTime = CMTimeGetSeconds(duration);
        NSTimeInterval currTime = CMTimeGetSeconds(currentTime);
        
        
        if(duTime == currTime)
        {
            NSString *llTempPath = [[NSString alloc]initWithFormat:@"records"];
            NSString *__path = [phoneDocumentDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@_%@_%@.mp4",llTempPath,[appDelegate.global_userInfo valueForKey:DATABASE_USERID],_assessnetUid,[globalDictionary valueForKey:@"uniqid"]]];
            
             NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [__path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            AVPlayer * expertPlayVideo = [[AVPlayer alloc] initWithURL:fileURL];
            reviewVideoViewPlayer.player = expertPlayVideo;
            [reviewVideoViewPlayer.player play];
            NSLog(@"error: %@", expertPlayVideo.error);
        }
        else
        {
            [reviewVideoViewPlayer.player play];
        }
        
       
        [modalVideoViewPlayer.player pause];
        [expertVideoViewPlayer.player pause];
        
//        [expertBtnImg removeFromSuperview];
//        [modalBtnImg removeFromSuperview];
//        [reviewBtnImg removeFromSuperview];
        reviewBtnImg.hidden = TRUE;
        
//        expertBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionAudioView.frame.size.width/2-25, questionAudioView.frame.size.height/2-25, 50, 50)];
//        [expertBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [expertBtnImg bringSubviewToFront:questionAudioView];
//        expertBtnImg.userInteractionEnabled = YES;
//        expertBtnImg.hidden = FALSE;
//        [questionAudioView addSubview:expertBtnImg];
        
//        modalBtnImg = [[UIImageView alloc]initWithFrame:CGRectMake(questionModalAudioView.frame.size.width/2-25, questionModalAudioView.frame.size.height/2-25, 50, 50)];
//        [modalBtnImg setImage:[UIImage imageNamed:@"Play.png"]];
//        [modalBtnImg bringSubviewToFront:questionModalAudioView];
//        modalBtnImg.userInteractionEnabled = YES;
//        modalBtnImg.hidden = FALSE;
//        [questionModalAudioView addSubview:modalBtnImg];
        
    }
}





-(void)clickTryAgain
{
    [self stopAllMeadia];
    [ansTrackArray removeLastObject];
    [self renderUI];
    
}

-(void)nextQuestion
{
    [self stopAllMeadia];
    [self clickNextManually];
}

@end






