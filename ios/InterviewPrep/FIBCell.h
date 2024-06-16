//
//  FIBCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ReloadTableDelegate <NSObject>

-(void)reloadTable;
@end


@interface FIBCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL isTapOnLabel;
    BOOL isMultipleOptions;
    CGFloat cellHeight;

}
@property (weak, nonatomic) IBOutlet UILabel *quesNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesDetailLbl;
@property (weak, nonatomic) IBOutlet UILabel *ansLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<ReloadTableDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblHgtConstraints;
@property (weak, nonatomic)  NSArray *answerArray;
@property (weak, nonatomic)  NSArray *optionArray;
@property (weak, nonatomic)  NSDictionary *answerDict;





-(void)configureCell:(NSDictionary *)responseDict;


@end

NS_ASSUME_NONNULL_END
