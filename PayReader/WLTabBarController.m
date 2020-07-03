//
//  WLTabBarController.m
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLTabBarController.h"
#import "Header.h"


@interface WLTabBarController ()<UITabBarControllerDelegate> {
    WLCenterStyle _centerStyle;
}
@property (nonatomic, strong) UIButton *centerBtn;

@end


@implementation WLTabBarController

#pragma mark - 题外话：测试这几个方法调用顺序。测试结果：看打印结果即可，除了得出调用顺序关系外，还能得到指定初始化方法最终不会调用init方法的结论

+ (void)load {
    NSLog(@"load");
}

+ (void)initialize {
    NSLog(@"initalize");
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

#pragma mark - 正题

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles images:(NSArray<NSString *> *)images selectedImages:(NSArray<NSString *> *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor centerStyle:(WLCenterStyle)centerStyle {
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
                [self setupChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i]];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
            
            [self.tabBar addSubview:self.centerBtn];
            
            self.delegate = self;
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)modifyBarTitleSelectedColor:(UIColor *)selectedColor unSelectedColor:(UIColor *)unSelectedColor {
    if (selectedColor) {
        if (@available(iOS 10.0, *)) {
            //写法二选一
            self.tabBar.tintColor = selectedColor;
//            [[UITabBar appearance] setTintColor:selectedColor];
        } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : selectedColor} forState:UIControlStateSelected];
        }
    }
    
    if (unSelectedColor) {
        if (@available(iOS 10.0, *)) {
            self.tabBar.unselectedItemTintColor = unSelectedColor;
//            [[UITabBar appearance] setUnselectedItemTintColor:unSelectedColor];
        } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : unSelectedColor} forState:UIControlStateNormal];
        }
    }
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
    NSLog(@"这种方式牺牲了一个控制器的内存占用，若项目使用web view较多，可以考虑在这里放个web view进行预热");
}

//解决中间特殊按钮凸起部分不能响应点击事件
//该次点击没有其他事件响应时，才会调用下面的方法（比如点击tabBarItem，会拦截响应该方法）
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
        _centerBtn.frame = CGRectMake(0, 0, TabBarHeight, TabBarHeight);
        if (_centerStyle == WLCenterStyleHump) {
            _centerBtn.center = CGPointMake(CGRectGetWidth(self.tabBar.frame)/2, 0);
        } else {
            _centerBtn.center = CGPointMake(CGRectGetWidth(self.tabBar.frame)/2, TabBarHeight/2);
        }
        [_centerBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        //中间tabBarItem的点击事件会拦截btn的点击事件，因此这里设置无效
//        [_centerBtn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

@end
