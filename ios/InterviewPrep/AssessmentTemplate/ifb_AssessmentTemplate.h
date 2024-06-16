//
//  ifb_AssessmentTemplate.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/04/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"


NS_ASSUME_NONNULL_BEGIN

@interface ifb_AssessmentTemplate : UIView
{
    NSArray * QuesOptionArr;
    NSArray * filledOptionArr;
    Assessment * superAssessmentObj;
    NSDictionary * quesDict;
}
@property  int viewHeight;

-(void) Create_ifbUIWithData:(NSDictionary *)question  :(NSDictionary *)obj : (UIScrollView *) scrollView :(Assessment *)superObj : (BOOL)isAnswerMode;
-(BOOL)enableQuizButton;
-(NSMutableArray *)getAnswerArray;
-(int)showRightWrongAnswerUI;

@end

NS_ASSUME_NONNULL_END
