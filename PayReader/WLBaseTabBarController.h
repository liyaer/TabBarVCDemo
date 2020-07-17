//
//  WLBaseTabBarController.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLBaseTabBar.h"


NS_ASSUME_NONNULL_BEGIN


@interface WLBaseTabBarController : UITabBarController

//add childVC for tabBarController
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;

//set up select/unselect color for tabBarItem.title
- (void)modifyBarTitleSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor;

@end

NS_ASSUME_NONNULL_END

/*
    封装的tabbarVC需要满足的要求：
        1，特殊按钮的构造；特殊按钮点击切换VC 或者 弹出试图（不切换VC）；特殊按钮的样式（图片、图片+文字）
        某个按钮，刷新效果（双击、单击等方式）
        2，点击动画效果
        3，红点
        4，顶部分割线
        5，适配暗黑
 */
