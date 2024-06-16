//
//  ReadingCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 25/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "ReadingCell.h"
#import "OptionsCell.h"
#import "baseViewController.h"

@implementation ReadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(NSDictionary *)responseDict{
        [self.tableView registerNib:[UINib nibWithNibName:@"OptionsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"textCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 40;
        [self.tableView reloadData];
        self.modelAnsLbl.hidden=true;
        self.modelImgV.hidden = true;

    NSString *question;
    NSString *quest;
    selectedOption = responseDict[@"option"];
    self.answerArray = [[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"];
    self.tblHgtConstraint.constant = self.answerArray.count*45;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
    [self.quesDetaillLbl addGestureRecognizer:tapGestureRecognizer];
    self.quesDetaillLbl.userInteractionEnabled = true;
    self.quesDetaillLbl.font = TEXTTITLEFONT;
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnFeedbackLabel:)];
    [self.modelAnsLbl addGestureRecognizer:tapGestureRecognizer1];
    self.modelAnsLbl.userInteractionEnabled = true;

    if([[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] != nil || ![[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] isEqual:@""]){
        quest =[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"];
    }

    NSString* newString = [quest stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
    NSString* newString3 = [newString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString* newString1 = [newString3 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    //NSString* newString2 = [newString1 stringByReplacingOccurrencesOfString:@"\t" withString:@"<br/>"];
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
            NSMutableString *fullString = [NSMutableString stringWithFormat:@"%@%@",question,@"...show less"];
            NSRange range = [fullString rangeOfString:@"...show less" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullString];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            self.quesDetaillLbl.attributedText = string;
        }else{
            question = [question substringToIndex:question.length-question.length*3/4];
            NSMutableString *fullString = [NSMutableString stringWithFormat:@"%@%@",question,@"...show more"];
            NSRange range = [fullString rangeOfString:@"...show more" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullString];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            self.quesDetaillLbl.attributedText = string;
        }

    
    if(isTapOnFeedbackLabel){
        
    }else{
    }
    self.quesDetaillLbl.font = TEXTTITLEFONT;
    self.quesDetaillLbl.numberOfLines = 0;
    [self.quesDetaillLbl sizeToFit];


}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.answerArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
    
    [cell.bckgroundView.layer setCornerRadius:17.0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *ansDict = [self.answerArray objectAtIndex:indexPath.row];
    cell.optionLbl.text = [ansDict[@"content"] valueForKey:@"text"];
    if([selectedOption integerValue] == (int)indexPath.row + 1 && [[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"true"])
    {
             NSString *stringColor = @"#89C63B";
             NSUInteger red, green, blue;
             sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
             UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
             [cell.bckgroundView setBackgroundColor:color];
             [cell.optionImgV setImage:[UIImage imageNamed:@"right_icon.png"]];
             [cell.optionLbl setTextColor:[UIColor whiteColor]];

        }else if([selectedOption integerValue] == (int)indexPath.row + 1 && [[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"false"]) {
            
            NSString *stringColor = @"#ED5565";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
            [cell.bckgroundView setBackgroundColor:color];
            [cell.optionImgV setImage:[UIImage imageNamed:@"wrong_icon.png"]];
            [cell.optionLbl setTextColor:[UIColor whiteColor]];
        }else{
            if([[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"true"]){
                NSString *stringColor = @"#89C63B";
                NSUInteger red, green, blue;
                sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
                UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
                [cell.bckgroundView setBackgroundColor:color];
                [cell.optionImgV setImage:[UIImage imageNamed:@"right_icon.png"]];
                [cell.optionLbl setTextColor:[UIColor whiteColor]];
            }else{
            NSString *stringColor = @"#eeeeee";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
            [cell.bckgroundView setBackgroundColor:color];
            [cell.optionLbl setTextColor:[UIColor blackColor]];
            [cell.optionImgV setImage:[UIImage imageNamed:@""]];
            }
            cell.optionLbl.font = TEXTTITLEFONT;

    }
    return cell;
}


-(void)handleTapOnLabel: (UITapGestureRecognizer *)recognizer{
    if(isTapOnLabel){
        isTapOnLabel = false;
    }else{
        isTapOnLabel = true;
    }
    [_delegate reloadTable];
    self.tblHgtConstraint.constant = self.tableView.contentSize.height;

}

-(void)handleTapOnFeedbackLabel: (UITapGestureRecognizer *)recognizer{
    if(isTapOnFeedbackLabel){
        isTapOnFeedbackLabel = false;
    }else{
        isTapOnFeedbackLabel = true;
    }
    [_delegate reloadTable];
    self.tblHgtConstraint.constant = self.tableView.contentSize.height;

}


@end






//{
//    endTime = 1585141724003;
//    object =         {
//        answers =             {
//            answer =                 (
//                                    {
//                    content =                         {
//                        text = share;
//                    };
//                    "is_correct" =                         {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51775.1.1";
//                },
//                                    {
//                    content =                         {
//                        text = develop;
//                    };
//                    "is_correct" =                         {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51775.1.2";
//                },
//                                    {
//                    content =                         {
//                        text = understand;
//                    };
//                    "is_correct" =                         {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51775.1.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =             {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =             {
//            "is_filled" = false;
//            text = "";
//        };
//        content =             {
//            text = "Read the text and select the missing word or phrase:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nThis new course helps people over 65 to see how new technology can improve their lives. It also challenges young people to ______________________ some of the basic problems older people have with technology.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =             {
//            feedback =                 (
//                                    {
//                    content =                         {
//                        text = "Feedback for Option1";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.1";
//                },
//                                    {
//                    content =                         {
//                        text = "Feedback for Option2";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.2";
//                },
//                                    {
//                    content =                         {
//                        text = "Feedback for Option3";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.3";
//                },
//                                    {
//                    content =                         {
//                        text = "Feedback for Option4";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.4";
//                },
//                                    {
//                    content =                         {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.5";
//                },
//                                    {
//                    content =                         {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.6";
//                },
//                                    {
//                    content =                         {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.7";
//                },
//                                    {
//                    content =                         {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.8";
//                }
//            );
//            text = "";
//        };
//        format =             {
//            aform =                 {
//                text = t;
//            };
//            delivery =                 {
//                text = mc;
//            };
//            qform =                 {
//                text = t;
//            };
//            text = "";
//        };
//        image =             {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =             {
//            text = "Choose the correct answer.";
//        };
//        popup =             {
//            audio =                 {
//                "is_filled" = false;
//                text = "";
//            };
//            image =                 {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =                 {
//                text = "";
//            };
//            text = "";
//            title =                 {
//                text = "";
//            };
//        };
//        practiceQuestion =             {
//            text = 0;
//        };
//        qmediaPoistion =             {
//            text = top;
//        };
//        skill =             {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51775;
//        video =             {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51775;
//    "skill_id" = 0;
//    startTime = 1585141707119;
//    type = mc;
//}
