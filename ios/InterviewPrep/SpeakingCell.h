//
//  SpeakingCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 26/03/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@protocol loadTable <NSObject>
-(void)reloadTable;

@end

@interface SpeakingCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,AVAudioPlayerDelegate> {
    
    BOOL isTapOnLabel;
    NSString *phoneDocumentDirectory;
    NSDictionary *globalDictionary;
    int isSelectedAudio;
    NSInteger isSelectedIndex;
    NSInteger lastSelectedIndex;
    NSString *yourAudioPath;
    NSMutableArray *imagesArray;
    BOOL isSelected;



}
@property (weak, nonatomic) IBOutlet UILabel *quesLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesDetailLbl;
@property (nonatomic, weak) id<loadTable> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collVHgtConstraint;
@property (nonatomic,strong)AVAudioPlayer *audioPlayer;
//@property (strong, nonatomic)  NSMutableArray *imagesArray;




-(void)configureCell:(NSDictionary *)responseDict selectedIndex:(int)selectedIndex;

@end

NS_ASSUME_NONNULL_END
