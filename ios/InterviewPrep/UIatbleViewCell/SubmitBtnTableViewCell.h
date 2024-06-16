//
//  SubmitBtnTableViewCell.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubmitBtnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;


-(void)configureCell:(NSDictionary*)responseDict;
@end

NS_ASSUME_NONNULL_END
