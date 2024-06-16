//
//  Catlog.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 27/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Catlog.h"
#import "Assessment.h"
#import "ScenarioPracticeModule.h"
static int const kHeaderSectionTag = 6900;
@interface Catlog ()
{
    
    int  selUid;
    int  pracUid;
    int  selType;
    NSString * zipName;
    NSDictionary *jsonResponse;
    UIView * downloadView1;
    UIProgressView *pView;
    UIActionSheet *DeleteSheet;
    NSMutableArray * deleteDataArr;
    UILabel * alert;
    UIButton * canbtn;
    NSDictionary * globalResponse;
    NSDictionary * catConArr;
    NSInteger expandedSectionHeaderNumber;
    UITableViewHeaderFooterView *expandedSectionHeader;
    UILabel *Percentagelbl;
    
    UIView *bar;
    UIButton * backBtn;
     UIButton * deleteBtn;
    
}



@end

@implementation Catlog

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = APP_DELEGATE;
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    appDelegate.baseObj = self ;
    super.delegate = self;
    
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0]];
    self.navigationController.navigationBarHidden = YES;
    
    
   bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,STSTUSNAVIGATIONBARHEIGHT)];
    bar.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    [self.view addSubview:bar];
    
    UILabel * lblquiz = [[UILabel alloc]initWithFrame:CGRectMake(50,STSTUSNAVIGATIONBARHEIGHT-44,SCREEN_WIDTH-100,44)];
    lblquiz.text = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getCourseName]];
    lblquiz.font = NAVIGATIONTITLEFONT;
    lblquiz.textColor = [self getUIColorObjectFromHexString:HEADER_TEXT_COLOR alpha:1.0];
    lblquiz.textAlignment = NSTextAlignmentCenter;
    [bar addSubview:lblquiz];
    
    
    
    backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT-44,44,44)];
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, STSTUSNAVIGATIONBARHEIGHT-44,44,44)];
    [deleteBtn setImage:[UIImage imageNamed:@"Ed.png"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(clickDeleteChapter) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:deleteBtn];
    
    
    
    expandableTblView  = [[UITableView alloc]initWithFrame:CGRectMake(0, STSTUSNAVIGATIONBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    expandableTblView.delegate = self;
    expandableTblView.dataSource = self;
    expandableTblView.rowHeight = UITableViewAutomaticDimension;
    expandableTblView.estimatedRowHeight = 100;
    expandedSectionHeaderNumber = 0;
    expandableTblView.separatorStyle = UITableViewCellSeparatorStyleNone;
    expandableTblView.bounces = NO;
    [self.view addSubview:expandableTblView];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray * arr = [catConArr valueForKey:HTML_JSONKEY_COURSE];
    NSLog(@"%d",[arr count]);
    return [arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (expandedSectionHeaderNumber == section) {
        NSMutableArray *arrayOfItems = [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_SCNARRAY];
        return arrayOfItems.count;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[catConArr valueForKey:HTML_JSONKEY_COURSE] count]) {
        
        NSString * str = [[NSString alloc]initWithFormat:@"      %@",@""];
        
        
        return str;
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 44.0;
}







- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    // recast your view as a UITableViewHeaderFooterView
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.frame = CGRectMake(0,0,SCREEN_WIDTH, 44);
    header.contentView.backgroundColor = [UIColor whiteColor];
    //header.textLabel.textColor = [UIColor grayColor];
    UIImageView *viewWithTag = [self.view viewWithTag:kHeaderSectionTag + section];
    if (viewWithTag) {
        [viewWithTag removeFromSuperview];
    }
    // add the arrow image
    CGSize headerFrame = self.view.frame.size;
    
    UIImageView *theImageView = (UIImageView*)[header.contentView viewWithTag:2];
    
    if (!theImageView) {
        
        theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 50, 4, 40, 40)];
        theImageView.tag = 2;
        [header.contentView addSubview:theImageView];
        
        
        theImageView.tag = kHeaderSectionTag + section;
    }
    
    UIImageView *theIconView = (UIImageView*)[header.contentView viewWithTag:3];
    
    if (!theIconView) {
        theIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 40, 40)];
        theIconView.tag = 3;
        [header.contentView addSubview:theIconView];
        
    }
    
    
    if([[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_TYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML] )
    {
        
        theIconView.image = [UIImage imageNamed:@"assessment.png"];
        
        
    }
    else{
        theIconView.image = [UIImage imageNamed:@"topic.png"];
    }
    
    
    if([[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:@"2"] )
    {
        theImageView.image = [UIImage imageNamed:@"update.png"];
    }
    else if ([[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:@"1"])
    {
        theImageView.image = [UIImage imageNamed:@"course_new.png"];
    }
    else
    {
        if(expandedSectionHeaderNumber == section)
        {
            theImageView.image = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
            header.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [UIView animateWithDuration:0.4 animations:^{
                theImageView.transform = CGAffineTransformMakeRotation((90.0 * M_PI) / 180.0);
            }];
        }
        else
        {
            theImageView.image = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
        }
        
    }
    
    // make headers touchable
    header.tag = section;
    UITapGestureRecognizer *headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderWasTouched:)];
    [header addGestureRecognizer:headerTapGesture];
    
    
    
    UIView *seperatorView = (UIView*)[header.contentView viewWithTag:444];
    
    if (!seperatorView) {
        
        CGRect sepFrame = CGRectMake(0, header.frame.size.height-1,self.view.frame.size.width, 1);
        seperatorView = [[UIView alloc] initWithFrame:sepFrame];
        seperatorView.tag= 444;
        seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
        [header.contentView addSubview:seperatorView];
    }
    
    CGRect sepFrame1 = CGRectMake(0, 1,self.view.frame.size.width, 1);
    UIView *seperatorView1 = [[UIView alloc] initWithFrame:sepFrame1];
    seperatorView1.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
    //[header addSubview:seperatorView1];
    
    
    
    UILabel *myLabel = (UILabel*)[header.contentView viewWithTag:1];
    
    if (!myLabel) {
        
        myLabel = [[UILabel alloc] init];
        myLabel.tag = 1;
        myLabel.frame = CGRectMake(20, 12, SCREEN_WIDTH-100, 20);
        myLabel.font = HEADERSECTIONTITLEFONT;
        myLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        [header.contentView addSubview:myLabel];
    }
    
    if ([[catConArr valueForKey:HTML_JSONKEY_COURSE] count]) {
        
        myLabel.text = [[NSString alloc]initWithFormat:@"      %@",[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_NAME] ];
        
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid=@"liqvidCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSArray *section = [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY];
    
    cell.textLabel.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
    cell.textLabel.text = [[section objectAtIndex:indexPath.row] valueForKey:HTML_JSON_KEY_NAME];
    cell.textLabel.font = TEXTTITLEFONT;
    CGSize headerFrame = self.view.frame.size;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    UIImageView *theImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 40, 14, 20, 20)];
    
    UIImageView *theIconView = [[UIImageView alloc] initWithFrame:CGRectMake(headerFrame.width - 40, 4, 40, 40)];
    
    
    
    theIconView.image = [UIImage imageNamed:@"chapter.png"];
    cell.userInteractionEnabled = TRUE;
    if([[[section objectAtIndex:indexPath.row] valueForKey:@"isLock"]isEqualToString:@"1"] )
    {
        cell.userInteractionEnabled = FALSE;
        theImageView.image = [UIImage imageNamed:@"password.png"];
        
    }
    else if([[[section objectAtIndex:indexPath.row] valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:@"2"])
    {
        theImageView.image = [UIImage imageNamed:@"update.png"];
    }
    else if ([[[section objectAtIndex:indexPath.row] valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:@"1"])
    {
        theImageView.image = [UIImage imageNamed:@"course_new.png"];
    }
    else{
        theImageView.image = [UIImage imageNamed:@"Chevron-Dn-Wht.png"];
    }
    
//    if(!appDelegate.isPreRegisteredUser && indexPath.row != 0 )
//    {
//        cell.userInteractionEnabled = FALSE;
//        theImageView.image = [UIImage imageNamed:@"password.png"];
//    }
    
    
    cell.accessoryView = theImageView;
    cell.imageView.image = theIconView.image;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if([[[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:DATABASE_CATTYPE_SCENARIO] )
    {
        
        jsonResponse = [[NSDictionary alloc]initWithObjectsAndKeys:[[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_TYPE], HTML_JSON_KEY_TYPE, [[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_NAME], HTML_JSON_KEY_NAME, [[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_UID],HTML_JSON_KEY_UID, [[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_ACTION], HTML_JSON_KEY_STATUS, [[[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:indexPath.section] valueForKey:HTML_JSON_KEY_SCNARRAY]objectAtIndex:indexPath.row]valueForKey:HTML_JSON_KEY_SIZE], HTML_JSON_KEY_SIZE, nil];
        
        
        
        
        selUid = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        selType = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]];
        zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
        if(zipName != nil && [zipName isEqualToString:@""] && [SHOWCAPTERBUY isEqualToString:@"1"] )
        {
            UIAlertController *_alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"BUY" alter:@"BUY"]
                                                                            message:@"Do youwant to purchase all courses Please visit"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 NSURL *url = [NSURL URLWithString:@"https://www.facebook.com"];
                                                                 if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                                                     [[UIApplication sharedApplication] openURL:url];
                                                                 }
                                                             }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                           }];
            [_alert addAction:okAction];
            [_alert addAction:cancel];
            
            [self presentViewController:_alert animated:YES completion:nil];
            
            return ;
        }
        else if(zipName != nil && [zipName isEqualToString:@""] && [SHOWCAPTERBUY isEqualToString:@"0"])
        {
            
            
            
            
        }
        else if(zipName == nil )
        {
        }
        else
        {
            if([[jsonResponse valueForKey:HTML_JSON_KEY_STATUS] isEqualToString:UPDATEACTION])
            {
                NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
                float zip_val  = [size floatValue]/(1024.0*1024.0);
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val];
                updateAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] otherButtonTitles:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"], nil];
                [updateAlrt show];
                
            }
            else
            {
                if(![appDelegate checkZipPath:zipName])
                {
                    NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
                    float zip_val  = [size floatValue]/(1024.0*1024.0);
                    NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val];
                    
                    downloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "] otherButtonTitles:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"], nil];
                    [downloadAlrt show];
                    
                }
                else if([appDelegate checkZipPath:zipName] && [[appDelegate.engineObj getChapterDetail:selUid]count] ==0)
                {
                    
                    [self showGlobalProgress];
                    [self.view setUserInteractionEnabled:NO];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                        NSDictionary * resData = [appDelegate.engineObj getChapterDetail:appDelegate.courseCode edge_Id:[jsonResponse valueForKey:HTML_JSON_KEY_UID]];
                        if([[resData valueForKey:@"resStat"] intValue] == 1)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self hideGlobalProgress];
                                globalResponse = [resData valueForKey:@"xmlData"];
                                [appDelegate.engineObj parseChapComponent:globalResponse];
                                [appDelegate.engineObj setModuleId:[jsonResponse valueForKey:HTML_JSON_KEY_UID]];
                                [appDelegate.engineObj EncryptAndParse:zipName];
                                
                            });
                            
                            
                            
                            
                            
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self hideGlobalProgress];
                                UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Unable to download  from the server. Please check your network connection and try later."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
                                downloadView1.hidden = YES;
                                self.view.userInteractionEnabled = YES;
                                [errorAlrt show];
                            });
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    });
                    
                }
                else if([appDelegate checkZipPath:zipName] && [[appDelegate.engineObj getChapterDetail:selUid]count] > 0)
                {
                    appDelegate.chapterId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                    scnPModule.ScnEdgeId = [[jsonResponse valueForKey:HTML_JSON_KEY_UID]intValue];
                    scnPModule.ScnType = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]intValue];
                    [self.navigationController pushViewController:scnPModule animated:YES];
                    
                }
            }
        }
    }
}

- (void)updateTableViewRowDisplay:(NSArray *)arrayOfIndexPaths {
    [expandableTblView beginUpdates];
    [expandableTblView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
    [expandableTblView endUpdates];
}

#pragma mark - Expand / Collapse Methods

- (void)sectionHeaderWasTouched:(UITapGestureRecognizer *)sender {
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)sender.view;
    NSInteger section = headerView.tag;
    UIImageView *eImageView = (UIImageView *)[headerView viewWithTag:kHeaderSectionTag + section];
    expandedSectionHeader = headerView;
    
    if (expandedSectionHeaderNumber == -1) {
        expandedSectionHeaderNumber = section;
        [self tableViewExpandSection:section withImage: eImageView];
        headerView.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    } else {
        
        if (expandedSectionHeaderNumber == section) {
            [self tableViewCollapeSection:section withImage: eImageView];
            headerView.contentView.backgroundColor = [UIColor whiteColor];
            expandedSectionHeader = nil;
        } else {
            UIImageView *cImageView  = (UIImageView *)[self.view viewWithTag:kHeaderSectionTag + expandedSectionHeaderNumber];
            headerView.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [self tableViewCollapeSection:expandedSectionHeaderNumber withImage: cImageView];
            [self tableViewExpandSection:section withImage: eImageView];
        }
    }
    
    if([[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_TYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML] )
    {
        
        jsonResponse = [[NSDictionary alloc]initWithObjectsAndKeys:[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_TYPE], HTML_JSON_KEY_TYPE, [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_NAME], HTML_JSON_KEY_NAME, [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_UID],HTML_JSON_KEY_UID, [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_ACTION], HTML_JSON_KEY_STATUS,[[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_SIZE], HTML_JSON_KEY_SIZE, nil];
        
        selUid = [[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue];
        selType = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] intValue];
        NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]];
        zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
        if(zipName != nil && [zipName isEqualToString:@""] && [SHOWCAPTERBUY isEqualToString:@"1"] )
        {
            
            
            
            UIAlertController *_alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"BUY" alter:@"BUY"]
                                                                            message:[appDelegate.langObj get:@"PURCHASE_MSG" alter:@"Do you want to purchase all courses Please visit"]
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"OK" alter:@"OK"]
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 
                                                                 NSURL *url = [NSURL URLWithString:@"https://www.facebook.com"];
                                                                 if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                                                     [[UIApplication sharedApplication] openURL:url];
                                                                 }
                                                                 
                                                             }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                           }];
            [_alert addAction:okAction];
            [_alert addAction:cancel];
            
            [self presentViewController:_alert animated:YES completion:nil];
            
            return ;
        }
        
        if([[jsonResponse valueForKey:HTML_JSON_KEY_STATUS] isEqualToString:UPDATEACTION])
        {
            
            NSString * fileName = [appDelegate.engineObj getZipfileName:[[jsonResponse valueForKey:HTML_JSON_KEY_UID] intValue] :[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]];
            zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
            NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
            float zip_val  = [size floatValue]/(1024.0*1024.0);
            NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"],zip_val];
            
            updateAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"CONTENT_UPDATE" alter:@"Update."] message:[appDelegate.langObj get:@"UPDATE_MSG" alter:@"Do you want to update ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"UPDATE_NOW" alter:@"Update Now"] otherButtonTitles:[appDelegate.langObj get:@"UPDATE_LATER" alter:@"Update Later"], nil];
            [updateAlrt show];
            
        }
        else
        {
            if(![appDelegate checkZipPath:zipName])
            {

                NSString *size = [jsonResponse valueForKey:HTML_JSON_KEY_SIZE];
                float zip_val  = [size floatValue]/(1024.0*1024.0);
                NSString * msgStr = [[NSString alloc]initWithFormat:@"%@\nSize: %.2f MB",[appDelegate.langObj get:@"DOWNLOAD_MSG" alter:@"Do you want to download ?"],zip_val];
                downloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:msgStr delegate:self cancelButtonTitle:[appDelegate.langObj get:@"DOWNLOAD_NOW" alter:@"Download Now "] otherButtonTitles:[appDelegate.langObj get:@"DOWNLOAD_LATER" alter:@"Download Later"], nil];
                [downloadAlrt show];
                
            }
            else
            {
                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                assess.type = 3;
                assess.scnUid = 0;
                assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                assess.selectedLevel  = @"-1";
                
                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                [assessmentObj setValue:@"3" forKey:@"type"];
                assess.testOBj = assessmentObj;
                assess.isRemediation = FALSE;
                assess.skillObj  = NULL;
                appDelegate.AssessmentQuesAttemptCounter = -1;
                [self.navigationController pushViewController:assess animated:YES];
                
                
            }
        }
        
        
    }
    
    
}

- (void)tableViewCollapeSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_SCNARRAY];
    
    expandedSectionHeaderNumber = -1;
    if (sectionData.count == 0) {
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((0.0 * M_PI) / 90.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        [expandableTblView beginUpdates];
        [expandableTblView deleteRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [expandableTblView endUpdates];
    }
}

- (void)tableViewExpandSection:(NSInteger)section withImage:(UIImageView *)imageView {
    NSArray *sectionData = [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:section] valueForKey:HTML_JSON_KEY_SCNARRAY];
    
    if (sectionData.count == 0) {
        expandedSectionHeaderNumber = -1;
        return;
    } else {
        [UIView animateWithDuration:0.4 animations:^{
            imageView.transform = CGAffineTransformMakeRotation((90.0 * M_PI) / 180.0);
        }];
        NSMutableArray *arrayOfIndexPaths = [NSMutableArray array];
        for (int i=0; i< sectionData.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:section];
            [arrayOfIndexPaths addObject:index];
        }
        expandedSectionHeaderNumber = section;
        [expandableTblView beginUpdates];
        [expandableTblView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation: UITableViewRowAnimationFade];
        [expandableTblView endUpdates];
    }
}


-(void)gestureHandlerMethod:(UITapGestureRecognizer*)sender
{
    
    alert = [[UILabel alloc]init];
    
    [alert setFrame:CGRectMake(20, 74, self.view.frame.size.width-40, 50)];
    alert.numberOfLines =2;
    alert.backgroundColor = [UIColor grayColor];
    alert.textAlignment = NSTextAlignmentCenter;
    [alert setFont:[UIFont systemFontOfSize:10]];
    alert.textColor = [UIColor whiteColor];
    alert.layer.masksToBounds = true;
    alert.layer.cornerRadius = 8.0;
    alert.text = [appDelegate.engineObj getCourseName];
    [self.view addSubview:alert];
    
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(hideUI)
                                   userInfo:nil
                                    repeats:NO];
    
    
}


-(void)hideUI
{
    alert.hidden = TRUE;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:GETPERCENTAGENOTIFICATIONNAME
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadComplete:)
                                                 name:DOWNLOADCOMPLETENOTIFICATIONNAME
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(errorDownload:)
                                                 name:DOWNLOADERRORNOTIFICATIONNAME
                                               object:nil];
    catConArr = [appDelegate.engineObj getCatelogDataObject:appDelegate.coursePack Topic:appDelegate.topicId];
    [expandableTblView reloadData];
    
    
    
}
-(void)clickCancelBtn:(id)sender
{
    cancelDownloadAlrt = [[UIAlertView alloc]initWithTitle:[appDelegate.langObj get:@"DOWNLOAD" alter:@"Download."] message:[appDelegate.langObj get:@"DOWNLOAD_CNL_MSG" alter:@"Do you want to stop download ?"] delegate:self cancelButtonTitle:[appDelegate.langObj get:@"YES" alter:@"Yes"] otherButtonTitles:[appDelegate.langObj get:@"NO" alter:@"No"], nil];
    [cancelDownloadAlrt show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(cancelDownloadAlrt == alertView )
    {
        if (buttonIndex == 0)
        {
            
            
            [appDelegate.engineObj cancelDownload];
            [downloadView1 removeFromSuperview];
            
        }
        else if (buttonIndex == 1)
        {
            
        }
    }
    else if(downloadAlrt == alertView ||updateAlrt == alertView  ){
        
        if (buttonIndex == 0)
        {
            
//            [downloadView1 removeFromSuperview];
//            downloadView1  = [[UIView alloc] initWithFrame:self.view.frame];
//            downloadView1.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
//
//            UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),110)];
//            canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 75, downloadView.frame.size.width, 30)];
//            [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
//            [canbtn addTarget:self
//                       action:@selector(clickCancelBtn:)
//             forControlEvents:UIControlEventTouchUpInside];
//            [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
//            UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
//
//            downloadinglbl.textAlignment = NSTextAlignmentCenter;
//            downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
//            downloadView.backgroundColor = [UIColor whiteColor];
//            downloadView.layer.cornerRadius = 5;
//            downloadView.layer.masksToBounds = YES;
//            //self.view.alpha = 0.5f;
//            //self.view.userInteractionEnabled = NO;
//            pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,50,downloadView.frame.size.width-20,20)];
//            pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
//            CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//            pView.transform = transform;
//
//            Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, pView.frame.size.height+55, downloadView.frame.size.width-20, 20)];
//
//            Percentagelbl.textAlignment = NSTextAlignmentCenter;
//            Percentagelbl.text = @"0%";
//            Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
//            Percentagelbl.font = [UIFont systemFontOfSize:15];
//            [downloadView addSubview:Percentagelbl];
//
//
//            [downloadView addSubview:pView];
//            [downloadView addSubview:downloadinglbl];
//            [downloadView addSubview:canbtn];
            if(downloadView1 != NULL )
                {
                    downloadView1.hidden = TRUE;
                    [downloadView1 removeFromSuperview];
                    downloadView1 =  NULL;
                }
                downloadView1  = [[UIView alloc] initWithFrame:self.view.frame];
                downloadView1.backgroundColor =  [self getUIColorObjectFromHexString:BLACKCOLOR alpha:0.6];
                
                UIView * downloadView  = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/10),(self.view.frame.size.height/2) -30,self.view.frame.size.width -(self.view.frame.size.width/5),180)];
                
                canbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, downloadView.frame.size.height-40, downloadView.frame.size.width, 30)];
                [canbtn setTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] forState:UIControlStateNormal];
                [canbtn addTarget:self
                           action:@selector(clickCancelBtn:)
                 forControlEvents:UIControlEventTouchUpInside];
                [canbtn setTitleColor:[self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0] forState:UIControlStateNormal];
                UILabel * downloadinglbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, downloadView.frame.size.width, 20)];
                downloadinglbl.textAlignment = NSTextAlignmentCenter;
                downloadinglbl.textColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
                downloadinglbl.text = @"Downloading...";
                [downloadView addSubview:downloadinglbl];
                
                UILabel * pleasewaitlbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, downloadView.frame.size.width, 20)];
                pleasewaitlbl.textAlignment = NSTextAlignmentCenter;
                pleasewaitlbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                pleasewaitlbl.text = @"Please wait.";
                [downloadView addSubview:pleasewaitlbl];
                
                downloadView.backgroundColor = [UIColor whiteColor];
                downloadView.layer.cornerRadius = 5;
                downloadView.layer.masksToBounds = YES;
                
                
                
                Percentagelbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, downloadView.frame.size.width-20, 35)];
                Percentagelbl.textAlignment = NSTextAlignmentCenter;
                Percentagelbl.text = @"0%";
                Percentagelbl.textColor = [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
                Percentagelbl.font = [UIFont systemFontOfSize:30];
                [downloadView addSubview:Percentagelbl];
                
                
                pView = [[UIProgressView alloc]initWithFrame:CGRectMake(10,120,downloadView.frame.size.width-20,10)];
                pView .trackTintColor = [self getUIColorObjectFromHexString:BACKGROUND_COLOR alpha:1.0];
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                pView.transform = transform;
                [downloadView addSubview:pView];
               
               [downloadView addSubview:canbtn];
            [downloadView1 addSubview:downloadView];
            [self.view addSubview:downloadView1];
            
            
            
            NSDictionary * resData = [appDelegate.engineObj getChapterDetail:appDelegate.courseCode edge_Id:[jsonResponse valueForKey:HTML_JSON_KEY_UID]];
            if([[resData valueForKey:@"resStat"] intValue] == 1)
            {
                globalResponse = [resData valueForKey:@"xmlData"];
//                if(downloadAlrt == alertView)
//                {
//                    downloadinglbl.text = [appDelegate.langObj get:@"DLOAD_CHAP_MSG" alter:@"Downloading..."];
//                }
//                else{
//
//                    downloadinglbl.text = [appDelegate.langObj get:@"DLOAD_CHAP_MSG" alter:@"Downloading. Please wait…"];
//
//                }
                
                [appDelegate.engineObj downloadZipFileAndParseData:zipName uID:[jsonResponse valueForKey:HTML_JSON_KEY_UID] ];
            }
            else
            {
                UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Unable to download  from the server. Please check your network connection and try later."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
                downloadView1.hidden = YES;
                self.view.userInteractionEnabled = YES;
                [errorAlrt show];
            }
        }
        else if (buttonIndex == 1)
        {
           if(![appDelegate checkZipPath:zipName])
            {
                
                
            }
            else
            {
                if([[jsonResponse valueForKey:HTML_JSON_KEY_TYPE] isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
                {
                    Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                    assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                    assess.type = 3;
                    assess.scnUid = 0;
                    assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                    assess.selectedLevel  = @"-1";
                    
                    NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                    [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                    [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                    [assessmentObj setValue:@"3" forKey:@"type"];
                    assess.testOBj = assessmentObj;
                    assess.isRemediation = FALSE;
                    assess.skillObj  = NULL;
                    appDelegate.AssessmentQuesAttemptCounter = -1;
                    [self.navigationController pushViewController:assess animated:YES];
                }
                else
                {
                    appDelegate.chapterId = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                    ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                    scnPModule.ScnEdgeId = [[jsonResponse valueForKey:HTML_JSON_KEY_UID]intValue];
                    scnPModule.ScnType = [[jsonResponse valueForKey:HTML_JSON_KEY_TYPE]intValue];
                    [self.navigationController pushViewController:scnPModule animated:YES];
                    
                }
                
            }
            
            
            
        }
        
    }
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:GETPERCENTAGENOTIFICATIONNAME])
    {
        
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo objectForKey:SOMEKEY];
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        pView.progress =val;
        pView .progressTintColor = [self getUIColorObjectFromHexString:PROGRESS_BAR_COLOR alpha:1.0];
        
        
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        if([myObject integerValue] >= 100)
        {
            downloadView1.hidden = YES;
            self.view.userInteractionEnabled = YES;
            [appDelegate.engineObj updateComponant:[[NSString alloc]initWithFormat:@"%i",selUid]];
            
            if(selType == [DATABASE_CATTYPE_ASSISMENT_XML integerValue])
            {
                Assessment * assess = [[Assessment alloc]initWithNibName:@"Assessment" bundle:nil];
                assess.assessnetUid = [jsonResponse valueForKey:HTML_JSON_KEY_UID];
                assess.cusTitleName = [jsonResponse valueForKey:HTML_JSON_KEY_NAME];
                assess.type = 3;
                assess.scnUid = 0;
                assess.selectedLevel  = @"-1";
                
                NSMutableDictionary * assessmentObj = [[NSMutableDictionary alloc]init];
                [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_UID] forKey:@"uid"];
                [assessmentObj setValue:[jsonResponse valueForKey:HTML_JSON_KEY_NAME] forKey:@"name"];
                [assessmentObj setValue:@"3" forKey:@"type"];
                assess.testOBj = assessmentObj;
                assess.isRemediation = FALSE;
                assess.skillObj  = NULL;
                appDelegate.AssessmentQuesAttemptCounter = -1;
                [self.navigationController pushViewController:assess animated:YES];
            }
            else
            {
                appDelegate.chapterId = [[NSString alloc]initWithFormat:@"%d",selUid];
                ScenarioPracticeModule * scnPModule = [[ScenarioPracticeModule alloc]initWithNibName:@"ScenarioPracticeModule" bundle:nil];
                scnPModule.ScnEdgeId = selUid;
                scnPModule.ScnType = selType;
                [self.navigationController pushViewController:scnPModule animated:YES];
            }
            
        }
        else if([myObject integerValue] >= 70)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        
    }
    
}

- (void) downloadComplete:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADCOMPLETENOTIFICATIONNAME])
    {
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        if([myObject integerValue] >= 100)
        {
            downloadView1.hidden = YES;
            self.view.userInteractionEnabled = YES;
        }
        else if([myObject integerValue] >= 85)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        [appDelegate.engineObj deleteScenario:[jsonResponse valueForKey:HTML_JSON_KEY_UID] deleteDirectory:YES deleteZip:NO];
        [appDelegate.engineObj parseChapComponent:globalResponse];
        [appDelegate.engineObj EncryptAndParse:(NSString *)[userInfo valueForKey:FILENAME]];
    }
    
    
    
}


- (void) errorDownload:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:DOWNLOADERRORNOTIFICATIONNAME])
    {
        //progress = 0;
        NSDictionary *userInfo = notification.userInfo;
        NSString *myObject = [userInfo valueForKey:SOMEKEY];
        
        //NSLog(@"%@",myObject);
        float full = 100.00;
        
        float val =  [myObject floatValue]/full;
        Percentagelbl.text = [[NSString alloc]initWithFormat:@"%d%%",(int)(val*100)/1];
        UIAlertView *errorAlrt = [[UIAlertView alloc]initWithTitle:@"" message:[appDelegate.langObj get:@"NW_EMSG" alter:@"Please check your network connection."] delegate:nil cancelButtonTitle:[appDelegate.langObj get:@"OK" alter:@"Ok"] otherButtonTitles:nil, nil];
        downloadView1.hidden = YES;
        self.view.userInteractionEnabled = YES;
        [errorAlrt show];
        if([myObject integerValue] >= 100)
        {
        }
        else if([myObject integerValue] >= 70)
        {
            canbtn.hidden = TRUE;
            [cancelDownloadAlrt dismissWithClickedButtonIndex:1 animated:YES];
        }
        
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clickBack
{
    
    int completionFlag=0;
    int counter = 0;
    int totalCount = 0;
    if([appDelegate.topicId integerValue] > 0)
    {
        NSMutableArray *arrayOfItems = [[[catConArr valueForKey:HTML_JSONKEY_COURSE] objectAtIndex:0] valueForKey:HTML_JSON_KEY_SCNARRAY];
        
        for (NSDictionary * obj  in arrayOfItems)
        {
            if([[obj valueForKey:DATABASE_SCENARIO_IS_HIDE]integerValue] == 1) continue;
            totalCount ++ ;
            if([[obj valueForKey:@"isComp"]integerValue] == -1)
            {
               
            }
            else if([[obj valueForKey:@"isComp"]integerValue] == 0)
            {
                completionFlag=1;
                break;
            }
            else
            {
                counter++;
            }
                
        }
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
        [data setValue:appDelegate.topicId forKey:NATIVE_JSON_KEY_MODULEID];
        [data setValue:[[NSString alloc]initWithFormat:@"%@",appDelegate.topicId] forKey:NATIVE_JSON_KEY_SCNID];
        [data setValue:[[NSString alloc] initWithFormat:@"%@",appDelegate.topicId] forKey:NATIVE_JSON_KEY_EDGEID];
        [data setValue:[[NSString alloc]initWithFormat:@"%@",@"4"] forKey:NATIVE_JSON_KEY_TYPE];
        [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
        [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
        [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
        [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
        [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
        if(completionFlag == 1)
        {
             [data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if(completionFlag == 0 && counter == 0 && totalCount > 0)
        {
            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else if (completionFlag == 0 && totalCount > 0 && counter == totalCount)
        {
            [data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        else
        {
            [data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
        }
        [appDelegate.engineObj setTracktableData:data];
        [self baseClass_syncTrackBasedOnEdgeId:[data valueForKey:NATIVE_JSON_KEY_EDGEID]];
     
    }
    
    
    
    [self.navigationController popViewControllerAnimated:TRUE];    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)clickDeleteChapter
{
    
    //  [self.navigationController popViewControllerAnimated:TRUE];
    deleteDataArr = [[NSMutableArray alloc]init];
    DeleteSheet = [[UIActionSheet alloc]
                   initWithTitle:[appDelegate.langObj get:@"CHAP_DEL_CONT_TEXT" alter:@"Select a chapter to delete the content."]
                   delegate:self
                   cancelButtonTitle:nil
                   destructiveButtonTitle:nil
                   otherButtonTitles:nil];
    
    // Add buttons one by one (e.g. in a loop from array etc...)
    BOOL downloadState = FALSE;
    NSMutableDictionary * CatDict = [appDelegate.engineObj getScenarioList:appDelegate.coursePack Topic:appDelegate.topicId];
    for (NSDictionary *obj  in [CatDict valueForKey:@"course"]) {
        for (NSDictionary * Lobj  in [obj valueForKey:@"scnArray"]) {
            
            
            NSString * zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[Lobj valueForKey:HTML_JSON_KEY_UID] intValue] :[Lobj valueForKey:HTML_JSON_KEY_TYPE]]];
            if([appDelegate checkZipPath:zipName])
            {
                downloadState = TRUE;
                [DeleteSheet addButtonWithTitle:[Lobj valueForKey:HTML_JSON_KEY_NAME]];
                [deleteDataArr addObject:Lobj];
            }
            
//            NSFileManager *fileManager = [[NSFileManager alloc] init];
//
//            NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//            NSString *documentsDirectoryPath = [documentPaths objectAtIndex:0];
//            if([[Lobj valueForKey:DATABASE_SCENARIO_ZIPURL] isEqualToString:@""])
//            {
//                continue;
//            }
//            NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[Lobj valueForKey:DATABASE_SCENARIO_DATA]];
//
//            BOOL fileExists = [fileManager fileExistsAtPath:path];
//
//            if (fileExists)
//            {
//
//
//            }
        }
    }
    
    if(!downloadState)
    {
        DeleteSheet.title = [appDelegate.langObj get:@"CHAP_DEL_NO_TEXT" alter:@"Currently there are no chapters to be deleted."];
    }
    
    [DeleteSheet addButtonWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]];
    // Set cancel button index to the one we just added so that we know which one it is in delegate call
    // NB - This also causes this button to be shown with a black background
    DeleteSheet.cancelButtonIndex = DeleteSheet.numberOfButtons-1;
    
    [DeleteSheet showInView:self.view];
    
    
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"]])
    {
        return;
    }
    else
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertController* _alert = [UIAlertController alertControllerWithTitle:[appDelegate.langObj get:@"CHAP_DEL_TITLE" alter:@"Delete Content"]
                                         
                                         
                                                                            message:[appDelegate.langObj get:@"CHAP_DEL_CON_MSG" alter:@"Do you want to delete content of this Chapter?"]
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"NO" alter:@"NO"] style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      
                                                                  }];
            
            [_alert addAction:defaultAction];
            
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"YES" alter:@"YES"] style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       [appDelegate.engineObj deleteScenario:[[deleteDataArr objectAtIndex:buttonIndex]valueForKey:HTML_JSON_KEY_UID] deleteDirectory:YES deleteZip:YES];
                                                                       
                                                                   }];
            
            [_alert addAction:defaultAction1];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                [self presentViewController:_alert animated:YES completion:nil];
            }
            else
            {
                [_alert setModalPresentationStyle:UIModalPresentationPopover];
                
                UIPopoverPresentationController *popPresenter = [_alert
                                                                 popoverPresentationController];
                popPresenter.sourceView = self.view;
                popPresenter.sourceRect = self.view.bounds;
                [self presentViewController:_alert animated:YES completion:nil];
            }
            
            
        });
        
    }
    
}



@end




