//
//  WLTabBarController.h
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLTabBarController : UITabBarController

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles images:(NSArray<NSString *> *)images selectedImages:(NSArray<NSString *> *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor;

@end

NS_ASSUME_NONNULL_END
