//
//  Games.m
//  InterviewPrep
//
//  Created by Amit Gupta on 24/10/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "Games.h"
#import "GameIndex.h"
#import "PDFViewer.h"
#import "MeProComponent.h"

@interface Games ()
{
    UIView * bar;
    UIButton *backBtn;
    UITableView * tblView;
    NSArray * gamesArr;
    NSMutableDictionary * data;
}

@end

@implementation Games

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
    data = [[NSMutableDictionary alloc]init];
    [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
    [data setValue:self.scnUid forKey:NATIVE_JSON_KEY_SCNID];
    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:EMPTYSTRING forKey:NATIVE_JSON_KEY_ENDTIME];
    [data setValue:[[NSString alloc] initWithFormat:@"%@",self.gameId] forKey:NATIVE_JSON_KEY_EDGEID];
    [data setValue:[[NSString alloc] initWithFormat:@"%d",self.type] forKey:NATIVE_JSON_KEY_TYPE];
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_STARTTIME];
    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
    
    
    
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
        bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        [self.view addSubview:bar];
        if([UISTANDERD isEqualToString:@"PRODUCT2"])
        {
          UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
          lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.GSE_Level,self.TopicName];
          lbl.font = NAVIGATIONTITLEUPFONT;
            lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
          lbl.textAlignment = NSTextAlignmentCenter;
          [bar addSubview:lbl];
            
            UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
            lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.name];
            lblquiz.font = NAVIGATIONTITLEDOWNFONT;
            lblquiz.textColor =[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
            lblquiz.textAlignment = NSTextAlignmentCenter;
            [bar addSubview:lblquiz];
            
            
        }
        else
        {
            UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,44)];
            lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.name];
            lblquiz.font = NAVIGATIONTITLEFONT;
            lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
            lblquiz.textAlignment = NSTextAlignmentCenter;
            [bar addSubview:lblquiz];
            
        }
    
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
        [bar addSubview:backBtn];
    
    UILabel * lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, 30)];
    lbl1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    lbl1.font = [UIFont boldSystemFontOfSize:14.0];
    lbl1.textAlignment = NSTextAlignmentLeft;
    lbl1.text = [appDelegate.langObj get:@"GAME_INS" alter:@"  Tap on a component to launch."]; //attributes:attrsDictionary];
    lbl1.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [self.view addSubview:lbl1];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.headIndent = 5.0;
//    paragraphStyle.firstLineHeadIndent = 5.0;
//    paragraphStyle.tailIndent = -5.0;
//    NSDictionary *attrsDictionary = @{NSParagraphStyleAttributeName: paragraphStyle};
    
    
    
    
    
     UIView *  footerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, self.view.frame.size.width,60)];
     footerView.backgroundColor = [UIColor whiteColor];
      if([UISTANDERD isEqualToString:@"PRODUCT2"])
      {
       tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT+30, SCREEN_WIDTH, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+90)) style:UITableViewStylePlain];
       [self.view addSubview:footerView];
      }
      else
      {
       tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT+30, SCREEN_WIDTH, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+30)) style:UITableViewStylePlain];
      }

       UIButton * mcqSubmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/10, 15, 8*(SCREEN_WIDTH/10),UIBUTTONHEIGHT)];
        mcqSubmitBtn.layer.cornerRadius = BUTTONROUNDRECT; // this value vary as per your desire
        mcqSubmitBtn.clipsToBounds = YES;
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37, mcqSubmitBtn.frame.size.width, 3)];
        [mcqSubmitBtn addSubview:lineView];
        [mcqSubmitBtn setTitle:@"Continue" forState:UIControlStateNormal];
        mcqSubmitBtn.titleLabel.textColor = [UIColor whiteColor];
    mcqSubmitBtn.titleLabel.font = BUTTONFONT;
        mcqSubmitBtn.hidden = FALSE;
        [mcqSubmitBtn addTarget:self
                         action:@selector(continueBack)
               forControlEvents:UIControlEventTouchUpInside];
        mcqSubmitBtn.enabled =  TRUE;
        mcqSubmitBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
        [footerView addSubview:mcqSubmitBtn];
    
    [tblView setDataSource:self];
    [tblView setDelegate:self];
    [tblView setShowsVerticalScrollIndicator:NO];
    tblView.translatesAutoresizingMaskIntoConstraints = NO;
    tblView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tblView];
    gamesArr = [appDelegate.engineObj getGameArr:self.gameId];
    
    if([gamesArr count] == 1)
    {
        if(self.type == [DATABASE_CATTYPE_GAME intValue])
        {
            GameIndex *gmInObj = [[GameIndex alloc]initWithNibName:@"GameIndex" bundle:nil];
            gmInObj.name = [[gamesArr objectAtIndex:0]valueForKey:@"title"];
            gmInObj.path = [[gamesArr objectAtIndex:0]valueForKey:@"data"];
            gmInObj.TopicName = self.TopicName;
            gmInObj.GSE_Level = self.GSE_Level;
            gmInObj.gameId = self.gameId;
            gmInObj.interectiveHtml = self.interectiveHtml;
            [self.navigationController pushViewController:gmInObj animated:YES];
        }
        else
        {
             PDFViewer * pdfObj = [[PDFViewer alloc]initWithNibName:@"PDFViewer" bundle:nil];
             
             NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
             NSString *documentsDirectory = [paths objectAtIndex:0];
             NSString *resourceUrl = [documentsDirectory stringByAppendingPathComponent:[[gamesArr objectAtIndex:0]valueForKey:@"file"]];
            pdfObj.GSE_Level = self.GSE_Level;
            pdfObj.TopicName = self.TopicName;
             pdfObj.practiceUid = self.gameId;
             pdfObj.practiceType = DATABASE_CATTYPE_RESOURSE;
             pdfObj.scnUid = self.scnUid;
             pdfObj.url = resourceUrl;
             pdfObj.titleName =[[gamesArr objectAtIndex:0]valueForKey:@"file_title"];
             [self.navigationController pushViewController:pdfObj animated:YES];
        }
    }
    else
    {
      [tblView reloadData];
    }
        
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}

-(void)continueBack
{
    [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME]longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME]longLongValue])
       [appDelegate.engineObj setTracktableData:data];

    
    NSArray *array = [self.navigationController viewControllers];
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProComponent class]]){
            MeProComponent * compoanatObj = (MeProComponent *)[array objectAtIndex:i];
            compoanatObj.isFlowContinue = TRUE;
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:NO];
            return;
        }
    }
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gamesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UIImageView *imgView;
    UILabel *title;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        //cell.imageView.tag = [[gamesArr objectAtIndex:indexPath.row]integerValue];
       // cell.imageView.image = [UIImage imageNamed:@"gameIcon.png"];
        imgView =  [[UIImageView alloc]init];
        imgView.tag = 1;
        [cell.contentView addSubview:imgView];
        
        
        title =  [[UILabel alloc]init];
        title.tag = 3;
        [cell.contentView addSubview:title];
        
    }
    else
    {
        
        imgView = (UIImageView *)[cell.contentView viewWithTag:1];
        title = (UILabel *)[cell.contentView viewWithTag:3];

        
        
    }
    
    
    
    imgView.frame = CGRectMake(10, 5, 35, 35);
    if(self.type == [DATABASE_CATTYPE_GAME intValue])
         imgView.image = [UIImage imageNamed:@"gameIcon.png"];
    else
        imgView.image = [UIImage imageNamed:@"topic.png"];
    
    title.frame = CGRectMake(50, 0, cell.frame.size.width-60, 40);
    title.numberOfLines = 2;
    title.textAlignment = NSTextAlignmentLeft;
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    title.font = TEXTTITLEFONT;
    if(self.type == [DATABASE_CATTYPE_GAME intValue])
       title.text = [[gamesArr objectAtIndex:indexPath.row]valueForKey:@"title"];
    else
       title.text = [[gamesArr objectAtIndex:indexPath.row]valueForKey:@"file_title"];
    
   
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(self.type == [DATABASE_CATTYPE_GAME intValue])
    {
        GameIndex *gmInObj = [[GameIndex alloc]initWithNibName:@"GameIndex" bundle:nil];
        gmInObj.name = [[gamesArr objectAtIndex:indexPath.row]valueForKey:@"title"];
        gmInObj.path = [[gamesArr objectAtIndex:indexPath.row]valueForKey:@"data"];
        gmInObj.TopicName = self.TopicName;
        gmInObj.GSE_Level = self.GSE_Level;
        gmInObj.gameId = self.gameId;
        gmInObj.interectiveHtml = self.interectiveHtml;
        [self.navigationController pushViewController:gmInObj animated:YES];
    }
    else
    {
         PDFViewer * pdfObj = [[PDFViewer alloc]initWithNibName:@"PDFViewer" bundle:nil];
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
         NSString *documentsDirectory = [paths objectAtIndex:0];
         NSString *resourceUrl = [documentsDirectory stringByAppendingPathComponent:[[gamesArr objectAtIndex:indexPath.row]valueForKey:@"file"]];
         
         pdfObj.practiceUid = self.gameId;
         pdfObj.practiceType = DATABASE_CATTYPE_RESOURSE;
         pdfObj.scnUid = self.scnUid;
         pdfObj.url = resourceUrl;
         pdfObj.titleName =[[gamesArr objectAtIndex:indexPath.row]valueForKey:@"file_title"];
         [self.navigationController pushViewController:pdfObj animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ClickBack
{
    
    
    [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
    [data setValue:@"0" forKey:NATIVE_JSON_KEY_USAGESCORE];
    [data setValue: [[NSString alloc] initWithFormat:@"%@",[appDelegate getCurrentTime]]forKey:NATIVE_JSON_KEY_ENDTIME];
    if([[data valueForKey:NATIVE_JSON_KEY_ENDTIME]longLongValue] >= [[data valueForKey:NATIVE_JSON_KEY_STARTTIME]longLongValue])
       [appDelegate.engineObj setTracktableData:data];
    [self.navigationController popViewControllerAnimated:TRUE];
    
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
