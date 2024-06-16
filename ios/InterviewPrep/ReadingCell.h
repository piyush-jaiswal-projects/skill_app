//
//  ReadingCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 25/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReloadTable <NSObject>
-(void)reloadTable;
@property (nonatomic, weak) id<ReloadTable> delegate;

@end


@interface ReadingCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL isTapOnLabel;
    BOOL isTapOnFeedbackLabel;
    NSString *selectedOption;

}
@property (weak, nonatomic) IBOutlet UILabel *quesLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesDetaillLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblHgtConstraint;
@property (nonatomic, weak) id<ReloadTable> delegate;
@property (weak, nonatomic) IBOutlet UILabel *modelAnsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *modelImgV;
@property (weak, nonatomic) IBOutlet UILabel *ansLbl;
@property (weak, nonatomic)  NSArray *answerArray;



-(void)configureCell:(NSDictionary *)responseDict;



@end

NS_ASSUME_NONNULL_END
