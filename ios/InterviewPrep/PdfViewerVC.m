//
//  PdfViewerVC.m
//  InterviewPrep
//
//  Created by Amit Gupta on 16/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "PdfViewerVC.h"

@interface PdfViewerVC ()

@end

@implementation PdfViewerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.backgroundColor = [self getUIColorObjectFromHexString:STATUSBARCOLOR alpha:1.0];
//    self.webView.scrollView.delegate = self;
    [self showPdfFile];



    // Do any additional setup after loading the view.
}


- (IBAction)backBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

-(void)showPdfFile{
    self.headerLbl.text = self.headerText;
//    NSURL *targetURL = [[NSBundle mainBundle] URLForResource:_pdfFileName withExtension:@"pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.pdfFileURL]];
    [self.webView loadRequest:request];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//-(void)scrollDown{
//
//    UIScrollView *scrollView = self.webView.scrollView;
//    CGSize contentSize = scrollView.contentSize;
//    CGPoint contentOffSet = scrollView.contentOffset;
//    CGSize frameSize = self.webView.frame.size;
//    CGFloat frameHeight = frameSize.height;
//
//    CGFloat heightOffSet = frameSize.height + contentOffSet.y;
//    CGFloat offSetToBottom = contentSize.height = frameSize.height;
//
//    if(contentOffSet.y + frameHeight > contentSize.height - frameHeight){
//        [scrollView setContentOffset:CGPointMake(0, offSetToBottom)];
//    }else{
//        [scrollView setContentOffset:CGPointMake(0, heightOffSet)];
//
//    }
    


@end
