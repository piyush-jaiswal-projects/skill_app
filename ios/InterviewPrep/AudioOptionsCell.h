//
//  AudioOptionsCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 27/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioOptionsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;
@property (weak, nonatomic) IBOutlet UIImageView *playPauseImgV;

@end

NS_ASSUME_NONNULL_END
