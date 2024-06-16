//
//  Assignment1ViewController.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "WriteResponseViewController.h"
#import "AssigmentResponseTableViewCell.h"
#import "SubmitBtnTableViewCell.h"
#import "DownloadedFileViewController.h"

@interface WriteResponseViewController ()
{
    UploadBtnTableViewCell *uploadBtnTableViewCell;
}

@end

@implementation WriteResponseViewController
@synthesize assignmentDictionary,delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate =  APP_DELEGATE;
    // Do any additional setup after loading the view.
    self.responseString = [[NSString alloc]init];
    self.view.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
    _assignment1TableView.delegate = self;
    _assignment1TableView.dataSource = self;
    _assignment1TableView.estimatedRowHeight = 120;
    self.fileName = @"";
    self.fileData = nil;
    [self registerNibs];
    NSLog(@"%@",self.assignmentDictionary);
    
}

#pragma marks :- register cell methods

-(void)registerNibs{
    [self.assignment1TableView registerNib:[UINib nibWithNibName:@"AssignmentDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AssignmentDetailTableViewCell"];
    [self.assignment1TableView registerNib:[UINib nibWithNibName:@"AssigmentResponseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AssigmentResponseTableViewCell"];
    [self.assignment1TableView registerNib:[UINib nibWithNibName:@"UploadBtnTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"UploadBtnTableViewCell"];
    [self.assignment1TableView registerNib:[UINib nibWithNibName:@"SubmitBtnTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SubmitBtnTableViewCell"];
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
            if(assignmentDictionary[@"assignment_desc"] != nil){
                NSString* newString = [assignmentDictionary[@"assignment_desc"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
                NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
                NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
                NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
                NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
                
                NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
                
                
                
                
                NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",16.0,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
                
                
                
                
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:TEXTTITLEFONT}
                                                        documentAttributes: nil
                                                        error: nil
                                                        ];
                
                CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(tableView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
                return rect.size.height+(brCounter.count*20);
                
                
               
            }
            else
            {
            return 118.0;
            }
            break;
        case 1:
            return 272.0;
            break;
        case 2:
            return 110.0;
            break;
        case 3:
            if([self.assignmentDictionary[@"teacher_evaluated"] isEqualToString:@"no"]){
                return 64.0;
                
            }else{
                return 118.0;
            }
            break;
        case 4:
            return 64.0;
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.assignmentDictionary[@"teacher_evaluated"] isEqualToString:@"no"]){
        return 4;
    }else{
        return 5;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"AssignmentDetailTableViewCell";
    static NSString *identifier1 = @"AssigmentResponseTableViewCell";
    static NSString *identifier2 = @"UploadBtnTableViewCell";
    static NSString *identifier3 = @"SubmitBtnTableViewCell";
    
    
    AssignmentDetailTableViewCell *assignmentDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    AssigmentResponseTableViewCell *assigmentResponseTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if(uploadBtnTableViewCell == NULL)
      uploadBtnTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    SubmitBtnTableViewCell *submitBtnTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier3];
    
    assignmentDetailTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    assigmentResponseTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    uploadBtnTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    submitBtnTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    switch (indexPath.row) {
        case 0:
            
            assignmentDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [assignmentDetailTableViewCell configureCell:self.assignmentDictionary];
            assignmentDetailTableViewCell.delegate = self;
            return assignmentDetailTableViewCell;
            //Load data in this prototype cell
            break;
        case 1:
            assigmentResponseTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            assigmentResponseTableViewCell.delegate = self;
            [assigmentResponseTableViewCell configureCell:self.assignmentDictionary];
            return assigmentResponseTableViewCell;
            //Load data in this prototype cell
            break;
        case 2:
            uploadBtnTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            [uploadBtnTableViewCell configureCell:self.assignmentDictionary];
            uploadBtnTableViewCell.delegate = self;
            //Load data in this prototype cell
            return uploadBtnTableViewCell;
            break;
            
        case 3:
            if([self.assignmentDictionary[@"teacher_evaluated"] isEqualToString:@"no"]){
                submitBtnTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier3];
                [submitBtnTableViewCell.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                return submitBtnTableViewCell;
            }else{
                assignmentDetailTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
                [assignmentDetailTableViewCell configureForFeedBack:self.assignmentDictionary];
                return assignmentDetailTableViewCell;
            }
            break;
        case 4:
            submitBtnTableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            [submitBtnTableViewCell configureCell:self.assignmentDictionary];
            [submitBtnTableViewCell.submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            return submitBtnTableViewCell;
            break;
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



#pragma mark:- UIDocument Picker Delegates

-(void)openDocumentPicker
{
    
    UIAlertController* alertController = [UIAlertController
    alertControllerWithTitle:@""
    message:@"Upload file from"
    preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* item = [UIAlertAction actionWithTitle:@"Document Gallery"
       style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
        
        UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"] inMode:UIDocumentPickerModeImport];
        
        documentPicker.delegate = self;
        documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:documentPicker animated:YES completion:nil];
    }];
    
    [alertController addAction:item];
    UIAlertAction* item1 = [UIAlertAction actionWithTitle:@"Photo Gallery"
       style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction *action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }];
    
    
    [alertController addAction:item1];
    
//    UIAlertAction* item2 = [UIAlertAction actionWithTitle:@"Camera"
//       style:UIAlertActionStyleDefault
//                                                 handler:^(UIAlertAction *action) {
//            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//            picker.delegate = self;
//            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//            picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
//            picker.allowsEditing = NO;
//            //picker.cameraViewTransform = CGAffineTransformIdentity;
//            [self presentViewController:picker animated:YES completion:NULL];
//    }];
//
//
//    [alertController addAction:item2];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:[appDelegate.langObj get:@"CANCEL" alter:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];

    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    if (controller.documentPickerMode == UIDocumentPickerModeImport)
    {
        NSString *urlString = url.absoluteString;
        self.fileName = [urlString lastPathComponent];
        self.fileData = [NSData dataWithContentsOfURL:url];
        uploadBtnTableViewCell.filename.text = url.lastPathComponent;
        //uploadBtnTableViewCell.filename.numberOfLines = 0;
        
        //uploadBtnTableViewCell.filename.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
        
    }
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//          UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
//          NSData *imageData = UIImagePNGRepresentation(chosenImage);
//          self.fileName = @"savedImage.png";
//          self.fileData = imageData;
//
//
//    }
//    else
//    {
        NSURL *urlString = info[UIImagePickerControllerImageURL];
        self.fileName = [urlString lastPathComponent];
        self.fileData = [NSData dataWithContentsOfURL:urlString];
    uploadBtnTableViewCell.filename.text = urlString.lastPathComponent;
   // }
    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    self.fileName = @"";
    self.fileData = nil;
    
}





#pragma mark:- Upload assignment method

-(void)uploadAssignment:(NSData*)fileData fileType:(NSString *)fileType{
    
    NSString *submitTxt  = [self.responseString stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(fileData != NULL && ([fileType isEqualToString:@""] || fileType == nil || fileType == NULL)){
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Failure"
                                              message:@"File extension is not valid"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(submitTxt == NULL || [submitTxt isEqualToString:@""] ){
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@""
                                              message:@"Please write your response"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else
    {
        [self showGlobalProgress];
       dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
           
         [appDelegate.engineObj.networkObj sendRequestToUploadAssesment:ADURO_ASSIGNMENT_URL data:fileData method:@"POST" location:[appDelegate.global_userInfo valueForKey:DATABASE_USERID] token:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] fileType:fileType fileName:@"doc" assignmentId:[NSString stringWithFormat:@"%@",self.assignmentDictionary[@"assignment_id"]] assignmentResponse:submitTxt success:^{
             [self hideGlobalProgress];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Success"
                                                  message:@"Submitted successfully!"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:true];
                
            }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
       });
    } failure:^{
        [self hideGlobalProgress];
      dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Failure"
                                                  message:@"Something went worng"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
    });
    }];
        });
    }
    
}




-(void)submitBtnAction:(UIButton*)sender{
    if([self.assignmentDictionary[@"teacher_evaluated"] isEqualToString:@"no"]){
        //[self showGlobalProgress];
        [self uploadAssignment:self.fileData fileType:[_fileName pathExtension]]; // upload file request
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }

}





#pragma mark:- upload btn Delegate methodsn

- (void)uploadAndDownloadAssesment {
    if([self.assignmentDictionary[@"teacher_evaluated"] isEqualToString:@"no"]){
        [self openDocumentPicker];
    }else{
        
        
    }
   // [self openDocumentPicker];
}


- (void)downloadBtnClick {
    
    UIStoryboard *willeySB = [UIStoryboard storyboardWithName:@"Wiley" bundle:nil];
    DownloadedFileViewController *vc = [willeySB instantiateViewControllerWithIdentifier:@"DownloadedFileViewController"];
    vc.fileUrl = self.assignmentDictionary[@"assignment_file"];
      [self.navigationController pushViewController:vc animated:true];
}


- (void)getResponseText:(nonnull NSString *)response {
    self.responseString = response;
}

@end
