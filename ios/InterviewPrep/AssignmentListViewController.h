//
//  ViewController.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "AssignmentListTableViewCell.h"

@interface AssignmentListViewController : baseViewController<UITableViewDelegate,UITableViewDataSource,AssignmentDetailDelegate>
{
    UIButton* backBtn;
}



@property (weak, nonatomic) IBOutlet UITableView *assignmentTableView;
@property UIView *topView;
@property IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSMutableArray *responseArray;
@property (strong, nonatomic) NSMutableArray *courseArray;
@property (strong, nonatomic) NSMutableArray *topicsArray;
@property (strong, nonatomic) NSMutableArray *assignmentArray;

@property (assign) NSInteger selectedRow;
@property (assign) NSInteger selectedSection;
@property (assign) BOOL isSelected;





@end

