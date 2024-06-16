//
//  LiqvidAlert.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 26/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiqvidAlert : UIAlertView
{
    UIView* alertView;
    
}

-(UIAlertView *)init:(NSString *)heading  Data:(NSString *)text;
@end
