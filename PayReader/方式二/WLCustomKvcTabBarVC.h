//
//  WLKvcTabBarVC.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCustomKvcTabBarVC : WLBaseTabBarController
//样式：特殊Item位置（凸起/不凸起）+ 特殊Item点击（不切换 VC）
- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex
                    centerStyle:(WLTabBarItemStyle)centerStyle;

@end

NS_ASSUME_NONNULL_END
