//
//  PTEG_UserProfile.m
//  InterviewPrep
//
//  Created by Uday Kranti on 27/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_UserProfile.h"
#import "PTEG_Account_Information.h"
#import "PTEG_Personal_Information.h"

@interface PTEG_UserProfile ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *backBtn;
    UIView * bar;
    UITableView *userprofileTbl;
    NSArray * dataArr;
}

@end

@implementation PTEG_UserProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-60,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",@"User Profile"];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:lblquiz];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT-30,25,17)];
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
    
    
    userprofileTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    userprofileTbl.tableFooterView = [UIView new];
    userprofileTbl.bounces =  FALSE;
    userprofileTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    userprofileTbl.delegate = self;
    userprofileTbl.dataSource = self;
    [self.view addSubview:userprofileTbl];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dataArr = [[NSArray alloc]initWithObjects:@"Account Information",@"Personal Information", nil];
   
    
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
    return [dataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *liqvidIdentifier = @"PTEG_userPCell";
    
    UIView * cellView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cellView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50)];
        cellView.tag = 1;
        [cell.contentView addSubview:cellView];
    }
    else
    {
        cellView = (UIView *)[cell.contentView viewWithTag:1];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    if(indexPath.row == 0)
    {
        for (UIView * view in cellView.subviews) {
            [view removeFromSuperview];
        }
    
         UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15,35,20)];
        UIImage * _prefence_img = NULL;
        _prefence_img = [UIImage imageNamed:@"PTEG_acImg.png"];
        _prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgView setImage:_prefence_img];
        imgView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:imgView];
        UILabel * title =  [[UILabel alloc]initWithFrame:CGRectMake(50, 0, cellView.frame.size.width-80, 50)];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:title];
        title.text = [[NSString alloc]initWithFormat:@"%@",[dataArr objectAtIndex:indexPath.row]];
    }
    else if(indexPath.row == 1)
    {
        for (UIView * view in cellView.subviews) {
            [view removeFromSuperview];
        }
    
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15,20,20)];
        UIImage * _prefence_img = [UIImage imageNamed:@"PTEG_perImg.png"];
        _prefence_img = [_prefence_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgView setImage:_prefence_img];
        imgView.tintColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:imgView];
        UILabel * title =  [[UILabel alloc]initWithFrame:CGRectMake(50, 0, cellView.frame.size.width-60, 50)];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.font = TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [cellView addSubview:title];
        title.text = [[NSString alloc]initWithFormat:@"%@",[dataArr objectAtIndex:indexPath.row]];
    }
    
  
        
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        PTEG_Account_Information * accInfo = [[PTEG_Account_Information alloc]initWithNibName:@"PTEG_Account_Information" bundle:nil];
        [self.navigationController pushViewController:accInfo animated:TRUE];
    }
    else
    {
        PTEG_Personal_Information * accInfo = [[PTEG_Personal_Information alloc]initWithNibName:@"PTEG_Personal_Information" bundle:nil];
        [self.navigationController pushViewController:accInfo animated:TRUE];
        
    }
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
