//
//  MyPerformanceViewController.m
//  InterviewPrep
//
//  Created by Amit Gupta on 04/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "MyPerformanceViewController.h"
#import "MyPerformanceHeaderCell.h"
#import "MyPerformanceStatsCell.h"
#import "MyPerformanceChartVCell.h"

@interface MyPerformanceViewController ()

@end

@implementation MyPerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    _myPerformanceTableView.delegate = self;
    _myPerformanceTableView.dataSource = self;
    [self registerNibs];
    //self.bac
    
}

#pragma marks :- register cell methods

-(void)registerNibs{
    [self.myPerformanceTableView registerNib:[UINib nibWithNibName:@"MyPerformanceHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPerformanceHeaderCell"];
    [self.myPerformanceTableView registerNib:[UINib nibWithNibName:@"MyPerformanceStatsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPerformanceStatsCell"];
    [self.myPerformanceTableView registerNib:[UINib nibWithNibName:@"MyPerformanceChartVCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyPerformanceChartVCell"];
}



#pragma Mark:- Btn Action Methods

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma Mark:- UitableView Methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
           case 0:
               return 196.0;
               break;
           case 1:
               return 101.0;
               break;
           case 2:
               return 120.0;
                   break;
           case 3:
               return 120.0;
                   break;
           default:
               break;
       }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    static NSString *identifier1 = @"MyPerformanceHeaderCell";
    static NSString *identifier2 = @"MyPerformanceStatsCell";
    static NSString *identifier3 = @"MyPerformanceChartVCell";
    static NSString *identifier4 = @"MyPerformanceChartVCell";

    
    MyPerformanceHeaderCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
    MyPerformanceStatsCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
    MyPerformanceChartVCell *cell3 = [tableView dequeueReusableCellWithIdentifier:identifier3];
    MyPerformanceChartVCell *cell4 = [tableView dequeueReusableCellWithIdentifier:identifier4];

    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    cell4.selectionStyle = UITableViewCellSelectionStyleNone;

    
    switch (indexPath.row) {
        case 0:{
            cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
            UIImage * T_img =  [UIImage imageNamed:@"round-header.png"];
            T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [cell1.backgroundImgView setTintColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
            cell1.backgroundImgView.image = T_img;
            return cell1;
            break;
        }
        case 1:{
            cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
            return cell2;
            //Load data in this prototype cell
            break;
        }

        case 2:{
            cell3 = [tableView dequeueReusableCellWithIdentifier:identifier3];
                //Load data in this prototype cell
            //cell3.graphTitle.text = @"Lession Performance";
            cell3.graphTitle.text = @"Lesson Time Performance";
            return cell3;
                break;
        }
        case 3:{
            cell4 = [tableView dequeueReusableCellWithIdentifier:identifier4];
            cell3.graphTitle.text = @"Lesson Time Performance";
                //Load data in this prototype cell
            return cell4;
                break;
        }
            
        default:
            break;
    }

        return nil;
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
