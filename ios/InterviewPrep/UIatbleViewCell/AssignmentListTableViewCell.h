//
//  AssignmentListTableViewCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 08/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AssignmentDetailDelegate <NSObject>

-(void)navigateToAssignmentDetail:(NSDictionary *)responseDict;

@end

@interface AssignmentListTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *topicsLbl;

@property (weak, nonatomic) IBOutlet UITableView *asssignmentTableView;
@property (strong, nonatomic) NSMutableArray *assignmentsArray;
@property (nonatomic, weak) id<AssignmentDetailDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImgView;

-(NSAttributedString *)getScore:(NSString *)gotScore totalScore:(NSString *)totalScore gotScoreFont:(UIFont *)gotScoreFont totalScoreFont:(UIFont *)totalScoreFont gotScoreColor:(UIColor *)gotScoreColor totalScoreColor:(UIColor *)totalScoreColor;
-(void)loadTableView:(NSArray *)assignmentArray;


@end

NS_ASSUME_NONNULL_END
