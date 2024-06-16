//
//  UIImageViewWithDownloading.h
//  InterviewPrep
//
//  Created by Amit Gupta on 05/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageViewWithDownloading : UIImageView

-(void)setImageURLPath:(NSString*)originalFilePathWithName BlurImageURLPath:(NSString*)blurPath;
-(void)setImageURLPath:(NSString*)originalFilePathWithName BlurImageLocalPath:(NSString*)blurPath;

@end

NS_ASSUME_NONNULL_END
