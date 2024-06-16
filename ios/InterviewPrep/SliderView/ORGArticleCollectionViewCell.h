//
//  ORGArticleCollectionViewCell.h
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/23/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORGArticleCollectionViewCell : UICollectionViewCell
@property  UIImageView *courseImage;
@property  UILabel *courseName;
@property  UILabel *courseDesc;
@property  UILabel *numberOfChap;
@property  UILabel *price;
@property  UIView * progress;
@property  UIImageView * downloadView;
@property  UILabel * updateText;


@end
