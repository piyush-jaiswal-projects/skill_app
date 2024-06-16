//
//  MobileDashboard.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "baseViewController.h"
#import "VCFloatingActionButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobileDashboard : baseViewController<floatMenuDelegate,UITableViewDataSource,UITableViewDelegate>
{
}
@property (weak, nonatomic) IBOutlet UITableView *dummyTable;


@end

NS_ASSUME_NONNULL_END
