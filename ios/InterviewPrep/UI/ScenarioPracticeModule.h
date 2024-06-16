//
//  ScenarioPracticeModule.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 01/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


#import "baseViewController.h"

@interface ScenarioPracticeModule : baseViewController
<UIWebViewDelegate>
{
    @private
        NSMutableDictionary * data;
        UITableView * bgComponantTbl;
        
}

@property int ScnEdgeId;
@property int ScnType;
@property NSString *titleName;
@property BOOL isFlowContinue;
@end
