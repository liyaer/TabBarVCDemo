//
//  SubmitTabBarVC.h
//  PayReader
//
//  Created by 杜文亮 on 2018/3/6.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

/*
 *   双击tabBarItem刷新效果
 */

#import <UIKit/UIKit.h>

@interface SubmitTabBarVC : UITabBarController

-(instancetype)initWithVCNames:(NSArray *)names titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor;

@end
