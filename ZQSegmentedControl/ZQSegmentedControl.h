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

@interface ZQSegmentedControl : UISegmentedControl
/**
 If YES, user can slide your finger on segments like UISlider. Default is NO.
 */
@property (nonatomic) BOOL canSlide;
/**
 The orientation of the SegmentedControl. Default is Horizontal.
 */
@property (nonatomic) ZQSegmentedControlOrientation orientation;
@end
