//
//  CoinsCounterView.m
//  InterviewPrep
//
//  Created by Amit Gupta on 07/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "CoinsCounterView.h"


@implementation CoinsCounterView


-(void)ShowUIWithNumber:(int)value totalCoins:(int)total_value
{
    UIView * roundedUI = [[UIView alloc]initWithFrame:CGRectMake(25, 15,self.frame.size.width-25, 20)];
    roundedUI.backgroundColor = [UIColor whiteColor];
    roundedUI.layer.borderWidth = 1;
    roundedUI.layer.cornerRadius = 7;
    roundedUI.clipsToBounds = YES;
    [self addSubview:roundedUI];
    
    self.counsNumber = [[UILabel alloc]initWithFrame:CGRectMake(13, 0,roundedUI.frame.size.width-20, 20)];
    self.counsNumber.textColor = [UIColor blackColor];
     self.counsNumber.backgroundColor = [UIColor whiteColor];
    self.counsNumber.textAlignment = NSTextAlignmentCenter;
    self.counsNumber.text = [[NSString alloc]initWithFormat:@"%d/%d",value,total_value];
    self.counsNumber.font = [UIFont systemFontOfSize:10];
    [roundedUI addSubview:self.counsNumber];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10,30, 30)];
    img.image = [UIImage imageNamed:@"p_coins.png"];
    [self addSubview:img];
    
    
}

-(void)increaseCoinsCounterNumber:(int)value totalCoins:(int)total_value
{
    self.counsNumber.text = [[NSString alloc]initWithFormat:@"%d/%d",value,total_value];
}






@end
