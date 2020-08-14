//
//  WLMemoryTabBarVC.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLSystemSpecialTabBarVC : WLBaseTabBarController
/**  --- DWL ---
*   样式：特殊Item的图文显示（图/文/图文，这里以 图 为例） + 位置（凸起/不凸起）。可通过设置UITabBarItem内容的偏移量来到达效果
*   @parem specialIndex 特殊Item的下标（用来描述其所处的位置）
*   @parem specialStyle 是否凸起
*   @parem show 点击特殊Item是否切换VC（yes: 切换）
*   @return WLSystemSpecialOneTabBarVC实例
*/
- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex
               specialItemStyle:(WLTabBarItemStyle)specialStyle
    showVCWhenSpecialItemCliked:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
