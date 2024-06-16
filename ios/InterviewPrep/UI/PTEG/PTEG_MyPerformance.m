//
//  PTEG_MyPerformance.m
//  InterviewPrep
//
//  Created by Uday Kranti on 12/06/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_MyPerformance.h"

@interface PTEG_MyPerformance ()<UITableViewDelegate,UITableViewDataSource,ChartViewDelegate>
{
    UIView * bar;
    UIButton *backBtn;
    UITableView * graphTbl;
    NSDictionary * respDict;
    
}

@end

@implementation PTEG_MyPerformance

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
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
    
    
    UILabel * viewTitle = [[UILabel alloc]initWithFrame:CGRectMake(45,STSTUSNAVIGATIONBARHEIGHT-30,SCREEN_WIDTH-50,20)];
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
    
    [backBtn addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    
    UIButton *hamburgBtn = [[UIButton alloc]initWithFrame:CGRectMake(bar.frame.size.width-30, bar.frame.size.height-34,20,20)];
    UIImage * img11 = [UIImage imageNamed:@"PTEG_hamburg.png"];
    img11 = [img11 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [hamburgBtn setImage:img11 forState:UIControlStateNormal];
    hamburgBtn.tintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];
    [hamburgBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:hamburgBtn];
    
    
    
    graphTbl = [[UITableView alloc]initWithFrame:CGRectMake(10, STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH-20, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT)) style:UITableViewStylePlain];
    graphTbl.tableFooterView = [UIView new];
    graphTbl.bounces =  FALSE;
    graphTbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    graphTbl.delegate = self;
    graphTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    graphTbl.dataSource = self;
    [self.view addSubview:graphTbl];
    
    
    
    // Do any additional setup after loading the view from its nib.
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
    
    
    
    NSArray * _arrCourseCode = [appDelegate.engineObj getAllCourseCodeWithPack:appDelegate.coursePack:[appDelegate getUserDefaultData:@"user_selected_level"]];
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
              respDict = [temp valueForKey:JSON_RETVAL];
                [graphTbl reloadData];
            }
            
        }
    });
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
    
    static NSString *liqvidIdentifier = @"PTEG_lCourseCell";
    
    UIView * overallPView;
    UIView * skillPView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        
        overallPView = [[UIView alloc]initWithFrame:CGRectMake(0,10, cell.frame.size.width, 230)];
        overallPView.tag = 1;
        overallPView.hidden = TRUE;
        [overallPView.layer setMasksToBounds:YES];
        
        [overallPView.layer setCornerRadius:10.0f];
        [overallPView.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [overallPView.layer setBorderWidth:1];
        overallPView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        
        [cell.contentView addSubview:overallPView];
        
        
        skillPView = [[UIView alloc]initWithFrame:CGRectMake(0,10, cell.frame.size.width, 220)];
        skillPView.tag = 2;
        skillPView.hidden = TRUE;
        [skillPView.layer setMasksToBounds:YES];
        [skillPView.layer setCornerRadius:10.0f];
        skillPView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [skillPView.layer setBorderColor:[self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0].CGColor];
        [skillPView.layer setBorderWidth:1];
        [cell.contentView addSubview:skillPView];
        
        
    }
    else
    {
        overallPView = (UIView *)[cell.contentView viewWithTag:1];
        overallPView.hidden = TRUE;
        skillPView = (UIView *)[cell.contentView viewWithTag:2];
        skillPView.hidden = TRUE;
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    if(indexPath.row == 0)
    {
        for (UIView * view in overallPView.subviews) {
         [view removeFromSuperview];
        }
        overallPView.hidden = FALSE;
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,overallPView.frame.size.width-20, 40)];
        lbl.text = @"Overall Progress";
        lbl.font = BOLDTEXTTITLEFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentLeft;
        [overallPView addSubview:lbl];
        UIView * lblborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,lbl.frame.size.height-1, lbl.frame.size.width,1)];
        lblborder_Line.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        [lbl addSubview:lblborder_Line];
        
        
        PieChartView *_piChartView = [[PieChartView alloc]initWithFrame:CGRectMake(0,40, overallPView.frame.size.width,180)];
        [overallPView addSubview:_piChartView ];
        _piChartView.usePercentValuesEnabled = NO;
        _piChartView.drawSlicesUnderHoleEnabled = NO;
        _piChartView.holeRadiusPercent = 0.85;
        _piChartView.transparentCircleRadiusPercent = 0.85;
        _piChartView.chartDescription.enabled = NO;
        [_piChartView setExtraOffsetsWithLeft:1.f top:1.f right:1.f bottom:1.f];
        _piChartView.drawCenterTextEnabled = YES;
       _piChartView.legend.enabled = TRUE;
         
        _piChartView.drawHoleEnabled = YES;
        _piChartView.rotationAngle = 0.0;
        _piChartView.rotationEnabled = YES;
        _piChartView.highlightPerTapEnabled = YES;
        ChartLegend *l = _piChartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
        l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        l.textColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
        l.font = SUBTEXTTILEFONT;
        l.orientation = ChartLegendOrientationHorizontal;
        l.drawInside = NO;
        l.xEntrySpace = 8.0;
        l.yEntrySpace = 0.0;
        l.yOffset = 0.0;
        _piChartView.delegate = self;
        _piChartView.entryLabelColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        _piChartView.entryLabelFont = BOLDTEXTTITLEFONT;
        //int p_count  =(int)[skillArr count];
        NSMutableArray *values = [[NSMutableArray alloc] init];
        int totalChap = [[respDict valueForKey:@"ttl_chapter"]intValue];
        if(totalChap > 0)
        {
            int compltedChap = [[respDict valueForKey:@"ttl_completed_chapter"]intValue];
            int inProgressChap = [[respDict valueForKey:@"ttl_not_completed_chapter"]intValue];
            int toBeginChap = totalChap - (compltedChap + inProgressChap);
            
            double percentComplete = ((double)((double)compltedChap*100/(double)totalChap));
            double percentInProgess = (double)(double)((double)inProgressChap*100/(double)totalChap);
            double percentNotStarted = (double)((double)((float)toBeginChap*100/(float)totalChap));
            
            [values addObject:[[PieChartDataEntry alloc] initWithValue:percentComplete label:[[NSString alloc]initWithFormat:@"%0.2f%% %@", percentComplete,@"Completed"] icon:nil]];
            [values addObject:[[PieChartDataEntry alloc] initWithValue:percentInProgess label:[[NSString alloc]initWithFormat:@"%0.2f%% %@",percentInProgess,@"In Progress" ]icon:nil]];
            [values addObject:[[PieChartDataEntry alloc] initWithValue:percentNotStarted label:[[NSString alloc]initWithFormat:@"%0.2f%% %@",percentNotStarted,@"To begin"] icon:nil]];
            
            
            NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
             paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
             paragraphStyle.alignment = NSTextAlignmentCenter;
            //NSString * str = [[NSString alloc]initWithFormat:@"%d%%       %d/%d",percentComplete,compltedChap,totalChap];
            NSString * str = [[NSString alloc]initWithFormat:@"%0.2f%%",percentComplete];
            NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:str];// [self covertIntoHrMinSec:totalCourseTime]
            [centerText setAttributes:@{
                    NSFontAttributeName: GRPAHTITLEFONT,
                    NSForegroundColorAttributeName: [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0],
                    NSParagraphStyleAttributeName: paragraphStyle
            } range:NSMakeRange(0, centerText.length)];
//            [centerText addAttributes:@{
//                    NSFontAttributeName:TEXTTITLEFONT,
//                    NSForegroundColorAttributeName: [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0]
//            } range:NSMakeRange(6, 5)];
            _piChartView.centerAttributedText = centerText;
            
            
        }
        
        
        
//        for (int i = 0; i < p_count; i++)
//            {
//                NSDictionary * obj = [skillArr objectAtIndex:i];
//
//                //double spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
//
//                double spent = 0;
//                if([obj valueForKey:@"total_time_spent"] != [NSNull null])
//                    spent = [[obj valueForKey:@"total_time_spent"] doubleValue];
//
//
//
//                if(totalCourseTime >0){
//                    double val = (ttl_completed_chapter/ttl_chapter)*100;
//
//                }
//                else
//                {
//                    [values addObject:[[PieChartDataEntry alloc] initWithValue:0 label:[obj valueForKey:@"skill_name"] icon:nil]];
//                }
//            }
            
            PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:values label:@""];
            
            dataSet.drawIconsEnabled = NO;
            
            dataSet.sliceSpace = 2.0;
            dataSet.iconsOffset = CGPointMake(0, 20);
            
            // add a lot of colors
            
            NSMutableArray *colors = [[NSMutableArray alloc] init];
//            [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//            [colors addObjectsFromArray:ChartColorTemplates.joyful];
//            [colors addObjectsFromArray:ChartColorTemplates.colorful];
//            [colors addObjectsFromArray:ChartColorTemplates.liberty];
//            [colors addObjectsFromArray:ChartColorTemplates.pastel];
            
            [colors addObject:[UIColor colorWithRed:204/255.f green:227/255.f blue:0/255.f alpha:1.f]];
            [colors addObject:[UIColor colorWithRed:0/255.f green:163/255.f blue:177/255.f alpha:1.f]];
            [colors addObject:[UIColor colorWithRed:228/255.f green:230/255.f blue:229/255.f alpha:1.f]];
            
            dataSet.colors = colors;
            
            PieChartData *pi_data = [[PieChartData alloc] initWithDataSet:dataSet];
            
            NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
            pFormatter.numberStyle = NSNumberFormatterPercentStyle;
            pFormatter.maximumFractionDigits = 1;
            pFormatter.multiplier = @1.f;
            pFormatter.percentSymbol = @"";
            [pi_data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
            [pi_data setValueFont:[UIFont systemFontOfSize:0.f]];
            [pi_data setValueTextColor:UIColor.blackColor];
            
            _piChartView.data = pi_data;
          
            
            //                    for (id<IChartDataSet> set in _piChartView.data.dataSets)
            //                    {
            //                        set.drawValuesEnabled = FALSE;
            //                    }
            //_piChartView.drawEntryLabelsEnabled = !_piChartView.drawEntryLabelsEnabled;
            //_piChartView.usePercentValuesEnabled = !_piChartView.isUsePercentValuesEnabled;
            
            [_piChartView highlightValues:nil];
            [_piChartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
            
        
//        UIView * bootomV = [[UIView alloc]initWithFrame:CGRectMake(0, overallPView.frame.size.height-50, overallPView.frame.size.width,50)];
//        [overallPView addSubview:bootomV];
//        UIView * bootomVborder_Line = [[UIView alloc]initWithFrame:CGRectMake(0,1, bootomV.frame.size.width,1)];
//        bootomVborder_Line.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [bootomV addSubview:bootomVborder_Line];
//
//
//
//        UIView * bView1 = [[UIView alloc]initWithFrame:CGRectMake(0,0, bootomV.frame.size.width/3,40)];
//        [bootomV addSubview:bView1];
//        UIView * bView1border_Line = [[UIView alloc]initWithFrame:CGRectMake(bootomV.frame.size.width-1,0,1, bootomV.frame.size.height)];
//        bView1border_Line.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//        [bView1 addSubview:bView1border_Line];
//
//
//
//        UIView * bView2 = [[UIView alloc]initWithFrame:CGRectMake(0,0, bootomV.frame.size.width/3,40)];
//        [bootomV addSubview:bView2];
//
//        UIView * bView3 = [[UIView alloc]initWithFrame:CGRectMake(0,0, bootomV.frame.size.width/3,40)];
//        [bootomV addSubview:bView3];
        
        
        
            
    }
    else if(indexPath.row == 1)
    {
        for (UIView * view in skillPView.subviews) {
          [view removeFromSuperview];
        }
        skillPView.hidden = FALSE;
        
        UILabel * lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,skillPView.frame.size.width-20, 40)];
        lbl.text = @"Skills Progress";
        lbl.font = BOLDTEXTTITLEFONT;
        lbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        lbl.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
        lbl.textAlignment = NSTextAlignmentLeft;
        [skillPView addSubview:lbl];
        if([[respDict valueForKey:@"skill_arr"] count]>0)
        {
            UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, skillPView.frame.size.width/2 -5 , 70)];
            [view1.layer setMasksToBounds:YES];
            [view1.layer setCornerRadius:10.0f];
            [view1.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
            [view1.layer setBorderWidth:1];
            view1.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            [skillPView addSubview:view1];
            
            
            UILabel * lblSkill = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,view1.frame.size.width-20, 15)];
            lblSkill.font = GRPAHTITLEFONT;
            lblSkill.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            lblSkill.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkill.textAlignment = NSTextAlignmentLeft;
            lblSkill.text = [[NSString alloc]initWithFormat:@"%@%%",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:0] valueForKey:@"skill_per"]];
            [view1 addSubview:lblSkill];
            
            
            UILabel * lblSkillName = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,view1.frame.size.width-20, 20)];
            lblSkillName.font = TEXTTITLEFONT;
            lblSkillName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            lblSkillName.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkillName.textAlignment = NSTextAlignmentLeft;
            lblSkillName.text = [[NSString alloc]initWithFormat:@"%@",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:0] valueForKey:@"skill_name"]];
            [view1 addSubview:lblSkillName];
            
            UIProgressView * progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
            progressView.frame =  CGRectMake(10, 50, view1.frame.size.width-20, 5);
            progressView.progress = 0.0f;
            progressView.layer.cornerRadius =10;
            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            progressView.transform = transform;
            int val = [[[[respDict valueForKey:@"skill_arr"] objectAtIndex:0] valueForKey:@"skill_per"]intValue];
           CGFloat f = (float)((float)val/(float)100);
            progressView.progress  = f ;
            progressView.progressTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
            if(val >= 100){
              progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];;
            }
            else if(val > 0)
            {
                progressView.progressTintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
            }
            progressView.trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
            [view1 addSubview:progressView];
            
            
            
            
             
        }
        
        if([[respDict valueForKey:@"skill_arr"] count]>1)
        {
        UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(skillPView.frame.size.width/2+5, 40, skillPView.frame.size.width/2 -5 , 70)];
        [view2.layer setMasksToBounds:YES];
        [view2.layer setCornerRadius:10.0f];
        [view2.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [view2.layer setBorderWidth:1];
        view2.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [skillPView addSubview:view2];
            
            
            UILabel * lblSkill = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,view2.frame.size.width-20, 15)];
            lblSkill.font = GRPAHTITLEFONT;
            lblSkill.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            lblSkill.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkill.textAlignment = NSTextAlignmentLeft;
            lblSkill.text = [[NSString alloc]initWithFormat:@"%@%%",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:1] valueForKey:@"skill_per"]];
            [view2 addSubview:lblSkill];
            
            
            UILabel * lblSkillName = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,view2.frame.size.width-20, 20)];
            lblSkillName.font = TEXTTITLEFONT;
            lblSkillName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            lblSkillName.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkillName.textAlignment = NSTextAlignmentLeft;
            lblSkillName.text = [[NSString alloc]initWithFormat:@"%@",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:1] valueForKey:@"skill_name"]];
            [view2 addSubview:lblSkillName];
            
            
            UIProgressView * progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
             progressView.frame =  CGRectMake(10, 50, view2.frame.size.width-20, 5);
             progressView.progress = 0.0f;
             progressView.layer.cornerRadius =10;
             CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
             progressView.transform = transform;
             int val = [[[[respDict valueForKey:@"skill_arr"] objectAtIndex:1] valueForKey:@"skill_per"]intValue];
            CGFloat f = (float)((float)val/(float)100);
             progressView.progress  = f ;
             progressView.progressTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             if(val >= 100){
               progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];;
             }
             else if(val > 0)
             {
                 progressView.progressTintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
             }
             progressView.trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             [view2 addSubview:progressView];
            
            
        }
        
        if([[respDict valueForKey:@"skill_arr"] count]>2)
        {
       UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 120, skillPView.frame.size.width/2 -5 , 70)];
        [view3.layer setMasksToBounds:YES];
        [view3.layer setCornerRadius:10.0f];
        [view3.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [view3.layer setBorderWidth:1];
        view3.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [skillPView addSubview:view3];
            
            UILabel * lblSkill = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,view3.frame.size.width-20, 15)];
            lblSkill.font = GRPAHTITLEFONT;
            lblSkill.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            lblSkill.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkill.textAlignment = NSTextAlignmentLeft;
            lblSkill.text = [[NSString alloc]initWithFormat:@"%@%%",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:2] valueForKey:@"skill_per"]];
            [view3 addSubview:lblSkill];
            
            
            UILabel * lblSkillName = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,view3.frame.size.width-20, 20)];
            lblSkillName.font = TEXTTITLEFONT;
            lblSkillName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            lblSkillName.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkillName.textAlignment = NSTextAlignmentLeft;
            lblSkillName.text = [[NSString alloc]initWithFormat:@"%@",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:2] valueForKey:@"skill_name"]];
            [view3 addSubview:lblSkillName];
            
            
            
            UIProgressView * progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
             progressView.frame =  CGRectMake(10, 50, view3.frame.size.width-20, 5);
             progressView.progress = 0.0f;
             progressView.layer.cornerRadius =10;
             CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
             progressView.transform = transform;
             int val = [[[[respDict valueForKey:@"skill_arr"] objectAtIndex:2] valueForKey:@"skill_per"]intValue];
            CGFloat f = (float)((float)val/(float)100);
             progressView.progress  = f ;
             progressView.progressTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             if(val >= 100){
               progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];;
             }
             else if(val > 0)
             {
                 progressView.progressTintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
             }
             progressView.trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             [view3 addSubview:progressView];
            
        }
        
        if([[respDict valueForKey:@"skill_arr"] count]>3)
        {
        UIView * view4 = [[UIView alloc]initWithFrame:CGRectMake(skillPView.frame.size.width/2+5, 120, skillPView.frame.size.width/2 -5 , 70)];
        [view4.layer setMasksToBounds:YES];
        [view4.layer setCornerRadius:10.0f];
        [view4.layer setBorderColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0].CGColor];
        [view4.layer setBorderWidth:1];
        view4.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
        [skillPView addSubview:view4];
            
            UILabel * lblSkill = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,view4.frame.size.width-20, 15)];
            lblSkill.font = GRPAHTITLEFONT;
            lblSkill.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            lblSkill.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkill.textAlignment = NSTextAlignmentLeft;
            lblSkill.text = [[NSString alloc]initWithFormat:@"%@%%",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:3] valueForKey:@"skill_per"]];
            [view4 addSubview:lblSkill];
            
            
            UILabel * lblSkillName = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,view4.frame.size.width-20, 20)];
            lblSkillName.font = TEXTTITLEFONT;
            lblSkillName.textColor = [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
            lblSkillName.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
            lblSkillName.textAlignment = NSTextAlignmentLeft;
            lblSkillName.text = [[NSString alloc]initWithFormat:@"%@",[[[respDict valueForKey:@"skill_arr"] objectAtIndex:3] valueForKey:@"skill_name"]];
            [view4 addSubview:lblSkillName];
            
            UIProgressView * progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
             progressView.frame =  CGRectMake(10, 50, view4.frame.size.width-20, 5);
             progressView.progress = 0.0f;
             progressView.layer.cornerRadius =10;
             CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
             progressView.transform = transform;
             int val = [[[[respDict valueForKey:@"skill_arr"] objectAtIndex:3] valueForKey:@"skill_per"]intValue];
            CGFloat f = (float)((float)val/(float)100);
             progressView.progress = f;
             progressView.progressTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             if(val >= 100)
             {
               progressView.progressTintColor = [self getUIColorObjectFromHexString:@"#D2DB27" alpha:1.0];;
             }
             else if(val > 0)
             {
                 progressView.progressTintColor = [self getUIColorObjectFromHexString:SIGNSIGNUPCOLOR alpha:1.0];
             }
             progressView.trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
             [view4 addSubview:progressView];
        }
    }
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row ==0)
  {
     return 240.0;
  }
  else if(indexPath.row ==1)
  {
       return 240.0;
  }
  else
  {
      return 0.0;
  }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)clickback {
    [self.navigationController popViewControllerAnimated:true];
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
