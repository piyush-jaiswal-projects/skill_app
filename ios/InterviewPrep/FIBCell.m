//
//  FIBCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 23/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "FIBCell.h"
#import "OptionsCell.h"
#import "baseViewController.h"

@implementation FIBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

//    [self.tableView reloadData];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(NSDictionary *)responseDict{
    NSString *question;
    NSString *quest;
    self.optionArray = responseDict[@"option"];
    if([[[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"] isKindOfClass:[NSArray class]]){
        self.answerArray = [[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"];
        isMultipleOptions = true;
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for(NSDictionary *ansDict in self.answerArray){
            NSArray * _arr = [ansDict[@"text"] componentsSeparatedByString:@"##"];
            [arr addObject:[_arr objectAtIndex:0]];
        }
        self.ansLbl.text = [NSString stringWithFormat:@"Correct Answer: %@",[self convertToCommaSeparatedFromArray:arr]];


        //Is array
    }else if([[[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"] isKindOfClass:[NSDictionary class]]){
        //is dictionary
        self.answerDict = [[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"];
        isMultipleOptions = false;
        NSArray * _arr = [self.answerDict[@"text"] componentsSeparatedByString:@"##"];
        self.ansLbl.text = [NSString stringWithFormat:@"Correct Answer: %@",[_arr objectAtIndex:0]];

    }

    
    self.tblHgtConstraints.constant = 45*self.optionArray.count + 20;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
    [self.quesDetailLbl addGestureRecognizer:tapGestureRecognizer];
    self.quesDetailLbl.userInteractionEnabled = true;

    if([[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] != nil || ![[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] isEqual:@""]){
        quest =[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"];
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
            NSMutableString *fullString = [NSMutableString stringWithFormat:@"%@%@",question,@"...show less"];
            NSRange range = [fullString rangeOfString:@"...show less" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullString];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            self.quesDetailLbl.attributedText = string;
        }else{
            question = [question substringToIndex:question.length-question.length*3/4];
            NSMutableString *fullString = [NSMutableString stringWithFormat:@"%@%@",question,@"...show more"];
            NSRange range = [fullString rangeOfString:@"...show more" options:NSCaseInsensitiveSearch];
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:fullString];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0 green:135 blue:167 alpha:1.0] range:range];
            self.quesDetailLbl.attributedText = string;
        }

    self.quesDetailLbl.numberOfLines = 0;
    [self.quesDetailLbl sizeToFit];
    self.ansLbl.numberOfLines = 0;
    self.quesDetailLbl.font = TEXTTITLEFONT;
    [self.ansLbl sizeToFit];

    
  NSString *stringColor = @"#89C63B";
  NSUInteger red, green, blue;
  sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
  UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    [self.ansLbl setTextColor:color];

    [self.tableView registerNib:[UINib nibWithNibName:@"OptionsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"textCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    self.tblHgtConstraints.constant = self.tableView.contentSize.height;


}

-(NSString *)convertToCommaSeparatedFromArray:(NSMutableArray*)array{
    return [array componentsJoinedByString:@","];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.optionArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textCell"];
    [cell.bckgroundView.layer setCornerRadius:18.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *ansDict;
    if(isMultipleOptions){
        ansDict = [self.answerArray objectAtIndex:indexPath.row];
    }else{
        ansDict = self.answerDict;
    }
    
    cell.optionLbl.text = [self.optionArray objectAtIndex:indexPath.row];

    NSArray * arr = [ansDict[@"text"] componentsSeparatedByString:@"##"];
    BOOL flag = TRUE;
    for (NSString * str in arr)
    {
        if([[str uppercaseString]isEqualToString:[[self.optionArray objectAtIndex:indexPath.row] uppercaseString]])
        {
            flag = FALSE;
            break;
        }
    }
    if(!flag)
    {
        NSString *stringColor = @"#89C63B";
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        [cell.bckgroundView setBackgroundColor:color];
        [cell.optionImgV setImage:[UIImage imageNamed:@"right_icon.png"]];
        [cell.optionLbl setTextColor:[UIColor whiteColor]];
    }
    else
    {
        NSString *stringColor = @"#ED5565";
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
        [cell.bckgroundView setBackgroundColor:color];
        [cell.optionImgV setImage:[UIImage imageNamed:@"wrong_icon.png"]];
        [cell.optionLbl setTextColor:[UIColor whiteColor]];
    }
    cell.optionLbl.font = TEXTTITLEFONT;
    
    
    
    
    
//    if([ansDict[@"text"]  isEqual: [self.optionArray objectAtIndex:indexPath.row]]){
//
//
//    }else{
//
//    }
    cell.optionLbl.numberOfLines = 0;
    [cell.optionLbl sizeToFit];

    return cell;
}



//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGRect cellSize = cell.frame;
//    cellHeight = cellSize.size.height;
//}

-(void)handleTapOnLabel: (UITapGestureRecognizer *)recognizer{
    if(isTapOnLabel){
        isTapOnLabel = false;
    }else{
        isTapOnLabel = true;
    }
    [_delegate reloadTable];
    self.tblHgtConstraints.constant = self.tableView.contentSize.height;

}



@end






//Printing description of self->ansTrackArray:
//<__NSArrayM 0x60000231bd20>(
//{
//    endTime = 1585162478895;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = share;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51775.1.1";
//                },
//                                {
//                    content =                     {
//                        text = develop;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51775.1.2";
//                },
//                                {
//                    content =                     {
//                        text = understand;
//                    };
//                    "is_correct" =                     {
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
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Read the text and select the missing word or phrase:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nThis new course helps people over 65 to see how new technology can improve their lives. It also challenges young people to ______________________ some of the basic problems older people have with technology.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "Feedback for Option1";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.1";
//                },
//                                {
//                    content =                     {
//                        text = "Feedback for Option2";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.2";
//                },
//                                {
//                    content =                     {
//                        text = "Feedback for Option3";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.3";
//                },
//                                {
//                    content =                     {
//                        text = "Feedback for Option4";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51775.1.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51775;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51775;
//    "skill_id" = 0;
//    startTime = 1585162473658;
//    type = mc;
//},
//{
//    endTime = 1585162483094;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = collection;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51776.2.1";
//                },
//                                {
//                    content =                     {
//                        text = range;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51776.2.2";
//                },
//                                {
//                    content =                     {
//                        text = type;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51776.2.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Read the text and select the missing word or phrase.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nWelcome to &lt;b&gt;Computer Repair UK&lt;/b&gt;. We offer a ______________________ of online computer support services including remote IT Support and server support services as well as local PC and computer help.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51776.2.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51776;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51776;
//    "skill_id" = 0;
//    startTime = 1585162481510;
//    type = mc;
//},
//{
//    endTime = 1585162485463;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "work experience";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51777.3.1";
//                },
//                                {
//                    content =                     {
//                        text = "personal development";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51777.3.2";
//                },
//                                {
//                    content =                     {
//                        text = "academic success";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51777.3.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Read the text and select the missing word or phrase.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nWorld Youth Adventures are committed to providing safe, rewarding travel experiences that achieve real _____________________ for students. We aim to provide quality ground services, exceptional value, expert advice, unique itineraries and friendly service.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51777.3.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51777;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51777;
//    "skill_id" = 0;
//    startTime = 1585162483902;
//    type = mc;
//},
//{
//    endTime = 1585162487746;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = explore;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51778.4.1";
//                },
//                                {
//                    content =                     {
//                        text = shop;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51778.4.2";
//                },
//                                {
//                    content =                     {
//                        text = play;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51778.4.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Read the text and select the missing word or phrase.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nOur aim is to make the Country Fair a great family day out, with good fun for all ages combined with a strong country theme. There is much to ________________, watch and enjoy - as well as some great shopping.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51778.4.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51778;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51778;
//    "skill_id" = 3;
//    startTime = 1585162486328;
//    type = mc;
//},
//{
//    endTime = 1585162490812;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "take the stand";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51779.5.1";
//                },
//                                {
//                    content =                     {
//                        text = "heed the warning";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51779.5.2";
//                },
//                                {
//                    content =                     {
//                        text = "fill the needs";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51779.5.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Read the text and select the missing word or phrase.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nThe Atlanta Opera strives to present opera productions of the highest standards possible, while fostering education about the art form and encouraging its growth with services and programs designed to _____________________ of the community.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51779.5.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51779;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51779;
//    "skill_id" = 0;
//    startTime = 1585162489554;
//    type = mc;
//},
//{
//    endTime = 1585162494068;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "When the war had finished";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51780.6.1";
//                },
//                                {
//                    content =                     {
//                        text = "When he was recovering from an injury";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51780.6.2";
//                },
//                                {
//                    content =                     {
//                        text = "When he later worked as a cobbler";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51780.6.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to Dr. Martens's footwear history, when did Martens begin to develop a new boot design?&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\n&lt;b&gt;Dr. Martens Footwear: The History&lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nKlaus Martens was a doctor in the German army during World War II. While on leave in 1945, he injured his ankle while skiing in the Bavarian Alps. He found that his standard-issue army boots were too uncomfortable on his injured foot. While recuperating, he designed improvements to the boots, with soft leather and air-padded soles. When the war ended, Martens used leather from a shoe repairer\U2019s shop to make himself a pair of boots with air-cushioned soles.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nMartens didn\U2019t have much luck selling his shoes until he met up with an old university friend, Dr. Herbert Funck, in Munich in 1947. Funck was intrigued by the new shoe design, and the two went into business that year in Seeshaupt, Germany. The comfortable and durable soles were a big hit with housewives, with 80% of sales in the first decade going to women over the age of 40.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51780.6.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51780;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51780;
//    "skill_id" = 0;
//    startTime = 1585162491722;
//    type = mc;
//},
//{
//    endTime = 1585162496918;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "When Martens teamed up with Herbert Funck";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51781.7.1";
//                },
//                                {
//                    content =                     {
//                        text = "When Martens went into business in Munich";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51781.7.2";
//                },
//                                {
//                    content =                     {
//                        text = "When Martens returned to his old university";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51781.7.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to Dr. Martens's footwear history, when were the new boots sold successfully?&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; &lt;b&gt;Dr. Martens Footwear: The History&lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nKlaus Martens was a doctor in the German army during World War II. While on leave in 1945, he injured his ankle while skiing in the Bavarian Alps. He found that his standard-issue army boots were too uncomfortable on his injured foot. While recuperating, he designed improvements to the boots, with soft leather and air-padded soles. When the war ended, Martens used leather from a shoe repairer\U2019s shop to make himself a pair of boots with air-cushioned soles.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nMartens didn\U2019t have much luck selling his shoes until he met up with an old university friend, Dr. Herbert Funck, in Munich in 1947. Funck was intrigued by the new shoe design, and the two went into business that year in Seeshaupt, Germany. The comfortable and durable soles were a big hit with housewives, with 80% of sales in the first decade going to women over the age of 40.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51781.7.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51781;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51781;
//    "skill_id" = 0;
//    startTime = 1585162494981;
//    type = mc;
//},
//{
//    endTime = 1585162499671;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = students;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51782.8.1";
//                },
//                                {
//                    content =                     {
//                        text = women;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51782.8.2";
//                },
//                                {
//                    content =                     {
//                        text = elderly;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51782.8.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to Dr. Martens's footwear history, who were most of their customers?&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;b&gt;Dr. Martens Footwear: The History&lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nKlaus Martens was a doctor in the German army during World War II. While on leave in 1945, he injured his ankle while skiing in the Bavarian Alps. He found that his standard-issue army boots were too uncomfortable on his injured foot. While recuperating, he designed improvements to the boots, with soft leather and air-padded soles. When the war ended, Martens used leather from a shoe repairer\U2019s shop to make himself a pair of boots with air-cushioned soles.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt; \n\nMartens didn\U2019t have much luck selling his shoes until he met up with an old university friend, Dr. Herbert Funck, in Munich in 1947. Funck was intrigued by the new shoe design, and the two went into business that year in Seeshaupt, Germany. The comfortable and durable soles were a big hit with housewives, with 80% of sales in the first decade going to women over the age of 40.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51782.8.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51782;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51782;
//    "skill_id" = 0;
//    startTime = 1585162497979;
//    type = mc;
//},
//{
//    endTime = 1585162523637;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "they began to make boots in larger sizes";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51783.9.1";
//                },
//                                {
//                    content =                     {
//                        text = "a British businessman bought all the boots";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51783.9.2";
//                },
//                                {
//                    content =                     {
//                        text = "small changes were made to the design";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51783.9.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to Dr. Martens's footwear history, what happened when Martens and Funck decided to sell the boots abroad?&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;b&gt;Dr. Martens Footwear: The History&lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nSales had grown so much by 1952 that they opened a factory in Munich. In 1959, the company had grown large enough that Martens and Funck looked at marketing the footwear internationally. Almost immediately, British shoe manufacturer R. Griggs Group Ltd. bought patent rights to manufacture the shoes in the United Kingdom. Griggs anglicized the name, slightly re-shaped the heel to make them fit better, added the trademark yellow stitching, and trademarked the soles as AirWair. &lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51783.9.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 0;
//            text = "";
//        };
//        text = "";
//        uniqid = 51783;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51783;
//    "skill_id" = 0;
//    startTime = 1585162500700;
//    type = mc;
//},
//{
//    endTime = 1585162538700;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = "the quality of the leather declined.";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51784.10.1";
//                },
//                                {
//                    content =                     {
//                        text = "they stopped selling as many boots.";
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    text = "";
//                    uniqid = "51784.10.2";
//                },
//                                {
//                    content =                     {
//                        text = "the Cobbs Lane factory closed.";
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    text = "";
//                    uniqid = "51784.10.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to Dr. Martens's footwear history given below, why did Dr Martens stopped making boots in the UK?&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;b&gt;Dr. Martens Footwear: The History&lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nThe first Dr. Martens boots in the United Kingdom came out on 1 April 1960 (known as style 1460 and still in production today). Originally Dr. Martens were made in their Cobbs Lane factory (which is still working today). In addition, a number of shoe manufacturers in the Northamptonshire area also produced DM\U2019s under license, as long as they passed quality standards.&lt;br/&gt;&lt;br/&gt;\n\nOn 1 April 2003, under pressure from declining sales, the Dr. Martens company ceased all production in the United Kingdom, with production moving to China and Thailand. With this change also came the end of the company\U2019s vegan-friendly non-leather products, which had been produced since the early 1990s. In 2007, the company began producing footwear again in England, in the Cobbs Lane Factory in Wollaston.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51784.10.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mc;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51784;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 51784;
//    "skill_id" = 3;
//    startTime = 1585162531026;
//    type = mc;
//},
//{
//    endTime = 1585162578361;
//    object =     {
//        answers =         {
//            answer =             {
//                text = hikers;
//                uniqid = "51785.11.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given passage, ________________ finds the Scorpion useful.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;b&gt;A new gadget &lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nLast month, Eton, manufacturer of kinetically powered gadgets, introduced the Scorpion. It is a hybrid of Etons typical fare, this time incorporating solar power into the equation. The gadget can be used by hikers to charge mobile devices, listen to the radio and power a built-in LED flashlight. It allows updates on weather conditions through the Ocean and Atmospheric Associations weather band. The radio tuner is digital and it even comes equipped with a bottle opener. The Scorpion retails for $50 and is about the size of a walkie-talkie.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nEton also offers a few bulkier but more powerful solar devices. The SolarLink FR600 is a bit bigger and has all the features of the Scorpion and more. These include a siren for emergencies, backlit digital display and digital clock, and of course, solar cells.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51785.11.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51785.11.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 7;
//            text = Undefined;
//        };
//        text = "";
//        uniqid = 51785;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Mmmmm
//    );
//    quesId = 51785;
//    "skill_id" = 7;
//    startTime = 1585162544188;
//    type = fb;
//},
//{
//    endTime = 1585162623728;
//    object =     {
//        answers =         {
//            answer =             {
//                text = weather;
//                uniqid = "51786.12.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given passage, information related to _________________ is available via the Scorpion.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;b&gt;A new gadget &lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nLast month, Eton, manufacturer of kinetically powered gadgets, introduced the Scorpion. It is a hybrid of Etons typical fare, this time incorporating solar power into the equation. The gadget can be used by hikers to charge mobile devices, listen to the radio and power a built-in LED flashlight. It allows updates on weather conditions through the Ocean and Atmospheric Associations weather band. The radio tuner is digital and it even comes equipped with a bottle opener. The Scorpion retails for $50 and is about the size of a walkie-talkie.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51786.12.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51786.12.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 7;
//            text = Undefined;
//        };
//        text = "";
//        uniqid = 51786;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Nnnnn
//    );
//    quesId = 51786;
//    "skill_id" = 7;
//    startTime = 1585162583292;
//    type = fb;
//},
//{
//    endTime = 1585162642372;
//    object =     {
//        answers =         {
//            answer =             {
//                text = "walkie-talkie";
//                uniqid = "51787.13.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given passage, ________________ is roughly as big as the Scorpion.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;b&gt;A new gadget &lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nLast month, Eton, manufacturer of kinetically powered gadgets, introduced the Scorpion. It is a hybrid of Etons typical fare, this time incorporating solar power into the equation. The gadget can be used by hikers to charge mobile devices, listen to the radio and power a built-in LED flashlight. It allows updates on weather conditions through the Ocean and Atmospheric Associations weather band. The radio tuner is digital and it even comes equipped with a bottle opener. The Scorpion retails for $50 and is about the size of a walkie-talkie.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51787.13.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51787.13.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 7;
//            text = Undefined;
//        };
//        text = "";
//        uniqid = 51787;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Bbbbb
//    );
//    quesId = 51787;
//    "skill_id" = 7;
//    startTime = 1585162626952;
//    type = fb;
//},
//{
//    endTime = 1585162648313;
//    object =     {
//        answers =         {
//            answer =             {
//                text = siren;
//                uniqid = "51788.14.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given passage, the SolarLink FR600 has a _________________ for crisis situations.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;&lt;b&gt;A new gadget &lt;/b&gt;&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nEton also offers a few bulkier but more powerful solar devices. The SolarLink FR600 is a bit bigger and has all the features of the Scorpion and more. These include a siren for emergencies, backlit digital display and digital clock, and of course, solar cells.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51788.14.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51788.14.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 7;
//            text = Undefined;
//        };
//        text = "";
//        uniqid = 51788;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Vvvvv
//    );
//    quesId = 51788;
//    "skill_id" = 7;
//    startTime = 1585162642410;
//    type = fb;
//},
//{
//    endTime = 1585162654301;
//    object =     {
//        answers =         {
//            answer =             {
//                text = "revised edition";
//                uniqid = "51789.15.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given book review, the book The Complete Guide to Cartoons and Animation is related to the 1979 original as its ________________. &lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nFirst published in 1979, &lt;b&gt;The Complete Guide to Cartoons and Animation&lt;/b&gt; is widely\nregarded as the most authoritative guide to making animated movies. This revised edition is not just a minor update - it's more like a completely new book. Since its first publication, computer technology has made a whole new world available to the amateur cartoonist, making it easy for anyone to create high quality animations. You don't even need much artistic talent or technical skill, just imagination and creativity. Nothing currently on the market comes close to this book's range of information. It does exactly what the title promises, and unless you're a real specialist, it's the only book you'll ever need.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51789.15.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51789.15.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51789;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Ccccc
//    );
//    quesId = 51789;
//    "skill_id" = 3;
//    startTime = 1585162648352;
//    type = fb;
//},
//{
//    endTime = 1585162663462;
//    object =     {
//        answers =         {
//            answer =             {
//                text = "computer technology";
//                uniqid = "51790.16.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given book review, ________________ has made animation easier ever since the first book was written.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nFirst published in 1979, &lt;b&gt;The Complete Guide to Cartoons and Animation&lt;/b&gt; is widely\nregarded as the most authoritative guide to making animated movies. This revised edition is not just a minor update - it's more like a completely new book. Since its first publication, computer technology has made a whole new world available to the amateur cartoonist, making it easy for anyone to create high quality animations. You don't even need much artistic talent or technical skill, just imagination and creativity. Nothing currently on the market comes close to this book's range of information. It does exactly what the title promises, and unless you're a real specialist, it's the only book you'll ever need.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51790.16.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51790.16.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51790;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Zzzzz
//    );
//    quesId = 51790;
//    "skill_id" = 3;
//    startTime = 1585162654338;
//    type = fb;
//},
//{
//    endTime = 1585162691093;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    text = imagination;
//                    uniqid = "51791.17.1";
//                },
//                                {
//                    text = creativity;
//                    uniqid = "51791.17.2";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given book review, ______________ and ______________ are needed to make good animations.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nFirst published in 1979, &lt;b&gt;The Complete Guide to Cartoons and Animation&lt;/b&gt; is widely\nregarded as the most authoritative guide to making animated movies. This revised edition is not just a minor update - it's more like a completely new book. Since its first publication, computer technology has made a whole new world available to the amateur cartoonist, making it easy for anyone to create high quality animations. You don't even need much artistic talent or technical skill, just imagination and creativity. Nothing currently on the market comes close to this book's range of information. It does exactly what the title promises, and unless you're a real specialist, it's the only book you'll ever need.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51791.17.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51791.17.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51791;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Aaaaa,
//        Sssss
//    );
//    quesId = 51791;
//    "skill_id" = 3;
//    startTime = 1585162663500;
//    type = fb;
//},
//{
//    endTime = 1585162696330;
//    object =     {
//        answers =         {
//            answer =             {
//                text = "range of information";
//                uniqid = "51792.18.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = false;
//            text = "";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "According to the given book review, this book is better than any other book available because of its __________________.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nFirst published in 1979, &lt;b&gt;The Complete Guide to Cartoons and Animation&lt;/b&gt; is widely\nregarded as the most authoritative guide to making animated movies. This revised edition is not just a minor update - it's more like a completely new book. Since its first publication, computer technology has made a whole new world available to the amateur cartoonist, making it easy for anyone to create high quality animations. You don't even need much artistic talent or technical skill, just imagination and creativity. Nothing currently on the market comes close to this book's range of information. It does exactly what the title promises, and unless you're a real specialist, it's the only book you'll ever need.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51792.18.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_51792.18.2";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = fb;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = false;
//            text = "";
//        };
//        instruction =         {
//            text = "Choose the correct answer.";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = false;
//                text = "";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "";
//            };
//            text = "";
//            title =             {
//                text = "";
//            };
//        };
//        practiceQuestion =         {
//            text = 0;
//        };
//        qmediaPoistion =         {
//            text = top;
//        };
//        skill =         {
//            id = 3;
//            text = Reading;
//        };
//        text = "";
//        uniqid = 51792;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Fffff,
//        Sssss
//    );
//    quesId = 51792;
//    "skill_id" = 3;
//    startTime = 1585162691124;
//    type = fb;
//}
//)
//(lldb)
