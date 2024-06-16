//
//  AttendCampaigns.m
//  InterviewPrep
//
//  Created by Amit Gupta on 09/10/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "AttendCampaigns.h"

#define SERVICE_SETCAMPAIGN @"setCampaign"

@interface AttendCampaigns ()<UITextViewDelegate>
{
    UIView *navigationView;
    UIButton * backBtn;
    UIButton * winnerBtn;
    UILabel * nav_title;
    UIScrollView * bgView;
    UITextView * lblName;
    UITextView * lblDesc;
    UITextView * lblQuestion;
    UIImageView * headImageView;
    UITextView *textView;
    UILabel * charCounter;
    UIButton * submit;
    float numberofChar;
    //UIActivityIndicatorView *activityIndicator;
    UIView * submitPopup;
    UIButton *popupCancleBtn;
    UIView * winnerListTab;
    
}

@end

@implementation AttendCampaigns


-(CGFloat)getTextViewHeight:(UITextView *)_textview
{
    CGFloat fixedWidth = _textview.frame.size.width;
    CGSize newSize = [_textview sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = _textview.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    
    return newFrame.size.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    numberofChar =47;
    
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, STSTUSNAVIGATIONBARHEIGHT)];
    [self.view addSubview:navigationView];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,20 , 40, 40)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView  addSubview:backBtn];
    
//    winnerBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60,20 , 40, 40)];
//    [winnerBtn setBackgroundImage:[UIImage imageNamed:@"winners.png"] forState:UIControlStateNormal];
//    [winnerBtn addTarget:self action:@selector(OpenWinnerList) forControlEvents:UIControlEventTouchUpInside];
//    [navigationView  addSubview:winnerBtn];
//
    nav_title = [[UILabel alloc]initWithFrame:CGRectMake(50, 25, SCREEN_WIDTH-100,17)];
    nav_title.backgroundColor = [UIColor clearColor];
    nav_title.font = [UIFont boldSystemFontOfSize:16.0];
    nav_title.textAlignment = NSTextAlignmentCenter;
    nav_title.text = @"Campaigns";
    nav_title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [navigationView  addSubview:nav_title];
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    [bgView setBackgroundColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    [self.view addSubview:bgView];
    
    
    NSString * strMsg = @"";
    if([self.campainObj valueForKey:@"campaign_questions"] != NULL && ![[self.campainObj valueForKey:@"campaign_questions"]isEqualToString:@""] &&  ![[self.campainObj valueForKey:@"campaign_questions"] isKindOfClass:[NSNull class]]  ){
        strMsg = [[NSString alloc]initWithFormat:@"%@\n\n%@\n\n %@",[self.campainObj valueForKey:@"campaign_name"],[self.campainObj valueForKey:@"campaign_desc"],[self.campainObj valueForKey:@"campaign_questions"]];
    }
    else
    {
        strMsg = [[NSString alloc]initWithFormat:@"%@\n\n%@",[self.campainObj valueForKey:@"campaign_name"],[self.campainObj valueForKey:@"campaign_desc"]];
    }
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:strMsg];
    
    [tncString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(0, [[self.campainObj valueForKey:@"campaign_name"] length])];
//    [tncString addAttribute:NSUnderlineColorAttributeName value:[appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0] range:NSMakeRange(11, [tncString length]-11)];
    
    
//    [tncString addAttribute:NSUnderlineStyleAttributeName
//                      value:@(NSUnderlineStyleSingle)
//                      range:(NSRange){11,[tncString length]-11}];
    
    
    
    
    
    
    
    
    
    
    
    NSUInteger numberOfOccurrences = [[strMsg componentsSeparatedByString:@"\n"] count] - 1;
    
    float height1 = (([strMsg length]/numberofChar)+1+numberOfOccurrences)*15;
    float height2 = 0.0;

    lblName = [[UITextView alloc]initWithFrame:CGRectMake(5,2, SCREEN_WIDTH-10, height1)];
    lblName.attributedText = tncString;
    lblName.font = [UIFont systemFontOfSize:12.0];
    [lblName setEditable:FALSE];
    lblName.scrollEnabled = FALSE;
    
    lblName.textAlignment = NSTextAlignmentLeft;
    //lblName.textColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    //lblName.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#000000" alpha:1.0];
    [bgView addSubview:lblName];
    
    
    
    
//    CGSize labelSize = [lblName.text sizeWithFont:lblName.font
//                                constrainedToSize:lblName.frame.size
//                                    lineBreakMode:NSLineBreakByWordWrapping];
    height1 = [self getTextViewHeight:lblName];
   lblName.frame =  CGRectMake(5,2, SCREEN_WIDTH-10, height1);
//    CGFloat labelHeight = labelSize.height;
//
//
//    int lines = [myLabel.text sizeWithFont:myLabel.font
//                         constrainedToSize:myLabel.frame.size
//                             lineBreakMode:NSLineBreakByWordWrapping].height/16;
    
    
    
    
    
    
    
//    NSUInteger numberOfOccurrences1 = [[[self.campainObj valueForKey:@"campaign_desc"] componentsSeparatedByString:@"\n"] count] - 1;
//    float height2 = (([[self.campainObj valueForKey:@"campaign_desc"] length]/numberofChar)+1+numberOfOccurrences1)*15;
//
//    lblDesc = [[UITextView alloc]initWithFrame:CGRectMake(5,height1+2, SCREEN_WIDTH-10, height2)];
//    lblDesc.text = [self.campainObj valueForKey:@"campaign_desc"];
//    lblDesc.font = [UIFont systemFontOfSize:12.0];
//    [lblDesc setEditable:FALSE];
//    lblDesc.scrollEnabled = FALSE;
//
//    lblDesc.textAlignment = NSTextAlignmentLeft;
////    lblDesc.textColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
////    lblDesc.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#000000" alpha:1.0];
//    [bgView addSubview:lblDesc];
//
//
//    NSUInteger numberOfOccurrences2 = [[[self.campainObj valueForKey:@"campaign_questions"] componentsSeparatedByString:@"\n"] count] - 1;
//    float height3 = (([[self.campainObj valueForKey:@"campaign_questions"] length]/numberofChar)+1+numberOfOccurrences2)*15;
//
//    lblQuestion = [[UITextView alloc]initWithFrame:CGRectMake(5,height1+height2+2, SCREEN_WIDTH-10, height3)];
//    lblQuestion.text = [[NSString alloc]initWithFormat:@"Q1.%@",[self.campainObj valueForKey:@"campaign_questions"] ];
//    lblQuestion.font = [UIFont systemFontOfSize:12.0];
//    [lblQuestion setEditable:FALSE];
//    lblQuestion.scrollEnabled = FALSE;
//
//    lblQuestion.textAlignment = NSTextAlignmentLeft;
//
//    [bgView addSubview:lblQuestion];
    if([[self.campainObj valueForKey:@"isImage"]intValue] == 1 && [self.campainObj valueForKey:@"campaign_image"] != NULL && ![[self.campainObj valueForKey:@"campaign_image"] isKindOfClass:[NSNull class]])
    {
     height2 = 180.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, height1+2, SCREEN_WIDTH, height2)];
        headerView.backgroundColor = [UIColor whiteColor];
    headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
    headImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    [headerView addSubview:headImageView];
    
    //headImageView.image = [UIImage imageNamed:@"malayalm.png"];
    
        NSMutableDictionary * dataObj = [[NSMutableDictionary alloc]init];
        [dataObj setValue:headImageView forKey:@"imageView"];
        [dataObj setValue:[[NSString alloc]initWithFormat:@"%@%@",@"https://tse.englishedge.in/live/campaign_images/",[self.campainObj valueForKey:@"campaign_image"]]  forKey:@"url"];
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self
                                       selector:@selector(downloadImageAndsetOnImgeView:)
                                       userInfo:dataObj
                                        repeats:NO];
    
    
    
    
    [bgView addSubview:headerView];
    }
    
    float height3 = 180.0;
    UIView * borderView = [[UIView alloc]initWithFrame:CGRectMake(5, height1+height2+10, SCREEN_WIDTH-10, height3)];
    [borderView.layer setMasksToBounds:YES];
    //borderView.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    [borderView.layer setCornerRadius:20.0f];
    [borderView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0].CGColor];
    [borderView.layer setBorderWidth:1];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(2, 2,borderView.frame.size.width-4,borderView.frame.size.height-20)];
    textView.delegate = self;
    charCounter = [[UILabel alloc]initWithFrame:CGRectMake(borderView.frame.size.width-60,borderView.frame.size.height-19 , 60,15)];
    charCounter.textColor = [self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    charCounter.text = @"0/350";
    charCounter.textAlignment = NSTextAlignmentCenter;
    charCounter.font = [UIFont systemFontOfSize:12.0];
    [borderView addSubview:charCounter];
    
    [borderView addSubview:textView];
    
    
    
    [bgView addSubview:borderView];
    
    
    
    
    float height4 = UIBUTTONHEIGHT;
    submit  = [[UIButton alloc] initWithFrame:CGRectMake(40, height1+height2+height3+20, SCREEN_WIDTH-80,height4)];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    submit.titleLabel.font = BUTTONFONT;
    [submit.layer setMasksToBounds:YES];
    //submit.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    submit.enabled =  FALSE;
    submit.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
    [submit.layer setCornerRadius:BUTTONROUNDRECT];
    //[submit.layer setBorderColor:[appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0].CGColor];
    //[submit.layer setBorderWidth:1];
    [submit setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [submit setHighlighted:YES];
    [submit addTarget:self action:@selector(SubmitData:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:submit];
    
    
    
    [bgView setContentSize:CGSizeMake(SCREEN_WIDTH,height1+height2+height3+height4+30)];
    
    
    

}
-(void)textViewDidChange:(UITextView *)textView
{
    NSString *trimmedString = [textView.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([trimmedString length] < 2)
        {
            submit.enabled =  FALSE;
            submit.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
            
        }
        else if([trimmedString length] > 350)
        {
          submit.enabled =  FALSE;
          submit.backgroundColor = [self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        
       }
        else
        {
            submit.enabled =  TRUE;
            submit.backgroundColor = [self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
            
        }
    charCounter.text = [[NSString alloc]initWithFormat:@"%lu/350",(unsigned long)[trimmedString length]];
}
    

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readLoginResponse:)
                                                 name:SERVICE_SETCAMPAIGN
                                               object:nil];
    
//    CGRect frame = lblName.frame;
//    frame.size.height = lblName.contentSize.height;
//    lblName.frame = frame;
//
//
//    CGRect frame1 = lblDesc.frame;
//    frame1.size.height = lblDesc.contentSize.height;
//    lblDesc.frame = frame1;
//
//    CGRect frame2 = lblQuestion.frame;
//    frame2.size.height = lblQuestion.contentSize.height;
//    lblQuestion.frame = frame2;
}


-(IBAction)ClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)downloadImageAndsetOnImgeView:(NSTimer *)theTimer
{
    NSMutableDictionary * dataObj = [theTimer userInfo];
    
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_async(q, ^{
        
        NSData *_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataObj valueForKey:@"url"]]];
        UIImage *img = [[UIImage alloc] initWithData:_data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imgView = (UIImageView *)[dataObj valueForKey:@"imageView"];
            [imgView setImage:img];
            
        });
    });
    
}

-(void)keyboardWillShow {
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.contentSize.height+200);
}

-(void)keyboardWillHide {
    
    bgView.contentSize = CGSizeMake(bgView.frame.size.width,bgView.contentSize.height-200);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(IBAction)SubmitData:(id)sender
{
//    activityIndicator = NULL;
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicator.alpha = 1.0;
//    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
//    activityIndicator.transform = transform;
//    activityIndicator.center = self.view.center;
//    activityIndicator.hidesWhenStopped = YES;
//    [self.view bringSubviewToFront:activityIndicator];
//    [self.view addSubview:activityIndicator];
//    [activityIndicator startAnimating];
//    [self.view setUserInteractionEnabled:NO];
//    [self showProgress];
//
//
//    NSMutableDictionary * override= [[NSMutableDictionary alloc]init];
//    [override setValue:[self.campainObj valueForKey:@"id"] forKey:@"campaign_id"];
//     [override setValue:@"iOS" forKey:@"plateform"];
//     [override setValue:textView.text forKey:@"response"];
//
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:appDelegate.engineObj.tokenID forKey:JSON_TOKEN ];
//    [reqObj setValue:JSON_SETCAMPAINING forKey:JSON_DECREE ];
//    [reqObj setValue:override forKey:JSON_PARAM];
//
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:SERVICE_SETCAMPAIGN forKey:@"SERVICE"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
}


- (void)readLoginResponse:(NSNotification *) notification
{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self hideProgress];
//        if([[[notification object]valueForKey:@"status"] intValue] == 4 && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_SETCAMPAIGN])
//        {
//            NSDictionary * temp = [[notification object]valueForKey:@"data"];
//            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                [self showSubmitPopup];
//
//            }
//        }
//        else
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:@""
//                                         message:@"Something wrong! Please try again later."
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//
//            [self presentViewController:alert animated:YES completion:nil];
//
//
//
//            int duration = 2; // duration in seconds
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                [alert dismissViewControllerAnimated:YES completion:nil];
//            });
//            return;
//        }
//
//    });
    
}


-(void)showSubmitPopup
{
    if(submitPopup != NULL){
        [submitPopup removeFromSuperview];
        submitPopup = NULL;
    }
    
    submitPopup =  NULL;
    submitPopup = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    submitPopup.backgroundColor = [self getUIColorObjectFromHexString:@"#000000" alpha:0.7];
    
    [self.view addSubview:submitPopup];
    
    
    popupCancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60,30,30,30)];
    [popupCancleBtn setImage:[UIImage imageNamed:@"cross.png"] forState:UIControlStateNormal];
    [popupCancleBtn addTarget:self action:@selector(ClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [submitPopup addSubview:popupCancleBtn];
    
    
    UIView * popupView = [[UIView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/3,SCREEN_WIDTH-40, SCREEN_HEIGHT/3)];
    popupView.backgroundColor = [UIColor whiteColor];
    [popupView.layer setMasksToBounds:YES];
    [popupView.layer setCornerRadius:20.0f];
     [submitPopup addSubview:popupView];
    
    UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20,SCREEN_HEIGHT/3-20,40,40)];
    rightImg.image = [UIImage imageNamed:@"right.png"];
    //rightImg.backgroundColor = [UIColor whiteColor];
    rightImg.contentMode = UIViewContentModeScaleAspectFit;
    [submitPopup bringSubviewToFront:rightImg];
    [submitPopup addSubview:rightImg];
    
    
    UILabel * thanks = [[UILabel alloc]initWithFrame:CGRectMake(0, 25,popupView.frame.size.width,20)];
    thanks.textAlignment = NSTextAlignmentCenter;
    thanks.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
    thanks.text = @"Thank You";
    thanks.textColor = [self getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
    [popupView addSubview:thanks];
    
    UILabel * second = [[UILabel alloc]initWithFrame:CGRectMake(0, 55,popupView.frame.size.width,25)];
    second.textAlignment = NSTextAlignmentCenter;
    second.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    second.numberOfLines = 2;
    second.lineBreakMode = NSLineBreakByWordWrapping;
    second.text = @"We have received your response.";
    second.textColor = [UIColor blackColor];
    [popupView addSubview:second];
    
    UILabel * third = [[UILabel alloc]initWithFrame:CGRectMake(10, 85,popupView.frame.size.width-20,80)];
    third.textAlignment = NSTextAlignmentCenter;
    third.numberOfLines = 3;
    third.lineBreakMode = NSLineBreakByWordWrapping;
    third.font =  [UIFont fontWithName:@"HelveticaNeue" size:15];
    third.text = @"List of winners can be accessed from the winners’ icon on the contests homepage.";
    third.textColor = [UIColor grayColor];
    [popupView addSubview:third];
    
    
//    winnerListTab = [[UIView alloc]initWithFrame:CGRectMake(popupView.frame.size.width/2-30,popupView.frame.size.height-80,60,60)];
//    winnerListTab.layer.masksToBounds = YES;
//    winnerListTab.clipsToBounds = YES;
//    winnerListTab.layer.cornerRadius = 30;
//    UIImageView * lowImg = [[UIImageView alloc]initWithFrame:CGRectMake(5,0,50,50)];
//    lowImg.image = [UIImage imageNamed:@"winners.png"];
//    winnerListTab.backgroundColor = [appDelegate getUIColorObjectFromHexString:@"#ff0000" alpha:1.0];
//    lowImg.contentMode = UIViewContentModeScaleAspectFit;
//    [winnerListTab addSubview:lowImg];
//
//    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0,43, winnerListTab.frame.size.width,8)];
//    lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.font = [UIFont boldSystemFontOfSize:6.0];
//    lbl.text = @"Winner list";
//    lbl.textColor = [UIColor whiteColor];
//    [winnerListTab addSubview:lbl];
//
//    [popupView addSubview:winnerListTab];
//
//    UITapGestureRecognizer *insGasture =  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                          action:@selector(OpenWinnerList)];
//    insGasture.numberOfTapsRequired =1;
//    [winnerListTab addGestureRecognizer:insGasture];
//
//
//    UILabel *lbltext = [[UILabel alloc]initWithFrame:CGRectMake(0,popupView.frame.size.height-20,popupView.frame.size.width,12)];
//    lbltext.textAlignment = NSTextAlignmentCenter;
//    lbltext.font = [UIFont systemFontOfSize:12.0];
//    lbltext.text = @"Click here to see the list";
//    lbltext.textColor = [UIColor grayColor];
//    [popupView addSubview:lbltext];
    
    
    
   
    
    
        
}


-(void)OpenWinnerList
{
    
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
