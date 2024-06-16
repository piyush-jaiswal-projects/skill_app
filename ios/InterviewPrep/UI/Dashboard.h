//
//  Dashboard.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 15/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//


//
#import "baseViewController.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>




@interface Dashboard : baseViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIDocumentInteractionControllerDelegate,MFMailComposeViewControllerDelegate,UIPopoverControllerDelegate,UIAlertViewDelegate,baseViewControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDataSourcePrefetching>
{
    
    @private
        IBOutlet UILabel * CurrentSeesion;
        IBOutlet UILabel * CurrentSeesionText;
        NSDictionary * currentSeesion;
        UIActionSheet *actionSheetshare;
        UIActionSheet *actionSheetphoto;
        UIAlertView * downloadAlrt;
        UIAlertView *updateAlrt;
    
}
@property (nonatomic, strong) UIPopoverController *popOver;
//@property NSString * topicId;
-(IBAction)CurrentSeesionClick:(id)sender;
@end
