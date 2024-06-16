//
//  SummeryPteVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEG_SummeryPteVC.h"

#define leftPadding  0
#define rightPadding  0
@interface PTEG_SummeryPteVC ()
{
    UIView * bar;
    UIButton *backBtn;
    UITableView * tableView;
    UIView * timeView;
    //BOOL isPlaying;
}

@end

@implementation PTEG_SummeryPteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = APP_DELEGATE;
    [AppDelegate deleteUserDefaultData:@"isPlay"];
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
    viewTitle.text = [[NSString alloc]initWithFormat:@"%@ Summary",self.titleName];
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
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(leftPadding, STSTUSNAVIGATIONBARHEIGHT+40, SCREEN_WIDTH-rightPadding, SCREEN_HEIGHT-(STSTUSNAVIGATIONBARHEIGHT+40)) style:UITableViewStylePlain];
    tableView.layer.cornerRadius = 10.0f;
    tableView.layer.borderWidth = 1.0f;
    tableView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    tableView.layer.masksToBounds = YES;
    tableView.clipsToBounds = YES;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self registerNibs];
    tableView.estimatedRowHeight = 400.0;
    //self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];

    NSLog(@"%@", self.questionArray);
    
    timeView = [[UIView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, 40)];
    
    timeView.backgroundColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
    
    UILabel *YTimelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5,SCREEN_WIDTH/2-10, 30)];
    YTimelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    YTimelbl.font = TEXTTITLEFONT;
    YTimelbl.text = @"Time Taken";
    YTimelbl.textAlignment = NSTextAlignmentLeft;
    [timeView addSubview:YTimelbl];
    
    UILabel *YTimeVal = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 5,SCREEN_WIDTH/2-10, 30)];
    YTimeVal.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    YTimeVal.font = BOLDTEXTTITLEFONT;
    YTimeVal.text = [[NSString alloc]initWithFormat:@"%@",[self covertIntoHrMinSec:self.totalSpentTime]];
    YTimeVal.textAlignment = NSTextAlignmentRight;
    [timeView addSubview:YTimeVal];
    
    
    
    
//    UILabel *YCTimelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 35,SCREEN_WIDTH/2-10, 30)];
//    YCTimelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    YCTimelbl.font = [UIFont systemFontOfSize:13.0f];
//    YCTimelbl.text = @"Country Average";
//    YCTimelbl.textAlignment = NSTextAlignmentLeft;
//    [timeView addSubview:YCTimelbl];
//
//    UILabel *YCTimeVal = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 35,SCREEN_WIDTH/2-10, 30)];
//    YCTimeVal.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    YCTimeVal.font = [UIFont systemFontOfSize:13.0f];
//    YCTimeVal.text = [[NSString alloc]initWithFormat:@"%@",[self covertIntoHrMinSec:self.totalSpentTime]];
//    YCTimeVal.textAlignment = NSTextAlignmentRight;
//    [timeView addSubview:YCTimeVal];
//
//
//    UILabel *YWTimelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 65,SCREEN_WIDTH/2-10, 30)];
//    YWTimelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    YWTimelbl.font = [UIFont systemFontOfSize:13.0f];
//    YWTimelbl.text = @"World Average";
//    YWTimelbl.textAlignment = NSTextAlignmentLeft;
//    [timeView addSubview:YWTimelbl];
//
//    UILabel *YWTimeVal = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 65,SCREEN_WIDTH/2-10, 30)];
//    YWTimeVal.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//    YWTimeVal.font = [UIFont systemFontOfSize:13.0f];
//    YWTimeVal.text = [[NSString alloc]initWithFormat:@"%@",[self covertIntoHrMinSec:self.totalSpentTime]];
//    YWTimeVal.textAlignment = NSTextAlignmentRight;
//    [timeView addSubview:YWTimeVal];
    
    

    //timeView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    [self.view addSubview:timeView];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma marks :- register cell methods

-(void)registerNibs{
    
    [tableView registerNib:[UINib nibWithNibName:@"WritingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WritingCell"];
    [tableView registerNib:[UINib nibWithNibName:@"FIBCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FIBCell"];
    [tableView registerNib:[UINib nibWithNibName:@"ListeningTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ListeningTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"ReadingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReadingCell"];
    [tableView registerNib:[UINib nibWithNibName:@"SpeakingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SpeakingCell"];

}

- (IBAction)crossBtnAction:(id)sender {
   NSArray *array = [self.navigationController viewControllers];
   [self.navigationController popToViewController:[array objectAtIndex:[array count]-4] animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
        if([[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"mc"]||[[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"mmc"]){
             static NSString *identifier = @"ReadingCell";
            ReadingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.quesLbl.text = [NSString stringWithFormat:@"Q%ld.",(long)indexPath.row+1];
            cell.quesLbl.font = SUBTEXTTILEFONT;
            cell.quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            cell.delegate = self;
            [cell configureCell:[self.questionArray objectAtIndex:indexPath.row]];
            return cell;

        }else if([[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"fb"] || [[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"ifb"]){
            
            static NSString *identifier = @"FIBCell";
            FIBCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.quesNoLbl.text = [NSString stringWithFormat:@"Q%ld.",(long)indexPath.row+1];
            cell.quesNoLbl.font = SUBTEXTTILEFONT;
            cell.quesNoLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            [cell configureCell:[self.questionArray objectAtIndex:indexPath.row]];
            cell.delegate = self;
            return cell;
        }else if([[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"es"]){
            static NSString *identifier = @"WritingCell";
            WritingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.quesNoLbl.text = [NSString stringWithFormat:@"Q%ld.",(long)indexPath.row+1];
            cell.quesNoLbl.font = SUBTEXTTILEFONT;
            cell.quesNoLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            cell.delegate = self;
            [cell configureCell:[self.questionArray objectAtIndex:indexPath.row]];
            return cell;
        }else if([[[self.questionArray objectAtIndex:indexPath.row] valueForKey:@"type"] isEqual:@"ra"]){
            
            static NSString *identifier = @"SpeakingCell";
            SpeakingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.collectionView.tag = indexPath.row;
            cell.tag = indexPath.row;
            cell.delegate = self;
            [cell configureCell:[self.questionArray objectAtIndex:indexPath.row] selectedIndex:(int)indexPath.row];
            cell.quesLbl.text = [NSString stringWithFormat:@"Q%ld.",(long)indexPath.row+1];
            cell.quesLbl.font = SUBTEXTTILEFONT;
            cell.quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];

            return cell;
        }else
        {
            static NSString *identifier = @"ListeningTableViewCell";
            ListeningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configureCell:[self.questionArray objectAtIndex:indexPath.row]];
            cell.quesLbl.text = [NSString stringWithFormat:@"Q%ld.",(long)indexPath.row+1];
            cell.quesLbl.font = SUBTEXTTILEFONT;
            cell.quesLbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
            return cell;
        }
    
}



- (void)reloadTable {
    [tableView reloadData];
}


-(void)viewWillDisappear:(BOOL)animated{
    
}

-(NSString*)covertIntoHrMinSec:(int)overAllTime
{
    int hr = overAllTime/(int)(60*60);
    int _min = overAllTime%(int)(60*60);
    int min = (int)_min/(int)(60);
    int sec = (int)_min%(int)(60);
    NSString * str;
    if((hr == 0 && min == 0) || (hr == 0 && min == 0 && sec == 0) )
    {
        str = [[NSString alloc]initWithFormat:@"%02ds",sec];
    }
    else if(hr == 0)
    {
        str = [[NSString alloc]initWithFormat:@"%02dmin %02ds",min,sec];
    }
    else
    {
        str = [[NSString alloc]initWithFormat:@"%02dhr %02dmin %02ds",hr,min,sec];
    }
    return str;
}
@end
