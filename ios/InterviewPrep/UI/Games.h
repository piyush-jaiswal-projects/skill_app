//
//  Games.h
//  InterviewPrep
//
//  Created by Amit Gupta on 24/10/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "baseViewController.h"

@interface Games : baseViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    //IBOutlet UINavigationBar * navBar;
    
}

@property NSString * gameId;
@property NSString * name;
@property NSString * scnUid;
@property int type;
@property NSString *  GSE_Level;
@property NSString * TopicName;
@property NSString * interectiveHtml;


@end
