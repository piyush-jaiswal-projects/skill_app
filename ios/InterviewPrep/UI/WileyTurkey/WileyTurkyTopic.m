//
//  WileyTurkyTopic.m
//  InterviewPrep
//
//  Created by Amit Gupta on 29/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "WileyTurkyTopic.h"
#import "UIView+Progress.h"
#import "Assessment.h"

@interface WileyTurkyTopic ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UITableView *topicTbl;
    NSArray * topicDataArr;
    UIView * headerView;
    UIScrollView *bgView;
    UIButton *backBtn;
    UIButton * h_btn;
}

@end

@implementation WileyTurkyTopic

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(75, STSTUSNAVIGATIONBARHEIGHT-44, SCREEN_WIDTH-150, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = [appDelegate.engineObj getCourseName];
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:title];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-42,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    h_btn = [[UIButton alloc]initWithFrame:CGRectMake(40, STSTUSNAVIGATIONBARHEIGHT-35, 25, 25)];
    UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [h_btn setTintColor:[self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0]];
    [h_btn setImage:T_img forState:UIControlStateNormal];
    
    if([CLASS_NAME isEqualToString:@"wiley"] || [CLASS_NAME isEqualToString:@"awards"])
        [h_btn addTarget:self action:@selector(showWileyDrawer) forControlEvents:UIControlEventTouchUpInside];
    else
         [h_btn addTarget:self action:@selector(showACEDrawer) forControlEvents:UIControlEventTouchUpInside];
    [h_btn bringSubviewToFront:bar];
    [bar addSubview:h_btn];
    h_btn.hidden =  FALSE;
    
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [self.view addSubview:bgView];
    
    topicTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width, bgView.frame.size.height) style:UITableViewStylePlain];
    topicTbl.tableFooterView = [UIView new];
    topicTbl.bounces =  FALSE;
    topicTbl.backgroundColor = [UIColor whiteColor];
    topicTbl.delegate = self;
    topicTbl.dataSource = self;
    [bgView addSubview:topicTbl];
}

-(void)clickBack
{
    
    
    //int completionFlag=0;
    int counter = 0;
    int ConpleteCounter = 0;
    int totalCount = 0;
    if(appDelegate.workingCourseObj != NULL)
    {
        
        for (NSDictionary * obj  in topicDataArr )
        {
            
           totalCount ++;
            if([[obj valueForKey:@"isComp"]integerValue] == 1)
            {
               ConpleteCounter++;
            }
            else if([[obj valueForKey:@"isComp"]integerValue] == 0)
            {
               counter++;
            }
            else
            {
                
            }
                
        }
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_MODULEID];
        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_SCNID];
        [data setValue:[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE] forKey:NATIVE_JSON_KEY_EDGEID];
        [data setValue:[[NSString alloc]initWithFormat:@"%@",@"1"] forKey:NATIVE_JSON_KEY_TYPE];
        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
        [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
        [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
        [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
        [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
        if(counter == 0 && ConpleteCounter ==0 && totalCount > 0)
        {
            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if (totalCount > 0 && ConpleteCounter == totalCount)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else
        {
            [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        [appDelegate.engineObj setTracktableData:data];
        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
    }
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    topicDataArr = [appDelegate.engineObj getAllTopicData];
    NSLog(@"%@",topicDataArr);
    [topicTbl reloadData];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    UILabel *myLabel = [[UILabel alloc] init];
    UILabel *myLabel1 = [[UILabel alloc] init];
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =   HEADERSECTIONTITLEFONT;
    myLabel1.font =  HEADERSECTIONTITLEFONT;
    myLabel.frame = CGRectMake(5, 8, 180, 20);
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel1.textAlignment = NSTextAlignmentRight;
    myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 8, 70, 20);
    myLabel.text = @"TOPICS";
    myLabel1.text = [appDelegate.langObj get:@"CLP_STATUS" alter:@"STATUS"];
    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 29.0f, headerView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:myLabel];
    [headerView addSubview:myLabel];
    [headerView addSubview:myLabel1];
    
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
    return [topicDataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"wileyTopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    UIImageView *LimageView;
    UILabel *title;
    UIView * circle;
    UIImageView *updateBtn ;
    NSDictionary * courseObj = [topicDataArr objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        updateBtn = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-30, 45, 20, 20)];
        [updateBtn setImage:[UIImage imageNamed:@"password.png"]];
        updateBtn.tag = 1001;
        [cell.contentView addSubview:updateBtn];
        
        title =  [[UILabel alloc]initWithFrame:CGRectMake(95, 0, cell.frame.size.width-125, 100)];
        title.tag = 3;
        title.numberOfLines = 6;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentView addSubview:title];
        
        
        circle = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.size.width-30, 40, 20, 20)];
        circle.layer.masksToBounds = YES;
        circle.layer.cornerRadius = circle.frame.size.width / 2.0;
        circle.backgroundColor = [self getUIColorObjectFromHexString:PERCENTAGECIRCLE alpha:1.0];
        circle.tag = 999;
        [cell.contentView addSubview:circle];
        
        
        
        LimageView =  [[UIImageView alloc]init];
        LimageView.frame = CGRectMake(3, 15, 90, 63);
        LimageView.tag = 5;
        LimageView.image = [UIImage imageNamed:@"malayalm.png"];
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:LimageView];
        

        
    }
    else
    {
        updateBtn = (UIImageView *)[cell.contentView viewWithTag:1001];
        circle = (UIView *)[cell.contentView viewWithTag:999];
        LimageView = (UIImageView *)[cell.contentView viewWithTag:5];
        cell.accessoryView = nil;
        title = (UILabel *)[cell.contentView viewWithTag:3];
        //Description = (UILabel *)[cell.contentView viewWithTag:4];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:DATABASE_CATLOGCONT_NAME]];
    
    [self setTextandDesc:[courseObj valueForKey:DATABASE_CATLOGCONT_NAME] SubTitle:[courseObj valueForKey:DATABASE_CATLOGCONT_DESC] :title];
    
    NSString *imageUrl = [[topicDataArr objectAtIndex:indexPath.row]valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                LimageView.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
                LimageView.image = _img;
            }
            
        }];
    }
    else
    {
        LimageView.image = Limg;
    }
    
    
    
        circle.hidden = FALSE;
        CGFloat progress = [[courseObj valueForKey:HTML_JSON_KEY_IRDATA]floatValue ]/100;
        [circle setPieProgress:progress];
        updateBtn.hidden = TRUE;
        if(!appDelegate.isPreRegisteredUser && indexPath.row != 0 )
        {
            updateBtn.hidden = FALSE;
            circle.hidden = TRUE;
        }
    
        if([[courseObj valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK]boolValue])
        {
            updateBtn.hidden = FALSE;
            circle.hidden = TRUE;
            cell.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0];
        }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 30.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 100.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(!appDelegate.isPreRegisteredUser && indexPath.row !=0 )return;
    NSDictionary * jsonResponse1 = [topicDataArr objectAtIndex:indexPath.row];
    if([[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK]boolValue])return;
    
        NSString * zipUrl = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_ZIPURL];
        NSString * type = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_CATTYPE];
        NSString * zipName;
        NSString * edge_id =  [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID];
        NSString * name = [jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME];
        if([type integerValue] == 3 )
        {
            NSArray *pathComponents = [zipUrl pathComponents];
            zipName = [pathComponents lastObject];
            if([[jsonResponse1 valueForKey:@"action"] isEqualToString:UPDATEACTION])
            {
                NSString *size = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"zipsize_%@",edge_id]];
                float zip_val  = [size floatValue]/(1024.0*1024.0);
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val];
                UIAlertController * updateAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction * action) {
                    [self showGlobalProgress];
                    [self addProcessInQueue:jsonResponse1 :@"assessmentUpdate":@"WileyTurkyTopic"];
                }];
                UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"] style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * action) {
                    if(![appDelegate checkZipPath:zipName])
                    {
                    }
                    else
                    {
//                        MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                        meProlComponantObj.chapterId = edge_id;
//                        meProlComponantObj.type = type;
//                        [self.navigationController pushViewController:meProlComponantObj animated:YES];
                    }
                }];
                
                [updateAlrt addAction:YesAction];
                [updateAlrt addAction:NoAction];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:updateAlrt animated:YES completion:nil];
                });
                
                
            }
            else
            {
                if(![appDelegate checkZipPath:zipName])
                {
                    
                    NSString *size = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"zipsize_%@",edge_id]];
                    float zip_val  = [size floatValue]/(1024.0*1024.0);
                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val];
                    UIAlertController * downloadAlrt = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* YesAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "]  style:UIAlertActionStyleCancel
                                                                      handler:^(UIAlertAction * action) {
                        //[self showGlobalProgress];
                        [self addProcessInQueue:jsonResponse1 :@"assessmentDownload":@"WileyTurkyTopic"];
                    }];
                    UIAlertAction* NoAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"] style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * action) {
                        if(![appDelegate checkZipPath:zipName])
                        {
                        }
                        else
                        {
//                            MeProComponent * meProlComponantObj = [[MeProComponent alloc]initWithNibName:@"MeProComponent" bundle:nil];
//                            meProlComponantObj.chapterId = edge_id;
//                            meProlComponantObj.type = type;
//                            [self.navigationController pushViewController:meProlComponantObj animated:YES];
                        }
                    }];
                    
                    [downloadAlrt addAction:YesAction];
                    [downloadAlrt addAction:NoAction];
                   
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self presentViewController:downloadAlrt animated:YES completion:nil];
                    });
                    
                }
                else
                {
                    
                    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                    [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:@"uid"];
                    [assessmentObj setValue:[jsonResponse1 valueForKey:DATABASE_CATLOGCONT_NAME] forKey:@"name"];
                    [assessmentObj setValue:@"3" forKey:@"type"];
                    
                    
                    
                    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                    assess.assessnetUid = edge_id;
                    assess.type = 3;
                    assess.scnUid = 0;
                    assess.cusTitleName = name;
                    assess.selectedLevel  = @"-1";
                    assess.isRemediation = FALSE;
                    assess.testOBj = assessmentObj;
                    assess.skillObj  = NULL;
                    appDelegate.AssessmentQuesAttemptCounter = -1;
                    [self.navigationController pushViewController:assess animated:YES];
                    
                    
                    
                }
            }
        }
        else
        {
             appDelegate.topicId = edge_id;
             //[appDelegate setUserDefaultData:appDelegate.topicId :@"current_topic_id"];
             appDelegate.viewMode = FALSE;
             [appDelegate gotoNextController:self controllerType:enum_dashboardController sendingObj:nil];
         }
        
    }
-(void)refreshBaseUI:(NSDictionary *)base_data
{
    //[self hideGlobalProgress];
    if([[base_data valueForKey:@"result"]isEqualToString:@"YES"] && ([[base_data valueForKey:@"action"]isEqualToString:@"assessmentUpdate"] || [[base_data valueForKey:@"action"]isEqualToString:@"assessmentDownload"] ))
    {
        [self.sharedDownloadManager cancelAllDownloadsAndRemoveFiles:NO];
        if([[[base_data valueForKey:@"original_data"] valueForKey:@"catType"]intValue] == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
        {
         
            Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
            assess.assessnetUid = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID];
            assess.type = [[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue];
            assess.scnUid = 0;
            assess.cusTitleName = [[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME];
            assess.selectedLevel  = @"-1";
            assess.isRemediation = FALSE;
            assess.testOBj = [base_data valueForKey:@"original_data"];
            assess.skillObj  = NULL;
            appDelegate.AssessmentQuesAttemptCounter = -1;
            [self.navigationController pushViewController:assess animated:YES];
            
//            [self gotoAssessmentQuiz :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_EDGEID]:[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_NAME] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_CATTYPE] :[[base_data valueForKey:@"original_data"] valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] ];
            
        }
    }
}
-(void)gotoAssessmentQuiz :(NSString *)uid :(NSString *)name :(NSString *)catType :(NSString *)remediatioId
{
    
}

-(CGRect)setDynamicHeightForLabel:(UILabel*)_lbl andMaxWidth:(float)_width{
    CGSize maximumLabelSize = CGSizeMake(_width, FLT_MAX);

    CGSize expectedLabelSize = [_lbl.text sizeWithFont:_lbl.font constrainedToSize:maximumLabelSize lineBreakMode:_lbl.lineBreakMode];

    //adjust the label the the new height.
    CGRect newFrame = _lbl.frame;
    newFrame.size.height = expectedLabelSize.height;
    return newFrame;
}
-(void)setTextandDesc:(NSString *)title SubTitle:(NSString *)desc :(UILabel *)lbl
{
    NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"%@\n%@",title,desc];
    NSString* newString = [str stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSArray * arr = [newString componentsSeparatedByString:@"\n"];
    NSString * str1 =  (NSString *) [arr objectAtIndex:0];
    int CharCount1 = str1.length;
    int CharCount2 = newString.length -( CharCount1+1);
    NSMutableAttributedString* timeString = [[NSMutableAttributedString alloc] initWithString:newString];
    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0] range:NSMakeRange(0,CharCount1)];
    [timeString addAttribute:NSFontAttributeName value:TEXTTITLEFONT range:NSMakeRange(0,CharCount1)];
    
    [timeString addAttribute:NSForegroundColorAttributeName value:[self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0] range:NSMakeRange(CharCount1+1,CharCount2)];
    [timeString addAttribute:NSFontAttributeName value:SUBTEXTTILEFONT range:NSMakeRange(CharCount1+1,CharCount2)];
    
    
    lbl.attributedText = timeString;
}

@end
