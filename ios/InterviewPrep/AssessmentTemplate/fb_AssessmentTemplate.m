//
//  fb_AssessmentTemplate.m
//  InterviewPrep
//
//  Created by Amit Gupta on 23/04/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "fb_AssessmentTemplate.h"


#define SELECTION_BG_COLOR  @"#ebf8fc"
#define SELECTION_OURLINECOLOR @"#36bbe1"

#define WRONG_SELECTION_BG_COLOR  @"#fdeeef"
#define WRONG_SELECTION_OURLINECOLOR @"#ed5565"

#define RIGHT_SELECTION_BG_COLOR  @"#e7f4d8"
#define RIGHT_SELECTION_OURLINECOLOR @"#89c63b"


@implementation fb_AssessmentTemplate

-(void) Create_fbUIWithData:(NSDictionary *)question  :(NSDictionary *)obj : (UIScrollView *) scrollView :(Assessment *)superObj : (BOOL)isAnswerMode
{
    self.viewHeight =  0;
    superAssessmentObj = superObj;
    RandomQuesOptionArr = [[NSMutableArray alloc]init];
    if([[[question valueForKey:@"answers"]valueForKey:@"answer"] isKindOfClass:[NSArray class]] && [[[question valueForKey:@"answers"]valueForKey:@"answer"] count] > 0){
            QuesOptionArr = [[question valueForKey:@"answers"]valueForKey:@"answer"];
        }
        else
        {
            NSDictionary * _option = [[question valueForKey:@"answers"]valueForKey:@"answer"];
            QuesOptionArr = [[NSArray alloc]initWithObjects:_option, nil];
        }
        
        for (int i =0; i < [QuesOptionArr count];i++)
         {
            [RandomQuesOptionArr addObject:[[QuesOptionArr objectAtIndex:i] valueForKey:@"text"]];
            UIView * areaTxt = [[UIView alloc]initWithFrame:CGRectMake(20, self.viewHeight, scrollView.frame.size.width-40,50)];
            [self addSubview:areaTxt];
            areaTxt.tag = 10+i;
            [[areaTxt layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
            [[areaTxt layer] setBorderWidth:2.0];
            [[areaTxt layer] setCornerRadius:15];
            UITextView * fbTextView1 = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, areaTxt.frame.size.width-25,30)];
            fbTextView1.autocorrectionType = UITextAutocorrectionTypeNo;
            fbTextView1.font = [UIFont systemFontOfSize:13.0];
            fbTextView1.tag = 100+i;
            fbTextView1.textColor = [superAssessmentObj getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            fbTextView1.delegate = superAssessmentObj.self;
            [areaTxt addSubview:fbTextView1];
            NSMutableArray * arrfb = [obj valueForKey:@"option"];
            if(arrfb != NULL && [arrfb count] > 0)
            {
                fbTextView1.text = [arrfb objectAtIndex:i];
            }
            self.viewHeight = self.viewHeight + 60;
             
        }
}

-(BOOL)enableQuizButton
{
    BOOL flag = TRUE;
    for (int i =0; i < [QuesOptionArr count];i++)
    {
        UIView * _view = [self viewWithTag:(10+i)];
        UITextView * textfield = [_view viewWithTag:(100+i)];
       
        NSString *trimmed1 = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([trimmed1 length] == 0)
        {
            flag = FALSE;
        }
    }
    return flag;
}
-(NSMutableArray *)getAnswerArray
{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i =0; i < [QuesOptionArr count];i++)
    {   UIView * _view = [self viewWithTag:(10+i)];
    UITextView * textfield = [_view viewWithTag:(100+i)];
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
    
    for (int i =0; i < [QuesOptionArr count];i++)
    {
        
        UIView * _view = [self viewWithTag:(10+i)];
        UITextView * textfield = [_view viewWithTag:(100+i)];
        _view.userInteractionEnabled = FALSE;
        NSString *trimmed1 = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        textfield.text = trimmed1;
        NSString* newString7 = [trimmed1 stringByReplacingOccurrencesOfString:@"’" withString:@"'"];
        
        
        
        NSString * dataStr = [[QuesOptionArr objectAtIndex:i] valueForKey:@"text"];
        NSArray * arr = [dataStr componentsSeparatedByString:@"##"];
        BOOL flag = TRUE;
        [convert appendFormat:@"<li style=\"margin-bottom:5px;color:%@\">%@</li>",RIGHT_SELECTION_OURLINECOLOR,[arr objectAtIndex:0]];
        for (NSString * str in arr)
        {
            NSString* re_str = [str stringByReplacingOccurrencesOfString:@"’" withString:@"'"];
            if([[re_str uppercaseString]isEqualToString:[newString7 uppercaseString]])
            {
                
                flag = FALSE;
                break;
            }
        }
        if(!flag)
        {
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(_view.frame.size.width-25, _view.frame.size.height-35, 20,20)];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [_view addSubview:rightImg];
            [[_view layer] setBorderColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0 ].CGColor];
            [_view setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0 ]];
            [textfield setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0 ]];
        }
        else
        {
            quesFlag = FALSE;
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(_view.frame.size.width-25, _view.frame.size.height-35, 20,20 )];
            rightImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [_view addSubview:rightImg];
            [[_view layer] setBorderColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0 ].CGColor];
            [_view setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0 ]];
            [textfield setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0 ]];
        }
        
        
        
    }
    
    if(!quesFlag)
    {
        [superAssessmentObj showFeedback:@"": FALSE :@"fb"];
        
        NSString * str_2 = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"4\">%@</font></div>",convert];
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                error: nil
                                                ];
        //questionView.attributedText = attributedString;
        self.viewHeight = self.viewHeight;
        UITextView * _view = [self viewWithTag:100];
        
        UIView * areaTxt = (UIView *)[[self subviews]lastObject];
//        NSLog(@"%f",areaTxt.frame.origin.y);
        UILabel * rightAns = [[UILabel alloc]initWithFrame:CGRectMake(areaTxt.frame.origin.x+5,self.viewHeight,areaTxt.frame.size.width ,50)];
        //rightAns.backgroundColor = [UIColor redColor];
        //rightAns.font = [UIFont systemFontOfSize:15.0];
        rightAns.numberOfLines = 0;
        rightAns.lineBreakMode = NSLineBreakByWordWrapping;
        rightAns.attributedText  = attributedString;
        
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(_view.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        CGFloat f_height = rect.size.height;
        height = f_height;
        rightAns.frame = CGRectMake(areaTxt.frame.origin.x+10,self.viewHeight,areaTxt.frame.size.width , height);
        self.viewHeight = self.viewHeight+height;
        rightAns.textColor = [superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
        [self addSubview:rightAns];
    }
    else
    {
        [superAssessmentObj showFeedback:@"": TRUE : @"fb"];
    }
    return height;
}

-(int)showRamdomRightWrongAnswerUI
{
    BOOL quesFlag = TRUE;
    int height = 0;
    NSMutableString * convert =  [[NSMutableString alloc]init];
    
    for (int i =0; i < [QuesOptionArr count];i++)
    {
        
        UIView * _view = [self viewWithTag:(10+i)];
        UITextView * textfield = [_view viewWithTag:(100+i)];
        _view.userInteractionEnabled = FALSE;
        NSString *trimmed1 = [textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        textfield.text = trimmed1;
        NSString* newString7 = [trimmed1 stringByReplacingOccurrencesOfString:@"’" withString:@"'"];
        BOOL flag = TRUE;
        for(int j =0; j < [RandomQuesOptionArr count];j++){
        
        NSString * dataStr = [RandomQuesOptionArr objectAtIndex:j] ;
        NSArray * arr = [dataStr componentsSeparatedByString:@"##"];
        
        //[convert appendFormat:@"<li style=\"margin-bottom:5px;color:%@\">%@</li>",RIGHT_SELECTION_OURLINECOLOR,[arr objectAtIndex:0]];
        for (NSString * str in arr)
        {
            NSString* re_str = [str stringByReplacingOccurrencesOfString:@"’" withString:@"'"];
            if([[re_str uppercaseString]isEqualToString:[newString7 uppercaseString]])
            {
                
                flag = FALSE;
                [RandomQuesOptionArr removeObjectAtIndex:j];
                break;
            }
        }
        
      }
        NSString * dataStr = [[QuesOptionArr objectAtIndex:i]valueForKey:@"text"] ;
        NSArray * arr = [dataStr componentsSeparatedByString:@"##"];
        [convert appendFormat:@"<li style=\"margin-bottom:5px;color:%@\">%@</li>",RIGHT_SELECTION_OURLINECOLOR,[arr objectAtIndex:0]];
      if(!flag)
      {
            
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(_view.frame.size.width-25, _view.frame.size.height-35, 20,20)];
            rightImg.image = [UIImage imageNamed:@"G_Right.png"];
            [_view addSubview:rightImg];
            [[_view layer] setBorderColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0 ].CGColor];
            [_view setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0 ]];
            [textfield setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_BG_COLOR alpha:1.0 ]];
            //break;
        }
        else
        {
            quesFlag = FALSE;
            UIImageView * rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(_view.frame.size.width-25, _view.frame.size.height-35, 20,20 )];
            rightImg.image = [UIImage imageNamed:@"G_Wrong.png"];
            [_view addSubview:rightImg];
            [[_view layer] setBorderColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_OURLINECOLOR alpha:1.0 ].CGColor];
            [_view setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0 ]];
            [textfield setBackgroundColor:[superAssessmentObj getUIColorObjectFromHexString:WRONG_SELECTION_BG_COLOR alpha:1.0 ]];
        }
        
        
        
    }
    
    if(!quesFlag)
    {
        [superAssessmentObj showFeedback:@"": FALSE :@"fb"];
        
        NSString * str_2 = [[NSString alloc]initWithFormat:@"<div><font face=\"HelveticaNeue\" size=\"4\">%@</font></div>",convert];
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [str_2 dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                documentAttributes: nil
                                                error: nil
                                                ];
        //questionView.attributedText = attributedString;
        self.viewHeight = self.viewHeight;
        UITextView * _view = [self viewWithTag:100];
        
        UIView * areaTxt = (UIView *)[[self subviews]lastObject];
//        NSLog(@"%f",areaTxt.frame.origin.y);
        UILabel * rightAns = [[UILabel alloc]initWithFrame:CGRectMake(areaTxt.frame.origin.x+5,self.viewHeight,areaTxt.frame.size.width ,50)];
        //rightAns.backgroundColor = [UIColor redColor];
        rightAns.font = [UIFont systemFontOfSize:15.0];
        rightAns.numberOfLines = 0;
        rightAns.lineBreakMode = NSLineBreakByWordWrapping;
        rightAns.attributedText  = attributedString;
        
        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(_view.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        CGFloat f_height = rect.size.height;
        height = f_height;
        
        rightAns.frame = CGRectMake(areaTxt.frame.origin.x+10,self.viewHeight,areaTxt.frame.size.width , height);
        self.viewHeight = self.viewHeight+height;
        rightAns.textColor = [superAssessmentObj getUIColorObjectFromHexString:RIGHT_SELECTION_OURLINECOLOR alpha:1.0];
        [self addSubview:rightAns];
    }
    else
    {
        [superAssessmentObj showFeedback:@"": TRUE : @"fb"];
    }
    return height;
}



@end
