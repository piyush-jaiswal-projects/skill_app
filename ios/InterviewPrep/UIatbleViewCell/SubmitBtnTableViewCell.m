//
//  SubmitBtnTableViewCell.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "SubmitBtnTableViewCell.h"

@implementation SubmitBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.submitBtn.layer setCornerRadius:15.0];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.submitBtn.clipsToBounds = true;
    self.submitBtn.backgroundColor = [self getUIColorObjectFromHexString:@"#cd2443" alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(NSDictionary*)responseDict{
    if([responseDict[@"teacher_evaluated"] isEqualToString:@"yes"]){
        [self.submitBtn setTitle:@"Got it!" forState:UIControlStateNormal];
    }else{
        [self.submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    }
         
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



- (IBAction)submitBtnAction:(id)sender {
    
    
}


@end
