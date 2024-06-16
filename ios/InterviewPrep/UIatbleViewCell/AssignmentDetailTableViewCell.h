//
//  AssignmentDetailTableViewCell.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DownloadBtnDelegate <NSObject>

-(void)downloadBtnClick;

@end

@interface AssignmentDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UITextView *detailTxtView;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (nonatomic, weak) id<DownloadBtnDelegate> delegate;



-(void)configureCell:(NSDictionary*)responseDict;
-(void)configureForFeedBack:(NSDictionary*)responseDict;
@end

NS_ASSUME_NONNULL_END
