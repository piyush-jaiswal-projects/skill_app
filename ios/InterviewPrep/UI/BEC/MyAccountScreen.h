//
//  MyAccountScreen.h
//  InterviewPrep
//
//  Created by Amit Gupta on 18/06/19.
//  Copyright © 2019 Liqvid. All rights reserved.
//

#import "baseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyAccountScreen : baseViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>


@property NSString * title;
@end

NS_ASSUME_NONNULL_END
