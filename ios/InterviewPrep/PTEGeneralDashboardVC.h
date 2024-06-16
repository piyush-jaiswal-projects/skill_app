//
//  PTEGeneralDashboardVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface PTEGeneralDashboardVC : baseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    AppDelegate *appdelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *profileImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (strong, atomic) Engine   *engineObj;

@end

NS_ASSUME_NONNULL_END
