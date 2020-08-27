//
//  WLMemoryTabBarVC.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLSystemSpecialTabBarVC.h"


@interface WLSystemSpecialTabBarVC ()<UITabBarControllerDelegate> {
    NSInteger _specialIndex;
    WLTabBarItemStyle _specialStyle;
    BOOL _show;
    
    NSInteger _itemCounts;
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
               specialItemIndex:(NSInteger)specialIndex
               specialItemStyle:(WLTabBarItemStyle)specialStyle
    showVCWhenSpecialItemCliked:(BOOL)show {
    
    if (self = [super init]) {
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            _specialIndex = specialIndex;
            _specialStyle = specialStyle;
            _show = show;
            _itemCounts = names.count;
            
            for (int i = 0; i < names.count; i++) {
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i] useNav:((!show && i==specialIndex) ? NO : YES)];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
                        
            self.delegate = self;
            
            if (specialStyle == WLTabBarItemHump) {
                [self.tabBar addSubview:self.centerBtn];
            }
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    UITabBarItem *specialItem = self.tabBar.items[_specialIndex];
    if (_specialStyle == WLTabBarItemNormal) {
        specialItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);//设置图片偏移（根据图片大小合理设置参数）
    } else if (_specialStyle == WLTabBarItemHump) {
        specialItem.imageInsets = UIEdgeInsetsMake(-25, 0, 25, 0);
    }
    specialItem.titlePositionAdjustment = UIOffsetMake(0, 100);//隐藏title
    
//    #error 不同设备分辨率对此是否产生影响？用粪X试试
    NSLog(@" image.size:%@ \n image.scale:%.2f", NSStringFromCGSize(specialItem.image.size), specialItem.image.scale);
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
    if (_show) {
        self.selectedIndex = _specialIndex;
    } else {
        NSLog(@"这种方式牺牲了一个控制器的内存占用。若项目使用web view较多，可以考虑在这里放个web view进行预热。这种想法不准确，若是特殊按钮点击后，不会进行VC切换，那就不会初始化这个VC");
    }
}

//解决特殊Item凸起部分不能响应点击事件
//该次点击没有其他事件响应时，才会调用下面的方法（比如点击tabBarItem，会拦截响应该方法。原理：事件传递和响应者链）
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if (_specialStyle == WLTabBarItemHump) {
        //只有当前正在显示tabBarController时，开启btn的交互
        if (!self.tabBar.hidden) {
            //判断点击是否在btn的范围内
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
        CGFloat itemWidth = CGRectGetWidth(self.tabBar.frame)/_itemCounts;
        CGFloat centerX = itemWidth*_specialIndex + itemWidth/2;
        _centerBtn.center = CGPointMake(centerX, 0);
/*
    现象：中间tabBarItem的点击事件会拦截btn的点击事件，因此这里设置无效。
    原因：系统添加tabBarItem的时机在添加btn之后（请看“视图层级.png”，同时也解释了方式三为什么不会影响tabBarItem的显示和交互）
    原理：hit-test（事件传递和响应者链）
 */
//        [_centerBtn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

@end
