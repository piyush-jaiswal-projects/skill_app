//
//  WritingCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TableReloadDelegate <NSObject>

-(void)reloadTable;

@end
@interface WritingCell : UITableViewCell{
    
    BOOL isTapOnLabel;
    BOOL isTapOnAnsLabel;

}
@property (weak, nonatomic) IBOutlet UILabel *quesNoLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesDetailLbl;
@property (weak, nonatomic) IBOutlet UITextView *ansTextView;
@property (weak, nonatomic) IBOutlet UILabel *ansLbl;
@property (weak, nonatomic) IBOutlet UILabel *modelAnsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *modelImageV;


@property (nonatomic, weak) id<TableReloadDelegate> delegate;
-(void)configureCell:(NSDictionary *)responseDict;



@end

NS_ASSUME_NONNULL_END
