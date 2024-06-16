//
//  CourseScreen.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 03/08/15.
//  Copyright (c) 2015 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "VCFloatingActionButton.h"
#import "FeedbackViewController.h"
#import "mobileScreen.h"


@interface CourseScreen: baseViewController<floatMenuDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
@private
    
   
    IBOutlet UITableView * uiTableView;
    
//    IBOutlet UINavigationBar * navBar;
//    IBOutlet UIBarButtonItem * editBtn;
    
    UIView * bar;
    UIButton *backBtn;
    UILabel * course_screen_title;
    UIImageView *course_title_image;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *dummyTable;
@property NSString * key;
@property NSString * _title;
@property NSString * selectedLevel;

@end
