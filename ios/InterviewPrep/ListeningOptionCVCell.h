//
//  OptionsImageCollectionViewCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 26/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListeningOptionCVCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLbl;
@property (weak, nonatomic) IBOutlet UIImageView *cellImgV;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UIImageView *radioImgV;
@property (weak, nonatomic) IBOutlet UILabel *optionLbl;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgV;


@end

NS_ASSUME_NONNULL_END
