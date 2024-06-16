//
//  MyPerformanceVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 17/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MyPerformanceVC.h"
#import "MyPerformanceCell.h"

@interface MyPerformanceVC ()
{
    UIView * bar;
    UIButton *backBtn;
}

@end

@implementation MyPerformanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-50,17)];
    viewTitle.text = @"My Performance";
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:viewTitle];

    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img11 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img11 = [img11 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img11 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    
//    UIImage * T_img =  [UIImage imageNamed:@"round-header.png"];
//    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [self.imgViews setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
//    self.imgViews.image = T_img;
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:SERVICE_PTEGPERFORMANCEGETLEVELSTATUS object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readResponsePTEPerformance:)
      name:SERVICE_PTEGPERFORMANCEGETLEVELSTATUS
    object:nil];
    
    [self showGlobalProgress];
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
    [reqObj setValue:JSON_GETLEVELDATA forKey:JSON_DECREE ];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    
    
    
    NSArray * _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:appDelegate.GSE_level];
    if(_arrCourseCode != NULL && [_arrCourseCode count] > 0 && [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] count] >0  ){
      NSArray *filterArr = [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(level_text contains[c] %@)", [appDelegate getUserDefaultData:@"user_selected_level"]]];
                [[[_arrCourseCode objectAtIndex:0] valueForKey:@"CouArr"] removeAllObjects];
        
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        
        for (NSDictionary * obj  in filterArr) {
            [arr addObject:[obj valueForKey:DATABASE_COURSE_DATA]];
        }
        
        
        NSMutableDictionary * obj1 = [[NSMutableDictionary alloc]init];
        [obj1  setValue:arr forKey:@"course_arr"];
        [obj1  setValue:[appDelegate getUserDefaultData:@"user_selected_level"] forKey:@"level_text"];
        
        
        
        NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
        [obj  setValue:obj1 forKey:@"level_arr"];
        [obj  setValue:appDelegate.coursePack forKey:@"package_code"];
        [reqObj setValue:obj forKey:JSON_PARAM];
        
        NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
        [_reqObj setValue:SERVICE_PTEGPERFORMANCEGETLEVELSTATUS forKey:@"SERVICE"];
        [_reqObj setValue:@"PTEG_Dashboard" forKey:@"original_source"];
        [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
           
    }
}


-(void)readResponsePTEPerformance:(NSNotification *) notification
{
    [self hideGlobalProgress];
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_PTEGPERFORMANCEGETLEVELSTATUS])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                
                NSDictionary * resp = [temp valueForKey:JSON_RETVAL];
                if(resp != NULL)
                {
                    self.totalTime  = [[resp valueForKey:@"ttl_time_sp"]doubleValue];
                    self.timeSpentArray = [resp valueForKey:@"skill_arr"];
                    self.itemsAttemptedArray = [resp valueForKey:@"skill_arr"];
                    self.skillPerformanceArray = [resp valueForKey:@"skill_arr"];
                    [self.tableView reloadData];
                }
            }
            
        }
    });
}


- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    static NSString *identifier = @"MyPerformanceCell";
    MyPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.nameLbl.text = [[appDelegate getFirstName] uppercaseString];
    [cell configureTimeSpentChart:self.timeSpentArray:self.totalTime];
    [cell configureItemsAttemptedChart:self.itemsAttemptedArray:self.totalTime];
    [cell configureSkillPerformanceChart:self.skillPerformanceArray:self.totalTime];
    return cell;
}


@end
