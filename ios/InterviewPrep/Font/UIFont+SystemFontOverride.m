//
//  UIFont+SystemFontOverride.m
//  InterviewPrep
//
//  Created by Amit Gupta on 06/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "UIFont+SystemFontOverride.h"
#import "AppConfig.h"

@implementation UIFont (SystemFontOverride)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:APPFONTBOLD size:fontSize];
}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:APPFONTNORMAL size:fontSize];
}

//+ (UIFont *)italicSystemFontOfSize:(CGFloat)fontSize {
//    return [UIFont fontWithName:APPFONTNORMAL size:fontSize];
//}


#pragma clang diagnostic pop

@end
