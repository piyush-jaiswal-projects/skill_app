//
//  MeProActivity.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 03/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"


@interface MeProActivity : baseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating> //<UIWebViewDelegate>
{
   //NSMutableArray *contentListRecord;
    NSMutableArray *contentListUpComing;
    NSMutableArray *filteredContentList;
    NSMutableArray *Dummy;
    BOOL isSearching;
    //BOOL isupComing;
}

@property (strong, nonatomic) IBOutlet UITableView *tblContentList;

@end



