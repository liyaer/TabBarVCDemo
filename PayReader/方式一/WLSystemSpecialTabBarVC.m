//
//  WLMemoryTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLSystemSpecialTabBarVC.h"


@interface WLSystemSpecialTabBarVC ()<UITabBarControllerDelegate> {
    WLCenterStyle _centerStyle;
}
@property (nonatomic, strong) UIButton *centerBtn;

@end


@implementation WLSystemSpecialTabBarVC

#pragma mark - 初始化

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor
                    centerStyle:(WLCenterStyle)centerStyle {
    
    if (self = [super init]) {
        NSLog(@"custom init");
                
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            _centerStyle = centerStyle;
            
            for (int i = 0; i < names.count; i++) {
                if (i == names.count/2) {
                    UIViewController *middleVC = [UIViewController new];
                    [self addChildViewController:middleVC];
                    continue;
                }
                
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i]];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
            
            if (_centerStyle != WLCenterStyleNone) {
                [self.tabBar addSubview:self.centerBtn];
                self.delegate = self;
            }
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

#pragma mark - UITabBarControllerDelegate

//拦截中间tabBarItem点击事件的响应，使其响应我们自定义的方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    
    [self centerBtnClicked];
    return NO;
}

#pragma mark - 点击事件

//中间特殊按钮的点击事件
- (void)centerBtnClicked {
    
    NSLog(@"这种方式牺牲了一个控制器的内存占用。若项目使用web view较多，可以考虑在这里放个web view进行预热。这种想法不准确，若是特殊按钮点击后，不会进行VC切换，那就不会初始化这个VC");
}

//解决中间特殊按钮凸起部分不能响应点击事件
//该次点击没有其他事件响应时，才会调用下面的方法（比如点击tabBarItem，会拦截响应该方法。原理：事件传递和响应者链）
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if (_centerStyle == WLCenterStyleHump) {
        //只有当前正在显示tabBarController时，开启中间特殊按钮的交互
        if (!self.tabBar.hidden) {
            //判断点击是否在特殊按钮的范围内
            CGPoint touch = [[touches anyObject] locationInView:_centerBtn];
            if (CGRectContainsPoint(_centerBtn.bounds, touch)) {
                [self centerBtnClicked];
            }
        }
    }
}

#pragma mark - 懒加载

- (UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(0, 0, cDTabBarHeight, cDTabBarHeight);
        if (_centerStyle == WLCenterStyleHump) {
            _centerBtn.center = CGPointMake(CGRectGetWidth(self.tabBar.frame)/2, 0);
        } else {
            _centerBtn.center = CGPointMake(CGRectGetWidth(self.tabBar.frame)/2, cDTabBarHeight/2);
        }
        [_centerBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
/*
    现象：中间tabBarItem的点击事件会拦截btn的点击事件，因此这里设置无效。
    原因：系统添加tabBarItem的时机在添加btn之后（请看“视图层级.png”，同时也解释了方式三为什么不会影响tabBarItem的显示和交互）
    原理：hit-test（事件传递和响应者链）
 */
//        [_centerBtn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

/*
  0，增加无特殊按钮模式
  1，指定特殊按钮位置
  2，centerBtn frame 的最优设置
 */

@end
