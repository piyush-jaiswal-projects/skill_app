//
//  AssignmentTableViewCell.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "AssignmentTableViewCell.h"
#import "baseViewController.h"

@implementation AssignmentTableViewCell{
    
    NSString *totalScore;
    NSString *gotScore;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.commentsLbl.layer setCornerRadius:7.0];
    self.commentsLbl.clipsToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(NSDictionary*)responseDict{
    if(responseDict[@"assignment_name"] != nil || ![responseDict[@"assignment_name"]  isEqual: @""]){
        [self.nameLbl setText:responseDict[@"assignment_name"]];
        self.nameLbl.font = HEADERSECTIONTITLEFONT;
        NSString *stringColor = DEFAULTTEXTCOLOR;
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        self.nameLbl.textColor = color;
    }
    if([responseDict[@"teacher_evaluated"] isEqualToString:@"yes"]){
        NSString *stringColor = @"#009ca9";
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:0.2];
        self.commentsLbl.text = @"View comments";
        [self.commentsLbl setBackgroundColor:color];
      //  [self.commentsLbl setTextColor:color];
        self.scoreLblViewHeightCons.constant = 31.0;
        self.tickImageView.hidden = false;
    }else{
        
        if([responseDict[@"user_attempted"] isEqualToString:@"yes"])
        {
            NSString *stringColor = @"#ff7428;";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:0.2];
            self.commentsLbl.text = @"Not scored";
            self.scoreLblViewHeightCons.constant = 6.0;
            [self.commentsLbl setBackgroundColor:color];
            // [self.commentsLbl setTextColor:color];
            self.tickImageView.hidden = true;
        }
        else
        {
            NSString *stringColor = @"#ff7428;";
             NSUInteger red, green, blue;
             sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
             UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:0.2];
             self.commentsLbl.text = @"Not attempted";
             self.scoreLblViewHeightCons.constant = 6.0;
             [self.commentsLbl setBackgroundColor:color];
            // [self.commentsLbl setTextColor:color];
             self.tickImageView.hidden = true;
        }
    }
    
    
    if(responseDict[@"total_grade"] != nil){
        NSString *totalScoreColor = DEFAULTTEXTCOLOR;
        NSUInteger red1, green1, blue1;
        sscanf([totalScoreColor UTF8String], "#%2lX%2lX%2lX", &red1, &green1, &blue1);
        UIColor *color2 = [UIColor colorWithRed:red1/255.0 green:green1/255.0 blue:blue1/255.0 alpha:1];
        self.totalScoreLbl.text = [NSString stringWithFormat:@"/ %@",responseDict[@"total_grade"]];
        [self.totalScoreLbl setTextColor:color2];
        [self.totalScoreLbl setFont:[UIFont systemFontOfSize:10.0]];
    }
    else
    {
       self.totalScoreLbl.text = @"";
    }
    if(responseDict[@"teacher_grade"] != nil){
        NSString *gotScoreColor = @"#009ca9";
        NSUInteger red, green, blue;
        sscanf([gotScoreColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *color1 = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];

        self.gotScoreLbl.text = [NSString stringWithFormat:@"%@",responseDict[@"teacher_grade"]];
        [self.gotScoreLbl setTextColor:color1];
        [self.gotScoreLbl setFont:[UIFont systemFontOfSize:30.0]];
    }
    else
    {
        self.gotScoreLbl.text = @"";
    }
     
}


-(NSAttributedString *)getScore:(NSString *)gotScore totalScore:(NSString *)totalScore gotScoreFont:(UIFont *)gotScoreFont totalScoreFont:(UIFont *)totalScoreFont gotScoreColor:(UIColor *)gotScoreColor totalScoreColor:(UIColor *)totalScoreColor{
    
    NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",gotScore,totalScore]];

    return attributedStr;

}

@end
