//
//  LiqvidAlert.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 26/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "LiqvidAlert.h"

@implementation LiqvidAlert

-(UIAlertView *)init:heading Data:(NSString *)text
{
    self = [super init];
    //self.delegate = self;
    alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 200)];
    [self setValue:alertView forKey:@"accessoryView"];
    [alertView setBackgroundColor:[UIColor redColor]];
    
    UIButton*testButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testButton setFrame:CGRectMake(75,50, 100, 40)];
    [testButton setBackgroundColor:[UIColor blueColor]];
    [testButton addTarget:self action:@selector(someAction) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:testButton];
    return self;
    

}

-(void)someAction
{
    [self dismissWithClickedButtonIndex:0 animated:TRUE];
}


@end
