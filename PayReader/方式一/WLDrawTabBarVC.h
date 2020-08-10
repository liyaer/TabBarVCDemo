//
//  WLDrawTabBarVC.h
//  PayReader
//
//  Created by DuBenben on 2020/7/22.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLDrawTabBarVC : WLBaseTabBarController

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor;

@end

NS_ASSUME_NONNULL_END
