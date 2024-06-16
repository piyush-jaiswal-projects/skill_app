//
//  PTEG_Preferences.m
//  InterviewPrep
//
//  Created by Amit Gupta on 15/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_Preferences.h"
#import "PTEG_ClearContent.h"

@interface PTEG_Preferences ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UIButton *backBtn;
    UITableView *preferencesTbl;
    NSArray * arr ;
}

@end

@implementation PTEG_Preferences

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    arr =[[NSArray alloc]initWithObjects:@"Download over wifi only",@"Clear Downloaded Content", nil];
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-60,20)];
    viewTitle.text =  @"Preferences";
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:viewTitle];

    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
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
    
    
    preferencesTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    preferencesTbl.tableFooterView = [UIView new];
    preferencesTbl.bounces =  FALSE;
    preferencesTbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    
    preferencesTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    preferencesTbl.delegate = self;
    preferencesTbl.dataSource = self;
    [self.view addSubview:preferencesTbl];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    return sectionName;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"PTEG_PrefCell";
    
    UIView * cellView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        cellView = [[UIView alloc]initWithFrame:CGRectMake(10,5, cell.frame.size.width-20, 40)];
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
    if(indexPath.row == 0)
    {
        for (UIView * view in cellView.subviews) {
            [view removeFromSuperview];
        }
        cellView.backgroundColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0].CGColor];
        
        UIImageView * selectView = [[UIImageView alloc]initWithFrame:CGRectMake(cellView.frame.size.width-30, 10,20,20)];
        UIImage * _selectView_img = NULL;
        _selectView_img = [_selectView_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        if([appDelegate getUserDefaultData:@"DownloadFlag"] != NULL &&  [[appDelegate getUserDefaultData:@"DownloadFlag"]intValue] == 1)
        {
            _selectView_img = [UIImage imageNamed:@"PTEG_levelCheck.png"];
            selectView.tintColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        }
        else
        {
            _selectView_img = nil;
            //selectView.tintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
        }
        [selectView setImage:_selectView_img];
        
        [cellView addSubview:selectView];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10,20,20)];
        UIImage * _prefence_img = NULL;
        _prefence_img = [UIImage imageNamed:@"wifi.png"];
        _prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgView setImage:_prefence_img];
        imgView.tintColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cellView addSubview:imgView];
        UILabel * title =  [[UILabel alloc]initWithFrame:CGRectMake(40, 0, cellView.frame.size.width-80, 40)];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [cellView addSubview:title];
        title.text = [arr objectAtIndex:indexPath.row];
    }
    else if(indexPath.row == 1)
    {
        for (UIView * view in cellView.subviews) {
            [view removeFromSuperview];
        }
        cellView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [cellView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5,40,30)];
        UIImage * _prefence_img = [UIImage imageNamed:@"Ed.png"];
        _prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgView setImage:_prefence_img];
        imgView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:imgView];
        UILabel * title =  [[UILabel alloc]initWithFrame:CGRectMake(40, 0, cellView.frame.size.width-60, 40)];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:title];
        title.text = [arr objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == 0)
    {
       if([appDelegate getUserDefaultData:@"DownloadFlag"] != NULL &&  [[appDelegate getUserDefaultData:@"DownloadFlag"]intValue] == 1)
       {
           [appDelegate setUserDefaultData:@"0" :@"DownloadFlag"];
       }
       else
       {
           [appDelegate setUserDefaultData:@"1" :@"DownloadFlag"];
       }
        
       [preferencesTbl reloadData];
        
    }
  else if(indexPath.row == 1)
    {
        PTEG_ClearContent * pteg_clearObj = [[PTEG_ClearContent alloc]initWithNibName:@"PTEG_ClearContent" bundle:nil];
        [self.navigationController pushViewController:pteg_clearObj animated:TRUE];
    }
    
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
