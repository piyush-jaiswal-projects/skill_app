//
//  PTEG_AboutTest.m
//  InterviewPrep
//
//  Created by Uday Kranti on 28/05/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_AboutTest.h"
#import "PTEG_OpenUrlWeb.h"

@interface PTEG_AboutTest ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UIButton *backBtn;
    UITableView *aboutTestTbl;
    NSArray * listArray ;
    NSArray * fileURLArray ;
}

@end

@implementation PTEG_AboutTest

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
    listArray = @[@"What is Pearson English International Certificate",@"Who takes Pearson English International Certificate",@"Test Structure",@"Test Content",@"Skills Tested",@"Scoring"];
    fileURLArray = @[PTEG_WHATIS,PTEG_WHATAKES,PTEG_TESTSTRUCTURE,PTEG_TESTSCONTENT,PTEG_SKILLSTESTED,PTEG_SCORING];
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UIImageView * branding = [[UIImageView alloc]initWithFrame:CGRectMake(0, bar.frame.size.height-79, SCREEN_WIDTH, 25)];
    branding.image = [UIImage imageNamed:@"LogowithText.png"];
    branding.contentMode = UIViewContentModeScaleAspectFit;
    [bar addSubview:branding];
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-120,20)];
    viewTitle.text =  @"About the Exam";
    viewTitle.font = NAVIGATIONTITLEFONT;
    viewTitle.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    viewTitle.textAlignment = NSTextAlignmentLeft;
    [bar addSubview:viewTitle];

    
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
    
    
    
    aboutTestTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
    aboutTestTbl.tableFooterView = [UIView new];
    aboutTestTbl.bounces =  FALSE;
    aboutTestTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    aboutTestTbl.delegate = self;
    aboutTestTbl.dataSource = self;
    [self.view addSubview:aboutTestTbl];
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
    return [listArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"PTEG_AboutTestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [listArray objectAtIndex:indexPath.row];
    cell.textLabel.font = TEXTTITLEFONT;
    cell.textLabel.numberOfLines=0;
    cell.textLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    PTEG_OpenUrlWeb * webObj = [[PTEG_OpenUrlWeb alloc]initWithNibName:@"PTEG_OpenUrlWeb" bundle:nil];
    webObj.titleName = [listArray objectAtIndex:indexPath.row];
    webObj.url = [fileURLArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:webObj animated:TRUE];
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
