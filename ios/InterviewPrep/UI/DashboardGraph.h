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




@interface DashboardGraph : baseViewController<UIWebViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIDocumentInteractionControllerDelegate,MFMailComposeViewControllerDelegate,UIPopoverControllerDelegate>
{
    @private
        IBOutlet UIWebView *webView;
        IBOutlet UIView *nativeView;
        IBOutlet UIView *nativeViewUpper;
        IBOutlet UIView *nativeViewLower;
        IBOutlet UILabel * username;
        IBOutlet UILabel * CurrentSeesion;
        IBOutlet UILabel * CurrentSeesionText;
        IBOutlet UINavigationBar * navBar;
        NSDictionary * currentSeesion;
        UIActionSheet *actionSheetshare;
        UIActionSheet *actionSheetphoto;
    //UIPopoverController *popover;
    
    
    
    
}
@property (nonatomic, strong) UIPopoverController *popOver;

-(IBAction)CurrentSeesionClick:(id)sender;
@property (retain) UIDocumentInteractionController * documentInteractionController;
@property IBOutlet UIImageView *imgView;
@end
