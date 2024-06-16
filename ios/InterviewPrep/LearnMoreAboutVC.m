//
//  LearnMoreAboutVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "LearnMoreAboutVC.h"
#import "PdfViewerVC.h"

@interface LearnMoreAboutVC ()

@end

@implementation LearnMoreAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = @[@"What is PTE General",@"Who takes PTE General",@"Test Structure",@"Test Content",@"Skills Tested",@"Scoring"];
    self.fileURLArray = @[WHATIS,WHOTAKES,TESTSTRUCTURE,TESTSCONTENT,SKILLSTESTED,SCORING];
    
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerNibs];
    
    // Do any additional setup after loading the view.
}



-(void)registerNibs{
    [self.tableView registerNib:[UINib nibWithNibName:@"LearnMoreTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LearnMoreTableViewCell"];
}

- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LearnMoreTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    PdfViewerVC *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"PdfViewerVC"];
    vc.pdfFileURL = [self.fileURLArray objectAtIndex:indexPath.row];
    vc.headerText = [self.listArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
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
