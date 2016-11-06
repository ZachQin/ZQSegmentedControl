//
//  ZQSegmentedControl.h
//  ZQSegmentedControlExample
//
//  Created by 秦智康 on 2016/11/4.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZQSegmentedControlOrientation) {
    ZQSegmentedControlHorizontal,
    ZQSegmentedControlVertical
};

typedef NS_ENUM(NSUInteger, ZQSegmentedControlPopViewDirection) {
    ZQSegmentedControlAbove,
    ZQSegmentedControlBelow
};

@class ZQSegmentedControl;
@protocol ZQSegmentControlDataSource <NSObject>
- (NSString *)segmentControl:(ZQSegmentedControl *)segmentControl popViewTitleForIndex:(NSInteger)index;
@end

@interface ZQSegmentedControl : UISegmentedControl
/**
 If YES, user can slide your finger on segments like UISlider. Default is NO.
 */
@property (nonatomic) BOOL canSlide;
/**
 The orientation of the SegmentedControl. Default is Horizontal.
 */
@property (nonatomic) ZQSegmentedControlOrientation orientation;
@property (weak) id<ZQSegmentControlDataSource> datasource;
@property (nonatomic) BOOL showPopView;
@property (nonatomic) NSTimeInterval popViewTimeOut;
@property (nonatomic) ZQSegmentedControlPopViewDirection popDirection;
@property (nonatomic) CGFloat popArrowLength;
@property (nonatomic) CGFloat popCornerRadius;
@property (nonatomic, copy) UIColor *popBackgroundColor;
@property (nonatomic, copy) UIColor *popTitleColor;
@property (nonatomic, copy) UIFont *popFont;
@end
