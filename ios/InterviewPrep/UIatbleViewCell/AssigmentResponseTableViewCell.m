//
//  AssigmentResponseTableViewCell.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "AssigmentResponseTableViewCell.h"
#import "baseViewController.h"

@implementation AssigmentResponseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *stringColor = @"#009ca9";
    NSUInteger red, green, blue;
    sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];

    [self.mainView.layer setBorderWidth:1.0];
    [self.mainView.layer setCornerRadius:10.0];
    [self.mainView.layer setBorderColor:color.CGColor];
    self.mainView.clipsToBounds = true;
    [self.headingLbl setTextColor:color];
    self.responseTxtView.delegate = self;
    self.alphabetLbl.hidden = false;

}



-(void)configureCell:(NSDictionary*)responseDict
{
    if([responseDict[@"teacher_evaluated"] isEqualToString:@"yes"]){
        self.headingLbl.hidden = false;
        NSString *stringColor = @"#f5f5f5";
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *bckgColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
        [self.mainView setBackgroundColor:bckgColor];
        [self.responseTxtView setBackgroundColor:bckgColor];
        NSString * str = responseDict[@"response_text"];
        //NSString *encodedLink = @"hello%20world";
        NSString *result = [(NSString *)str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        NSString *decodedUrl = [result stringByRemovingPercentEncoding];
        NSLog (@"%@", decodedUrl);
        
        if(decodedUrl == NULL || decodedUrl == Nil || decodedUrl == nil || [decodedUrl isEqual:[NSNull null]])
         self.responseTxtView.text = @"";
        else
            self.responseTxtView.text =decodedUrl;
        
        self.alphabetLbl.text = [NSString stringWithFormat:@"%lu/320",(unsigned long)self.responseTxtView.text.length];
        self.responseTxtView.editable = NO;
    }else{
        self.headingLbl.hidden = true;
        [self.responseTxtView setBackgroundColor:[UIColor clearColor]];
        self.responseTxtView.text = @"Write your response here";
        self.responseTxtView.font = TEXTTITLEFONT;
        [self.responseTxtView setTextColor:[UIColor lightGrayColor]];
        self.alphabetLbl.text = @"0/320";
        self.responseTxtView.editable = YES;
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark:- TextView Delegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [textView setTextColor:[UIColor blackColor]];
    if(textView != nil && [textView.text isEqualToString:@"Write your response here"] ){
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [_delegate getResponseText:textView.text];
}

-(void)textViewDidChange:(UITextView *)textView
{
   int len = (int)textView.text.length;
   self.alphabetLbl.text = [NSString stringWithFormat:@"%@/320",[NSString stringWithFormat:@"%i",len]];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            return YES;
        }
    }
    else if([[textView text] length] > 319)
    {
        return NO;
    }
    return YES;
}
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
//    }];
//    return [super canPerformAction:action withSender:sender];
//}
@end
