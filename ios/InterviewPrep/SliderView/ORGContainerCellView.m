//
//  ORGContainerCellView.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "ORGContainerCellView.h"
#import "ORGArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "baseViewController.h"

@interface ORGContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    AppDelegate * appDelegate;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end

@implementation ORGContainerCellView

- (void)awakeFromNib {

  [super awakeFromNib];
    appDelegate = APP_DELEGATE;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(180.0, 190.0);
    [self.collectionView setCollectionViewLayout:flowLayout];

    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];

}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
    
    unsigned int hexint = [self intFromHexString:hexStr];
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:alpha];
    
    return color;
    
}


- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    return hexInt;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
 ORGArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ORGArticleCollectionViewCell" forIndexPath:indexPath];
    
 
    
    
    cell.clipsToBounds = YES;
    
    cell.contentView.layer.cornerRadius = 1.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [self getUIColorObjectFromHexString:@"#f2f2f2" alpha:1.0].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    // yourButton.layer.cornerRadius = 10; // this value vary as per your desire
    cell.clipsToBounds = YES;
    
    
//    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
//    cell.layer.shadowRadius = 1.0f;
//    cell.layer.shadowOpacity = 2.0f;
//    cell.layer.masksToBounds = NO;
//    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.courseImage =  (UIImageView*)[cell.contentView viewWithTag:1];
    if (!cell.courseImage) {
        cell.courseImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, cell.frame.size.width-2,100 )];
        cell.courseImage.tag =1;
    }
    
    NSString *imageUrl = [[NSString alloc]initWithFormat:@"%@%@",DOCUMENETSSERVERPATH,[cellData objectForKey:@"imgPath"]];
    UIImage *Limg = NULL;
    Limg = [[UIImage alloc] initWithData:[appDelegate getUserDefaultData:imageUrl]];
    if(Limg == NULL ){
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            UIImage * _img = [UIImage imageWithData:data];
            if(_img != NULL)
            {
                cell.courseImage.image = _img;
                [appDelegate setUserDefaultData:data :imageUrl];
            }
            else
            {
                cell.courseImage.image = _img;
            }
            
        }];
    }
    else
    {
        cell.courseImage.image = Limg;
    }
    
    
    //cell.courseImage.image = [UIImage imageNamed:[cellData objectForKey:@"imgPath"]];
    [cell.contentView addSubview:cell.courseImage];
    
    
    cell.courseName =  (UILabel*)[cell.contentView viewWithTag:2];
    if (!cell.courseName) {
        
     cell.courseName = [[UILabel alloc]initWithFrame:CGRectMake(10, 115, cell.frame.size.width-20,15)];
        cell.courseName.font = TEXTTITLEFONT;
        cell.courseName.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
     cell.courseName.tag =2;
    }
     cell.courseName.text = [cellData objectForKey:@"name"];
     [cell.contentView addSubview:cell.courseName];
    
    cell.courseDesc =  (UILabel*)[cell.contentView viewWithTag:3];
    if (!cell.courseDesc) {
        cell.courseDesc = [[UILabel alloc]initWithFrame:CGRectMake(10, 132, cell.frame.size.width-20,10)];
        cell.courseDesc.font = SUBTEXTTILEFONT;
        cell.courseDesc.textColor =  [self getUIColorObjectFromHexString:DEFAULTLIGHTTEXTCOLOR alpha:1.0];
        cell.courseDesc.tag =3;
    }
    cell.courseDesc.text = [cellData objectForKey:@"desc"];
    
    [cell.contentView addSubview:cell.courseDesc];
    
    
    cell.numberOfChap =  (UILabel*)[cell.contentView viewWithTag:4];
    if (!cell.numberOfChap) {
        cell.numberOfChap = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, cell.frame.size.width-20,12)];
        cell.numberOfChap.font = SUBTEXTTILEFONT;
        cell.numberOfChap.textColor = [UIColor redColor];
        cell.numberOfChap.tag =4;
    }
    cell.numberOfChap.text = [[NSString alloc]initWithFormat:@"%@ Chapters",[cellData objectForKey:@"total_chapters"]];
    [cell.contentView addSubview:cell.numberOfChap];
    
    
    
    cell.price =  (UILabel*)[cell.contentView viewWithTag:5];
    if (!cell.price) {
        cell.price = [[UILabel alloc]initWithFrame:CGRectMake(10, 168, cell.frame.size.width-20,15)];
        cell.price.font = NAVIGATIONTITLEFONT;
        cell.price.textColor =  [self getUIColorObjectFromHexString:DEFAULTTEXTCOLOR alpha:1.0];
        cell.price.tag =5;
    }
        
    cell.price.text = [cellData objectForKey:@"price"];
    [cell.contentView addSubview:cell.price];
    
    
   
    cell.downloadView =  (UIImageView*)[cell.contentView viewWithTag:6];
    if (!cell.downloadView) {
        cell.downloadView = [[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width-50, 150, 40,40 )];
        cell.downloadView.tag =6;
    }
    
    cell.downloadView.image = [UIImage imageNamed:@"course_new"];
    [cell.contentView addSubview:cell.downloadView];
    
    
    
//    cell.numberOfChap.text = [cellData objectForKey:@"total_chapters"];
//    cell.courseDesc.text = [cellData objectForKey:@"description"];
//    cell.price.text = [cellData objectForKey:@"price"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}


@end
