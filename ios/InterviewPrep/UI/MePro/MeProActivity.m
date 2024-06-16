//
//  Activity.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 03/12/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "MeProActivity.h"
#import "MePro_Acticity_Launcher.h"



@interface MeProActivity ()
{
    UIView * bar;
    UIView * headerView;
    UIButton *backBtn;
//    UIButton *upcoming;
//    UIButton *Recorded;
    
    UIImageView * imageView;
    UIImageView * checkImageView;
    
    UILabel * userName;
    UILabel * Time;
    UILabel * Date;
    UILabel * Title;
    UILabel * TitleDesc;
    UILabel * userTitle;
    UIProgressView * pView;
    UILabel *duration;
    UIImageView * rightImageView;
    UIAlertController *joinCancel;
    UIAlertController *booking;
    //NSDictionary * currentSlctBooking;
    NSMutableDictionary * imgArr;
    UIActivityIndicatorView *indicator;
    // UIActivityIndicatorView *activityIndicator;
    UISearchController * searchController;
    
    //  UIView *tabView;
    
}


@end

@implementation MeProActivity
@synthesize tblContentList;


- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(50, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-100, 44)];
    title.text = @"Live Session";
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    if([UISTANDERD isEqualToString:@"PRODUCT2"]){
        UIButton * mepro_h_btn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
        UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [mepro_h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
        [mepro_h_btn setImage:T_img forState:UIControlStateNormal];
    
        [mepro_h_btn addTarget:self action:@selector(showMeProDrawer) forControlEvents:UIControlEventTouchUpInside];
        [mepro_h_btn bringSubviewToFront:bar];
        [bar addSubview:mepro_h_btn];
        mepro_h_btn.hidden =  FALSE;
    }
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(ClickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
//    for(UIView *subView in searchController.searchBar.subviews) {
//        if ([subView isKindOfClass:[UITextField class]]) {
//            UITextField *searchField = (UITextField *)subView;
//            searchField.font = [UIFont systemFontOfSize:13.0];
//            searchField.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//        }
//    }
    UIFont *font = TEXTTITLEFONT;
    UIColor *color = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    NSDictionary * defaultTextAttribs = @{NSFontAttributeName:font, NSForegroundColorAttributeName: color};
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[searchController.searchBar class]]].defaultTextAttributes = defaultTextAttribs;
//    UITextField *textField = [[searchController.searchBar subviews] objectAtIndex:1];
//    [textField setFont:[UIFont systemFontOfSize:13.0]];
//    [textField setTextColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]];
    
    
    // Add the search bar
    tblContentList = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    tblContentList.delegate = self;
    tblContentList.dataSource = self;
    tblContentList.tableFooterView = [UIView new];
    [self.view addSubview:tblContentList];
    tblContentList.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    [searchController.searchBar sizeToFit];
    
    filteredContentList = [[NSMutableArray alloc] init];
    Dummy = [[NSMutableArray alloc]init];
    
    imgArr = [[NSMutableDictionary alloc]init];
    
    //tblContentList.frame = CGRectMake(0, 4,SCREEN_WIDTH,SCREEN_HEIGHT-88);
    
    contentListUpComing = [[NSMutableArray alloc]init];
    //contentListRecord = [[NSMutableArray alloc]init];
    //isupComing = TRUE;
    
//    UIView *_view = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-44 ,SCREEN_WIDTH,44)];
//    [_view setBackgroundColor:[self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0]];
//    [self.view addSubview:_view];
    
//    upcoming = [[UIButton alloc]initWithFrame:CGRectMake(0,1, (_view.frame.size.width/2)-1,43)];
//    [_view addSubview:upcoming];
//
//    [upcoming addTarget:self
//                 action:@selector(clickOnUpComing)
//       forControlEvents:UIControlEventTouchUpInside];
//
//    Recorded = [[UIButton alloc]initWithFrame:CGRectMake((_view.frame.size.width/2),1, (_view.frame.size.width/2),43)];
//    [_view addSubview:Recorded];
//
//    [Recorded addTarget:self
//                 action:@selector(clickOnRecorded)
//       forControlEvents:UIControlEventTouchUpInside];
//
//    [upcoming setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [Recorded setTitleColor:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [upcoming setTitle:@"Upcoming" forState:UIControlStateNormal];
//    upcoming.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    Recorded.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    [Recorded setTitle:@"Recorded" forState:UIControlStateNormal];
//    [upcoming setBackgroundColor:[UIColor whiteColor]];
//    [Recorded setBackgroundColor:[UIColor whiteColor]];
    
    [self showGlobalProgress];
    
    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
    [reqObj setValue:JSON_EVENTLIST_DECREE forKey:JSON_DECREE ];
    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETLIVESESSIONLIST forKey:@"SERVICE"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
}

- (void)readActivityData:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self hideGlobalProgress];
        if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETLIVESESSIONLIST])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                if([temp valueForKey:@"retVal"] != NULL){
                    NSArray *oldSavedArray = (NSArray *)[temp valueForKey:@"retVal"];
                    NSArray *Arr = [[NSMutableArray alloc] initWithArray:oldSavedArray];
                    [self ConvertArrayFormat:Arr];
                    if(Arr == NULL || [Arr count] == 0 )
                    {
                        UIView * noClassView = [[UIView alloc]initWithFrame:CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height)];
                        noClassView.backgroundColor = [UIColor whiteColor];
                        UIView * centerView  = [[UIView alloc]initWithFrame:CGRectMake(0,0,250,300)];
                        UILabel * nowebinar = [[UILabel alloc]initWithFrame:CGRectMake(0,20,250,30)];
                        [centerView addSubview:nowebinar];
                        
                        nowebinar.text = @"No Webinar !!";
                        nowebinar.font = [UIFont boldSystemFontOfSize:30];
                        nowebinar.textAlignment = NSTextAlignmentCenter;
                        
                        UILabel * nowebinarDesc = [[UILabel alloc]initWithFrame:CGRectMake(20,60,210,60)];
                        [centerView addSubview:nowebinarDesc];
                        
                        nowebinarDesc.text = @"We will notify you once we have the session aligned.";
                        //nowebinarDesc.numberOfLines =2;
                        nowebinarDesc.lineBreakMode = NSLineBreakByWordWrapping ;// Wrap at word boundaries
                        nowebinarDesc.numberOfLines = 0;
                        nowebinarDesc.textAlignment = NSTextAlignmentCenter;
                        
                        centerView.center = self.view.center;
                        [noClassView addSubview:centerView ];
                        
                        [self.view addSubview:noClassView ];
                    }
                    else{
                        [tblContentList reloadData];
                    }
                }
            }
        }
        else if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_CANCELSESSION])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                [self showGlobalProgress];
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                [reqObj setValue:JSON_EVENTLIST_DECREE forKey:JSON_DECREE ];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_GETLIVESESSIONLIST forKey:@"SERVICE"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
            }
            
        }
        
        
    });
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readActivityData:)
                                                 name:SERVICE_GETLIVESESSIONLIST
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readActivityData:)
                                                 name:SERVICE_JOINSESSION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(readActivityData:)
                                                 name:SERVICE_CANCELSESSION
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}
-(void)ClickBack
{
    [self.navigationController popViewControllerAnimated:FALSE];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return 150;
}

- (void)viewDidUnload {
    [self setTblContentList:nil];
    //    [self setSearchBar:nil];
    //    [self setSearchBarController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isSearching) {
        return [filteredContentList count];
    }
    else {
        return [contentListUpComing count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        
        rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40,40,40,40)];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,20,60,60)];
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = YES;
    
        userName = [[UILabel alloc]initWithFrame:CGRectMake(0,85,90,20)];
        userName.textAlignment = NSTextAlignmentCenter;
        userName.font = [UIFont systemFontOfSize:10];
        userName.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cell addSubview:userName];
    
        Time = [[UILabel alloc]initWithFrame:CGRectMake(115,20,45,15)];
        Time.font = [UIFont boldSystemFontOfSize:15];
        Time.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    
        Date = [[UILabel alloc]initWithFrame:CGRectMake(165,25,self.view.frame.size.width-150,10)];
        Date.font = [UIFont systemFontOfSize:10];
    
        checkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-110,0,40,40)];
    
        duration = [[UILabel alloc]initWithFrame:CGRectMake(115,35,self.view.frame.size.width-210,15)];
        duration.font = [UIFont systemFontOfSize:10];
        Title = [[UILabel alloc]initWithFrame:CGRectMake(115,50,self.view.frame.size.width-150,15)];
        Title.font = [UIFont boldSystemFontOfSize:13];
        TitleDesc = [[UILabel alloc]initWithFrame:CGRectMake(115,65,self.view.frame.size.width-150,20)];
        TitleDesc.font = [UIFont systemFontOfSize:10];
        TitleDesc.numberOfLines = 2;
        userTitle  = [[UILabel alloc]initWithFrame:CGRectMake(115,85,self.view.frame.size.width-150,20)];
        userTitle.font = [UIFont systemFontOfSize:10];
        pView = [[UIProgressView alloc]initWithFrame:CGRectMake(115,105,self.view.frame.size.width-150,20)];
        pView .trackTintColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
   // }
    userTitle.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    Date.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    duration.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    TitleDesc.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    Title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    
    [imageView setImage:[UIImage imageNamed:@"TrainerImage"]];
    [rightImageView setImage:[UIImage imageNamed:@"nextWizIQ.png"]];
    [checkImageView setImage:[UIImage imageNamed:@"complete.png"]];
    
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    pView.transform = transform;
    
    [cell.contentView addSubview:imageView];
    
    [cell.contentView addSubview:Time];
    [cell.contentView addSubview:duration];
    [cell.contentView addSubview:Date];
    [cell.contentView addSubview:Title];
    [cell.contentView addSubview:TitleDesc];
    [cell.contentView addSubview:userTitle];
    [cell.contentView addSubview:pView];
    [cell.contentView addSubview:rightImageView];
    
    
    NSDictionary *obj ; //= [filteredContentList objectAtIndex:indexPath.row];
    
    if (isSearching) {
        obj = [filteredContentList objectAtIndex:indexPath.row];
    }
    else
    {
        obj = [contentListUpComing objectAtIndex:indexPath.row];
//        if(isupComing)
//
//        else
//            obj = [contentListRecord objectAtIndex:indexPath.row];
    }
    
    Time.text =[obj valueForKey:UIACTIVITYTIME];
    Date.text =[obj valueForKey:UIACTIVITYDATE];
    NSMutableString * strDuration = [[NSMutableString alloc]initWithFormat:@"Duration - %@",[obj valueForKey:UIACTIVITYDURATION]];
    duration.text =strDuration;
    if([[[obj valueForKey:UIACTIVITYISBOOKED]uppercaseString] isEqualToString:@"YES"])
    {
        [cell addSubview:checkImageView];
    }
    Title.text =[obj valueForKey:UIACTIVITYHEADERTITLE];
    TitleDesc.text =[obj valueForKey:UIACTIVITYHEADERDESCRIPTION];
    NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"User (%i/%@)",([[obj valueForKey:UIACTIVITYTOTELSEATS] intValue]-[[obj valueForKey:UIACTIVITYBOOKEDSHEET] intValue]),[obj valueForKey:UIACTIVITYTOTELSEATS]];
    userTitle.text =str;
    userName.text =[obj valueForKey:UIACTIVITYUSERNAME];
    float val =  ([[obj valueForKey:UIACTIVITYTOTELSEATS] floatValue] -[[obj valueForKey:UIACTIVITYBOOKEDSHEET] floatValue ])/[[obj valueForKey:UIACTIVITYTOTELSEATS] floatValue];
    pView.progress =val;
    pView .progressTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
    
    
    
    
    NSString *imageUrl = [obj valueForKey:UIACTIVITYUSERIMAGE];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                imageView.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
                imageView.image = _img;
            }
            
        }];
    }
    else
    {
        imageView.image = Limg;
    }
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![appDelegate isNetworkAvailable])
    {
        UIAlertView * netAlert = [[UIAlertView alloc]initWithTitle:@"Can't Connect" message:@"Check your internet connection and try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [netAlert show];
        return;
    }    
    NSDictionary *obj ; //= [filteredContentList objectAtIndex:indexPath.row];
    
    if (isSearching) {
        obj = [filteredContentList objectAtIndex:indexPath.row];
    }
    else
    {
         obj = [contentListUpComing objectAtIndex:indexPath.row];
//        if(isupComing)
//
//        else
//            obj = [contentListRecord objectAtIndex:indexPath.row];
    }
    if([[[obj valueForKey:UIACTIVITYISRECORDED]uppercaseString] isEqualToString:@"YES"])
    {
        
        MePro_Acticity_Launcher * m_l = [[MePro_Acticity_Launcher alloc]initWithNibName:@"MePro_Acticity_Launcher" bundle:nil];
        m_l.webinar_title = [obj valueForKey:UIACTIVITYHEADERTITLE];
        m_l.openUrl = [obj valueForKey:UIACTIVITYRECORDURL];
       [self.navigationController pushViewController:m_l animated:TRUE];
        
       // [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[obj valueForKey:UIACTIVITYRECORDURL]]];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[obj valueForKey:UIACTIVITYRECORDURL]] options:nil completionHandler:^(BOOL success) {
//
//        }];
    }
    else
    {
        if([[[obj valueForKey:UIACTIVITYISBOOKED]uppercaseString] isEqualToString:@"NO"])
        {
            if([[obj valueForKey:UIACTIVITYBOOKEDSHEET]intValue] > 0){
            booking =  [UIAlertController alertControllerWithTitle:[obj valueForKey:UIACTIVITYHEADERTITLE] message:[obj valueForKey:UIACTIVITYHEADERDESCRIPTION] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            UIAlertAction *ok  = [UIAlertAction actionWithTitle:@"Book now" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showGlobalProgress];
                
                NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                                           @"cache-control": @"no-cache",
                                           @"Postman-Token": @"872133e8-6c41-49c7-96b5-d8da1d14f4d9" };
                
                
                NSDictionary *_obj =[[NSDictionary alloc]initWithObjectsAndKeys:@"user_id",@"name", [[NSString alloc]initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]],@"value",nil];
                
                NSDictionary *_obj1 =[[NSDictionary alloc]initWithObjectsAndKeys:@"user_name",@"name",[appDelegate.global_userInfo valueForKey:DATABASE_USERNAME],@"value",nil];
                
                NSDictionary *_obj2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"class_id",@"name",[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:UIACTIVITYEVENTID]],@"value",nil];
                
                NSDictionary *_obj3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"action",@"name",@"add_attendee",@"value",nil];
                
                NSArray *parameters = @[_obj,_obj2,_obj1,_obj3];
                NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
                
                NSError *error;
                
                NSMutableString *body = [NSMutableString string];
                
                for (NSDictionary *param in parameters) {
                    
                    [body appendFormat:@"--%@\r\n", boundary];
                    [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
                    [body appendFormat:@"%@", param[@"value"]];
                    [body appendFormat:@"\r\n--%@--\r\n", boundary];
                }
                
                NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
                
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ADURO_ADD_ATTENDEE]
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                   timeoutInterval:30.0];
                [request setHTTPMethod:@"POST"];
                [request setAllHTTPHeaderFields:headers];
                [request setHTTPBody:postData];
                
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    [self hideGlobalProgress];
                    if (error) {
                        NSLog(@"%@", error);
                    } else {
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                        //NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSLog(@"Live Class booking %@",res);
                        
                        //NSDictionary*  json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        //@"{\"status\":1,\"res\":\"success\"}"
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        if(httpResponse.statusCode == 200 && [res rangeOfString:@"{\"status\":1,\"res\":\"success\"}"].location != NSNotFound)
                        {
                            //NSLog(@"%@",[ NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding]);
                           [self showGlobalProgress];
                            NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                            [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                            [reqObj setValue:JSON_EVENTLIST_DECREE forKey:JSON_DECREE ];
                            [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                            [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                            [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                            [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                            [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                            NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                            [_reqObj setValue:SERVICE_GETLIVESESSIONLIST forKey:@"SERVICE"];
                            [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                        }
                        else
                        {
                           
                            UIAlertController * alert = [UIAlertController
                                                         alertControllerWithTitle:@""
                                                         message:@"failed."
                                                         preferredStyle:UIAlertControllerStyleAlert];
                            
                            
                            [self presentViewController:alert animated:YES completion:nil];
                            int duration = 3; // duration in seconds
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                [alert dismissViewControllerAnimated:YES completion:nil];
                            });
                            
                          
                        }
                       });
                    }
                }];
                [dataTask resume];
                
                
            }];
            [booking addAction:ok];
            [booking addAction:Cancel];
            [self presentViewController:booking animated:YES completion:nil];
            
            }
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@""
                                             message:@"All seats already booked."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
                
                int duration = 2; // duration in seconds
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
                return  ;
            }
            
            
        }
        else
        {
            joinCancel =  [UIAlertController alertControllerWithTitle:[obj valueForKey:UIACTIVITYHEADERTITLE] message:[obj valueForKey:UIACTIVITYHEADERDESCRIPTION] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *join  = [UIAlertAction actionWithTitle:@"Join" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[obj valueForKey:UIACTIVITYWIZIQURL]] options:nil completionHandler:^(BOOL success) {

                }];
                
//                MePro_Acticity_Launcher * m_l = [[MePro_Acticity_Launcher alloc]initWithNibName:@"MePro_Acticity_Launcher" bundle:nil];
//                 m_l.webinar_title = [obj valueForKey:UIACTIVITYHEADERTITLE];
//                 m_l.openUrl = [obj valueForKey:UIACTIVITYWIZIQURL];
//                [self.navigationController pushViewController:m_l animated:TRUE];
                
            }];
            UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel Booking" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self showGlobalProgress];
                NSMutableDictionary * paramObj = [[NSMutableDictionary alloc] init];
                [paramObj setValue:[obj valueForKey:UIACTIVITYEVENTID] forKey:JSON_CLASSID];
                
                NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
                [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
                [reqObj setValue:paramObj forKey:JSON_PARAM];
                [reqObj setValue:JSON_EVENTCANCEL_DECREE forKey:JSON_DECREE ];
                [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
                [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
                [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
                [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
                [reqObj setObject:CLIENT forKey:JSON_CLIENT];
                NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
                [_reqObj setValue:SERVICE_CANCELSESSION forKey:@"SERVICE"];
                [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
                
            }];
            UIAlertAction *ok  = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [joinCancel addAction:join];
            [joinCancel addAction:Cancel];
            [joinCancel addAction:ok];
            [self presentViewController:joinCancel animated:YES completion:nil];
            
            
        }
    }
    
}



- (void)searchTableList :(NSString *) searchString {
    //NSString *searchString = @"";//searchBar.text;
    
    NSMutableArray * lArr;
    lArr = contentListUpComing;
//    if(isupComing)
//    {
//
//    }
//    else{
//        lArr = contentListRecord;
//    }
    
    
    
    for (NSDictionary *tempStr in lArr) {
        NSComparisonResult result = [[tempStr valueForKey:UIACTIVITYHEADERTITLE] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
        NSComparisonResult result1 = [[tempStr valueForKey:UIACTIVITYUSERNAME] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result1 == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
        
        NSComparisonResult result2 = [[tempStr valueForKey:UIACTIVITYDATE] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result2 == NSOrderedSame) {
            [filteredContentList addObject:tempStr];
        }
        
    }
}

#pragma mark - Search Implementation

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    isSearching = YES;
//}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    [filteredContentList removeAllObjects];
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList:searchText];
    }
    else {
        isSearching = NO;
    }
    [self.tblContentList reloadData];
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    //NSLog(@"Text change - %d",isSearching);
//
//    //Remove all objects first.
//
//
//
//}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"Cancel clicked");
//    isSearching = NO;
//    [self.tblContentList reloadData];
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"Search Clicked");
//    [self searchTableList];
//}



//-(IBAction)clickOnRecorded
//{
//    [Recorded setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [upcoming setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    isupComing = FALSE;
//    [self.tblContentList reloadData];
//}
//-(IBAction)clickOnUpComing
//{
//    [upcoming setTitleColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0] forState:UIControlStateNormal];
//    [Recorded setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    isupComing = TRUE;
//    [self.tblContentList reloadData];
//}


-(void)ConvertArrayFormat:(NSArray *)arr
{
    [contentListUpComing removeAllObjects];
    //[contentListRecord removeAllObjects];
    
    for (NSDictionary *tempStr in arr)
    {
        if([[[tempStr valueForKey:UIACTIVITYISRECORDED]uppercaseString] isEqualToString:@"YES"])
        {
            //[contentListRecord addObject:tempStr];
            
        }
        else
        {
            [contentListUpComing addObject:tempStr];
        }
    }
    
    
}

//-(NSString *)getEventURL:(NSString *)eventId
//{
//    for (NSDictionary *obj in contentListUpComing) {
//        if([[obj valueForKey:UIACTIVITYEVENTID] isEqualToString:eventId]) return [obj valueForKey:UIACTIVITYWIZIQURL];
//    }
//    return @"";
//}

//-(void)addCalendarEvent
//{
//    EKEventStore *store = [EKEventStore new];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if (!granted) { return; }
//        EKEvent *event = [EKEvent eventWithEventStore:store];
//        //event.eventIdentifier = [currentSlctBooking valueForKey:UIACTIVITYEVENTID];
//        event.title = [currentSlctBooking valueForKey:UIACTIVITYHEADERTITLE];
//        //event.d = [currentSlctBooking valueForKey:UIACTIVITYHEADERDESCRIPTION];
//        //event.title = [currentSlctBooking valueForKey:UIACTIVITYHEADERTITLE];
//        // event.title = [currentSlctBooking valueForKey:UIACTIVITYHEADERTITLE];
//
//
//
//
//        NSString *dateStr = [[NSString alloc]initWithFormat:@"%@ %@:00",[currentSlctBooking valueForKey:UIACTIVITYDATE],[currentSlctBooking valueForKey:UIACTIVITYTIME]];
//
//        // Convert string to date object
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//        [dateFormat setDateFormat:@"dd-MM-yyy HH:mm:ss"];
//        NSDate *date = [dateFormat dateFromString:dateStr];
//
//
//
//        event.startDate = date;
//        int val = [[currentSlctBooking valueForKey:UIACTIVITYDURATION] intValue]*60;
//        event.endDate = [event.startDate dateByAddingTimeInterval:val];
//
//
//        event.notes = [currentSlctBooking valueForKey:UIACTIVITYHEADERDESCRIPTION];
//
//        NSString * str = [self getEventURL:[currentSlctBooking valueForKey:UIACTIVITYEVENTID]];
//
//        event.URL = [NSURL URLWithString:str];
//
//
//        NSTimeInterval alarmOffset = -1*60*60;//1 hour
//        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:alarmOffset];
//
//        [event addAlarm:alarm];
//
//
//        event.calendar = [store defaultCalendarForNewEvents];
//        NSError *err = nil;
//        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
//
//
//
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:[[NSString alloc] initWithFormat:@"%@",event.eventIdentifier] forKey:[currentSlctBooking valueForKey:UIACTIVITYEVENTID]];
//        [defaults synchronize];
//
//
//    }];
//}
//-(void)deleteCalendarEvent
//{
//
//    EKEventStore* store = [EKEventStore new];
//    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
//        if (!granted) { return; }
//
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//        NSString *Value = [defaults objectForKey:[currentSlctBooking valueForKey:UIACTIVITYEVENTID]];
//
//
//
//        EKEvent* eventToRemove = [store eventWithIdentifier:Value];
//        if (eventToRemove) {
//            NSError* error = nil;
//            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
//        }
//
//
//
//
//    }];
//
//
//}

//-(void)downloadImageAndsetOnImgeView:(NSTimer *)theTimer
//{
//
////    [NSTimer scheduledTimerWithTimeInterval:1.0f
////                                     target:self
////                                   selector:@selector(downloadImageAndsetOnImgeView:)
////                                   userInfo:nil
////                                    repeats:NO];
//
//    //(UIImageView *)imgView :(NSString *)eventId :(NSString *)URLstr
//
//
//   NSMutableDictionary * dataObj = [theTimer userInfo];
//
//    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//    dispatch_async(q, ^{
//
//
//    NSData *_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dataObj valueForKey:@"url"]]];
//    UIImage *img = [[UIImage alloc] initWithData:_data];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        UIImageView *view = (UIImageView *)[dataObj valueForKey:@"imageView"];
//        if(view.tag == [[dataObj valueForKey:@"course_id"] integerValue]){
//        [view setImage:img];
//        }
//
//        //[(UIActivityIndicatorView *)[dataObj valueForKey:@"imdi"] stopAnimating];
//    });
//
//
//     });
//
//}




@end
