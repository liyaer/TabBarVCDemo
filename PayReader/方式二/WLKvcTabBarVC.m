//
//  WLKvcTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLKvcTabBarVC.h"
#import "WLKvcTabBar.h"


@interface WLKvcTabBarVC ()

@end


@implementation WLKvcTabBarVC

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles images:(NSArray<NSString *> *)images selectedImages:(NSArray<NSString *> *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor centerStyle:(WLCenterStyle)centerStyle {
    
    if (self = [super init]) {
                        
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        
        if (countEqual && countNoZero) {
            
            [self setValue:[WLKvcTabBar tabBarWithCenterStyle:centerStyle barItemCounts:images.count] forKey:@"tabBar"];

            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i]];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    
    return self;
}

@end
