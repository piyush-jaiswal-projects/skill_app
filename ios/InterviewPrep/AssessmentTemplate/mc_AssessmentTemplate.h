//
//  mc_AssessmentTemplate.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/04/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"
#import "CustomUIView.h"
NS_ASSUME_NONNULL_BEGIN

@interface mc_AssessmentTemplate : UIView<UIGestureRecognizerDelegate>
{
  NSArray * QuesOptionArr;
  NSDictionary * filledOption;
  Assessment * superAssessmentObj;
  NSDictionary * quesObj;

 }
 @property  int viewHeight;

-(void) Create_MCUIWithData:(NSDictionary *)question  :(NSDictionary *)obj : (UIScrollView *) scrollView :(Assessment *)superObj : (BOOL)isAnswerMode;
-(NSMutableArray *)getAnswerArray;
-(int)showRightWrongAnswerUI;
- (void)multipleChoice_optTouchClick:(UITapGestureRecognizer *)optTouchClick;

@end

NS_ASSUME_NONNULL_END
