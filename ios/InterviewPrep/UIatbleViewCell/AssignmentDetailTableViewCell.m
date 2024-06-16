//
//  AssignmentDetailTableViewCell.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "AssignmentDetailTableViewCell.h"
#import "baseViewController.h"

@implementation AssignmentDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    NSString *stringColor = @"#009ca9";
    NSUInteger red, green, blue;
    sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
    [self.nameLbl setTextColor:color];
    
    NSString *textColor = DEFAULTTEXTCOLOR;
    NSUInteger red1, green1, blue1;
    sscanf([textColor UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
    UIColor *color1 = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1];
    [self.detailTxtView setTextColor:color1];
    

    // Configure the view for the selected state
}


-(void)configureCell:(NSDictionary*)responseDict{
    if(responseDict[@"assignment_desc"] != nil){
        
        //self.detailTxtView.textContainer.maximumNumberOfLines = 0;
        self.detailTxtView.scrollEnabled = FALSE;
        self.detailTxtView.font = TEXTTITLEFONT;
        
        
        
        NSString* newString = [responseDict[@"assignment_desc"] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
        NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
        NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
        NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
        NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
        NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
        NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
        
        
        
        
        
        NSString * str = [[NSString alloc]initWithFormat:@"<div><font face=\"Helvetica\" color=\"#4e4e4e\" style=\"font-size:%fpx;\">%@</font></div>",self.detailTxtView.font.pointSize,newString8];
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                 initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                                 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType}
                                                 documentAttributes: nil
                                                 error: nil
                                                 ];
        
        
        
        
        
//        NSString* newString = [responseDict[@"assignment_desc"]
//                               stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
//        NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
//        NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
//        NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
//        NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
//        NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
//
//        NSArray * brCounter = [newString8 componentsSeparatedByString:@"<br/>"];
//
//
//
//
//        NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",self.detailTxtView.font.pointSize,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
//
//
//
//
//        NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                                initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
//                                                options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:TEXTTITLEFONT}
//                                                documentAttributes: nil
//                                                error: nil
//                                                ];
        
//        CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(self.detailTxtView.frame.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//        CGFloat f_height = rect.size.height+20;
        self.detailTxtView.attributedText = attributedString;
//        self.detailTxtView.frame = CGRectMake(self.detailTxtView.frame.origin.x, self.detailTxtView.frame.origin.y, self.detailTxtView.frame.size.width, f_height);
//        self.frame = CGRectMake(0,0, self.detailTxtView.frame.size.width, f_height);
//        //self.detailTxtView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    if(responseDict[@"assignment_text"] != nil){
        self.nameLbl.font = TEXTTITLEFONT;
        self.nameLbl.text = responseDict[@"assignment_text"];
    }
    
    
    if([responseDict[@"teacher_evaluated"] isEqualToString:@"yes"]){
        self.detailTxtView.editable = NO;
    }else{
        self.detailTxtView.editable = NO;
    }
         
}



-(void)configureForFeedBack:(NSDictionary*)responseDict{
    self.downloadBtn.hidden = true;
    self.detailTxtView.editable = NO;
    self.nameLbl.text = @"Comments";
    if(responseDict[@"teacher_feedback"] != nil && ![responseDict[@"teacher_feedback"]isEqual:[NSNull null]] ){
        NSString *result = [(NSString *)responseDict[@"teacher_feedback"] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        NSString *decodedUrl = [result stringByRemovingPercentEncoding];
        NSLog (@"%@", decodedUrl);
        self.detailTxtView.text = decodedUrl;
    }
    else
    {
        self.detailTxtView.text = @"";
    }

}

- (IBAction)downloadBtnAction:(id)sender {
    [_delegate downloadBtnClick];
}



@end
