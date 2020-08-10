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
- (void)addChildVC:(UIViewController *)vc
             title:(NSString *)title
             image:(NSString *)image
     selectedImage:(NSString *)selectedImage;

//set up select/unselect color for tabBarItem.title
- (void)modifyBarTitleSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor;

/*
    改变顶部黑线颜色，需同时设置tabBar.shadowImage、tabBar.backgroundImage，二者颜色可以不同。也就是说，调用以下方法之前：
        设置过tabBar.backgroundImage，第二个参数可以不传（传nil）
        未设置过。。。。。。。。。。。。。，第二个参数必传（不可传nil）
 */
//有image，直接设置
- (void)modifyTabBarTopLineWithLineImage:(UIImage *)lineImage backgroundImage:(UIImage *)bgImage;
//无image，通过color绘制image，然后设置
- (void)modifyTabBarTopLineWithLineColor:(UIColor *)lineColor backgroundColor:(UIColor *)bgColor;

@end

NS_ASSUME_NONNULL_END

/*
    封装的tabbarVC需要满足的要求：
        1，特殊按钮的构造；特殊按钮点击切换VC 或者 弹出试图（不切换VC）；特殊按钮的样式（图片、图片+文字）
        某个按钮，刷新效果（双击、单击等方式）
    2，顶部分割线
        3，红点
        4，点击动画效果
        5，适配暗黑、粪叉
 */
