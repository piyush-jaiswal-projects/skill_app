//
//  OptionsImageTableViewCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 26/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "ListeningTableViewCell.h"
#import "AppDelegate.h"
#import "ListeningOptionCVCell.h"
#import "baseViewController.h"

@implementation ListeningTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    // Register the colleciton cell
    [self.imageOptionsCollectionsView registerNib:[UINib nibWithNibName:@"ListeningOptionCVCell" bundle:nil] forCellWithReuseIdentifier:@"ListeningOptionCVCell"];
    [_imageOptionsCollectionsView setDataSource:self];
    [_imageOptionsCollectionsView setDelegate:self];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/2-30, 130.0)];
    _imageOptionsCollectionsView.collectionViewLayout = flowLayout;
    phoneDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [self.imageOptionsCollectionsView reloadData];


}

-(void)configureCell:(NSDictionary *)responseDict{
    self.answerArray = [[responseDict[@"object"] valueForKey:@"answers"] valueForKey:@"answer"];
    selectedOption = responseDict[@"option"];
    [self.imageOptionsCollectionsView reloadData];
    self.bottomView.hidden = true;
    self.collVHgtConstraint.constant = 130*2;
    [self layoutSubviews];
    [self layoutIfNeeded];




    NSString *question;
    if([[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] != nil || ![[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"] isEqual:@""]){
        question =[[responseDict[@"object"] valueForKey:@"content"] valueForKey:@"text"];
    }
    NSString* newString = [question stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
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
    
    self.quesDetailLbl.attributedText = attributedString;
    self.quesDetailLbl.numberOfLines = 0;
    [self.quesDetailLbl sizeToFit];
    
    self.collVHgtConstraint.constant = self.imageOptionsCollectionsView.contentSize.height;
    [self layoutSubviews];
    [self layoutIfNeeded];


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.answerArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListeningOptionCVCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ListeningOptionCVCell" forIndexPath:indexPath];
    NSDictionary *ansDict = [self.answerArray objectAtIndex:indexPath.row];
    NSString *imageFilePath = [phoneDocumentDirectory stringByAppendingPathComponent:[ansDict[@"media"] valueForKey:@"text"]];
    [cell.cellImgV setImage:[UIImage imageWithContentsOfFile: imageFilePath]];
//    cell.cellImgV.contentMode = UIViewContentModeScaleAspectFit;

    if([selectedOption integerValue] == (int)indexPath.row + 1 && [[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"true"])
    {
             NSString *stringColor = @"#89C63B";
             NSUInteger red, green, blue;
             sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
             UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
//        cell.statusView.frame = [CGRectMake(cell.statusView.frame.origin.x, cell.statusView.frame.origin.y, SCREEN_WIDTH/2-30, cell.statusView.frame.size.height) ];
             [cell.statusView setBackgroundColor:color];
              
             [cell.radioImgV setImage:[UIImage imageNamed:@"MEPro_score-circle.png"]];
             [cell.statusImgV setImage:[UIImage imageNamed:@"right_icon.png"]];
             [cell.optionLbl setTextColor:[UIColor whiteColor]];
             cell.optionLbl.text = [ansDict[@"content"] valueForKey:@"text"];
             cell.radioImgV.tintColor = [UIColor whiteColor];
        }else if([selectedOption integerValue] == (int)indexPath.row + 1 && [[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"false"]) {
            NSString *stringColor = @"#ED5565";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
            [cell.statusView setBackgroundColor:color];
            [cell.radioImgV setImage:[UIImage imageNamed:@"MEPro_score-circle.png"]];
            [cell.statusImgV setImage:[UIImage imageNamed:@"wrong_icon.png"]];
            [cell.optionLbl setTextColor:[UIColor whiteColor]];
            cell.optionLbl.text = [ansDict[@"content"] valueForKey:@"text"];
            cell.radioImgV.tintColor = [UIColor whiteColor];
        }else{
            if([[ansDict[@"is_correct"] valueForKey:@"text"]  isEqual: @"true"]){
                NSString *stringColor = @"#89C63B";
                NSUInteger red, green, blue;
                sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
                UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
                [cell.statusView setBackgroundColor:color];
                [cell.radioImgV setImage:[UIImage imageNamed:@"MEPro_score-circle.png"]];
                [cell.statusImgV setImage:[UIImage imageNamed:@"right_icon.png"]];
                [cell.optionLbl setTextColor:[UIColor whiteColor]];
                cell.optionLbl.text = [ansDict[@"content"] valueForKey:@"text"];
                cell.radioImgV.tintColor = [UIColor whiteColor];
            }else{
            NSString *stringColor = @"#eeeeee";
            NSUInteger red, green, blue;
            sscanf([stringColor UTF8String], "#%2lX%2lX%2lX", &red, &green, &blue);
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
            [cell.statusView setBackgroundColor:color];
            [cell.radioImgV setImage:[UIImage imageNamed:@"RadioButton.png"]];
            [cell.statusImgV setImage:[UIImage imageNamed:@""]];
            [cell.optionLbl setTextColor:[UIColor blackColor]];
            cell.optionLbl.text = [ansDict[@"content"] valueForKey:@"text"];
            }
            
            cell.optionLbl.font = TEXTTITLEFONT;

    }


    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end



//2020-03-26 16:54:05.756526+0530 Pearson MePro[81136:4734700] [aqsrv] AQServer.cpp:68:APIResult: Exception caught in AudioQueueInternalNotifyRunning - error -66671
//Printing description of self->ansTrackArray:
//<__NSArrayM 0x600000298360>(
//{
//    endTime = 1585221787303;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/1_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".1.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/1_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".1.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/1_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".1.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 1_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify what is Julia going to do that morning.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "Correct Answer";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.1";
//                },
//                                {
//                    content =                     {
//                        text = "Correct Answer: A";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.2";
//                },
//                                {
//                    content =                     {
//                        text = "Correct Answer: A";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53755.1.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Feedback for Option1_22096_6.Feedback for Option1";
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
//            id = 1;
//            text = Listening;
//        };
//        text = "";
//        uniqid = 53755;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53755;
//    "skill_id" = 1;
//    startTime = 1585221782641;
//    type = mci;
//},
//{
//    endTime = 1585221791677;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/2_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".2.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/2_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".2.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/2_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".2.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 2_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify what is Mr Hammond's job.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "Correct Answer: B";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.1";
//                },
//                                {
//                    content =                     {
//                        text = "Correct Answer";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.2";
//                },
//                                {
//                    content =                     {
//                        text = "Correct Answer: B";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53756.2.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53756;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53756;
//    "skill_id" = 7;
//    startTime = 1585221788999;
//    type = mci;
//},
//{
//    endTime = 1585221795102;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/3_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".3.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/3_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".3.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/3_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".3.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 3_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify where's the book?";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53757.3.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53757;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53757;
//    "skill_id" = 0;
//    startTime = 1585221793523;
//    type = mci;
//},
//{
//    endTime = 1585221797744;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/4_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".4.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/4_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".4.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/4_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".4.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 4_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify where's the woman.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53758.4.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53758;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53758;
//    "skill_id" = 0;
//    startTime = 1585221796251;
//    type = mci;
//},
//{
//    endTime = 1585221800780;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/5_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".5.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/5_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".5.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/5_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".5.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 5_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and select what are the speakers doing.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53759.5.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53759;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53759;
//    "skill_id" = 0;
//    startTime = 1585221799433;
//    type = mci;
//},
//{
//    endTime = 1585221803330;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/6_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".6.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/6_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".6.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/6_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".6.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 6_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify which is the correct picture.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53760.6.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53760;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53760;
//    "skill_id" = 0;
//    startTime = 1585221801987;
//    type = mci;
//},
//{
//    endTime = 1585221806067;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/7_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".7.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/7_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".7.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/7_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".7.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 7_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify where is the sandwich.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53761.7.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53761;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53761;
//    "skill_id" = 0;
//    startTime = 1585221804486;
//    type = mci;
//},
//{
//    endTime = 1585221808823;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/8_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".8.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/8_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".8.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/8_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".8.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 8_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify which man is the brides father.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53762.8.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53762;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53762;
//    "skill_id" = 0;
//    startTime = 1585221807185;
//    type = mci;
//},
//{
//    endTime = 1585221811128;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/9_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".9.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/9_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".9.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/9_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".9.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 9_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify what time is the baseball game.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53763.9.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53763;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53763;
//    "skill_id" = 0;
//    startTime = 1585221809853;
//    type = mci;
//},
//{
//    endTime = 1585221813562;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    content =                     {
//                        text = A;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/10_opt1_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".10.1";
//                },
//                                {
//                    content =                     {
//                        text = B;
//                    };
//                    "is_correct" =                     {
//                        text = false;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/10_opt2_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".10.2";
//                },
//                                {
//                    content =                     {
//                        text = C;
//                    };
//                    "is_correct" =                     {
//                        text = true;
//                    };
//                    media =                     {
//                        text = "PracticeApp/CRS-1524/course/module1/scenario3/media/10_opt3_22096_6.png";
//                    };
//                    text = "";
//                    uniqid = ".10.3";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 10_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Listen to the recording and identify what is John going to put in the back of the car.";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.2";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.3";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.4";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.5";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.6";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.7";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53764.10.8";
//                }
//            );
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = mci;
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
//        uniqid = 53764;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = 3;
//    quesId = 53764;
//    "skill_id" = 0;
//    startTime = 1585221812163;
//    type = mci;
//},
//{
//    endTime = 1585221823862;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    text = 01271398332;
//                    uniqid = "53765.11.1";
//                },
//                                {
//                    text = "12:30";
//                    uniqid = "53765.11.2";
//                },
//                                {
//                    text = Marley;
//                    uniqid = "53765.11.3";
//                },
//                                {
//                    text = Evening;
//                    uniqid = "53765.11.4";
//                },
//                                {
//                    text = Email;
//                    uniqid = "53765.11.5";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Questions 12 to 16_2_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "You will hear a telephone message. First, read the notes below then listen and complete the information from the telephone message.&lt;br&gt;\n\n1. Telephone number: _____________________ .&lt;br&gt;\n2. Morning opening: 8.30 till ______________________.&lt;br&gt;\n3. Dogs name:_____________________ .&lt;br&gt;\n4. Best time for appointment:_____________________.&lt;br&gt;\n5. If today send: ____________________ .&lt;br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53765.11.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53765.11.2";
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Correct Feedback_22096_6.Correct Feedback";
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
//        uniqid = 53765;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        cadcaas,
//        Csasa,
//        Cacas,
//        Scascascasca,
//        Csascasca
//    );
//    quesId = 53765;
//    "skill_id" = 7;
//    startTime = 1585221814643;
//    type = fb;
//},
//{
//    endTime = 1585221832150;
//    object =     {
//        answers =         {
//            answer =             (
//                                {
//                    text = "Too slow";
//                    uniqid = "53766.12.1";
//                },
//                                {
//                    text = "8 pm/8";
//                    uniqid = "53766.12.2";
//                },
//                                {
//                    text = "Near dave's house";
//                    uniqid = "53766.12.3";
//                },
//                                {
//                    text = Caesars;
//                    uniqid = "53766.12.4";
//                },
//                                {
//                    text = "Tomorrow morning";
//                    uniqid = "53766.12.5";
//                }
//            );
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Questions 17 to 21_2_22096_6.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "You will hear a recorded message. First, read the notes below then listen and complete the notes with information from the message.&lt;br&gt;\n\n1. Problem with computer: _____________________.&lt;br&gt;\n2. Time to meet: ______________________.&lt;br&gt;\n3. Location of restaurant:_____________________ .&lt;br&gt;\n4. Name of restaurant:_____________________.&lt;br&gt;\n5. Phone back: ____________________ .&lt;br&gt;";
//        };
//        feedbacks =         {
//            feedback =             (
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53766.12.1";
//                },
//                                {
//                    content =                     {
//                        text = "";
//                    };
//                    text = "";
//                    uniqid = "fb_53766.12.2";
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
//        uniqid = 53766;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        Cacsa,
//        Csascas,
//        Cascsa,
//        Cascas,
//        Cacasc
//    );
//    quesId = 53766;
//    "skill_id" = 7;
//    startTime = 1585221823906;
//    type = fb;
//},
//{
//    endTime = 1585221864797;
//    object =     {
//        answers =         {
//            answer =             {
//                "max_length" =                 {
//                    text = 500;
//                };
//                "min_length" =                 {
//                    text = 10;
//                };
//                text = "";
//                uniqid = "53775.13.1";
//            };
//            choice = single;
//            "display_time" = 0;
//            served = random;
//            text = "";
//        };
//        audio =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1524/course/module1/scenario3/media/Question 11-1581937285.mp3";
//        };
//        "audio_transcript" =         {
//            "is_filled" = false;
//            text = "";
//        };
//        content =         {
//            text = "Here you will note down information from the recording. First, listen to the whole recording about &lt;br&gt;pets.&lt;/br&gt;\n\nThe recording will play again with pauses for you to write down what you hear. Make sure you spell the words correctly.";
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = es;
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
//            text = "";
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
//                text = "On television tomorrow, there is a programme about rabbits and what they like to eat. Please tell your children so that they can watch it.";
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
//        sample1 =         {
//            text = "On television tomorrow, there is a programme about rabbits and what they like to eat. Please tell your children so that they can watch it.";
//        };
//        sample2 =         {
//            text = "";
//        };
//        skill =         {
//            id = 1;
//            text = Listening;
//        };
//        text = "";
//        uniqid = 53775;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option = "Fill in the blank.csascacscascascascaca";
//    quesId = 53775;
//    "skill_id" = 1;
//    startTime = 1585221832184;
//    type = es;
//}
//)
//(lldb)
