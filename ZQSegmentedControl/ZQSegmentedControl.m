//
//  ZQSegmentedControl.m
//  ZQSegmentedControlExample
//
//  Created by 秦智康 on 2016/11/4.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import "ZQSegmentedControl.h"

@interface UISegmentedControl()
- (void)highlightSegment:(int)index;
- (void)_setSelectedSegmentIndex:(long long)arg1 notify:(bool)arg2 animate:(bool)arg3;
@end

@implementation ZQSegmentedControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)highlightSegment:(int)index {
    [super highlightSegment:index];
    if (self.canSlide) {
        if (index != -1) {
            [super _setSelectedSegmentIndex:index notify:YES animate:YES];
        }
    }
}

- (void)setup {
    _canSlide = YES;
    _orientation = ZQSegmentedControlHorizontal;
}

- (void)setOrientation:(ZQSegmentedControlOrientation)orientation {
    _orientation = orientation;
    CGRect frame = self.frame;
    if (orientation == ZQSegmentedControlVertical) {
        self.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    subView.transform = CGAffineTransformMakeRotation(- M_PI / 2.0);
                }
            }];
        }];
    } else if (orientation == ZQSegmentedControlHorizontal) {
        self.transform = CGAffineTransformIdentity;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([subView isKindOfClass:[UILabel class]]) {
                    subView.transform = CGAffineTransformIdentity;
                }
            }];
        }];
    }
    self.frame = frame;
    
}

@end
