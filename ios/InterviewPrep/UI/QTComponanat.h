//
//  QTComponanat.h
//  InterviewPrep
//
//  Created by Amit Gupta on 25/09/17.
//  Copyright © 2017 Liqvid. All rights reserved.
//

#import "baseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface QTComponanat : baseViewController<AVAudioPlayerDelegate,UITextViewDelegate,UITextFieldDelegate,AVAudioRecorderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    //IBOutlet UINavigationBar * navBarPlayer;
    NSMutableDictionary * data;
    int sanaAttemptCounter;
    NSTimer * expertAudioTimer;
}

@property NSString * assessnetUid;
@property NSString * cusTitleName;
@property NSString * TopicName;

@property NSString * scnUid;
@property int type;
@property NSString*  selectedLevel;
@property NSDictionary * testOBj;
@property BOOL isRemediation;
@property NSMutableDictionary *skillObj;
@property BOOL isResumeStart;


-(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width;
-(void)showFeedback:(NSString *)ansId :(BOOL)isTrue :(NSString *)quesType;
-(NSMutableArray *)randomOptionArr :(NSMutableArray *)arr :(BOOL)isForcely;
-(NSMutableDictionary *)createDictionaryifNot :(NSDictionary *) quesObj type:(NSString *)type  Time:(NSString * )duration;
-(void)addOrReplace : (NSMutableDictionary *)obj;
-(void)disableQuizBtn;
-(void)enableQuizBtn;
-(UITapGestureRecognizer * )addMCTapgasture;



@end

