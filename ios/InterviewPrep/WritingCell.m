//
//  WritingCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "WritingCell.h"
#import "baseViewController.h"

@implementation WritingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configureCell:(NSDictionary *)responseDict{
    NSString *question;
    NSString *answer;
    NSString *quest;

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
    [self.quesDetailLbl addGestureRecognizer:tapGestureRecognizer];
    self.quesDetailLbl.userInteractionEnabled = true;
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnAnsLabel:)];
    [self.modelAnsLbl addGestureRecognizer:tapGestureRecognizer1];
    self.modelAnsLbl.userInteractionEnabled = true;
    if([[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] != nil || ![[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"]){
         quest = [[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"];
    }
    
    NSString* newString = [quest stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    NSString* newString4 = [newString1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString* newString5 = [newString4 stringByReplacingOccurrencesOfString:@"<br/><br/><br/><br/>" withString:@"<br/>"];
    NSString* newString6 = [newString5 stringByReplacingOccurrencesOfString:@"<br/><br/><br/>" withString:@"<br/>"];
    NSString* newString7 = [newString6 stringByReplacingOccurrencesOfString:@"^" withString:@"<br/>"];
    NSString* newString8 = [newString7 stringByAppendingString:@"<br/>"];
    NSString * str = [[NSString alloc]initWithFormat:@"<p style=\" font-size:%fpx; font-family:%@;  color:%@;\">%@</p>",TEXTTITLEFONT.pointSize,APPFONTNORMAL,DEFAULTTEXTCOLOR,newString8];
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [str dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:13.0]}
                                            documentAttributes: nil
                                            error: nil
                                            ];
        question = attributedString.string;

        if(isTapOnLabel){
            NSMutableString *fullQuestion = [NSMutableString stringWithFormat:@"%@%@",question,@"...show less"];
            NSRange range = [fullQuestion rangeOfString:@"...show less" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullQuestion];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            
            self.quesDetailLbl.attributedText = string;
            
        }else{
            question = [question substringToIndex:question.length-question.length*3/4];
            NSMutableString *fullQuestion = [NSMutableString stringWithFormat:@"%@%@",question,@"...show more"];
            NSRange range = [fullQuestion rangeOfString:@"...show more" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullQuestion];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            self.quesDetailLbl.attributedText = string;
            
        }
    self.quesDetailLbl.font = TEXTTITLEFONT;
    self.quesDetailLbl.numberOfLines = 0;
    [self.quesDetailLbl sizeToFit];

    
    if([[responseDict[@"object"] valueForKey:@"sample1"] valueForKey:@"text"] != nil || ![[responseDict[@"object"] valueForKey:@"sample1"] valueForKey:@"text"]){
        answer = [[responseDict[@"object"] valueForKey:@"sample1"] valueForKey:@"text"];
    }

    if(isTapOnAnsLabel){
        self.ansLbl.text = answer;
        [self.modelImageV setImage:[UIImage imageNamed:@"minus.png"]];


    }else{
        self.ansLbl.text = @"";
        [self.modelImageV setImage:[UIImage imageNamed:@"plus_icon.png"]];
    }

    self.ansLbl.numberOfLines = 0;
    self.ansLbl.font = TEXTTITLEFONT;
    [self.ansLbl sizeToFit];


    [self.ansTextView setText:responseDict[@"option"]];
    self.ansTextView.scrollEnabled = false;
    [self.ansTextView layoutIfNeeded]; // <--- Add this
    [self.ansTextView sizeToFit];
    self.ansTextView.font = TEXTTITLEFONT;
}

-(void)handleTapOnLabel: (UITapGestureRecognizer *)recognizer{
    if(isTapOnLabel){
        isTapOnLabel = false;
    }else{
        isTapOnLabel = true;
    }
    [_delegate reloadTable];
}

-(void)handleTapOnAnsLabel: (UITapGestureRecognizer *)recognizer{
 
    if(isTapOnAnsLabel){
        isTapOnAnsLabel = false;
    }else{
        isTapOnAnsLabel = true;
    }
    [_delegate reloadTable];
}



@end
