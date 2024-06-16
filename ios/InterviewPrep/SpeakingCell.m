//
//  SpeakingCell.m
//  InterviewPrep
//
//  Created by Amit Gupta on 26/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import "SpeakingCell.h"
#import "AudioOptionsCell.h"
#import "baseViewController.h"




@implementation SpeakingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    isSelectedAudio = -1;
    isSelected = false;
    [[NSUserDefaults standardUserDefaults] setInteger:-1 forKey:@"lastSelectedIndex"];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"AudioOptionsCell" bundle:nil] forCellWithReuseIdentifier:@"AudioOptionsCell"];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [flowLayout setItemSize:CGSizeMake((self.collectionView.frame.size.width/2)-10, 130.0)];
    self.collectionView.collectionViewLayout = flowLayout;
    phoneDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",phoneDocumentDirectory);
    [self.self.collectionView reloadData];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)configureCell:(NSDictionary *)responseDict selectedIndex:(int)selectedIndex{
    
    yourAudioPath = [responseDict[@"option"] objectAtIndex:selectedIndex];
    globalDictionary = responseDict;
    [self.self.collectionView reloadData];
    self.collVHgtConstraint.constant = 130;
    [self layoutSubviews];
    [self layoutIfNeeded];


    NSString *question;
    NSString *quest;
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
    self.quesDetailLbl.font = TEXTTITLEFONT;
    self.quesDetailLbl.numberOfLines = 0;
    [self.quesDetailLbl sizeToFit];


}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AudioOptionsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"AudioOptionsCell" forIndexPath:indexPath];
    NSString *audioPath;
    if(indexPath.row %2)
    {
        //[[[globalDictionary valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]
        if([[[[globalDictionary[@"object"] valueForKey:@"popup"]valueForKey:@"audio"] valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
        
            audioPath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary[@"object"] valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
        }
        else
        {
        
        }
    }
    else
    {

        NSString * str = [NSString stringWithFormat:@"%@/%@",phoneDocumentDirectory,@"records"];
        audioPath = [str stringByAppendingPathComponent:yourAudioPath];
       
    }
    if([[[NSString alloc] initWithFormat:@"%@",[AppDelegate getUserDefaultData:@"isPlay"]] isEqualToString:audioPath])
    {
       
      [cell.playPauseImgV setImage:[UIImage imageNamed:@"PauseIcon.png"]];
       
    }
    else
    {
        [cell.playPauseImgV setImage:[UIImage imageNamed:@"Play.png"]];
    }
    if(cell.isSelected){
        NSLog(@"SELECTEDDDDDDDD");
    }else{
        
        NSLog(@"NOTTTTTTTTT SELECTEDDDDDDDD");
    }
    if(indexPath.row %2){
        if([[[[globalDictionary[@"object"] valueForKey:@"popup"]valueForKey:@"audio"] valueForKey:@"is_filled"] isEqualToString:@"true"])
            {
              cell.textLbl.text = @"Model Answer";
              cell.hidden = FALSE;
            }
            else
            {
                cell.textLbl.text = @"";
                cell.hidden = TRUE;
            }
    }else{
        cell.textLbl.text = @"Your Answer";
    }
    


    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    NSString *audioPath;
    isSelected = true;
    if(indexPath.row %2)
    {
        if([[[[globalDictionary[@"object"] valueForKey:@"popup"]valueForKey:@"audio"] valueForKey:@"is_filled"] isEqualToString:@"true"])
        {
            
            audioPath = [phoneDocumentDirectory stringByAppendingPathComponent:[[[globalDictionary[@"object"] valueForKey:@"popup"]valueForKey:@"audio"]valueForKey:@"text"]];
           isSelectedAudio = 1;
        }
        else
        {
            
        }
    }
    else
    {

        NSString * str = [NSString stringWithFormat:@"%@/%@",phoneDocumentDirectory,@"records"];
        audioPath = [str stringByAppendingPathComponent:yourAudioPath];
        isSelectedAudio = 0;
    }
    
    
    
    
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:audioPath]){
       return;
    }
    
    
    
    AudioOptionsCell *cell = (AudioOptionsCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    NSError *err;
    if([[[NSString alloc] initWithFormat:@"%@",[AppDelegate getUserDefaultData:@"isPlay"]] isEqualToString:audioPath])
     {
         [self.audioPlayer stop];
         [cell.playPauseImgV setImage:[UIImage imageNamed:@"Play.png"]];
         [AppDelegate deleteUserDefaultData:@"isPlay"];
         [self.collectionView reloadData];
         return;
     }
    
    if([AppDelegate getUserDefaultData:@"isPlay"] != NULL)
    {
        return;
    }
    
    [self.audioPlayer stop];
    [cell.playPauseImgV setImage:[UIImage imageNamed:@"Play.png"]];
    self.audioPlayer = NULL;
    [self.collectionView reloadData];
    
    [cell.playPauseImgV setImage:[UIImage imageNamed:@"PauseIcon.png"]];
    self.audioPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[audioPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ] error:&err];
    [self.audioPlayer prepareToPlay];
    self.audioPlayer.delegate=self;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.audioPlayer play];
    [AppDelegate setUserDefaultData:audioPath:@"isPlay"];
    
    
    
    
//    [_delegate reloadTable];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
       [self.audioPlayer stop];
       self.audioPlayer =  NULL;
       [AppDelegate deleteUserDefaultData:@"isPlay"];
       [self.collectionView reloadData];

}


- (BOOL)collectionView:(UICollectionView *)collectionView
        shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
        shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}

-(void)handleTapOnLabel: (UITapGestureRecognizer *)recognizer{
    if(isTapOnLabel){
        isTapOnLabel = false;
    }else{
        isTapOnLabel = true;
    }
    [_delegate reloadTable];

}


@end


//Printing description of self->ansTrackArray:
//<__NSArrayM 0x6000002f37e0>(
//{
//    endTime = 1585219836875;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "50772.1.1";
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
//            text = "In this practice, you need to speak on your own for about 60 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;Topic:&lt;/b&gt; 'The Weather Where You Live'&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n- What is the weather like in the summer?&lt;br&gt;&lt;/br&gt;\n- How different is the weather in winter?&lt;br&gt;&lt;/br&gt;\n- Is the weather one of the reasons people like living where you live? Why / Why not?&lt;br&gt;&lt;/br&gt;\n- How important to you is good weather?";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/S10 1-3 Weather_Clubbed-1578376679.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = ": I live in England, but I think the weather is okay, although it can be quite changeable sometimes, because we're basically living on an island. So, one day it's possible that the sun is shining, the skies are blue and everyone's outside. Then the next day, it's pouring with rain and everyone's freezing cold. To be honest, I think our four seasons seem to have become a bit unpredictable, especially now that I'm always reading about how the world climate is changing, getting warmer everywhere. Our summers do seem to be getting hotter, and even our winters are warmer than they used to be, although we still expect snow in January and February. And of course, Great Britain is famous for its rain and you can expect rain in any season of the year, and at any time. We're famous for it. So, the summer weather is mostly good, and in fact, they seem to be getting warmer, if I'm honest. We've even had a couple of heatwaves in the past year or two. Having said that, it's important that we don't rely on sunny days, nor the weather forecast, because the forecasters very often get it all wrong, and we hear about festivals and holidays being ruined by rain in August! Oh goodness, the weather in winter really gets me down. It's definitely much cooler, and it always rains more, especially in the autumn. And it's quite likely that January and February will be the coldest months. There's always a good possibility of snow and ice. And winter weather, when it's very bad, affects everything. It all stops. cars, buses, trains, even planes!. Actually, you know, I think the British climate is quite mild. So it's good for people who don't like extremes of temperature. Some people find living in very hot or very cold climates really uncomfortable, so our weather is good for people who prefer temperatures that are neither too high, nor too low. I don't recommend the British climate for people who don't like wet weather though, it rains a lot, that's for sure. Well, yes, I guess good weather is important to me, I suppose. I don't mind the occasional rainy day, but day after day of rain makes can be a bit depressing, don't you think? Plus, I think everyone would agree that bad weather puts people into bad moods, so, um, I like sunny days best of all. And of course, when going on holiday, good weather is really important, especially if I'm planning outdoor activities. I like walking, but not in the rain.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 50772;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 50772;
//    "skill_id" = 2;
//    startTime = 1585219832451;
//    type = ra;
//},
//{
//    endTime = 1585219840411;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "50773.2.1";
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
//            text = "In this practice, you need to speak on your own for about 60 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;Topic:&lt;/b&gt; 'Qualities You Look For in a Friend'.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n- What is the most important quality that a friend of yours must possess?&lt;br&gt;&lt;/br&gt;\n- Do you think you will look for different qualities in friends when you get older? Why / Why not?&lt;br&gt;&lt;/br&gt;\n- Do you consider yourself to have qualities that make you a good friend to others? Why / Why not?&lt;br&gt;&lt;/br&gt;\n- If a friend has some bad qualities, what could be a reason for staying friends with that person?&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/S10 2-1 Qualities_Clubbed-1578377444.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "Well, in my opinion, I think we all look for different qualities in our friends. For me, the qualities I'd really most appreciate include honesty, kindness and loyalty. A friend's honesty is so important. I don't think any friendship can continue to exist if friends don't tell each other the truth. That means being able to speak from the heart and to be ready to help me when I make mistakes. A kind friend will also be there to help when I'm worried or have problems. They'll be someone to turn to when I need advice, and I'll be able to talk to them about anything without being judged. They'll also be there when times are tough, for example if I lose my job, or I'm not feeling well, they'll help me. And loyalty, well, that is maybe the most important quality, to be honest. Yes, I think life is very challenging these days, and we all need friends to see us through. A loyal friend will stay with me through thick and thin. Well, to be honest, I think the most important quality for me would be truthfulness. I mean, it would be impossible to stay friends with someone who keeps telling untruths, or lies, wouldn't it? How could you build a friendship on that? Yes, for me, the most important quality of a good friend would be honesty. Um, well yea, it depends. Maybe. I guess it's quite possible that my interests will change as I get older. So, yes, it's also possible that I will meet new people and make new friends with different qualities as my interests change. But I think it's also important to remember that a really good friend is often someone you've been friends with for a long time. I've still got several very good friends from my schooldays. Oh, gosh, I hope so! I'm often told that I am a very honest person, and I like helping people, especially my friends. Yes, I think being kind goes a long way to making me a good friend, I'll always try to help friends out if they are worried or need a favour. Um, well, to be honest, I think it depends on the sort of bad qualities we're talking about. If we are talking about a friend who seems to be bad tempered all the time, then it would be important to try and find out what the problem is, don't you think? Yea, and then help them to solve the difficulties they're facing. I couldn't just walk away, simply because they are in trouble. Then I'd be the bad friend!";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 50773;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 50773;
//    "skill_id" = 2;
//    startTime = 1585219837265;
//    type = ra;
//},
//{
//    endTime = 1585219843771;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "50774.3.1";
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
//            text = "In this practice, you need to speak on your own for about 60 seconds. &lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;Topic:&lt;/b&gt; 'Food You Like to Cook'&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n- How often do you cook meals?&lt;br&gt;&lt;/br&gt;\n- How did you learn to cook?&lt;br&gt;&lt;/br&gt;\n- What kind of meals would you like to be able to cook?&lt;br&gt;&lt;/br&gt;\n- How could you improve your cooking skills?&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/Clubbed_S10 1-3 Food-1578317155.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "Um, I think I'd have to choose Indian food as my favourite food to cook, if I'm honest. I know that many people say that Indian food is really hot and spicy, but actually I don't think that's always the case! Indian recipes come from over 100 regions of the country, and there's a huge variety of different types of dishes to choose from, and many of them are vegetarian too. In fact, most recipes that I use include lots of fresh vegetables and herbs, which are all delicious, and actually are very good for you. Some of the spices can even improve your health, for example turmeric, ginger and green chillies. And you don't always have to fry the food. I use lots of different methods, roasting, grilling, boiling, etc. But if you ask me to choose my favourite dish, I'd say my favourite dish to cook is Tandoori chicken. it's chicken that is cooked in a very hot oven, in a special spice and yoghurt sauce, and served with lovely basmati rice, and fresh herbs or salad, it's absolutely delicious and so easy to make. My family and friends love it. Not as often as I'd like to, to be honest, I have lots of recipe books and very little time. I work, so I never have time to cook a proper lunch, unless it's the weekend, and I'm at home. I do manage to cook most evenings, even if it's something quite simple like a pasta dish. I look forward to Sundays though, because that's the day I can cook a big lunch, and the whole family come around. It's fabulous. Well, I must thank my Mum for helping me to learn how to cook family favourites, I spent hours with her in the kitchen, just watching cook all sorts of exciting things. One of my earliest memories is baking cakes, standing on a chair and stirring the cake mix. I learned a lot from my mum. But I learned a lot in school too. we had timetabled cookery lessons, and I loved making something new each week, and taking it home for the family to try. I watch a lot of cookery programmes on TV now, they are really helpful too. Let me think, yes, I'd like to learn more about the Japanese style of cooking, actually. This seems to be coming into fashion now, and I know it's a really healthy way of eating. I see sushi and ramen bars popping up all over the town, and across the country, and it all seems to be getting very popular, as well. Well I guess the best way to improve is to take cookery classes, but that's quite time consuming. There are lots of cookery programmes on the TV nowadays too, and I do try and watch them when I can, I think I can learn lots from professional TV chefs.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 50774;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 50774;
//    "skill_id" = 2;
//    startTime = 1585219840736;
//    type = ra;
//},
//{
//    endTime = 1585219847260;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "51793.4.1";
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
//            text = "In this practice, you need to speak on your own for about 60 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;Topic:&lt;/b&gt; 'What does it mean to have a pet?'&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n- If you have a pet, what are the benefits? If not, what are the benefits of having a pet?&lt;br&gt;&lt;/br&gt;\n- What are the responsibilities that go with having a pet?&lt;br&gt;&lt;/br&gt;\n- Are some pets better to have than others? Why / Why not?&lt;br&gt;&lt;/br&gt;\n- Are there some people who should not have pets? Why / Why not?&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/S10.4-5 Pet_clubbed-1578377511.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "I think having a pet in some ways brings the same responsibilities as having a child. I mean, animals are living beings, so they need to be cared for. They don't take care of themselves, in fact they can't, can they? So, if you are thinking of having a dog or a cat, or any type of animal that needs regular feeding, walking or exercising, then you'll just need to accept that you are taking on that responsibility. The animal will depend on you for every single thing, and you should be prepared to take care of it forever. Yes, you'll definitely need extra time to take of the animal properly. It also means an added expense for taking care of food and vet bills, and even for someone to take care of the pet when you travel or go on holiday. So I guess what I'm actually saying is that the decision to have a pet is a decision to take on responsibility for the animal, and a commitment to look after it for its entire life, basically. Option A: has a pet: Well actually, I've got the most beautiful dog called George. He's a sheepdog, and so the first benefit is that he loves going for a walk at least twice a day, and more, if possible, so there's the first advantage. I get lots of exercise! And when I get stressed, I know that he will always be there, and greet me with his wagging tail, and he makes me feel a whole lot better. He's such a sociable dog, yes, huge benefits for me. Option B: no pet: Um, I've never had a pet, but I can just imagine what the benefits might be. I mean, some pets need regular exercise don't they? You'd get enormous benefits from taking a dog out to walk once or twice a day. I've read many articles how animals can reduce stress too, simply by patting or stroking them, and that they can even help with medical conditions. And pets are great company, especially for people who live on their own. Well, to be frank, I don't think anyone should get a pet without first thinking about their lifestyle. Apart from anything else, there are so many pets to choose from, and so many things to think about to take care of them properly. Well, you'd have to ask yourself lots of different questions, for example a puppy needs a lot of time and attention, so, have you got the energy? They can't be left alone for long. And if you work long hours, is it really fair to leave a pet alone at home? Even cats need some kind of company. You'll need to make sure that you've got room at home to keep them too, dogs and cats both need beds, and might even need toys. So you need to accept that they are going to cost you money too. Option A: some pets are better: Oh definitely, I think some animals make much better pets than others. It depends what you want from having a pet, I mean, take dogs. they generally make great pets because they actually interact with humans. And, you can go for walks together, play games with dogs, and build up a relationship. Um, whereas cats tend to be more independent, and don't necessarily need that much human interaction. Option B: no pets are better than others : I can't think of any pet that is better than another, to be honest. If you want to keep an animal, no matter what it is, it'll need to be looked after. Dogs, cats, birds, even pets like tortoises and fish, well, they are all living beings, and they will need feeding and attention. Of course, people who live busy lives and are always working should think very carefully about having a pet. You ca't leave animals alone all the time, they need attention, even if it's only cleaning out their cage and providing them with the basics. And if you haven't got much room, or have family members with allergies, you'd have to think carefully about having a pet.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 51793;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 51793;
//    "skill_id" = 2;
//    startTime = 1585219844162;
//    type = ra;
//},
//{
//    endTime = 1585219850251;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 90;
//                };
//                uniqid = "51794.5.1";
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
//            text = "Here are two pictures showing scenes related to the news. Based on what you can see in the pictures, speak for about 60 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nWhat do you think are the advantages and disadvantages of seeing news on television compared to reading newspapers? Speak for 30 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1459/course/module2/scenario4/media/Picture3-1578379157.png";
//        };
//        instruction =         {
//            text = "";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/S12.1a-1578313560.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "Well, in the first picture, I can see a young woman who is standing outside what is possibly an office building, and she's reading a newspaper. It seems she's paying very close attention to whatever she's reading, it seems to be a newspaper that has a lot of data on it, so perhaps it is a financial newspaper. She's dressed very well, in a white suit, so perhaps it's a business newspaper. It's also quite a large newspaper, so it must be difficult to turn the pages, because she's standing up. The second picture is very different. This is clearly a classroom, and there's a group of children, sitting at tables and on chairs, all looking towards a small television at the front of the class. Yes, there are also two presenters on the screen, and from the way that they are sitting, side by side, okay, they look like they are presenting a news programme of some sorts. There are two adults at the front of the class; they are most probably the teachers, and one of them has their hand raised, possibly asking a question about the news programme. Perhaps the children are watching the daily news? Well, in my opinion, the biggest advantage of TV news is that you can get closer to the actual event, because you can see what is going on, as well as hearing about it too. When you read a newspaper, you're a little removed from the event. For example, watching a news report about a wedding, you can see the people getting married, the clothes, the guests, the flowers, and it becomes more alive in your mind. That makes it more emotional too. If you're reading about it you might have a photograph, but everything is written in the past, so it's all over and finished. But I'd agree that there are drawbacks too. The news items are chosen by programme editors, so you have less choice in what you see and hear, and news broadcasts also limited in time too. There may be less coverage of important stories, so if you are really interested in a particular item, maybe you'd have to go out and buy a newspaper to find out all the details.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 51794;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 51794;
//    "skill_id" = 2;
//    startTime = 1585219847629;
//    type = ra;
//},
//{
//    endTime = 1585219853575;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "51797.6.1";
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
//            text = "This is a role play, where you have to speak based on a given situation and a goal. You have 15 seconds to prepare.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;The situation&lt;/b&gt;: You are a student. You help to produce a student newspaper in your school.The examiner is your teacher.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n&lt;b&gt;Your goal&lt;/b&gt;: You want to persuade your teacher to write a short article for your student newspaper.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n\n- But I couldn\U2019t write anything interesting to the students.&lt;br&gt;&lt;/br&gt;\n- How long would the article have to be?&lt;br&gt;&lt;/br&gt;\n- What other articles will there be in the newspaper?&lt;br&gt;&lt;/br&gt;\n- OK, I\U2019ll see what I can do?&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/Level3_6-1583727210.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "You are a student and you help to produce a student newspaper in your school. I am your teacher, and you want me to write a short article for your newspaper. Alright? You start. Good morning, Mrs White, thanks for seeing me. Iu2019m just come to remind you that the next edition of u201cGreenbridge High School Newsu201d is coming out in term 3. Itu2019s our most important edition, because itu2019s the end of the school year. The team have been thinking, and weu2019d really love you to write a short article. for it. We are running a feature called u201cTeacher of the Yearu201d, and youu2019re the lucky teacher. But I couldn't write anything interesting to the students. Oh, we're sure you can. we know all about the interesting things that you've done this year. You took a group of students to Madrid, and you also helped to organise a cake sale to raise money for the local hospital. And don't forget your class won that singing competition. There's loads to write about. How long would the article have to be? We'd like to have a two- page article, so it would be about a thousand words, but we hope to include photographs too. What other articles will there be in the newspaper? Um, we've got lots of other articles. We are writing about the new school sports centre, and some students have written about the school trip to the theatre. We've got a crossword competition, and the Headteacher is going to write the Editorial. We'll have a letters page too, so it's really exciting. OK, I'l see what I can do? Oh, thank you so much, this is great, everyone will be very pleased.";
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
//            text = right;
//        };
//        skill =         {
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 51797;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 51797;
//    "skill_id" = 2;
//    startTime = 1585219850684;
//    type = ra;
//},
//{
//    endTime = 1585219856735;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 90;
//                };
//                uniqid = "51798.7.1";
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
//            text = "Here are two pictures showing different types of holiday accommodation. Based on what you can see in the pictures, speak for about 60 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nWhat kind of people would each place appeal to? Why? Speak for 30 seconds.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
//            };
//            qform =             {
//                text = t;
//            };
//            text = "";
//        };
//        image =         {
//            "is_filled" = true;
//            text = "PracticeApp/CRS-1459/course/module2/scenario4/media/Picture4-1578379452.png";
//        };
//        instruction =         {
//            text = "";
//        };
//        popup =         {
//            audio =             {
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/Level3_7-1583727590.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "In the first picture, there is a very large, modern style hotel. It's what you'd expect a hotel to look like. There seems to be lots of rooms, and it looks as though there are two parts to the hotel, with a long building, and a round annex. The rooms all have balconies, and they look over a very big, swimming pool that is surrounded by palm trees. There are lots of sun beds by the pool, so that suggests that holidaymakers at this hotel might like to spend part of their time lying by the swimming pool, although the weather looks a little bit cloudy. In the second picture, the holiday accommodation looks less luxurious, but more natural. The rooms seem to be made of wood, with straw roofs, and it's a very natural setting, with palm trees and bushes. It could even be in a jungle. There isn't a swimming pool, but there are tables and chairs in front of the cabins, in what looks like a little garden area. The tables and chairs are also in a shady part of the garden, so it would be good for people who are not so keen on sitting in the sun. Well, the kind of people who would enjoy staying at the big hotel, I think, would be people who enjoy more traditional type of holiday accommodation. I'd guess that they'd have everything made available to them, with comfortable bedrooms, different restaurants to choose from, and the chance to spend lazy days by the pool. In fact, they'd probably be able to do everything they want to do in the hotel, and not have to leave to get anything else. The second picture shows accommodation that might appeal to people who enjoy looking after themselves on holiday. I mean, the rooms look quite basic, so it's possible that guests would have to cook their own food, and maybe they eat meals in the garden. I imagine that people staying in this style of accommodation wouldn't be the type to sit around a pool all day but would be going into the jungle or forest behind their room and getting back to nature.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 51798;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 51798;
//    "skill_id" = 2;
//    startTime = 1585219854004;
//    type = ra;
//},
//{
//    endTime = 1585219860302;
//    object =     {
//        answers =         {
//            answer =             {
//                "content_type" =                 {
//                    text = audio;
//                };
//                text = "";
//                "time_limit" =                 {
//                    text = 60;
//                };
//                uniqid = "51801.8.1";
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
//            text = "This is a role play, where you have to speak based on a given situation and a goal. Take 15 seconds to prepare.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n&lt;b&gt;The situation&lt;/b&gt;: You want to go camping, but you don\U2019t want to go alone.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n&lt;b&gt;Your goal&lt;/b&gt;: Persuade your friend to go with you.&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\nUse the following hints as you speak:&lt;br&gt;&lt;/br&gt;&lt;br&gt;&lt;/br&gt;\n\n- I don\U2019t have a tent.&lt;br&gt;&lt;/br&gt;\n- The weather might not be good.&lt;br&gt;&lt;/br&gt;\n- We can\U2019t watch television in the evening.&lt;br&gt;&lt;/br&gt;\n- I don\U2019t know how to cook without a kitchen.&lt;br&gt;&lt;/br&gt;";
//        };
//        "evaluation_subtype" =         {
//            text = 0;
//        };
//        "evaluation_type" =         {
//            text = 0;
//        };
//        feedbacks =         {
//            text = "";
//        };
//        format =         {
//            aform =             {
//                text = t;
//            };
//            delivery =             {
//                text = ra;
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
//                "is_filled" = true;
//                text = "PracticeApp/CRS-1459/course/module2/scenario4/media/S13.2a-1578313853.mp3";
//            };
//            image =             {
//                "is_filled" = false;
//                text = "";
//            };
//            paragraph =             {
//                text = "Hi! There's a music festival on at Deer Lake this weekend. I've got tickets, and I'm going to camp out for a couple days. I'll be so bored on my own, I'd love you to come with me. Would you come? I don't have a tent. Well, don't worry, you don't need one. I've just bought a brand new one, it's fabulous. It's super spacious, it's got three rooms, you'd have your own bedroom. The weather might not be good. I've checked in the newspaper, and online - it's going to be sunny and warm all weekend. We can't watch television in the evening. There is a huge outside TV screen that will be on every night. You can use it if you really want to, but you won't want to watch television. there are so many musicians and acts on and guess who is the headline act. your favourite singer, Ted Sheehan. I don't know how to cook without a kitchen. Well it's only a couple of days, and there are plenty of cafes to choose from. I've packed lots of salads and sandwiches too, so we won't be hungry. Ok. I will join you. It could be fun after all.";
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
//            id = 2;
//            text = Speaking;
//        };
//        text = "";
//        uniqid = 51801;
//        video =         {
//            "is_filled" = false;
//            text = "";
//        };
//    };
//    option =     (
//        "(null)_71725_50772.mp4",
//        "(null)_71725_50773.mp4",
//        "(null)_71725_50774.mp4",
//        "(null)_71725_51793.mp4",
//        "(null)_71725_51794.mp4",
//        "(null)_71725_51797.mp4",
//        "(null)_71725_51798.mp4",
//        "(null)_71725_51801.mp4"
//    );
//    quesId = 51801;
//    "skill_id" = 2;
//    startTime = 1585219857170;
//    type = ra;
//}
//)
//(lldb)
