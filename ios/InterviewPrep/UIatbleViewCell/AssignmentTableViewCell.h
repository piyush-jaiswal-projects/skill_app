//
//  AssignmentTableViewCell.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssignmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageView;
@property (weak, nonatomic) IBOutlet UIImageView *groupImgView;
@property (weak, nonatomic) IBOutlet UILabel *gotScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreLblViewHeightCons;


-(void)configureCell:(NSDictionary*)responseDict;

-(NSAttributedString *)getScore:(NSString *)gotScore totalScore:(NSString *)totalScore gotScoreFont:(UIFont *)gotScoreFont totalScoreFont:(UIFont *)totalScoreFont gotScoreColor:(UIColor *)gotScoreColor totalScoreColor:(UIColor *)totalScoreColor;

@end

NS_ASSUME_NONNULL_END
