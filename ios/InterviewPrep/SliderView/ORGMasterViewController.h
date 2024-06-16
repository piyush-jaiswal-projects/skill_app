//
//  ORGMasterViewController.h
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Globalheader.h"
#import "URL_Macro.h"

@class ORGDetailViewController;

@interface ORGMasterViewController : UITableViewController
@property (strong, nonatomic)UIAlertView *dashProgrssView;
@property (strong, nonatomic) ORGDetailViewController *detailViewController;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) UIViewController *parentObj;

@end
