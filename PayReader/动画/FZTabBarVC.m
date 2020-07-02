//
//  FZTabBarVC.m
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "FZTabBarVC.h"


@interface FZTabBarVC ()

//记录上一次点击tabbar
@property (nonatomic,assign) NSInteger indexFlag;
@property (nonatomic,strong) UIView *lastClickView;

@end


@implementation FZTabBarVC

-(instancetype)initWithVCNames:(NSArray *)names titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages selectedTitleColor:(UIColor *)selectedColor unSelectedTitleColor:(UIColor *)unSelectedColor
{
    if (self = [super init])
    {
        for (int i = 0; i < names.count; i++)
        {
#warning 添加子控制器时并不会提前走4个VC的ViewDidLoad方法，只会走一个默认选中的VC的ViewDidLoad，这也是符合我们的预期和需求的。如果发现会走4个VC的ViewDidLoad方法，那么一定是用了自定义的导航栏导致了该问题
            UIViewController *vc = [[NSClassFromString(names[i]) alloc] init];
            vc.title = titles[i];
            vc.tabBarItem.title = titles[i];
            vc.tabBarItem.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self addChildViewController:nav];
        }
        self.tabBar.tintColor = selectedColor;//设置选中Item的title颜色
        if (@available(iOS 10.0, *))
        {
            self.tabBar.unselectedItemTintColor = unSelectedColor;//设置未选中Item的title颜色
        }
    }
    return self;
}

//为初始化时默认选中的tabBarItem添加动画效果
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.indexFlag = -1;
    [self tabBar:self.tabBar didSelectItem:self.tabBar.selectedItem];
}




#pragma mark - UITabBarDelegate

//点击tabBarItem时调用(两种实现方式：1，遍历子视图  2，KVC  使用私有API可能会被拒绝，也可能导致崩溃，这两种方式严格意义上都算是使用私有API，但是2更明显一些)
#if 0
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    NSLog(@"%@",tabBar.subviews);
    
    if (self.animationType == NoAnimation) return;

    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag)
    {
        //遍历获得继承自UIView的UITabBarButton（继承自UIView的控件才能构造动画效果）
        NSMutableArray *array = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews)
        {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")])
            {
//                NSLog(@"%@",btn.subviews);

                if (self.animationType == ImageTitleAnimation)
                {
                    [array addObject:btn];
                }
                else if (self.animationType == ImageAnimation)
                {
                    for (UIView *imageView in btn.subviews)
                    {
                        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
                        {
                            [array addObject:imageView];
                        }
                    }
                }
            }
        }

        //添加动画(这里以基础动画为例，关键帧和动画组不再演示)
        if (array.count > 0)
        {
//            [self scaleMode:array[index]];
//            [self rotateMode:array[index]];
//            [self translationMode:array[index]];
            [self scaleKeepMode:array[index]];
        }

        //更新标识
        self.indexFlag = index;
        self.lastClickView = array[index];
    }
}
#else
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.animationType == NoAnimation) return;
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag)
    {
        UIView *view;
        UIControl *tabBarButton = [item valueForKey:@"view"];
        UIImageView *tabBarSwappableImageView = [tabBarButton valueForKey:@"info"];
        view = self.animationType == ImageAnimation ? tabBarSwappableImageView : tabBarButton;
        
//        [self scaleMode:view];
//        [self rotateMode:view];
//        [self translationMode:view];
        [self scaleKeepMode:view];
        
        self.indexFlag = index;
        self.lastClickView = view;
    }
}
#endif




#pragma mark - 构造动画效果

//1，放大效果，并回到原位
-(void)scaleMode:(UIView *)view
{
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.0;
    animation.repeatCount = 1;
    //完成动画后会回到执行动画之前的状态，默认值NO（实际上，因为layer动画并未真正对layer做出相关改变，只是一种视觉效果，所以即便设置为NO，动画结束后还是会回到动画前的状态，只不过是瞬间返回动画前的状态，不带有动画效果，而设置为YES，会带有动画效果）
    animation.autoreverses = YES;
//    animation.removedOnCompletion = YES;//动画完成移除动画，默认YES，不写也可以
    //动画开始值（不设置的话，默认从当前值开始，当前值用1.0表示）
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    //动画结束值
    animation.toValue = [NSNumber numberWithFloat:1.2];
    //添加动画
    [view.layer addAnimation:animation forKey:nil];
}

//2，z轴旋转180度，并回到原位
-(void)rotateMode:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.0;
    animation.repeatCount = 1;
//    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:M_PI];
    [view.layer addAnimation:animation forKey:nil];
}

//3，向上移动，并回到原位
-(void)translationMode:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.0;
    animation.repeatCount = 1;
//    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:-10];
    [view.layer addAnimation:animation forKey:nil];
}

//4，放大效果，并保持（这种效果单独使用可以，但是如果需要配合其他效果，比如双击刷新时慎用，因为需要维护其放大状态，比较麻烦，不建议使用）
-(void)scaleKeepMode:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.0;
    animation.repeatCount = 1;
    animation.fillMode = kCAFillModeForwards;//保证动画效果延续
    animation.removedOnCompletion = NO;//因为要保持动画效果，所以不能移除动画
    animation.fromValue = [NSNumber numberWithFloat:0.8];
    animation.toValue = [NSNumber numberWithFloat:1.3];
    [view.layer addAnimation:animation forKey:nil];
    //移除其他tabbar的动画(使上次动画的按钮恢复原状，只保留本次点击的动画效果)
    [self.lastClickView.layer removeAllAnimations];
}


@end
