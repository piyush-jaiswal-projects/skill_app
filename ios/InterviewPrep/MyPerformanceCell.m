//
//  MyPerformanceCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 22/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MyPerformanceCell.h"
#import "MyPerformanceXaxis.h"
#import "MyPerformanceXaxis_SkillP.h"
@implementation MyPerformanceCell{
    
    NSString *imgName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.timeSpentChatV.layer setCornerRadius:10.0];
    [self.skillPerformanceChartV.layer setCornerRadius:10.0];
    [self.itemsAttemptedChartV.layer setCornerRadius:10.0];
    [self.itemsAttemptedChartV setBackgroundColor:[UIColor whiteColor]];
    [self.skillPerformanceChartV setBackgroundColor:[UIColor whiteColor]];
    [self.timeSpentChatV setBackgroundColor:[UIColor whiteColor]];
    
    NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
    if(level !=nil || ![level isEqualToString:@""]){
       self.levelLbl.text = level;
    }
    
    imgName = @"img_150x150.png";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      imgName ];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    UIImage* image;
    //image = [UIImage imageNamed:@"user.png"];
    if ([fileManager fileExistsAtPath:path]== NO) {
        image = [UIImage imageNamed:imgName];
    }
    else{
        image = [UIImage imageWithContentsOfFile:path];
    }
    [self.profileImageBtn setImage:image forState:UIControlStateNormal];
    [self.profileImageBtn.layer setCornerRadius:80.0/2];
    self.profileImageBtn.clipsToBounds = true;




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureTimeSpentChart:(NSMutableArray *)timeSpentArray :(double)totalTime{
    _timeSpentChatV.delegate = self;
    _timeSpentArray = [[NSMutableArray alloc]init];
    for(NSDictionary *dict in timeSpentArray){
        
        double time = [[dict objectForKey:@"skill_time"] doubleValue];
        
        [_timeSpentArray addObject:[[PieChartDataEntry alloc] initWithValue:time/totalTime*100 label:[dict objectForKey:@"skill_name"] icon:nil]];
        
        
        
        
        
//        [_timeSpentArray addObject:[[PieChartDataEntry alloc] initWithValue:writingTime/total*100 label:@"Writing" icon:nil]];
//
//
//
//        if([dict[@"name"] isEqualToString:@"Writing Activities"]){
//            double time = [[dict objectForKey:@"timeSpent"] doubleValue];
//            writingTime = writingTime + time;
//        }else if([dict[@"name"] isEqualToString:@"Reading Activities"]){
//            double time = [[dict objectForKey:@"timeSpent"] doubleValue];
//            readingTime = readingTime + time;
//        }else if([dict[@"name"] isEqualToString:@"Listening Activities"]){
//            double time = [[dict objectForKey:@"timeSpent"] doubleValue];
//            listeningTime = listeningTime + time;
//        }else{
//            double time = [[dict objectForKey:@"timeSpent"] doubleValue];
//            speakingTime = speakingTime + time;
//        }
    }
    
//    double total = writingTime+readingTime+listeningTime+speakingTime;
//
//
//
//    [_timeSpentArray addObject:[[PieChartDataEntry alloc] initWithValue:listeningTime/total*100 label:@"Listening" icon:nil]];
//    [_timeSpentArray addObject:[[PieChartDataEntry alloc] initWithValue:speakingTime/total*100 label:@"Speaking" icon:nil]];
    

    [self.timeSpentChatV setCenterText:@""];
    
    PieChartDataSet *dataSet;
    if(totalTime > 0){
         dataSet = [[PieChartDataSet alloc] initWithEntries:_timeSpentArray label:@""];
    }else{
         dataSet = [[PieChartDataSet alloc] initWithEntries:0 label:@"Data not Available"];
    }
    
    
    dataSet.drawIconsEnabled = NO;
    
    dataSet.sliceSpace = 5.0;
    dataSet.iconsOffset = CGPointMake(0, 20);
    
    // add a lot of colors
    NSString *stringColor = @"#63c033";
    NSUInteger red, green, blue;
    sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
    UIColor *writingcolor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
    NSString *stringColor1 = @"#336187";
    NSUInteger red1, green1, blue1;
    sscanf([stringColor1 UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
    UIColor *readingcolor = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1.0];
    
    NSString *stringColor2 = @"#00a5a4";
    NSUInteger red2, green2, blue2;
    sscanf([stringColor2 UTF8String], "#%2lX%2lX%2lX", &red2, &green2, &blue2);
    UIColor *listeningcolor = [UIColor colorWithRed:red2/255.0 green:green2/255.0 blue:blue2/255.0 alpha:1.0];
    
    NSString *stringColor3 = @"#643474";
    NSUInteger red3, green3, blue3;
    sscanf([stringColor3 UTF8String], "#%2lX%2lX%2lX", &red3, &green3, &blue3);
    UIColor *speakingcolor = [UIColor colorWithRed:red3/255.0 green:green3/255.0 blue:blue3/255.0 alpha:1.0];

    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:writingcolor];
    [colors addObject:readingcolor];
    [colors addObject:listeningcolor];
    [colors addObject:speakingcolor];


//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
//    [colors addObjectsFromArray:ChartColorTemplates.colorful];
//    [colors addObjectsFromArray:ChartColorTemplates.liberty];
//    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    PieChartData *pi_data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @"%";
    [pi_data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [pi_data setValueFont:[UIFont systemFontOfSize:0.f]];
    [pi_data setValueTextColor:UIColor.blackColor];
    _timeSpentChatV.data = pi_data;
    _timeSpentChatV.holeRadiusPercent = 0.80;
    [_timeSpentChatV highlightValues:nil];
    [_timeSpentChatV animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
}


-(void)configureItemsAttemptedChart:(NSMutableArray *)itemsAttemptedArray :(double)totalTime{
    _itemsAttemptedChartV.chartDescription.enabled = NO;
    _itemsAttemptedChartV.drawGridBackgroundEnabled = NO;
    _itemsAttemptedChartV.legend.enabled = FALSE;
    _itemsAttemptedChartV.dragEnabled = NO;
    [_itemsAttemptedChartV setScaleEnabled:NO];
    _itemsAttemptedChartV.pinchZoomEnabled = NO;
    _itemsAttemptedChartV.doubleTapToZoomEnabled = NO;
    _itemsAttemptedChartV.rightAxis.enabled = NO;
    _itemsAttemptedChartV.leftAxis.enabled = YES;
    _itemsAttemptedChartV.delegate = self;
    _itemsAttemptedChartV.drawBarShadowEnabled = NO;
    _itemsAttemptedChartV.drawValueAboveBarEnabled = YES;
    [_itemsAttemptedChartV animateWithXAxisDuration:3.0 yAxisDuration:3.0];
    
    ChartXAxis *xAxis = _itemsAttemptedChartV.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:8.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 2;
    xAxis.valueFormatter = [[MyPerformanceXaxis alloc] initForChart:self.itemsAttemptedChartV];
    
    NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
    rightAxisFormatter.minimumFractionDigits = 0;
    rightAxisFormatter.maximumFractionDigits = 1;
    rightAxisFormatter.negativeSuffix = @"";
    rightAxisFormatter.positiveSuffix = @"%";
    
    ChartYAxis *leftAxis = _itemsAttemptedChartV.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 7;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0;
    
    
    self.itemsAttemptedChartV.delegate = self;
//    double totalWritingQuiz = 0;
//    double totalWritingAttemptedQuiz = 0;
//    
//    double totalSpeakingQuiz = 0;
//    double totalSpeakingAttemptedQuiz = 0;

    
    _itemsAttemptedArray = [[NSMutableArray alloc]init];
    double writingPercentage  = 0.0;
    double speakingPercentage = 0.0;
    
    for(NSDictionary *dict in itemsAttemptedArray){
        if([dict[@"skill_name"] isEqualToString:@"Writing"]){
            writingPercentage = [[dict objectForKey:@"skill_per"] doubleValue];
        }else if([dict[@"skill_name"] isEqualToString:@"Speaking"]){
            speakingPercentage = [[dict objectForKey:@"skill_per"] doubleValue];

        }
    }
    
    [_itemsAttemptedArray addObject:[[BarChartDataEntry alloc] initWithX:0 y:writingPercentage]];
    [_itemsAttemptedArray addObject:[[BarChartDataEntry alloc] initWithX:1 y:speakingPercentage]];

    
    BarChartDataSet *set1 = nil;
//    if (_itemsAttemptedChartV.data.dataSetCount > 0 )
    if(isnan(writingPercentage) && isnan(speakingPercentage))
    {
        set1 = (BarChartDataSet *)_itemsAttemptedChartV.data.dataSets[0];
        [set1 replaceEntries: _itemsAttemptedArray];
        [_itemsAttemptedChartV.data notifyDataChanged];
        [_itemsAttemptedChartV notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithEntries:_itemsAttemptedArray label:@""];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _itemsAttemptedChartV.data = data;
    }


}




-(void)configureSkillPerformanceChart:(NSMutableArray *)skillPerformanceArray :(double)totalTime{
    self.skillPerformanceChartV.delegate = self;
    _skillPerformanceChartV.chartDescription.enabled = NO;
    _skillPerformanceChartV.drawGridBackgroundEnabled = NO;
    _skillPerformanceChartV.legend.enabled = FALSE;
    _skillPerformanceChartV.dragEnabled = NO;
    [_skillPerformanceChartV setScaleEnabled:NO];
    _skillPerformanceChartV.pinchZoomEnabled = NO;
    _skillPerformanceChartV.doubleTapToZoomEnabled = NO;
    _skillPerformanceChartV.rightAxis.enabled = NO;
    _skillPerformanceChartV.leftAxis.enabled = YES;
    _skillPerformanceChartV.delegate = self;
    _skillPerformanceChartV.drawBarShadowEnabled = NO;
    _skillPerformanceChartV.drawValueAboveBarEnabled = YES;
    [_skillPerformanceChartV animateWithXAxisDuration:3.0 yAxisDuration:3.0];

    ChartXAxis *xAxis = _skillPerformanceChartV.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:8.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 2;
    xAxis.valueFormatter = [[MyPerformanceXaxis_SkillP alloc] initForChart:self.skillPerformanceChartV];

    NSNumberFormatter *rightAxisFormatter = [[NSNumberFormatter alloc] init];
    rightAxisFormatter.minimumFractionDigits = 0;
    rightAxisFormatter.maximumFractionDigits = 1;
    rightAxisFormatter.negativeSuffix = @"";
    rightAxisFormatter.positiveSuffix = @"%";

    ChartYAxis *leftAxis = _skillPerformanceChartV.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 7;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:rightAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0;
    
    
    self.skillPerformanceChartV.delegate = self;
//    double totalReadingQuiz = 0;
//    double totalReadingCorretQuiz = 0;
    
//    double totalListeningQuiz = 0;
//    double totalListeningCorretQuiz = 0;

    
    _skillPerformanceArray = [[NSMutableArray alloc]init];
    double readingPercentge = 0.0;
    double listeningPercentge = 0.0;
    
    for(NSDictionary *dict in skillPerformanceArray){
        if([dict[@"skill_name"] isEqualToString:@"Listening"])
        {
            listeningPercentge = [[dict objectForKey:@"skill_per"] doubleValue];
        }else if([dict[@"skill_name"] isEqualToString:@"Reading"])
        {
            readingPercentge = [[dict objectForKey:@"skill_per"] doubleValue];
        }
        
    }
    
   

    [_skillPerformanceArray addObject:[[BarChartDataEntry alloc] initWithX:0 y:readingPercentge]];
    [_skillPerformanceArray addObject:[[BarChartDataEntry alloc] initWithX:1 y:listeningPercentge]];

    
    BarChartDataSet *set1 = nil;
//    if (_skillPerformanceChartV.data.dataSetCount > 0)
    if(isnan(readingPercentge) && isnan(listeningPercentge))
    {
        set1 = (BarChartDataSet *)_skillPerformanceChartV.data.dataSets[0];
        [set1 replaceEntries: _skillPerformanceArray];
        [_skillPerformanceChartV.data notifyDataChanged];
        [_skillPerformanceChartV notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithEntries:_skillPerformanceArray label:@""];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = 0.9f;
        _skillPerformanceChartV.data = data;
    }


}
@end
