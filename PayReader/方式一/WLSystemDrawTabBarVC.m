//
//  WLDrawTabBarVC.m
//  PayReader
//
//  Created by DuBenben on 2020/7/22.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLSystemDrawTabBarVC.h"
#import "WLDrawTabBarView.h"


static const CGFloat AddHeight = 50;
#define kDTabBarHeightCustom (kDTabBarHeightAll + AddHeight)//原始高度 + 自定（可变）值


@interface WLSystemDrawTabBarVC ()<UITabBarControllerDelegate> {
    NSInteger _specialIndex;
    BOOL _show;
}

@end


@implementation WLSystemDrawTabBarVC

#pragma mark - 初始化

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
               specialItemIndex:(NSInteger)specialIndex
    showVCWhenSpecialItemCliked:(BOOL)show {
    
    if (self = [super init]) {
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            _specialIndex = specialIndex;
            _show = show;
            
            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i] useNav:((!show && i==specialIndex) ? NO : YES)];
            }

            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
                        
            self.delegate = self;
            
            [self modifyTabBarTopLineWithLineColor:[UIColor redColor] backgroundColor:[UIColor yellowColor]];
            
            [self setupDrawViewForTabBar:specialIndex itemCount:names.count];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

- (void)setupDrawViewForTabBar:(NSInteger)specialIndex itemCount:(NSInteger)itemCount {
    
    WLDrawTabBarView *view = [[WLDrawTabBarView alloc] initWithFrame:CGRectMake(0, 0, kDScreenWidth, kDTabBarHeightCustom)];
    view.specialIndex = specialIndex;
    view.itemCount = itemCount;
    view.backgroundColor = [UIColor lightGrayColor];
    [self.tabBar addSubview:view];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    //调整tabBar的frame（主要是高度调整）
    CGRect frame = self.tabBar.frame;
    frame.size.height = kDTabBarHeightCustom;
    frame.origin.y = self.view.frame.size.height - kDTabBarHeightCustom;
    self.tabBar.frame = frame;
    
    //调整UITabBarItem中图片、文字的位置（默认上下排列；UIButton默认左右排列）
    for (int i=0; i<self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        if (i!=_specialIndex) {
            item.imageInsets = UIEdgeInsetsMake(AddHeight/2, 0, -AddHeight/2, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, 0);
        }else{
            item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -5);
        }
    }
}

#pragma mark - UITabBarControllerDelegate

//拦截特殊tabBarItem点击事件的响应，使其响应我们自定义的方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController {
    
    if (_show) {
        return YES;
    } else {
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            return YES;
        } else {
            [self centerBtnClicked];
            return NO;
        }
    }
}

#pragma mark - 点击事件

//特殊Item的点击事件
- (void)centerBtnClicked {
    NSLog(@"这种方式牺牲了一个控制器的内存占用。若项目使用web view较多，可以考虑在这里放个web view进行预热。这种想法不准确，若是特殊按钮点击后，不会进行VC切换，那就不会初始化这个VC");
}

@end
