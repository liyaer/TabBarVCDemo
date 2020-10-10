//
//  UITabBar+WLRedpointTip.h
//  PayReader
//
//  Created by DuBenben on 2020/9/24.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (WLBadge)

//显示
- (void)showBadgeWithIndex:(NSInteger)index badgeColor:(UIColor *)color animation:(BOOL)animation;

//隐藏
- (void)hiddenBadgeWithIndex:(NSInteger)index animation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
