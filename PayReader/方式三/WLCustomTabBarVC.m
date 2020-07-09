//
//  WLCustomTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomTabBarVC.h"
#import "WLCustomTabBar.h"


@interface WLCustomTabBarVC () {
    WLCenterStyle _centerStyle;
}

@property (nonatomic, strong) WLCustomTabBar *customTabBar;

@end


@implementation WLCustomTabBarVC

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles images:(NSArray<NSString *> *)images selectedImages:(NSArray<NSString *> *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor centerStyle:(WLCenterStyle)centerStyle {
    
    if (self = [super init]) {
        
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        
        if (countEqual && countNoZero) {
            
            _centerStyle = centerStyle;
            
            for (int i = 0; i < names.count; i++) {
                [self setupChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i]];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBar addSubview:self.customTabBar];
}

- (WLCustomTabBar *)customTabBar {
    if (!_customTabBar) {
        _customTabBar = [[WLCustomTabBar alloc] init];
        _customTabBar.frame = self.tabBar.bounds;
        _customTabBar.backgroundColor = [UIColor blueColor];
    }
    return _customTabBar;
}

@end
