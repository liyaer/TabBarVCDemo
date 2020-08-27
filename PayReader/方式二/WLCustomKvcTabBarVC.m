//
//  WLKvcTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomKvcTabBarVC.h"
#import "WLKvcTabBar.h"


@interface WLCustomKvcTabBarVC ()

@end


@implementation WLCustomKvcTabBarVC

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex
                    centerStyle:(WLTabBarItemStyle)centerStyle {
    
    if (self = [super init]) {
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            [self setValue:[WLKvcTabBar tabBarWithCenterStyle:centerStyle barItemCounts:images.count specialItemIndex:specialIndex] forKey:@"tabBar"];

            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i] useNav:YES];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

@end
