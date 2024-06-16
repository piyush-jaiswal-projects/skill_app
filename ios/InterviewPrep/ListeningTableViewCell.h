//
//  OptionsImageTableViewCell.h
//  InterviewPrep
//
//  Created by Amit Gupta on 26/02/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListeningTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    BOOL isTapOnLabel;
    NSString *selectedOption;
    NSString *phoneDocumentDirectory;


}
@property (weak, nonatomic) IBOutlet UICollectionView *imageOptionsCollectionsView;
@property (weak, nonatomic) IBOutlet UILabel *quesLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesDetailLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collVHgtConstraint;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLbl;
@property (weak, nonatomic) IBOutlet UILabel *ansLbl;
@property (weak, nonatomic) IBOutlet UIImageView *plusImgV;
@property (weak, nonatomic)  NSArray *answerArray;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


-(void)configureCell:(NSDictionary *)responseDict;


@end

NS_ASSUME_NONNULL_END
