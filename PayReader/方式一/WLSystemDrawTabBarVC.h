//
//  WLDrawTabBarVC.h
//  PayReader
//
//  Created by DuBenben on 2020/7/22.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLSystemDrawTabBarVC : WLBaseTabBarController

//样式：特殊Item位置（凸起）+ 特殊Item点击（切换/不切换 VC）
- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex
    showVCWhenSpecialItemCliked:(BOOL)show;

@end

//缺点：改变tabBar.height，VC的frame会受影响

NS_ASSUME_NONNULL_END
