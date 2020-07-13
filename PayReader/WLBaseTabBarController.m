//
//  WLBaseTabBarController.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLBaseTabBarController.h"


@interface WLBaseTabBarController ()

@end


@implementation WLBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    if (vc) {
    
        if (title) {
            vc.title = title;
            vc.tabBarItem.title = title;
        }
        
        if (image) {
            vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        if (selectedImage) {
            vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
    }
}

- (void)modifyBarTitleSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor {
    
    if (selectedColor) {
        
        if (@available(iOS 10.0, *)) {
            self.tabBar.tintColor = selectedColor;
            //or
//            [[UITabBar appearance] setTintColor:selectedColor];
        } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateSelected];
        }
    }
    
    if (unSelectedColor) {
        
        if (@available(iOS 10.0, *)) {
            self.tabBar.unselectedItemTintColor = unSelectedColor;
            //or
//            [[UITabBar appearance] setUnselectedItemTintColor:unSelectedColor];
        } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : unSelectedColor} forState:UIControlStateNormal];
        }
    }
}

@end
