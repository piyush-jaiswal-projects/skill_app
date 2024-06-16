//
//  WileyClassSlides.m
//  InterviewPrep
//
//  Created by Uday Kranti on 02/07/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "WileyClassSlides.h"
#import "WileyPDFViewer.h"

@interface WileyClassSlides ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bar;
    UITableView *classSlidesTbl;
    NSMutableArray * slidesDataArr;
    UIButton *backBtn;
    UIScrollView *bgView;
}

@end

@implementation WileyClassSlides

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * title= [[UILabel alloc]initWithFrame:CGRectMake(75, 20, SCREEN_WIDTH-150, 44)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = [appDelegate.engineObj getCourseName];
    title.font = NAVIGATIONTITLEFONT;
    title.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    [bar addSubview:title];
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20,40,40)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:backBtn];
    
    bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,STSTUSNAVIGATIONBARHEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT-STSTUSNAVIGATIONBARHEIGHT)];
    bgView.backgroundColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0];
    [self.view addSubview:bgView];
    
    classSlidesTbl = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,bgView.frame.size.width, bgView.frame.size.height) style:UITableViewStylePlain];
    classSlidesTbl.tableFooterView = [UIView new];
    classSlidesTbl.bounces =  FALSE;
    classSlidesTbl.backgroundColor = [UIColor whiteColor];
    classSlidesTbl.delegate = self;
    classSlidesTbl.dataSource = self;
    [bgView addSubview:classSlidesTbl];
    // Do any additional setup after loading the view from its nib.
    
    [self showGlobalProgress];
    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
    [ldict setValue:appDelegate.coursePack forKey:JSON_COURSEPACK];
    [ldict setValue:appDelegate.courseCode forKey:JSON_COURSECODE];
    [ldict setObject:APPVERSION forKey:JSON_APPVERSION];
    [ldict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
    [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
    [ldict setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
    [ldict setObject:CLIENT forKey:JSON_CLIENT];

    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc]init];
    [reqObj setValue:ldict forKey:JSON_PARAM];
    [reqObj setValue: JSON_COURSESLIDEFROMFILES_DECREE forKey:JSON_DECREE];
    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];

    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
    [_reqObj setValue:SERVICE_GETCOURSESLIDES forKey:@"SERVICE"];
    [_reqObj setValue:appDelegate.coursePack forKey:@"package_code"];
    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
    
    
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:SERVICE_GETCOURSESLIDES object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(readLoginResponse:)
        name:SERVICE_GETCOURSESLIDES
      object:nil];


    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    UILabel *myLabel = [[UILabel alloc] init];
    //UILabel *myLabel1 = [[UILabel alloc] init];
    myLabel.textColor =[self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    //myLabel1.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    myLabel.font =   HEADERSECTIONTITLEFONT;
    //myLabel1.font =  HEADERSECTIONTITLEFONT;
    myLabel.frame = CGRectMake(10, 15, 180, 20);
    myLabel.textAlignment = NSTextAlignmentLeft;
   // myLabel1.textAlignment = NSTextAlignmentRight;
   // myLabel1.frame = CGRectMake(headerView.frame.size.width-80, 8, 70, 20);
    myLabel.text = @"LESSONS";
    //myLabel1.text = [appDelegate.langObj get:@"CLP_STATUS" alter:@"STATUS"];
    headerView.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, 49.0f, headerView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [self getUIColorObjectFromHexString:CATEGOEY_HEADER_COLOR alpha:1.0].CGColor;
    [headerView.layer addSublayer:bottomBorder];
    
    [headerView addSubview:myLabel];
    //[headerView addSubview:myLabel];
    //[headerView addSubview:myLabel1];
    
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
    return [slidesDataArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *liqvidIdentifier = @"wileyTopicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:liqvidIdentifier];
    UIImageView *LimageView;
    UILabel *title;
    NSDictionary * courseObj = [slidesDataArr objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:liqvidIdentifier];
        cell.frame = CGRectMake(0,0,tableView.frame.size.width,cell.frame.size.height);
        cell.accessoryView = nil;
        title =  [[UILabel alloc]initWithFrame:CGRectMake(50, 0, cell.frame.size.width-75, 50)];
        title.tag = 3;
        title.numberOfLines = 6;
        title.font =TEXTTITLEFONT;
        title.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentView addSubview:title];
        
        LimageView =  [[UIImageView alloc]init];
        LimageView.frame = CGRectMake(10, 15, 20, 20);
        LimageView.tag = 5;
        LimageView.image = [UIImage imageNamed:@"Wiley_ClassSlide.png"];
        LimageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:LimageView];
        

        
    }
    else
    {
        
        LimageView = (UIImageView *)[cell.contentView viewWithTag:5];
        cell.accessoryView = nil;
        title = (UILabel *)[cell.contentView viewWithTag:3];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0];
    title.text = [[NSMutableString alloc]initWithFormat:@"%@",[courseObj valueForKey:@"lesson_name"]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * jsonResponse1 = [slidesDataArr objectAtIndex:indexPath.row];
    WileyPDFViewer * pdfObj = [[WileyPDFViewer alloc]initWithNibName:@"WileyPDFViewer" bundle:nil];
    pdfObj.titleName = [jsonResponse1 valueForKey:@"lesson_name"];
    NSString * path = [[NSString alloc]initWithFormat:@"%@%@",AUDRO_PDF_PATH,[jsonResponse1 valueForKey:@"lessonUrl"]];
    pdfObj.pDFPath = path;
    [self.navigationController pushViewController:pdfObj animated:TRUE];
}

- (void)readLoginResponse:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideGlobalProgress];
         if([[[notification object]valueForKey:NETWORKSTATUS] intValue] == [SUCCESSRESULT intValue] && [[[notification object]valueForKey:@"SERVICE"] isEqualToString:SERVICE_GETCOURSESLIDES])
        {
            NSDictionary * temp = [[notification object]valueForKey:@"data"];
            if(temp!= NULL && [[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
            {
                NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
                if(resUserData != NULL)
                {
                    slidesDataArr = [[NSMutableArray alloc]init];
                    for (NSDictionary * topicObj  in [resUserData valueForKey:@"pdfArr"]) {
                        NSMutableDictionary * _resObj  = [[NSMutableDictionary alloc]init];
                        
                    
                        NSString * name = [[NSString alloc]initWithFormat:@"%@",[topicObj valueForKey:@"file_name"]];
                        [_resObj setValue:name forKey:@"lesson_name"];
                        [_resObj setValue:[topicObj valueForKey:@"file_path"] forKey:@"lessonUrl"];
                        
                        [slidesDataArr addObject:_resObj ];
                    }
//                    for (NSDictionary * topicObj  in [resUserData valueForKey:@"topicArr"]) {
//                        for (NSDictionary * ChapObj  in [topicObj valueForKey:@"chapterArr"]) {
//
//                            for (NSDictionary * resObj  in [ChapObj valueForKey:@"resourceArr"]) {
//
//                                //for () {
//                                NSString * str = (NSString *)[resObj valueForKey:@"file"];
//                                     NSData *jsonRawData = [str dataUsingEncoding:NSUTF8StringEncoding];
//                                     id _obj = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//                                    if(_obj != NULL && [_obj isKindOfClass:[NSArray class]])
//                                    {
//                                        NSArray * localArr = (NSArray*)_obj;
//                                        for (NSDictionary * __resObj   in localArr) {
//                                            NSMutableDictionary * _resObj  = [[NSMutableDictionary alloc]init];
//
//
//                                            NSString * name = [[NSString alloc]initWithFormat:@"%@ %@",[topicObj valueForKey:@"name"],[__resObj valueForKey:@"file_title"] ];
//                                            [_resObj setValue:name forKey:@"lesson_name"];
//                                            [_resObj setValue:[__resObj valueForKey:@"file"] forKey:@"lessonUrl"];
//
//                                            [slidesDataArr addObject:_resObj ];
//                                        }
//                                    }
//                                    else if(_obj != NULL && [_obj isKindOfClass:[NSDictionary class]])
//                                    {
//                                        NSDictionary * __resObj = (NSDictionary*)_obj;
//                                        NSMutableDictionary * _resObj  = [[NSMutableDictionary alloc]init];
//                                        NSString * name = [[NSString alloc]initWithFormat:@"%@ %@",[topicObj valueForKey:@"name"],[resObj valueForKey:@"scenario_name"] ];
//                                        [_resObj setValue:name forKey:@"lesson_name"];
//                                        [_resObj setValue:[__resObj valueForKey:@"file"] forKey:@"lessonUrl"];
//                                        [slidesDataArr addObject:_resObj ];
//                                    }
//                                    else
//                                    {
//
//                                    }
//
//
//
//                                //}
//
//                            }
//
//                        }
//                    }
                    
                    
                    
                }
                [classSlidesTbl reloadData];
            }
            else
            {
                UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:@""
                                                 message:@"No data found."
                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                    
                    int duration = 2; // duration in seconds
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                    });
                    
              
            }
        }
        
        
    });
    
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
