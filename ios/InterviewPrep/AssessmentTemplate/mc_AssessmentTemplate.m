//
//  mc_AssessmentTemplate.m
//  InterviewPrep
//
//  Created by Amit Gupta on 23/04/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "mc_AssessmentTemplate.h"

#define SELECTION_BG_COLOR  @"#ebf8fc"
#define SELECTION_OURLINECOLOR @"#36bbe1"

#define WRONG_SELECTION_BG_COLOR  @"#fdeeef"
#define WRONG_SELECTION_OURLINECOLOR @"#ed5565"

#define RIGHT_SELECTION_BG_COLOR  @"#e7f4d8"
#define RIGHT_SELECTION_OURLINECOLOR @"#89c63b"

#define MC_MMC_TEST_TOP_BOTTOM_PADDING 25

@implementation mc_AssessmentTemplate

-(void) Create_MCUIWithData:(NSDictionary *)question  :(NSDictionary *)obj : (UIScrollView *) scrollView :(Assessment *)superObj : (BOOL)isAnswerMode
{
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -10.0f;
    
    self.viewHeight =  0;
    superAssessmentObj = superObj;
    quesObj = question;
    if([[[question valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]] && [[[question valueForKey:@"answers"]valueForKey:@"answer"] count] > 0){
        
        NSArray * optArr  = [superAssessmentObj randomOptionArr:[[question valueForKey:@"answers"]valueForKey:@"answer"]:NO];
        QuesOptionArr = optArr;
    }
    else
    {
        NSDictionary * _option = [[question valueForKey:@"answers"]valueForKey:@"answer"];
        QuesOptionArr = [[NSArray alloc]initWithObjects:_option, nil];
    }
    
    filledOption = obj;
    
    
    
    for (int i =0; i < [QuesOptionArr count];i++)
    {
         NSDictionary * option1Dict = [QuesOptionArr objectAtIndex:i];
        
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[[option1Dict valueForKey:@"content"] valueForKey:@"text"] attributes:@{ NSParagraphStyleAttributeName : style,NSFontAttributeName : [UIFont systemFontOfSize:13.0f]}];
        
        CustomUIView * op1 =[[CustomUIView alloc]initWithFrame:CGRectMake(10, self.viewHeight, SCREEN_WIDTH-20, 0)];
        
        op1.ansObj = option1Dict;
        op1.tag = i;
        [self addSubview:op1];
        
        UIImageView * cirImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 25, 25)];
        cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
        cirImg.tag = 100+i;
        [op1 addSubview:cirImg];
        UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, op1.frame.size.width-30, 0)];
        text.tag = 200+i;
        text.numberOfLines = 0 ;
        text.font  = [UIFont systemFontOfSize:13.0];
        text.textColor = [superAssessmentObj getUIColorObjectFromHexString:@"#4e4e4e" alpha:1.0];
        text.lineBreakMode  = NSLineBreakByWordWrapping;
        text.textAlignment = NSTextAlignmentLeft;
        CALayer * lay1 = [text layer];
        [lay1 setMasksToBounds:YES];
        [lay1 setCornerRadius:20.0];
        [lay1 setBorderWidth:1.0];
        [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        text.attributedText = attrText;
        [op1 addSubview:text];
        
        int height = [superAssessmentObj heightForText:attrText.string font:text.font withinWidth:text.frame.size.width]+MC_MMC_TEST_TOP_BOTTOM_PADDING;
        op1.frame = CGRectMake(10, self.viewHeight, SCREEN_WIDTH-20, height);
        text.frame = CGRectMake(30, 0, op1.frame.size.width-30, height);
        
        UIButton * hiddenBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-20, height)];
        hiddenBtn.backgroundColor = [UIColor clearColor];
        [op1 addSubview:hiddenBtn];
        [hiddenBtn addTarget:superAssessmentObj action:@selector(multipleChoice_optTouchClick:) forControlEvents:(UIControlEventTouchUpInside|UIControlEventTouchUpOutside)];
        //[op1 addGestureRecognizer:[superAssessmentObj addMCTapgasture]];
        
        
        if([obj valueForKey:@"ansObj"] != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[[obj valueForKey:@"ansObj"] valueForKey:@"uniqid"]])
        {
            cirImg.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
            text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
            CALayer * lay1 = [text layer];
            [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
        }
        self.viewHeight = self.viewHeight + height+10;
        
        
    }
}

- (void)multipleChoice_optTouchClick:(id )optTouchClick
{
    
    [superAssessmentObj enableQuizBtn];
    for (int i =0; i < [QuesOptionArr count];i++)
    {
        CustomUIView  *local_touch_view = (CustomUIView *)[self viewWithTag:i];
        UIImageView * local_cirImg = (UIImageView *)[local_touch_view viewWithTag:100+local_touch_view.tag];
        UILabel * local_text = (UILabel *)[local_touch_view viewWithTag:200+local_touch_view.tag];
        
        local_text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0];
        local_cirImg.image = [UIImage imageNamed:@"RadioButton.png"];
        CALayer * lay8 = [local_text layer];
        [lay8 setMasksToBounds:YES];
        [lay8 setCornerRadius:20.0];
        [lay8 setBorderWidth:1.0];
        [lay8 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
        
    }
    
    CustomUIView  *touch_view = (CustomUIView *)[optTouchClick superview];
    UIImageView * cirImg = (UIImageView *)[touch_view viewWithTag:100+touch_view.tag];
    UILabel * text = (UILabel *)[touch_view viewWithTag:200+touch_view.tag];
    cirImg.image = [UIImage imageNamed:@"Selected_RadioButton.png"];
    CALayer * lay1 = [text layer];
    text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:SELECTION_BG_COLOR alpha:1.0];
    [lay1 setMasksToBounds:YES];
    [lay1 setCornerRadius:20.0];
    [lay1 setBorderWidth:1.0];
    [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
    
    NSMutableDictionary * obj = [superAssessmentObj createDictionaryifNot:quesObj type:@"mc" Time:[NSString stringWithFormat: @"%lld",[@(floor([[NSDate date] timeIntervalSince1970] * 1000)) longLongValue]]];
    [obj setObject:@"1" forKey:@"option"];
    [obj setObject:touch_view.ansObj forKey:@"ansObj"];
    [superAssessmentObj addOrReplace:obj];
}




-(NSMutableArray *)getAnswerArray
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i =0; i < [QuesOptionArr count];i++)
    {   UIView * view = [self viewWithTag:i];
        UITextField * textfield = [view viewWithTag:(100+i)];
        NSString *trimmed1 = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [arr addObject:trimmed1];
    }
    return arr;
}

-(int)showRightWrongAnswerUI
{
    BOOL quesFlag = TRUE;
    int height = 0;
    NSMutableString * convert =  [[NSMutableString alloc]init];
    NSMutableDictionary * calObj = [superAssessmentObj createDictionaryifNot:quesObj type:@"mc" Time:[NSString stringWithFormat: @"%lld",[@(floor([[NSDate date] timeIntervalSince1970] * 1000)) longLongValue]]];
    for (int i =0; i < [QuesOptionArr count];i++)
    {
        NSDictionary * option1Dict = [QuesOptionArr objectAtIndex:i];
        NSDictionary * obj =  [calObj valueForKey:@"ansObj"];
        if(obj != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[obj valueForKey:@"uniqid"]])
        {
            if([[[ obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                
                CustomUIView  *local_touch_view = (CustomUIView *)[self viewWithTag:i];
                UIImageView * local_cirImg = (UIImageView *)[local_touch_view viewWithTag:100+local_touch_view.tag];
                UILabel * local_text = (UILabel *)[local_touch_view viewWithTag:200+local_touch_view.tag];
                
                CALayer * lay1 = [local_text layer];
                local_text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(local_text.frame.size.width-30, 10, 20,20 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [local_text addSubview:rightImg];
                
                    [superAssessmentObj showFeedback:[option1Dict valueForKey:@"uniqid"] :TRUE :[calObj valueForKey:@"type"]];
            }
            else
            {
               if(obj != NULL && [[option1Dict valueForKey:@"uniqid"]isEqualToString:[obj valueForKey:@"uniqid"]])
                {
                    CustomUIView  *local_touch_view = (CustomUIView *)[self viewWithTag:i];
                    UIImageView * local_cirImg = (UIImageView *)[local_touch_view viewWithTag:100+local_touch_view.tag];
                    UILabel * local_text = (UILabel *)[local_touch_view viewWithTag:200+local_touch_view.tag];
                    CALayer * lay1 = [local_text layer];
                    local_text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0];
                    [lay1 setMasksToBounds:YES];
                    [lay1 setCornerRadius:20.0];
                    [lay1 setBorderWidth:1.0];
                    [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                    UIImageView * wrongImg = [[UIImageView alloc]initWithFrame:CGRectMake(local_text.frame.size.width-30, 15, 15,15 )];
                    wrongImg.image = [UIImage imageNamed:@"G_Wrong.png"];
                    [local_text addSubview:wrongImg];
                }
                    [superAssessmentObj showFeedback:[option1Dict valueForKey:@"uniqid"] :FALSE : [calObj valueForKey:@"type"]];
            }
            
        }
        else
        {
            if([[[obj valueForKey:@"is_correct"] valueForKey:@"text"] isEqualToString:@"true"])
            {
                
                CustomUIView  *local_touch_view = (CustomUIView *)[self viewWithTag:i];
                UIImageView * local_cirImg = (UIImageView *)[local_touch_view viewWithTag:100+local_touch_view.tag];
                UILabel * local_text = (UILabel *)[local_touch_view viewWithTag:200+local_touch_view.tag];
                
                CALayer * lay1 = [local_text layer];
                local_text.backgroundColor = [superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0];
                [lay1 setMasksToBounds:YES];
                [lay1 setCornerRadius:20.0];
                [lay1 setBorderWidth:1.0];
                [lay1 setBorderColor:[[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0] CGColor]];
                UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(local_text.frame.size.width-30, 10, 20,20 )];
                rightImg.image = [UIImage imageNamed:@"G_Right.png"];
                [local_text addSubview:rightImg];
                [superAssessmentObj showFeedback:[option1Dict valueForKey:@"uniqid"] :TRUE :[calObj valueForKey:@"type"]];
            }
        }
    }
    return height;
}
@end
