//
//  SampleAnswer.m
//  InterviewPrep
//
//  Created by Amit Gupta on 21/02/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "SampleAnswer.h"
#import "baseViewController.h"

@interface SampleAnswer ()
{
    UIButton * crossbtn;
}

@end

@implementation SampleAnswer

- (void)viewDidLoad {
    appDelegate = APP_DELEGATE;
    [super viewDidLoad];
     //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view setFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view setBackgroundColor:[self getUIColorObjectFromHexString:@"#000000" alpha:0.7] ];
    
    UIView * back_view = [[UIView alloc]initWithFrame:CGRectMake(0, 70,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-50)];
    [back_view setBackgroundColor:[UIColor whiteColor]];
    CALayer * lay2 = [back_view layer];
    [lay2 setMasksToBounds:YES];
    [lay2 setCornerRadius:10.0];
    
    // You can even add a border
    [lay2 setBorderWidth:1.0];
    [lay2 setBorderColor:[[self getUIColorObjectFromHexString:@"#f1f1f1" alpha:1.0] CGColor]];
    [self.view addSubview:back_view];
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    
    zoomWebObj = [[WKWebView alloc] initWithFrame:CGRectMake(0, 30,back_view.bounds.size.width, back_view.bounds.size.height-50) configuration:theConfiguration];
    zoomWebObj.UIDelegate = self;
    zoomWebObj.navigationDelegate = self ;
    zoomWebObj.scrollView.delegate = self;
    zoomWebObj.backgroundColor = [UIColor whiteColor];
    zoomWebObj.scrollView.bounces = false;
    zoomWebObj.scrollView.bouncesZoom = false;
    zoomWebObj.scrollView.bounces = false;
    
    [zoomWebObj setBackgroundColor:[UIColor whiteColor]];
    
    // Do any additional setup after loading the view from its nib.
    //zoomWebObj.scalesPageToFit=YES;
    [back_view addSubview:zoomWebObj];
    
   //
    NSString *HTMLData;
   if([self.path isEqualToString:@""])
   {
//       NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                               initWithData: [self.sampleText dataUsingEncoding:NSUnicodeStringEncoding]
//                                               options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:TEXTTITLEFONT}
//                                               documentAttributes: nil
//                                               error: nil
//                                               ];
       
//       NSData *unicodedStringData = [self.sampleText dataUsingEncoding:NSUTF8StringEncoding];
//       NSString *decodevalue = [[NSString alloc] initWithData:unicodedStringData encoding:NSUTF8StringEncoding];
//
//       NSData *data = [self.sampleText dataUsingEncoding:NSUTF8StringEncoding];
//        NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
//       
//       
//       NSData *data = [self.sampleText dataUsingEncoding:NSUTF8StringEncoding];
//        NSString *decodevalue = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];

//       NSString * newString7 = [self.sampleText stringByReplacingOccurrencesOfString:@"u2018" withString:@"'"];
//       NSString * newString8 = [newString7 stringByReplacingOccurrencesOfString:@"u2019" withString:@"'"];
       
       
       NSString* newString = [self.sampleText stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
       NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
       NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
       //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
       NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
       NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
       NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
       NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
       NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
       
       
       
       HTMLData =[[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style> html, body,  { height:100%%; width: 100%%; margin: 0; padding: 0; border: 0; }</style><h4 style=\"text-align:center; font-size:%fpx; font-family:%@;  color:%@;\">%@</h4><p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p></body></html>",GRPAHTITLEFONT.pointSize,@"Helvetica Neue",DEFAULTTEXTCOLOR,self.title,TEXTTITLEFONT.pointSize,@"Helvetica Neue",DEFAULTTEXTCOLOR,newString8];
        [zoomWebObj loadHTMLString:HTMLData baseURL:nil];
   }
   else
   {
       
       NSString* newString = [self.sampleText stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
       NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
       NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
       //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
       NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
       NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
       NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
       NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
       NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
       
       
       NSMutableString *url = [[NSMutableString alloc]initWithFormat:@"%@",self.path];
       NSURL *websiteUrl = [[NSURL alloc] initFileURLWithPath:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       
       
        HTMLData =[[NSString alloc]initWithFormat:@"<html><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0,user-scalable=no,maximum-scale=1.0\"><body><style> html, body,  { height:100%%; width: 100%%; margin: 0; padding: 0; border: 0; } #wrapper { height:100%%; width: 100%%; margin: 0; padding: 0; border: 0;background:black; } #wrapper td { vertical-align: middle; text-align: center; } </style><h4 style=\"text-align:center; font-size:%fpx; font-family:%@;  color:%@;\"><br/><br/>%@</h4><table ><tr><td><img style=\"width:100%%\" src=\"%@\" alt=\"\" /></td></tr></table> <p style=\"font-size:%fpx; font-family:%@;  color:%@;\">%@</p></body></html>",GRPAHTITLEFONT.pointSize,@"Helvetica Neue",DEFAULTTEXTCOLOR,self.title,websiteUrl.lastPathComponent,TEXTTITLEFONT.pointSize,@"Helvetica Neue",DEFAULTTEXTCOLOR,newString8];
       [zoomWebObj loadFileURL:websiteUrl.URLByDeletingLastPathComponent allowingReadAccessToURL:websiteUrl.URLByDeletingLastPathComponent];
       [zoomWebObj loadHTMLString:HTMLData baseURL:websiteUrl.URLByDeletingLastPathComponent];
   }
    
   
    
    
    crossbtn = [[UIButton alloc]initWithFrame:CGRectMake(back_view.bounds.size.width-30, 0, 25, 25)];
    //[crossbtn setTitle:@"X" forState:UIControlStateNormal];
    [crossbtn setImage:[UIImage imageNamed:@"popup_close.png"] forState:UIControlStateNormal];
    [crossbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [crossbtn addTarget:self action:@selector(HideZoomWidow:) forControlEvents:UIControlEventTouchUpInside];
    [back_view addSubview:crossbtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    
    unsigned int hexint = [self intFromHexString:hexStr];
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
    
}


- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(IBAction)HideZoomWidow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
