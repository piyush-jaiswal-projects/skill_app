//
//  LevelViewController.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelsTableViewCell.h"
#import "PTEG_CourseView.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.levelArray = [[NSArray alloc]initWithObjects:@"Level A1",@"Level 1",@"Level 2",@"Level 3",@"Level 4",@"Level 5", nil];
    self.levelTitleArray = [[NSArray alloc]initWithObjects:@"A1 Begninner",@"1 Elementary",@"2 Intermediate",@"3 Upper Intermediate",@"4 Advanced",@"5 Proficiency", nil];

    self.isSelected = false;
    self.selectedIndex = -1;
    
    [self.roundedView.layer setCornerRadius:30.0];
    self.roundedView.clipsToBounds = true;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerNibs];
    // Do any additional setup after loading the view.
}


#pragma mark- register cell methods

-(void)registerNibs{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LevelsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LevelsTableViewCell"];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.levelTitleArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *footerV = (UITableViewHeaderFooterView *)view;
    footerV.contentView.backgroundColor = [UIColor whiteColor];
    UIButton *continueBtn = [[UIButton alloc]initWithFrame:CGRectMake(20.0, 10.0, self.tableView.frame.size.width-40.0, 40.0)];
    [continueBtn setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    [continueBtn.layer setCornerRadius:20.0];
    [continueBtn setTitle:@"Continue" forState:UIControlStateNormal];
    [continueBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0]];
    [footerV addSubview:continueBtn];
    [continueBtn addTarget:self action:@selector(continueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    static NSString *identifier = @"LevelsTableViewCell";
    LevelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLbl.text = [_levelTitleArray objectAtIndex:indexPath.row];
    if(self.isSelected && self.selectedIndex == (int)indexPath.row){
        [cell.circleImage setImage:[UIImage imageNamed:@"selected-circle"]];
        [cell.pointerImage setImage:[UIImage imageNamed:@"pointer"]];
        cell.colorLbl.backgroundColor = [UIColor lightGrayColor];
        [cell.textLbl setFont:[UIFont boldSystemFontOfSize:17.0]];
        [cell.circleImage setAutoresizingMask:false];
        cell.circleImgHgtConstraints.constant = 30.0;
        cell.circleImgWdhConstraints.constant = 30.0;
    }else{
        if(_selectedIndex > indexPath.row && _selectedIndex != -1){
            [cell.circleImage setImage:[UIImage imageNamed:@"selected-circle"]];
            [cell.pointerImage setImage:[UIImage imageNamed:@""]];
            cell.colorLbl.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
            [cell.textLbl setFont:[UIFont systemFontOfSize:12.0]];
            cell.circleImgHgtConstraints.constant = 20.0;
            cell.circleImgWdhConstraints.constant = 20.0;
        }else{
            if(indexPath.row ==0){
                [cell.circleImage setImage:[UIImage imageNamed:@"selected-circle"]];
                [cell.pointerImage setImage:[UIImage imageNamed:@"pointer"]];
                [cell.textLbl setFont:[UIFont boldSystemFontOfSize:17.0]];
                [cell.circleImage setAutoresizingMask:false];
                cell.circleImgHgtConstraints.constant = 30.0;
                cell.circleImgWdhConstraints.constant = 30.0;
            }else{
            cell.circleImgHgtConstraints.constant = 20.0;
            cell.circleImgWdhConstraints.constant = 20.0;
            [cell.circleImage setImage:[UIImage imageNamed:@"white-cricle"]];
            [cell.pointerImage setImage:[UIImage imageNamed:@""]];
            cell.colorLbl.backgroundColor = [UIColor lightGrayColor];
            [cell.textLbl setFont:[UIFont systemFontOfSize:12.0]];

            }
        }
    }
    if(indexPath.row == 5){
        cell.colorLbl.hidden = true;
    }else{
        cell.colorLbl.hidden = false;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSUserDefaults standardUserDefaults] setValue:[self.levelArray objectAtIndex:indexPath.row] forKey:@"user_selected_level"];
    self.isSelected = true;
    self.selectedIndex = (int)indexPath.row;
    [self.tableView reloadData];
}


#pragma mark - Btn Click method

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(IBAction)continueBtnClick:(UIButton *)sender {
    //NSMutableDictionary * dicObj = [[NSMutableDictionary alloc]init];
    NSString *slelctedLevel = [[NSString alloc]init];
    if(_selectedIndex == -1)
    {
        slelctedLevel = [_levelArray objectAtIndex:0];
    }else
    {
        slelctedLevel = [_levelArray objectAtIndex:_selectedIndex];
    }
//    [dicObj setValue:APP_LICENCE_KEY_PTEGENERAL forKey:@"licence"];
//    [dicObj setValue:slelctedLevel forKey:@"Title"];
//    [dicObj setValue:slelctedLevel forKey:@"level"];
//    [appDelegate gotoNextController:self controllerType:enum_courseCodeController sendingObj:dicObj];
    
    
    PTEG_CourseView *pteg_courseObj = [[PTEG_CourseView alloc]initWithNibName:@"PTEG_CourseView" bundle:nil];
    pteg_courseObj.level = slelctedLevel;
    pteg_courseObj.licence_key = APP_LICENCE_KEY_PTEGENERAL;
    pteg_courseObj.title_Name = slelctedLevel;
    [self.navigationController pushViewController:pteg_courseObj animated:true];
    

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
