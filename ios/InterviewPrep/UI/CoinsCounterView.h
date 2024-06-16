//
//  CoinsCounterView.h
//  InterviewPrep
//
//  Created by Amit Gupta on 07/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoinsCounterView : UIView
@property  UILabel *counsNumber;

-(void)ShowUIWithNumber:(int)value totalCoins:(int)total_value;
-(void)increaseCoinsCounterNumber:(int)value totalCoins:(int)total_value;

@end

NS_ASSUME_NONNULL_END
