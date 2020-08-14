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

- (void)addChildVC:(UIViewController *)vc
             title:(NSString *)title
             image:(NSString *)image
     selectedImage:(NSString *)selectedImage
            useNav:(BOOL)use {
    
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
        
        if (use) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self addChildViewController:nav];
        } else {
            [self addChildViewController:vc];
        }
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

- (void)modifyTabBarTopLineWithLineImage:(UIImage *)lineImage backgroundImage:(UIImage *)bgImage {
    
    if (lineImage) {
        self.tabBar.shadowImage = lineImage;
    }
    
    if (bgImage) {
        self.tabBar.backgroundImage = bgImage;
    }
}

- (void)modifyTabBarTopLineWithLineColor:(UIColor *)lineColor backgroundColor:(UIColor *)bgColor {
    
    if (lineColor) {
        self.tabBar.shadowImage = [self imageWithColor:lineColor];
    }
    
    if (bgColor) {
        self.tabBar.backgroundImage = [self imageWithColor:bgColor];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return img;
}

@end
