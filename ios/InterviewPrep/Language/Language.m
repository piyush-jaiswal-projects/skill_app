//
//  Language.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 06/11/14.
//  Copyright (c) 2014 LIQVID eLearning Services Pvt Ltd. All rights reserved.
//

#import "Language.h"

@implementation Language



-(Language *)initialize:(NSString *)language {
    ////NSLog(@"preferredLang: %@", language);
    NSString *path = [[ NSBundle mainBundle ] pathForResource:language ofType:@"lproj" ];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        bundle = [NSBundle bundleWithPath:path];
        return self;
    }
    return NULL;
    
}


-(NSString *)get:(NSString *)key alter:(NSString *)alternate {
   // //NSLog(@"bundlePath = %@",[bundle bundlePath]);;
    return [bundle localizedStringForKey:key value:alternate table:nil];
}

@end
