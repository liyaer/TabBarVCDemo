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
*   样式：特殊Item位置（凸起/不凸起）+ 特殊Item点击（切换/不切换 VC）
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

/*
   待优化：centerBtn frame 的最优设置（根据图片大小设置）
 
   缺点：对于凸起样式，VC上有tap手势时，点击凸起的同时会触发tap，若优化，可去VC优化(当show = NO时出现，yes时不出现。可能和NO时只执行了NSlog有关，若执行类似yes时的操作（弹出view等类似操作），也许也不会出现)
 
   其他实现方式：也可以用btn完成展示操作（好处是特殊item尺寸可控），这里btn只用来处理点击
*/

NS_ASSUME_NONNULL_END
