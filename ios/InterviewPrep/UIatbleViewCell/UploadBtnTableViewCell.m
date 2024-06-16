//
//  UploadBtnTableViewCell.m
//  Willey
//
//  Created by Amit Gupta on 03/03/20.
//  Copyright © 2020 Dharmender Sharma. All rights reserved.
//

#import "UploadBtnTableViewCell.h"

@implementation UploadBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.uploadBtn.layer setCornerRadius:10.0];
    self.uploadBtn.clipsToBounds = true;
    self.uploadBtn.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)configureCell:(NSDictionary*)responseDict{
    if([responseDict[@"teacher_evaluated"] isEqualToString:@"yes"]){
    }else{
        [self.uploadBtn setBackgroundImage:[UIImage imageNamed:@"uploadIcon.png"] forState:UIControlStateNormal];
    }         
}

- (IBAction)uploadBtnAction:(id)sender {
    [_delegate uploadAndDownloadAssesment];
}


@end
