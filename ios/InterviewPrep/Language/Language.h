//
//  Language.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 06/11/14.
//  Copyright (c) 2014 LIQVID eLearning Services Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject
{
    NSBundle *bundle;
}

-(Language *)initialize:(NSString *)language;

-(NSString *)get:(NSString *)key alter:(NSString *)alternate;

@end
