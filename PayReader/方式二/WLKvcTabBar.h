//
//  WLKvcTabBar_.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLKvcTabBar : WLBaseTabBar

+ (instancetype)tabBarWithCenterStyle:(WLTabBarItemStyle)centerStyle
                        barItemCounts:(NSInteger)itemCounts
                     specialItemIndex:(NSInteger)specialIndex;

@end

NS_ASSUME_NONNULL_END
