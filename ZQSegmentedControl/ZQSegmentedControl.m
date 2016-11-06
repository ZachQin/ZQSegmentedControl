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

@interface ZQSegmentedControl ()
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UILabel *popLabel;
@end

@implementation ZQSegmentedControl {
    CAShapeLayer *_popShapeLayer;
    NSString *_currentPopTitle;
    NSInteger _popSegmentIndex;
    CGFloat _widthPopPadding;
    CGFloat _heightPopPadding;
}

#pragma mark - **************** init
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

- (void)setup {
    _canSlide = YES;
    _orientation = ZQSegmentedControlHorizontal;
    // ------Set the pop view
    _popView = [[UIView alloc] initWithFrame:CGRectZero];
    _popDirection = ZQSegmentedControlAbove;
    _popArrowLength = 13.0;
    _popCornerRadius = 4.0;
    
    
    _popBackgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    _popTitleColor = [UIColor whiteColor];
    _popFont = [UIFont systemFontOfSize:16];
    _widthPopPadding = 10.0;
    _heightPopPadding = 8.0;
    _showPopView = YES;
    
    _popShapeLayer = [CAShapeLayer layer];
    _popShapeLayer.fillColor = _popBackgroundColor.CGColor;
    [_popView.layer addSublayer:_popShapeLayer];
    
    _popLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _popLabel.textAlignment = NSTextAlignmentCenter;
    _popLabel.font = _popFont;
    _popLabel.textColor = _popTitleColor;
    [_popView addSubview:_popLabel];
    [self addSubview:_popView];
}

#pragma mark - **************** override
- (void)highlightSegment:(int)index {
    [super highlightSegment:index];
    if (self.canSlide) {
        if (index != -1) {
            [self _setSelectedSegmentIndex:index notify:YES animate:YES];
        }
    }
}

- (void)_setSelectedSegmentIndex:(long long)arg1 notify:(bool)arg2 animate:(bool)arg3 {
    if (arg1 == self.selectedSegmentIndex) {
        return;
    }
    if ([self.datasource respondsToSelector:@selector(segmentControl:popViewTitleForIndex:)]) {
        _popSegmentIndex = arg1;
        _currentPopTitle = [self.datasource segmentControl:self popViewTitleForIndex:_popSegmentIndex];
        if (_showPopView) {
            [self showPopViewAtIndex:_popSegmentIndex title:_currentPopTitle];
        }
    }
    [super _setSelectedSegmentIndex:arg1 notify:arg2 animate:arg3];
}

#pragma mark - **************** setter/getter

- (void)setOrientation:(ZQSegmentedControlOrientation)orientation {
    _orientation = orientation;
    CGRect frame = self.frame;
    if (orientation == ZQSegmentedControlVertical) {
        self.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (view == _popView) {
//                return;
//            }
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

- (void)setPopFont:(UIFont *)popFont {
    _popFont = popFont;
    _popLabel.font = popFont;
}

- (void)setPopColor:(UIColor *)popColor {
    _popBackgroundColor = popColor;
    _popShapeLayer.fillColor = popColor.CGColor;
}

- (void)setPopDirection:(ZQSegmentedControlPopViewDirection)popDirection {
    _popDirection = popDirection;
    if (_showPopView && _currentPopTitle) {
        [self showPopViewAtIndex:_popSegmentIndex title:_currentPopTitle];
    }
}

- (void)setShowPopView:(BOOL)showPopView {
    _showPopView = showPopView;
    if (_showPopView && _currentPopTitle) {
        [self showPopViewAtIndex:_popSegmentIndex title:_currentPopTitle];
    }
}

- (void)setPopTitleColor:(UIColor *)popTitleColor {
    _popTitleColor = popTitleColor;
    _popLabel.textColor = popTitleColor;
}

#pragma mark - **************** private



/**
 Generate pop shape path. Borrow from ASValueTrackingSlider. https://github.com/alskipp/ASValueTrackingSlider/blob/master/ASValueTrackingSlider/ASValuePopUpView.m
 */
- (UIBezierPath *)pathForRect:(CGRect)rect withArrowOffset:(CGFloat)arrowOffset;
{
    if (CGRectEqualToRect(rect, CGRectZero)) return nil;
    
    rect = (CGRect){CGPointZero, rect.size}; // ensure origin is CGPointZero
    
    // Create rounded rect
    CGRect roundedRect = rect;
    roundedRect.size.height -= _popArrowLength;
    UIBezierPath *popUpPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:_popCornerRadius];
    
    // Create arrow path
    CGFloat maxX = CGRectGetMaxX(roundedRect); // prevent arrow from extending beyond this point
    CGFloat arrowTipX = CGRectGetMidX(rect) + arrowOffset;
    CGPoint tip = CGPointMake(arrowTipX, CGRectGetMaxY(rect));
    
    CGFloat arrowLength = CGRectGetHeight(roundedRect)/2.0;
    CGFloat x = arrowLength * tan(45.0 * M_PI/180); // x = half the length of the base of the arrow
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:tip];
    [arrowPath addLineToPoint:CGPointMake(MAX(arrowTipX - x, 0), CGRectGetMaxY(roundedRect) - arrowLength)];
    [arrowPath addLineToPoint:CGPointMake(MIN(arrowTipX + x, maxX), CGRectGetMaxY(roundedRect) - arrowLength)];
    [arrowPath closePath];
    
    [popUpPath appendPath:arrowPath];
    return popUpPath;
}

- (NSArray *)framesOfSegments {
    NSMutableArray *frames = [NSMutableArray array];
    NSArray *segments = [self valueForKey:@"segments"];
    [segments enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [frames addObject:[NSValue valueWithCGRect:obj.frame]];
    }];
    return [frames copy];
}

- (void)updatePopFrameFromPopSize:(CGSize)popSize {
    CGRect frame = ((NSValue *)[self framesOfSegments][_popSegmentIndex]).CGRectValue;
    if (_popDirection == ZQSegmentedControlAbove) {
        _popView.frame = CGRectMake(CGRectGetMidX(frame) - popSize.width / 2, CGRectGetMinY(frame) - popSize.height, popSize.width, popSize.height);
        _popLabel.frame = CGRectMake(_popView.bounds.origin.x, _popView.bounds.origin.y, _popView.bounds.size.width, _popView.bounds.size.height - _popArrowLength);
    } else {
        _popView.frame = CGRectMake(CGRectGetMidX(frame) - popSize.width / 2, CGRectGetMaxY(frame), popSize.width, popSize.height);
        _popLabel.frame = CGRectMake(_popView.bounds.origin.x, _popView.bounds.origin.y + _popArrowLength, _popView.bounds.size.width, _popView.bounds.size.height - _popArrowLength);
    }
}

- (CGSize)popSizeFromString {
    CGSize titleSize = [_currentPopTitle sizeWithAttributes:@{NSFontAttributeName : _popFont}];
    CGFloat w, h;
    
    if (_orientation == ZQSegmentedControlHorizontal) {
        w = ceilf(titleSize.width + _widthPopPadding);
        h = ceilf((titleSize.height + _heightPopPadding) + _popArrowLength);
    } else {
        h = ceilf((titleSize.width + _heightPopPadding) + _popArrowLength);
        w = ceilf(titleSize.height + _widthPopPadding);
    }
    return CGSizeMake(w, h);
}

- (void)showPopViewAtIndex:(NSInteger)index title:(NSString *)title {
    _popView.hidden = NO;
    CGSize popSize = [self popSizeFromString];
    [self updatePopFrameFromPopSize:popSize];
    UIBezierPath *popPath = [self pathForRect:CGRectMake(0, 0, popSize.width, popSize.height) withArrowOffset:0];
    if (_popDirection == ZQSegmentedControlBelow) {
        CGAffineTransform mirrorOverXOrigin = CGAffineTransformMakeScale(1.0f, -1.0f);
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0, popSize.height);
        [popPath applyTransform:mirrorOverXOrigin];
        [popPath applyTransform:translate];
    }
    _popShapeLayer.path = popPath.CGPath;
    _popLabel.text = title;
}

@end
