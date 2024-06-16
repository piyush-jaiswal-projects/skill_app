//
//  PTEG_SummeryPteVC.h
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "WritingCell.h"
#import "FIBCell.h"
#import "ListeningTableViewCell.h"
#import "ReadingCell.h"
#import "SpeakingCell.h"


NS_ASSUME_NONNULL_BEGIN

@interface PTEG_SummeryPteVC : baseViewController<UITableViewDelegate,UITableViewDataSource,TableReloadDelegate,ReloadTableDelegate,ReloadTable,loadTable>
 
@property (weak, nonatomic) NSMutableArray *questionArray;
@property NSString * titleName;
@property int  totalSpentTime;



@end

NS_ASSUME_NONNULL_END
