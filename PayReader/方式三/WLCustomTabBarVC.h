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

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
                    centerStyle:(WLTabBarItemStyle)centerStyle;

@end

NS_ASSUME_NONNULL_END
