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
@property (nonatomic) BOOL canSlide;
@property (nonatomic) ZQSegmentedControlOrientation orientation;
@end
