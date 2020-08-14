//
//  WLDrawTabBarVC.m
//  PayReader
//
//  Created by DuBenben on 2020/7/22.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLDrawTabBarVC.h"
#import "WLDrawTabBarView.h"


static const CGFloat AddHeight = 50;
#define kDTabBarHeightCustom (kDTabBarHeightAll + AddHeight)//原始高度 + 自定（可变）值


@interface WLDrawTabBarVC ()

@end


@implementation WLDrawTabBarVC

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor {
    
    if (self = [super init]) {

        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;

        if (countEqual && countNoZero) {

            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i] useNav:YES];
            }

            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
            
            [self modifyTabBarTopLineWithLineColor:[UIColor redColor] backgroundColor:[UIColor yellowColor]];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
       
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WLDrawTabBarView *view = [[WLDrawTabBarView alloc] initWithFrame:CGRectMake(0, 0, kDScreenWidth, kDTabBarHeightCustom)];
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
        if (i!=(self.tabBar.items.count/2)) {
            item.imageInsets = UIEdgeInsetsMake(AddHeight/2, 0, -AddHeight/2, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, 0);
        }else{
            item.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            item.titlePositionAdjustment = UIOffsetMake(0, -5);
        }
    }
}

@end
