//
//  UITabBar+WLRedpointTip.m
//  PayReader
//
//  Created by DuBenben on 2020/9/24.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "UITabBar+WLBadge.h"


static const CGFloat badgeY = 5.0;
static const CGFloat badgeW = 8.0;

CG_INLINE NSInteger RealTag(NSInteger index) {
    return index + 666;
}


@implementation UITabBar (WLBadge)

#pragma mark - 对外暴露

#if 1
//添加到UITabBar上
- (void)showBadgeWithIndex:(NSInteger)index badgeColor:(UIColor *)color animation:(BOOL)animation {
    
    //上次生成的红点未及时删除（比如外界调用时show和hidden未成对调用），本次添加红点前先删除上次的
    [self removeBadgeWithIndex:index animation:NO];
    
    //添加红点
    UIView *point = [self createPointWithIndex:index pointColor:color];
    [self addSubview:point];
    
    //设置红点frame
    int i = 0;
    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIControl class]]) { 或者
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == index) {
                CGFloat x = CGRectGetMaxX(view.frame) - CGRectGetWidth(view.frame)*2/5;
                CGFloat y = badgeY;
                point.frame = CGRectMake(x, y, badgeW, badgeW);
                point.layer.cornerRadius = CGRectGetHeight(point.bounds)/2;
                point.clipsToBounds = YES;
                
                [self showBadge:point animation:animation];
            }
            i++;
        }
    }
}
#else
//添加到对应index的UITabBarButton上(相比添加到tabBar上，更方便调整红点frame)
- (void)showBadgeWithIndex:(NSInteger)index badgeColor:(UIColor *)color animation:(BOOL)animation {
    
    //上次生成的红点未及时删除（比如外界调用时show和hidden未成对调用），本次添加红点前先删除上次的
    [self removeBadgeWithIndex:index animation:NO];
    
    //创建红点
    UIView *point = [self createPointWithIndex:index pointColor:color];
    
    //设置红点frame，并添加
    int i = 0;
    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIControl class]]) { 或者
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == index) {
                for (UIView *subView in view.subviews) {
//                    if ([subView isKindOfClass:[UIImageView class]]) { 或者
                    if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                        point.frame = CGRectMake(0, 0, badgeW, badgeW);
                        point.center = CGPointMake(CGRectGetMaxX(subView.frame), CGRectGetMinY(subView.frame));
                        point.layer.cornerRadius = CGRectGetHeight(point.bounds)/2;
                        point.clipsToBounds = YES;
                        [view addSubview:point];
                        
                        [self showBadge:point animation:animation];
                    }
                }
            }
            i++;
        }
    }
}
#endif

- (void)hiddenBadgeWithIndex:(NSInteger)index animation:(BOOL)animation {
    
    [self removeBadgeWithIndex:index animation:animation];
}

#pragma mark - 私有

- (UIView *)createPointWithIndex:(NSInteger)index pointColor:(UIColor *)color {
    
    UILabel *point = [[UILabel alloc] init];
    point.tag = RealTag(index);
//    point.text = @"999+";
//    [point sizeToFit];
//    point.textColor = [UIColor whiteColor];
//    point.font = [UIFont systemFontOfSize:14.0];
    point.backgroundColor = color ? : [UIColor redColor];
    return point;
    
//    UIImageView *point = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
//    point.tag = RealTag(index);
//    return point;
}

- (void)removeBadgeWithIndex:(NSInteger)index animation:(BOOL)animation {
    
    UIView *badge = [self viewWithTag:RealTag(index)];
    
    [self hiddenBadge:badge animation:animation];
}

#pragma mark - 动画

- (void)showBadge:(UIView *)badge animation:(BOOL)animation {
    
    if (!animation) {
        return;
    }
    
    badge.alpha = 0;
    badge.transform = CGAffineTransformScale(badge.transform, 2, 2);
    [UIView animateWithDuration:0.3 animations:^{
        badge.transform = CGAffineTransformScale(badge.transform, 0.5, 0.5);
        badge.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenBadge:(UIView *)badge animation:(BOOL)animation {
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
           badge.transform = CGAffineTransformScale(badge.transform, 2, 2);
           badge.alpha = 0;
        } completion:^(BOOL finished) {
           [badge removeFromSuperview];
        }];
    } else {
        [badge removeFromSuperview];
    }
}


sizeToFit
分类+属性的方法，在此之前，先系统了解分类+属性原理
结构体中能否放对象，如果可以，那么可以将多个参数封装进一个结构体


//待完善：
//图片、文字

//另一种方式：
//UITabBarItem分类尝试

@end
