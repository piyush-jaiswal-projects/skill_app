//
//  InterviewPrep-Swift.h
//  InterviewPrep
//
//  Created by Amit Gupta on 13/01/20.
//  Copyright © 2020 Liqvid. All rights reserved.
//

#ifndef InterviewPrep_Swift_h
#define InterviewPrep_Swift_h

@import Charts;
@import CoreGraphics;
@import ObjectiveC;
@import UIKit;


@class UIColor;
@class UIFont;
@class ChartDataEntry;
@class ChartHighlight;

SWIFT_CLASS("InterviewPrep_BalloonMarker")
@interface BalloonMarker : ChartMarkerImage
@property (nonatomic, strong) UIColor * _Nonnull color;
@property (nonatomic) CGSize arrowSize;
@property (nonatomic, strong) UIFont * _Nonnull font;
@property (nonatomic, strong) UIColor * _Nonnull textColor;
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGSize minimumSize;
- (nonnull instancetype)initWithColor:(UIColor * _Nonnull)color font:(UIFont * _Nonnull)font textColor:(UIColor * _Nonnull)textColor insets:(UIEdgeInsets)insets OBJC_DESIGNATED_INITIALIZER;
- (CGPoint)offsetForDrawingAtPoint:(CGPoint)point SWIFT_WARN_UNUSED_RESULT;
- (void)drawWithContext:(CGContextRef _Nonnull)context point:(CGPoint)point;
- (void)refreshContentWithEntry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight;
- (void)setLabel:(NSString * _Nonnull)newLabel;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class ChartAxisBase;
@class ChartViewPortHandler;

SWIFT_CLASS("InterviewPrep_LargeValueFormatter")
@interface LargeValueFormatter : NSObject <IChartAxisValueFormatter, IChartValueFormatter>
/// Suffix to be appended after the values.
/// <em>default</em>: suffix: [””, “k”, “m”, “b”, “t”]
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull suffix;
/// An appendix text to be added at the end of the formatted value.
@property (nonatomic, copy) NSString * _Nullable appendix;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithAppendix:(NSString * _Nullable)appendix OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler SWIFT_WARN_UNUSED_RESULT;
@end

@class UILabel;
@class NSCoder;

SWIFT_CLASS("InterviewPrep_RadarMarkerView")
@interface RadarMarkerView : ChartMarkerView
@property (nonatomic, strong) IBOutlet UILabel * _Nullable label;
- (void)awakeFromNib;
- (void)refreshContentWithEntry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("InterviewPrep_XYMarkerView")
@interface XYMarkerView : BalloonMarker
@property (nonatomic, strong) id <IChartAxisValueFormatter> _Nullable xAxisValueFormatter;
- (nonnull instancetype)initWithColor:(UIColor * _Nonnull)color font:(UIFont * _Nonnull)font textColor:(UIColor * _Nonnull)textColor insets:(UIEdgeInsets)insets xAxisValueFormatter:(id <IChartAxisValueFormatter> _Nonnull)xAxisValueFormatter OBJC_DESIGNATED_INITIALIZER;
- (void)refreshContentWithEntry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight;
- (nonnull instancetype)initWithColor:(UIColor * _Nonnull)color font:(UIFont * _Nonnull)font textColor:(UIColor * _Nonnull)textColor insets:(UIEdgeInsets)insets SWIFT_UNAVAILABLE;
@end


#endif /* Demo2_Swift_h */
