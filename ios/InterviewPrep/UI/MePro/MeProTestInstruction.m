//
//  MeProTestInstruction.m
//  InterviewPrep
//
//  Created by Amit Gupta on 14/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MeProTestInstruction.h"
#import "MeProQuizReport.h"
#import "Assessment.h"
#import "MeProDashboard.h"


@interface MeProTestInstruction ()
{
    UIView * bar;
    UIView * headerView;
    UIScrollView *bgView;
    UIButton *backBtn;
    UILabel * progressLbl;
    UITableView * skillTbl;
    NSArray * skillArr ;
    NSDictionary * quizAddtionalProperty;
   
}

@end

@implementation MeProTestInstruction

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
    
    
    UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-120,15)];
    lbl.text = [[NSString alloc]initWithFormat:@"%@ %@ - %@",LEVEL_TEXT,self.selectedLevel,self.TopicName];
    lbl.font = [UIFont systemFontOfSize:10.0];
    lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lbl.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lbl];
     
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[self.testOBj valueForKey:@"name"]];
    lblquiz.font = [UIFont systemFontOfSize:13.0];
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
    [self.view addSubview:bgView];
    
    quizAddtionalProperty = [appDelegate.engineObj getQuizOrAssementData: [self.testOBj valueForKey:@"uid"]:[[self.testOBj valueForKey:@"type"]intValue]];
    
    
    UIView * _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 30)];
    _view.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    progressLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, _view.frame.size.width-20, 20)];
    progressLbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    progressLbl.text = @"0% completed";
    progressLbl.font = [UIFont systemFontOfSize:10.0];
    progressLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    [_view addSubview:progressLbl];
    [bgView addSubview:_view];
    UIView * backG = [[UIView alloc]initWithFrame:CGRectMake(15, 40,bgView.frame.size.width-30,bgView.frame.size.height-80)];
    backG.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    backG.layer.cornerRadius = 10.0;
    backG.layer.masksToBounds = YES;
    [bgView addSubview:backG];
    
    appDelegate.topicId = [self.testOBj valueForKey:@"uid"];
    appDelegate.chapterId = @"0";
    appDelegate.bookmark_type = @"assessment";
    [self setBookmarks];
    
    //NSString * str = (NSString *) [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"skill_%@",[self.testOBj valueForKey:@"uid"]]];
    NSString * str = (NSString *) [quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_SKILLS];
    NSData *objectData = [str dataUsingEncoding:NSUTF8StringEncoding];
    //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
    if(objectData != NULL)
    {
       skillArr  = (NSArray *) [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers
      error:nil];
    }
    else
    {
        skillArr =  [[NSArray alloc]init];
    }
    
    int count = [skillArr count]/2;
    int reminder =  [skillArr count]%2;
    
    int height = 360;
    
    
    skillTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,backG.frame.size.width,height) style:UITableViewStylePlain];
    [backG addSubview:skillTbl];
    [skillTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    skillTbl.delegate = self;
    skillTbl.dataSource = self;
    skillTbl.tableFooterView = [UIView new];
    skillTbl.bounces =  FALSE;
    skillTbl.backgroundColor = [UIColor whiteColor];
    //skillTbl.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
    

    UIButton *continueBtn  = [[UIButton alloc] initWithFrame:CGRectMake(40,backG.frame.size.height-50, backG.frame.size.width-80,UIBUTTONHEIGHT)];
    [continueBtn setTitle:@"Start Quiz" forState:UIControlStateNormal];
    continueBtn.titleLabel.font = BUTTONFONT;
    [continueBtn setTitleColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0] forState:UIControlStateNormal];
    [continueBtn.layer setMasksToBounds:YES];
    continueBtn.backgroundColor = [self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0];
    [continueBtn.layer setCornerRadius:BUTTONROUNDRECT];
    [continueBtn.layer setBorderColor:[self getUIColorObjectFromHexString:WIDGET_MCQ_BUTTON_BACKGROUD_COLOR alpha:1.0].CGColor];
    [continueBtn.layer setBorderWidth:1];
    [continueBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [continueBtn setHighlighted:YES];
    [continueBtn addTarget:self action:@selector(clickNextScreen) forControlEvents:UIControlEventTouchUpInside];
    [backG addSubview:continueBtn];
    

}
-(void)clickBack
{
  NSArray *array = [self.navigationController viewControllers];
  
  for (int i = 0 ; i <array.count; i++){
      UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
      if([viewCObj isKindOfClass:[MeProDashboard class]]){
          MeProDashboard * meProObj = (MeProDashboard *)viewCObj;
          meProObj.isFlowContinue = FALSE;
          [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
          return;
      }
  }
}

-(void)clickNextScreen
{
    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
    assess.assessnetUid = [self.testOBj valueForKey:@"uid"];
    assess.cusTitleName = [self.testOBj valueForKey:@"name"];
     
    assess.type = 3;
    assess.scnUid = 0;
    assess.selectedLevel  = self.selectedLevel;
    assess.isRemediation  = FALSE;
    assess.testOBj = self.testOBj;
    assess.skillObj  = NULL;
    assess.TopicName   = self.TopicName;
    if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 2)
    {
       appDelegate.AssessmentQuesAttemptCounter = -1;
    }
    else if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 3)
    {
        appDelegate.AssessmentQuesAttemptCounter = 2;
    }
    else if([[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] intValue] == 4)
    {
        appDelegate.AssessmentQuesAttemptCounter = 3;
    }
    
    [self.navigationController pushViewController:assess animated:YES];

    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 240)];
    UILabel * welcomelbl =  [[UILabel alloc]initWithFrame:CGRectMake(10, 15, headerView.frame.size.width-20, 20)];
        welcomelbl.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        welcomelbl.text = [[NSString alloc]initWithFormat:@"Get ready for a %@!",[self.testOBj valueForKey:@"name"]];
        welcomelbl.font = [UIFont boldSystemFontOfSize:15.0];
        welcomelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        welcomelbl.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:welcomelbl];
        
        
        
        UILabel * TText = [[UILabel alloc]initWithFrame:CGRectMake(60, 70, 100, 20)];
        TText.tag =6;
        TText.font = [UIFont systemFontOfSize:12.0];
        TText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [headerView addSubview:TText];
        
        UIImageView * Timg = [[UIImageView alloc]initWithFrame:CGRectMake(30, 70, 20, 20)];
        Timg.tag =8;
        [headerView addSubview:Timg];
        
        UIImage* T_img =  [UIImage imageNamed:@"MePro_ReadT.png"];
        T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        Timg.image = T_img;
        [Timg setTintColor:[self getUIColorObjectFromHexString:@"#00a5a4" alpha:1.0]];
        
        
        
        
        UILabel * QText = [[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width/2+30, 70, 100, 20)];
        QText.tag =7;
        QText.font = [UIFont systemFontOfSize:12.0];
        QText.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [headerView addSubview:QText];
        UIImageView * Qimg = [[UIImageView alloc]initWithFrame:CGRectMake(headerView.frame.size.width/2 , 70, 20, 20)];
        Qimg.tag =9;
        [headerView addSubview:Qimg];
        UIImage* Q_img =  [UIImage imageNamed:@"MePro_ReadQ.png"];
        Q_img = [Q_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        Qimg.image = Q_img;
         
        [Qimg setTintColor:[self getUIColorObjectFromHexString:@"#63c033" alpha:1.0]];
        
        int question = [[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION]intValue];
    //
        int duration = [[quizAddtionalProperty valueForKey:DATABASE_CATLOGCONT_DURATION] intValue];
        
        
        if(question > 1 )
            QText.text = [[NSString alloc]initWithFormat:@"%d Questions",question];
        else
            QText.text = [[NSString alloc]initWithFormat:@"%d Question",question];
        
        
        if(duration > 1 )
            TText.text = [[NSString alloc]initWithFormat:@"%d Mins",duration];
        else
            TText.text = [[NSString alloc]initWithFormat:@"%d Min",duration];
        
        
        UIView * sub_view = [[UIView alloc]initWithFrame:CGRectMake(40, 120,headerView.frame.size.width-80,30)];
        sub_view.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        [headerView addSubview:sub_view];
        
        UIImageView * hint3 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0,20,20)];
        hint3.image = [UIImage imageNamed:@"MPheadphone.png"];
        [sub_view addSubview:hint3];
        
        UILabel * hint3Text = [[UILabel alloc]initWithFrame:CGRectMake(50, 0,sub_view.frame.size.width-50, 20)];
        hint3Text.text = @"Headphone Required";
        hint3Text.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        hint3Text.font = [UIFont systemFontOfSize:12.0];
        
        [sub_view addSubview:hint3Text];
        
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 180,headerView.frame.size.width,1)];
        line.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
        [headerView addSubview:line];
        
        
        UILabel * skillTest =  [[UILabel alloc]initWithFrame:CGRectMake(10, 200, headerView.frame.size.width-20, 20)];
           skillTest.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
           skillTest.text = @"Skills tested";
           skillTest.font = [UIFont boldSystemFontOfSize:15.0];
           skillTest.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
           skillTest.textAlignment = NSTextAlignmentCenter;
           [headerView addSubview:skillTest];
    headerView.frame = CGRectMake(0, 0,tableView.frame.size.width, 240);
   // headerView.backgroundColor = [UIColor redColor];
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [skillArr count]/2;
    int reminder =  [skillArr count]%2;
    
    return count +reminder;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"wileyAssignmentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    UIView *ReadingL;
    UIView *ReadingR;

    NSDictionary * courseObj;
    NSDictionary * courseObj1;
    
    if([skillArr count] > 2*(indexPath.row))
       courseObj = [skillArr objectAtIndex:2*(indexPath.row)];
    else
       courseObj = NULL;
    
    
    if([skillArr count] > 2*(indexPath.row)+1)
       courseObj1 = [skillArr objectAtIndex:2*(indexPath.row)+1];
    else
       courseObj1 = NULL;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        
        ReadingL = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width/2, 60)];
        ReadingL.tag = 1;
        [cell.contentView addSubview:ReadingL];
        
        ReadingR = [[UIView alloc]initWithFrame:CGRectMake(tableView.frame.size.width/2, 0, tableView.frame.size.width/2, 60)];
        ReadingR.tag = 2;
        [cell.contentView addSubview:ReadingR];
          
    }
    else
    {
        ReadingL = (UIView *)[cell.contentView viewWithTag :1];
        ReadingR = (UIView *)[cell.contentView viewWithTag :2];
        
    }

    for (UIView *view in ReadingL.subviews) {
        [view removeFromSuperview];
    }
    
    for (UIView *view in ReadingR.subviews) {
        [view removeFromSuperview];
    }

     
     UIView *readingL = [[UIView alloc]initWithFrame:CGRectMake(30, 5, 40, 40)];
     readingL.layer.masksToBounds = YES;
     readingL.tag = 1;
     readingL.layer.cornerRadius = 20.0;
     readingL.layer.cornerRadius = 20.0;
    NSString * skill_id = [[NSString alloc]initWithFormat:@"%d",[[courseObj valueForKey:@"skill_id"] intValue]];
     readingL.backgroundColor =[self getUIColorObjectFromHexString:[appDelegate.skillDict valueForKey:skill_id] alpha:0.2];
    [ReadingL addSubview:readingL];
     
     UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
      //Rimg.image  = [UIImage imageNamed:@""];
     [readingL addSubview:Rimg];
      NSString *imageUrl = [appDelegate.skillImgDict valueForKey:skill_id];
      UIImage *rimg = NULL;
      rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
      if(rimg == NULL ){
         [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  UIImage * _img = [UIImage imageWithData:data];
                  if(_img != NULL)
                  {
                      Rimg.image = _img;
                      [appDelegate setUserDefaultData:data :imageUrl];
                  }
                  else
                  {
                      Rimg.image = _img;
                  }
                  
              }];
          }
          else
          {
              Rimg.image = rimg;
          }
           UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(75, 20, ReadingL.frame.size.width-70, 20)];
             readingTextL.font = [UIFont systemFontOfSize:12.0];
             readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             readingTextL.text = [appDelegate.skillNameDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[courseObj valueForKey:@"skill_id"]]];
            [ReadingL addSubview:readingTextL];
    
    
    if(courseObj1 != NULL)
    {
    UIView *readingL1 = [[UIView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
     readingL1.layer.masksToBounds = YES;
     readingL1.layer.cornerRadius = 20.0;
     readingL1.layer.cornerRadius = 20.0;
    NSString * skill_id = [[NSString alloc]initWithFormat:@"%d",[[courseObj1 valueForKey:@"skill_id"] intValue]];
     readingL1.backgroundColor =[self getUIColorObjectFromHexString:[appDelegate.skillDict valueForKey:skill_id] alpha:0.2];
    [ReadingR addSubview:readingL1];
     
     UIImageView * Rimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
      //Rimg.image  = [UIImage imageNamed:@""];
     [readingL1 addSubview:Rimg];
        
      NSString *imageUrl = [appDelegate.skillImgDict valueForKey:skill_id];
      UIImage *rimg = NULL;
      rimg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
      if(rimg == NULL ){
         [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  UIImage * _img = [UIImage imageWithData:data];
                  if(_img != NULL)
                  {
                      Rimg.image = _img;
                      [appDelegate setUserDefaultData:data :imageUrl];
                  }
                  else
                  {
                      Rimg.image = _img;
                  }
                  
              }];
          }
          else
          {
              Rimg.image = rimg;
          }
           UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(55, 20, ReadingR.frame.size.width-50, 20)];
             readingTextL.font = [UIFont systemFontOfSize:12.0];
             readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
             //readingTextL.text = @"Grammar"; //[courseObj1 valueForKey:@"skill_Name"];
             readingTextL.text = [appDelegate.skillNameDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[courseObj1 valueForKey:@"skill_id"]]];
            [ReadingR addSubview:readingTextL];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 240.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary * jsonResponse1 = [skillArr objectAtIndex:indexPath.row];
       
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
