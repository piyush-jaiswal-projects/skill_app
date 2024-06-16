//
//  PTEG_ClearContent.m
//  InterviewPrep
//
//  Created by Amit Gupta on 15/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_ClearContent.h"

@interface PTEG_ClearContent ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UIButton *backBtn;
    UITableView *downloadedContentTbl;
    NSMutableArray * arr ;
}
@end

@implementation PTEG_ClearContent

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
//    arr =[[NSArray alloc]initWithObjects:@"Download over wifi only",@"Clear Downloaded Content", nil];
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-120,20)];
    viewTitle.text =  @"Clear Content";
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:viewTitle];

    
    backBtn =[[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
    UIImage * img = [UIImage imageNamed:@"leftNavigation.png"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [backBtn setImage:img forState:UIControlStateNormal];
    backBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img1 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img1 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    downloadedContentTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    downloadedContentTbl.tableFooterView = [UIView new];
    downloadedContentTbl.bounces =  FALSE;
    downloadedContentTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    downloadedContentTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    downloadedContentTbl.delegate = self;
    downloadedContentTbl.dataSource = self;
    [self.view addSubview:downloadedContentTbl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    arr = [appDelegate.engineObj getAllDownloadedCoursesWithChapters:appDelegate.coursePack];
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if([arr count] >0)
       return [[arr objectAtIndex:section]valueForKey:DATABASE_COURSE_NAME];
    else
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.view.bounds.size.width-60, self.view.bounds.size.height)];
        
        messageLabel.text = [appDelegate.langObj get:@"CHAP_DEL_NO_TEXT" alter:@"Currently there are no chapters \n to be deleted."];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        messageLabel.font = [UIFont boldSystemFontOfSize:18];
        [messageLabel sizeToFit];
        tableView.backgroundView = messageLabel;
        return @"";
    }
        
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if([arr count] >0)
    return [arr count];
  else
   return 1;
      
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([arr count] >0) {
    NSMutableArray *_chapArr  = [[arr objectAtIndex:section] valueForKey:@"DownloadedChapters"];
    return [_chapArr count];
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *liqvidIdentifier = @"PTEG_PrefCell";
    NSMutableArray *_chapArr  = [[arr objectAtIndex:indexPath.section] valueForKey:@"DownloadedChapters"];
    NSDictionary * _obj = [_chapArr objectAtIndex:indexPath.row];
    UIView * cellView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        cellView = [[UIView alloc]initWithFrame:CGRectMake(10,5, SCREEN_WIDTH-20, 40)];
        cellView.tag = 1;
        [cellView.layer setMasksToBounds:YES];
        
        [cellView.layer setCornerRadius:10.0f];
        cellView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [cellView.layer setBorderWidth:1];
        [cell.contentView addSubview:cellView];
        
        
    }
    else
    {
        cellView = (UIView *)[cell.contentView viewWithTag:1];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
        for (UIView * view in cellView.subviews) {
            [view removeFromSuperview];
        }
    
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(cellView.frame.size.width-60, 0,40,40)];
        UIImage * _prefence_img = [UIImage imageNamed:@"Ed.png"];
        _prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgView setImage:_prefence_img];
        imgView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:imgView];
        UILabel * title =  [[UILabel alloc]initWithFrame:CGRectMake(10, 0, cellView.frame.size.width-65, 40)];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = [UIFont systemFontOfSize:13];
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:title];
        if([[_obj valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 3)
          title.text = [_obj valueForKey:DATABASE_CATLOGCONT_NAME];
        else
          title.text = [_obj valueForKey:DATABASE_SCENARIO_NAME];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 30.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *_chapArr  = [[arr objectAtIndex:indexPath.section] valueForKey:@"DownloadedChapters"];
    NSDictionary * _obj = [_chapArr objectAtIndex:indexPath.row];
  UIAlertController* DeleteAlert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CHAP_DEL_TITLE" alter:@"Delete Content"]
        message:[appDelegate.langObj get:@"CHAP_DEL_CON_MSG" alter:@"Do you want to delete content of this Chapter?"] preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"NO" alter:@"NO"] style:UIAlertActionStyleDefault
              handler:^(UIAlertAction * action) {
                                                            
                                                            
             }];
  
  [DeleteAlert addAction:NoAction];
  
  UIAlertAction* yesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"YES" alter:@"YES"] style:UIAlertActionStyleDestructive
            handler:^(UIAlertAction * action) {
               [appDelegate.engineObj deleteScenario:[_obj valueForKey:DATABASE_SCENARIO_EDGEID] deleteDirectory:YES deleteZip:YES];
      arr = [appDelegate.engineObj getAllDownloadedCoursesWithChapters:appDelegate.coursePack];
      [downloadedContentTbl reloadData];
                                                             
     }];
    [DeleteAlert addAction:yesAction];
    [self presentViewController:DeleteAlert animated:YES completion:nil];
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
