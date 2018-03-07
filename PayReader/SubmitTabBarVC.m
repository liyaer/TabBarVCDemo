//
//  SubmitTabBarVC.m
//  PayReader
//
//  Created by 杜文亮 on 2018/3/6.
//  Copyright © 2018年 杜文亮. All rights reserved.
//

#import "SubmitTabBarVC.h"
#import "BookShelfVC.h"


@interface SubmitTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSDate *lastDate;

@end


@implementation SubmitTabBarVC

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
        self.tabBar.unselectedItemTintColor = unSelectedColor;//设置未选中Item的title颜色
        
        self.delegate = self;
    }
    return self;
}




//给第一个tabBarItem添加双击刷新
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSDate *nowDate = [[NSDate alloc] init];
    UIViewController *nowVC = viewController.childViewControllers.firstObject;
    if ([nowVC isKindOfClass:[BookShelfVC class]])//只为第一个tabBarItem添加
    {
        if (nowDate.timeIntervalSince1970 - self.lastDate.timeIntervalSince1970 < .5f)//是双击
        {
            UIImageView *tabBarSwappableImageView = [self getImageViewFromVC:viewController];
            if (tabBarSwappableImageView)
            {
                //是否正在动画中
                if (![tabBarSwappableImageView.layer animationForKey:@"submit"])
                {
//                    NSLog(@"-------\n%@\n%@",viewController.tabBarItem,tabBarSwappableImageView);
                    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    viewController.tabBarItem.image = [[UIImage imageNamed:@"5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
#warning 重设了selectedImage，地址已经改变，所以需要获取新地址，进行动画的添加。正因如此，动画必须放在重设图片之后。上下注释掉的两个NSLog可以证明,详情看截图Log1
                    UIImageView *tbImg = [self getImageViewFromVC:viewController];
                    [self submitMode:tbImg];
//                    NSLog(@"-------\n%@\n%@",viewController.tabBarItem,tbImg);
                    
                    
                    //模拟viewController刷新页面,刷新完成后移除动画
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                       [tbImg.layer removeAnimationForKey:@"submit"];
                       
                       viewController.tabBarItem.image = [[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                       viewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
#warning 最好在地址变化前先移除动画
//                       NSLog(@"----\n%@\n%@",tbImg,[self getImageViewFromVC:viewController]);
                   });
                }
                else
                {
                    NSLog(@"=======动画中！");
                }
            }
        }
        self.lastDate = nowDate;
    }
    return YES;
}

-(UIImageView *)getImageViewFromVC:(UIViewController *)vc
{
    return [[vc.tabBarItem valueForKey:@"view"] valueForKey:@"info"];
}

-(void)submitMode:(UIView *)view
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 1.0;
    animation.repeatCount = 5;
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:M_PI*2];
    [view.layer addAnimation:animation forKey:@"submit"];
}


@end
