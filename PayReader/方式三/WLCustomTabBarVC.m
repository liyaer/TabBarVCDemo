//
//  WLCustomTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomTabBarVC.h"
#import "WLCustomTabBar.h"


@interface WLCustomTabBarVC ()<WLCustomTabBarDelegate>

@end


@implementation WLCustomTabBarVC

#pragma mark - 初始化

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex {
    
    if (self = [super init]) {
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:nil selectedImage:nil useNav:YES];
            }
            
            WLCustomTabBar *customTabBar = [[WLCustomTabBar alloc] initWithFrame:self.tabBar.bounds barItemTitles:titles barItemTitleSelectedColor:selectedColor barItemTitleUnselectedColor:unSelectedColor barItemSelectedImageNames:selectedImages barItemUnselectedImageNames:images specialItemIndex:specialIndex];
            customTabBar.delegate = self;
            [self.tabBar addSubview:customTabBar];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    
    return self;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    // 移除原有的UITabBarButton(继承自UIControl)
    for (UIView *subView in self.tabBar.subviews) {
        // UITabBarButton私有API, 普通开发者不能使用
        if ([subView isKindOfClass:[UIControl class]]) {
            // 判断如果子控件是UITabBarButton, 就删除
            [subView removeFromSuperview];
        }
    }
}

#pragma mark - WLCustomTabBarDelegate

- (void)tabBar:(WLCustomTabBar *)tabBar didSelectIndexFrom:(NSInteger)from to:(NSInteger)to {
    
    if (to == 10086) {
        NSLog(@"中间特殊按钮点击");
    } else {
        // 使控制器跟随按钮点击进行切换
        self.selectedIndex = to;
    }
}

@end
