//
//  OptionsImageCollectionViewCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 26/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "ListeningOptionCVCell.h"

@implementation ListeningOptionCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cellLbl.layer setBorderWidth:0.3];
    [self.cellLbl.layer setCornerRadius:5.0];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.statusView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(5.0, 5.0)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.statusView.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.statusView.layer.mask = maskLayer;

}

@end
