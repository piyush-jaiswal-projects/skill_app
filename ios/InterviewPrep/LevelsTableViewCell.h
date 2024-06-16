//
//  LevelsTableViewCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LevelsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *circleImage;
@property (weak, nonatomic) IBOutlet UIImageView *pointerImage;
@property (weak, nonatomic) IBOutlet UILabel *colorLbl;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleImgWdhConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleImgHgtConstraints;

@end

NS_ASSUME_NONNULL_END
