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
