//
//  PTEGeneralDashboardVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 13/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PTEGeneralDashboardVC.h"
#import "DashboardOptionsTableViewCell.h"
#import "PdfViewerVC.h"
#import "SummeryPteVC.h"
#import "MyAccountScreen.h"
#import "PTEG_CourseView.h"
#import "PTEG_LevelSelection.h"


@interface PTEGeneralDashboardVC (){
    UIButton * sideMenuBtn;
    NSString *imgName;

}
@property NSDictionary * global_userInfo;

@end

@implementation PTEGeneralDashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    appDelegate = APP_DELEGATE;
    [self.roundedView.layer setCornerRadius:30.0];
    self.roundedView.clipsToBounds = true;
    
    self.profileImageBtn.layer.cornerRadius = 80/2.0f;
    self.profileImageBtn.layer.borderColor=[UIColor redColor].CGColor;
    //Adding side menu btn
    sideMenuBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 30, 30)];
    UIImage* T_img =  [UIImage imageNamed:@"MePro_MEA.png"];
    T_img = [T_img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [sideMenuBtn setTintColor:[self getUIColorObjectFromHexString:@"#ffffff" alpha:1.0]];
    [sideMenuBtn setImage:T_img forState:UIControlStateNormal];
    [sideMenuBtn addTarget:self action:@selector(showPTEGeneralDrawer) forControlEvents:UIControlEventTouchUpInside];
    [sideMenuBtn bringSubviewToFront:self.view];
    [self.view addSubview:sideMenuBtn];
    sideMenuBtn.hidden =  FALSE;
    self.nameLbl.text = [[appDelegate getFirstName] uppercaseString];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerNibs];
}


-(void)viewWillAppear:(BOOL)animated{
    
    


   
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",IMAGEPATH,[appDelegate.global_userInfo valueForKey:DATABASE_PROFILEPIC]];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                
                [self.profileImageBtn setImage:_img forState:UIControlStateNormal];
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
               // userImg.image = _img;
            }
            
        }];
    }
    else
    {
        [self.profileImageBtn setImage:Limg forState:UIControlStateNormal];
    }

    
    
    
    
    [self.profileImageBtn.layer setCornerRadius:80.0/2];
    self.profileImageBtn.clipsToBounds = true;

}


#pragma marks :- register cell methods

-(void)registerNibs{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DashboardOptionsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DashboardOptionsTableViewCell"];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    static NSString *identifier = @"DashboardOptionsTableViewCell";
    DashboardOptionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell.practiceBtn addTarget:self action:@selector(practiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.learnMoreBtn addTarget:self action:@selector(learnMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chatBtn addTarget:self action:@selector(chatWithPalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.tipsBtn addTarget:self action:@selector(tipsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.resourcesBtn addTarget:self action:@selector(resourceClick:) forControlEvents:UIControlEventTouchUpInside];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;



    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
}

- (IBAction)profileBtnAction:(id)sender {
    MyAccountScreen * accObj = [[MyAccountScreen alloc]initWithNibName:@"MyAccountScreen" bundle:nil];
    accObj.title = [appDelegate.langObj get:@"MENU_AC" alter:@"My Account"] ;
    [self.navigationController pushViewController:accObj animated:YES];
}


-(void)practiceBtnClick:(UIButton *)sender{
    NSString *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_selected_level"];
    if(level != nil){
       PTEG_CourseView *pteg_courseObj = [[PTEG_CourseView alloc]initWithNibName:@"PTEG_CourseView" bundle:nil];
        pteg_courseObj.level = level;
        pteg_courseObj.licence_key = APP_LICENCE_KEY_PTEGENERAL;
        pteg_courseObj.title_Name = level;
         [self.navigationController pushViewController:pteg_courseObj animated:true];
    
    }else{
        PTEG_LevelSelection *pteg_courseObj = [[PTEG_LevelSelection alloc]initWithNibName:@"PTEG_LevelSelection" bundle:nil];
         [self.navigationController pushViewController:pteg_courseObj animated:true];
        

    }
}
    

-(void)learnMoreBtnClick:(UIButton *)sender{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    UIViewController *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"LearnMoreAboutVC"];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)chatWithPalBtnClick:(UIButton *)sender{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    UIViewController *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"ChatWithPalVC"];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)tipsBtnClick:(UIButton *)sender{
    UIStoryboard *pteGeneral = [UIStoryboard storyboardWithName:@"PTEGeneral" bundle:nil];
    PdfViewerVC *vc = [pteGeneral instantiateViewControllerWithIdentifier:@"PdfViewerVC"];
    vc.pdfFileURL = TESTSTIPS;
    vc.headerText = @"Tips & Tricks";
    [self.navigationController pushViewController:vc animated:true];
}


-(void)resourceClick:(UIButton *)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://qualifications.pearson.com/en/qualifications/pearson-test-of-english/pearson-test-of-english-general/resources.html"]];
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
