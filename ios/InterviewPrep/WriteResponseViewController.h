//
//  Assignment1ViewController.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseViewController.h"
#import "UploadBtnTableViewCell.h"
#import "AssignmentDetailTableViewCell.h"
#import "AssigmentResponseTableViewCell.h"


NS_ASSUME_NONNULL_BEGIN


@interface WriteResponseViewController : baseViewController<UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate,UITextViewDelegate,UploadaAndDownloadDelegate,DownloadBtnDelegate,GetResponseTextDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
}


@property (weak, nonatomic) IBOutlet UITableView *assignment1TableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) NSDictionary *assignmentDictionary;
@property (strong, nonatomic) NSString *responseString;
@property (strong, nonatomic) NSString *countString;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSData *fileData;





@end


NS_ASSUME_NONNULL_END
