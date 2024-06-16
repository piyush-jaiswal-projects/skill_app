//
//  OptionsCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *optionImgV;
@property (weak, nonatomic) IBOutlet UILabel *optionLbl;
@property (weak, nonatomic) IBOutlet UIView *bckgroundView;

@end

NS_ASSUME_NONNULL_END
