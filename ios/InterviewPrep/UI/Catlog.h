//
//  Catlog.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 27/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface Catlog : baseViewController<UIActionSheetDelegate,baseViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>//,SKProductsRequestDelegate,SKPaymentTransactionObserver
{
    @private
        //IBOutlet UINavigationBar *navBar;
        NSArray *validProducts;
        UIAlertView * downloadAlrt;
        UIAlertView * updateAlrt;
        UIAlertView * cancelDownloadAlrt;
        UITableView * expandableTblView;
    
    
}

@end
