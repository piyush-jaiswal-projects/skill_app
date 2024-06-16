//
//  AssignmentList.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "AssignmentListViewController.h"
#import "AssignmentTableViewCell.h"
#import "WriteResponseViewController.h"

@interface AssignmentListViewController ()
{
    
}

@end

@implementation AssignmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    if(ISENABLECOINSUI){
        self.coinView = [[CoinsCounterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, STSTUSNAVIGATIONBARHEIGHT-45,80, 40)];
        self.coinView.backgroundColor = [UIColor clearColor];
        [self.coinView ShowUIWithNumber:0 totalCoins:0];
        [self.topView addSubview:self.coinView];
    }
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(75, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-150, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"Assignment";
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [self.topView addSubview:title];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backBtn];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,30)];
    self.bottomView.backgroundColor =  [UIColor whiteColor];
    
    
    UILabel * assign = [[UILabel alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH/2-10, 30)];
    assign.backgroundColor = [UIColor whiteColor];
    assign.text = @"ASSIGNMENT";
    assign.textAlignment = NSTextAlignmentLeft;
    assign.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    assign.font = HEADERSECTIONTITLEFONT;
    
    [self.bottomView addSubview:assign];
    
    UILabel * score = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/2-10, 30)];
    score.backgroundColor = [UIColor whiteColor];
    score.textAlignment = NSTextAlignmentRight;
    score.text = @"SCORE";
    score.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    score.font = HEADERSECTIONTITLEFONT;
    
    
    [self.bottomView addSubview:score];
    [self.view addSubview:self.bottomView];
    
    self.assignmentTableView.frame = CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT+30,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT-30);
    
    
    [self registerNibs];
    self.assignmentTableView.delegate = self;
    self.assignmentTableView.dataSource = self;
    self.assignmentTableView.tableFooterView = [UIView new];
    _isSelected = false;

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _responseArray = [[NSMutableArray alloc]init];
//    _courseArray = [[NSMutableArray alloc]init];
//    _topicsArray = [[NSMutableArray alloc]init];
//    _assignmentArray = [[NSMutableArray alloc]init];


    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(readNetworkRespose:)
                                                            name:SERVICE_GETASSIGNMENTLIST
                
                                                          object:nil];
    [self showGlobalProgress];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_GETASSIGNMENTLIST forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    //NSArray * arr =  [appDelegate.engineObj.dataMngntObj getAllTrackData:0];
    NSMutableDictionary * userObj = [[NSMutableDictionary alloc]init];
    [userObj setValue:CLASS_NAME forKey:JSON_CALSS_NAME];
    [userObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_LOGIN] forKey:@"user_name"];
    [reqObj setValue:userObj forKey:JSON_PARAM];
    
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETASSIGNMENTLIST forKey:@"SERVICE"];
    [_reqObj setValue:@"AssignmentListViewController" forKey:@"original_source"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SERVICE_GETASSIGNMENTLIST
                                                  object:nil];
    
}

#pragma marks :- register cell methods

-(void)registerNibs{
    
    [self.assignmentTableView registerNib:[UINib nibWithNibName:@"AssignmentListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AssignmentListTableViewCell"];
}


#pragma Mark:- Btn Action Methods

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


#pragma Mark:- UitableView Methods





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.responseArray count] > 0) {
        self.assignmentTableView.backgroundView = nil;
        return [self.responseArray count];
    } else {
//        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//
//        messageLabel.text = @"Retrieving data.\nPlease wait.";
//        messageLabel.numberOfLines = 0;
//        messageLabel.textAlignment = NSTextAlignmentCenter;
//        messageLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
//        [messageLabel sizeToFit];
//        self.assignmentTableView.backgroundView = messageLabel;
        
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.responseArray objectAtIndex:section]valueForKey:@"topicArr"] count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.responseArray count]) {
        return [[self.responseArray objectAtIndex:section]valueForKey:@"course_name"];
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 44.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *topicDict = [[[self.responseArray objectAtIndex:indexPath.section]valueForKey:@"topicArr"] objectAtIndex:indexPath.row];
    NSArray *arr = [topicDict valueForKey:@"assignmentArr"];
    if(_isSelected && _selectedRow == indexPath.row && _selectedSection == indexPath.section){
        return arr.count*120.0;
    }else{
       return 50;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // recast your view as a UITableViewHeaderFooterView
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
    header.textLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [header.textLabel setFont:HEADERSECTIONTITLEBOLDFONT];
}






-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    static NSString *identifier = @"AssignmentListTableViewCell";
    
    AssignmentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.preservesSuperviewLayoutMargins = false;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    NSDictionary *topicDict = [[[self.responseArray objectAtIndex:indexPath.section]valueForKey:@"topicArr"] objectAtIndex:indexPath.row];
    cell.topicsLbl.text = [topicDict valueForKey:@"topic_name"];
//    NSData *unicodedStringData = [self.sampleText dataUsingEncoding:NSUTF8StringEncoding];
//    //       NSString *decodevalue = [[NSString alloc] initWithData:unicodedStringData encoding:NSUTF8StringEncoding];
    cell.topicsLbl.font = HEADERSECTIONTITLEFONT;
    cell.topicsLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.arrowImgView setTintColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];

    if(_isSelected && indexPath.row == _selectedRow && indexPath.section == _selectedSection){
        self.assignmentArray = [topicDict valueForKey:@"assignmentArr"];
        [cell loadTableView:self.assignmentArray];
        [UIView animateWithDuration:0.4 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeRotation((90) * M_PI/180);
            cell.arrowImgView.transform = transform;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.4 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeRotation((0) * M_PI/180);
            cell.arrowImgView.transform = transform;
        }];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_isSelected == false){
    _isSelected = true;
    _selectedRow = indexPath.row;
    _selectedSection = indexPath.section;
    }else{
        _isSelected = false;
        _selectedRow = nil;
        _selectedSection = nil;

    }
    
    [self.assignmentTableView reloadData];
    
}


-(void)readNetworkRespose:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [self hideGlobalProgress];
    if (![NSStringFromClass([self class]) isEqualToString: [[notification object]valueForKey:@"original_source"]]){
        return;
    }
    if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETASSIGNMENTLIST])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                self.responseArray = [temp valueForKey:JSON_RETVAL];
                for(NSDictionary *responseDict in self.responseArray)
                {
                    NSString *courseName = responseDict[@"course_name"];
                    [self.courseArray addObject:courseName];
                    if(ISENABLECOINSUI)
                    {
                        
                            int total_coins = [[responseDict valueForKey:@"assignment_coins"] intValue];
                            int earn_coins = [[responseDict valueForKey:@"assignment_coins_earned"] intValue];
                            if(earn_coins > total_coins)
                            {
                              [self.coinView increaseCoinsCounterNumber:total_coins totalCoins:total_coins];
                            }
                            else
                            {
                                [self.coinView increaseCoinsCounterNumber:earn_coins totalCoins:total_coins];
                            }
                            
                    }
//                    NSArray * topicArr = responseDict[@"topicArr"];
//                    for(NSDictionary *topicsDict in topicArr){
//                        [self.topicsArray addObject:topicsDict[@"topic_name"]];
//                        NSArray *assmntArr = topicsDict[@"assignmentArr"];
//                        for(NSDictionary *assignmentDict in assmntArr){
//                            [self.assignmentArray addObject:assignmentDict];
//                        }
//                    }
                }
                [self.assignmentTableView reloadData];
            }
            else
            {
                
            }
        }
    });
}



- (void)navigateToAssignmentDetail:(nonnull NSDictionary *)responseDict {
        UIStoryboard *willeySB = [UIStoryboard storyboardWithName:@"Wiley" bundle:nil];
        WriteResponseViewController *vc = [willeySB instantiateViewControllerWithIdentifier:@"WriteResponseViewController"];
//        WriteResponseViewController *writeResponseVC = [[WriteResponseViewController alloc]init];
        vc.assignmentDictionary = responseDict;
        [self.navigationController pushViewController:vc animated:true];
}


@end





//{
//    retCode = SUCCESS;
//    retStat = 1;
//    retVal =     (
//                {
//            "course_code" = "CRS-1469";
//            "course_name" = "A2 course";
//            topicArr =             (
//                                {
//                    assignmentArr =                     (
//                                                {
//                            "assignment_desc" = "Test Assignment text goes here.";
//                            "assignment_end_date" = "2015-03-04 00:00:00";
//                            "assignment_file" = "sample.pdf";
//                            "assignment_id" = 1;
//                            "assignment_name" = "Test Assignment ";
//                            "assignment_text" = "Test Assignment ";
//                            "assignment_type" = teacher;
//                            "created_date" = "2020-03-04 10:03:16";
//                        },
//                                                {
//                            "assignment_desc" = test;
//                            "assignment_end_date" = "2020-03-06 00:00:00";
//                            "assignment_file" = "Penguins-1583499580.jpg";
//                            "assignment_id" = 20;
//                            "assignment_name" = test;
//                            "assignment_text" = test;
//                            "assignment_type" = teacher;
//                            "created_date" = "2020-03-06 18:03:40";
//                        }
//                    );
//                    "topic_edge_id" = 73933;
//                    "topic_name" = "Lesson 9";
//                },
//                                {
//                    assignmentArr =                     (
//                                                {
//                            "assignment_desc" = "Global Assignment";
//                            "assignment_end_date" = "2015-03-04 00:00:00";
//                            "assignment_file" = "Sample Document.docx";
//                            "assignment_id" = 3;
//                            "assignment_name" = "Global Assignment";
//                            "assignment_text" = "Global Assignment";
//                            "assignment_type" = global;
//                            "created_date" = "2020-03-04 13:03:22";
//                        }
//                    );
//                    "topic_edge_id" = 73746;
//                    "topic_name" = "Lesson 6";
//                },
//                                {
//                    assignmentArr =                     (
//                                                {
//                            "assignment_desc" = test;
//                            "assignment_end_date" = "2020-03-06 00:00:00";
//                            "assignment_file" = "Lighthouse-1583499269.jpg";
//                            "assignment_id" = 19;
//                            "assignment_name" = test;
//                            "assignment_text" = test;
//                            "assignment_type" = teacher;
//                            "created_date" = "2020-03-06 18:03:29";
//                        }
//                    );
//                    "topic_edge_id" = 72975;
//                    "topic_name" = "Past Simple";
//                }
//            );
//        },
//                {
//            "course_code" = "CRS-1470";
//            "course_name" = "Beginner English";
//            topicArr =             (
//            );
//        }
//    );
//}
