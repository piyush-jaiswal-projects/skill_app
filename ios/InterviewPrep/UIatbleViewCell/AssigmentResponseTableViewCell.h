//
//  AssigmentResponseTableViewCell.h
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GetResponseTextDelegate <NSObject>

-(void)getResponseText:(NSString *)response;

@end

@interface AssigmentResponseTableViewCell : UITableViewCell<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextView *responseTxtView;
@property (weak, nonatomic) IBOutlet UILabel *alphabetLbl;
@property (weak, nonatomic) IBOutlet UILabel *headingLbl;
@property (nonatomic, weak) id<GetResponseTextDelegate> delegate;



-(void)configureCell:(NSDictionary*)responseDict;

@end

NS_ASSUME_NONNULL_END
