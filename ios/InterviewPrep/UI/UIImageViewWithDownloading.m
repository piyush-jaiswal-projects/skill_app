//
//  UIImageViewWithDownloading.m
//  InterviewPrep
//
//  Created by Amit Gupta on 05/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "UIImageViewWithDownloading.h"
#import "AppDelegate.h"


@implementation UIImageViewWithDownloading
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setImageURLPath:(NSString*)originalFilePathWithName BlurImageURLPath:(NSString*)blurPath
{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:blurPath]];
    self.image = [UIImage imageWithData: imageData];
   [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:originalFilePathWithName]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                self.image = _img;
                [APP_DELEGATE setUserDefaultData:data :originalFilePathWithName];
            }
        }];
    self.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setImageURLPath:(NSString*)originalFilePathWithName BlurImageLocalPath:(NSString*)blurPath
{
    self.image = [UIImage imageNamed:blurPath];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:originalFilePathWithName]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                self.image = _img;
                [APP_DELEGATE setUserDefaultData:data :originalFilePathWithName];
                
            }
        }];
    self.contentMode = UIViewContentModeScaleAspectFit;
}


@end
