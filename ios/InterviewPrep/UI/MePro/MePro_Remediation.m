//
//  MePro_Remediation.m
//  InterviewPrep
//
//  Created by Amit Gupta on 12/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MePro_Remediation.h"
#import "MeProDashboard.h"
#import "Assessment.h"
#import "MeProChapter.h"

@interface MePro_Remediation ()
{
    UIView * bar;
    UIButton *backBtn;
    UIView * headerView;
    UIScrollView *bgView;
   
    
    UILabel * progressLbl;
    UITableView * skillTbl;
    
}

@end

@implementation MePro_Remediation

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
        lbl.text = [[NSString alloc]initWithFormat:@"%@ %@",LEVEL_TEXT,self.selectedLevel];
        lbl.font = [UIFont systemFontOfSize:10.0];
        lbl.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [bar addSubview:lbl];
         
        UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(60,STSTUSNAVIGATIONBARHEIGHT-29,SCREEN_WIDTH-120,20)];
        lblquiz.text = [[NSString alloc]initWithFormat:@"%@",self.quizName];
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
    
        skillTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width,bgView.frame.size.height) style:UITableViewStylePlain];
        [bgView addSubview:skillTbl];
        [skillTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        skillTbl.delegate = self;
        skillTbl.dataSource = self;
        [skillTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        skillTbl.tableFooterView = [UIView new];
        skillTbl.bounces =  FALSE;
        skillTbl.backgroundColor = [UIColor whiteColor];
        skillTbl.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
    
}
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 0)];
        return headerView;
    }

 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
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
      return [self.skillArr count];
    }

 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        static NSString *liqvidIdentifier = @"wileyAssignmentCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
        UIView *skillview;
       
        NSMutableDictionary * courseObj;
        courseObj = [self.skillArr objectAtIndex:indexPath.row];
       
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
            cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
            cell.backgroundColor = [self getUIColorObjectFromHexString:@"#f5f5f5" alpha:1.0];
            cell.accessoryView = nil;
            
            
            skillview = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-20, 80)];
            skillview.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            skillview.layer.masksToBounds = YES;
            skillview.tag = 1;
            skillview.layer.cornerRadius = 10.0;
            skillview.layer.cornerRadius = 10.0;
            skillview.tag = 1;
            [cell.contentView addSubview:skillview];
            
                 
        }
        else
        {
            skillview = (UIView *)[cell.contentView viewWithTag :1];
           
            
        }
        
        
        for (UIView *view in skillview.subviews) {
            [view removeFromSuperview];
        }
        
        
        UIView *readingL = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
         readingL.layer.masksToBounds = YES;
         readingL.tag = 1;
         readingL.layer.cornerRadius = 20.0;
         readingL.layer.cornerRadius = 20.0;
        NSString * skill_id = [[NSString alloc]initWithFormat:@"%d",[[courseObj valueForKey:@"skill_id"] intValue]];
         readingL.backgroundColor =[self getUIColorObjectFromHexString:[appDelegate.skillDict valueForKey:skill_id] alpha:0.2];
        [skillview addSubview:readingL];
         
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
               UILabel * readingTextL = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, skillview.frame.size.width-100, 20)];
                 readingTextL.font = [UIFont systemFontOfSize:12.0];
                 readingTextL.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                 readingTextL.text = [appDelegate.skillNameDict valueForKey:[[NSString alloc]initWithFormat:@"%@",[courseObj valueForKey:@"skill_id"]]];
                [skillview addSubview:readingTextL];
        
//            if([[courseObj valueForKey:@"isComplete"]intValue]  == 0 ){
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MePro_complete.png"]];
//                imageView.frame = CGRectMake(0, 0, 20, 20);
//                imageView.contentMode = UIViewContentModeScaleAspectFit;
//                cell.accessoryView = imageView;
//
//            }
           
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         return cell;
    }
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
       return 0.0;
    }
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
      return 85.0;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * skillObj = [self.skillArr objectAtIndex:indexPath.row];
    appDelegate.topicId = self.remediationEdgeId;
    MeProChapter * MeProChapterObj = [[MeProChapter alloc]initWithNibName:@"MeProChapter" bundle:nil];
    MeProChapterObj.GSE_Level = self.selectedLevel;
    MeProChapterObj.TopicName = [self.testOBj valueForKey:@"name"];
    MeProChapterObj.skillObj = skillObj;
    MeProChapterObj.isFlowContinue = FALSE;
    MeProChapterObj.componantCounter = 0;
    [self.navigationController pushViewController:MeProChapterObj animated:YES];
           
}
-(void)clickBack
{
    NSArray *array = [self.navigationController viewControllers];
    
    for (int i = 0 ; i <array.count; i++){
        UIViewController * viewCObj = (UIViewController*)[array objectAtIndex:i];
        if([viewCObj isKindOfClass:[MeProDashboard class]]){
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            return;
        }
    }
}
    @end
