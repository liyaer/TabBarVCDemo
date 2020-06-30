//
//  FZTabBarVC.h
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//


/*
 *   点击tabBarItem带动画效果
 */

#import <UIKit/UIKit.h>


typedef enum : NSUInteger
{
    NoAnimation,//0，无动画
    ImageAnimation,//1，图片动画
    ImageTitleAnimation,//2，图片+文字动画
}
TabBarItemAnimationType;


@interface FZTabBarVC : UITabBarController

-(instancetype)initWithVCNames:(NSArray *)names titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor;

//设置点击tabBarItem带何种动画效果
@property (nonatomic,assign) TabBarItemAnimationType animationType;

@end
