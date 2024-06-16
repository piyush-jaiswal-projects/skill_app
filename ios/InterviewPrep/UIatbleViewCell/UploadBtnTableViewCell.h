//
//  UploadBtnTableViewCell.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UploadaAndDownloadDelegate <NSObject>

-(void)uploadAndDownloadAssesment;

@end
@interface UploadBtnTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UILabel *filename;

@property (nonatomic, weak) id<UploadaAndDownloadDelegate> delegate;

-(void)configureCell:(NSDictionary*)responseDict;

@end

NS_ASSUME_NONNULL_END
