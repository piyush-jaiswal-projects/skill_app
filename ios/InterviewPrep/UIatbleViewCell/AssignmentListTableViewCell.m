//
//  AssignmentListTableViewCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 08/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "AssignmentListTableViewCell.h"
#import "AssignmentTableViewCell.h"




@implementation AssignmentListTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.arrowImgView.image = [_arrowImgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadTableView:(NSMutableArray *)assignmentArray{
    self.assignmentsArray = assignmentArray;
    [self.asssignmentTableView registerNib:[UINib nibWithNibName:@"AssignmentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AssignmentTableViewCell"];
    self.asssignmentTableView.delegate = self;
    self.asssignmentTableView.dataSource = self;
    self.asssignmentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.asssignmentTableView reloadData];
    
}


-(NSAttributedString *)getScore:(NSString *)gotScore totalScore:(NSString *)totalScore gotScoreFont:(UIFont *)gotScoreFont totalScoreFont:(UIFont *)totalScoreFont gotScoreColor:(UIColor *)gotScoreColor totalScoreColor:(UIColor *)totalScoreColor{
    NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",gotScore,totalScore]];
    return attributedStr;

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assignmentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssignmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssignmentTableViewCell"];
    NSDictionary *dict = [self.assignmentsArray objectAtIndex:indexPath.row];
    cell.nameLbl.text = dict[@"assignment_name"];
    cell.nameLbl.font = HEADERSECTIONTITLEFONT;
    [cell configureCell:dict];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *selectedDict = [self.assignmentsArray objectAtIndex:indexPath.row];
    [_delegate navigateToAssignmentDetail:selectedDict];
}



@end
