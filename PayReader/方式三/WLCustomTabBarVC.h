//
//  WLCustomTabBarVC.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLCustomTabBarVC : WLBaseTabBarController

//样式：特殊Item位置（不凸起）+ 特殊Item点击（不切换 VC）
- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex;

//缺点：凸起样式不完美，凸起部分点击无响应

@end

NS_ASSUME_NONNULL_END
