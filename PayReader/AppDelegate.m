//
//  AppDelegate.m
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "AppDelegate.h"

#import "FZTabBarVC.h"
#import "SubmitTabBarVC.h"

#import "WLSystemNomalTabBarVC.h"
#import "WLSystemSpecialTabBarVC.h"
#import "WLDrawTabBarVC.h"

#import "WLKvcTabBarVC.h"

#import "WLCustomTabBarVC.h"


#define TabBarType 21


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self setRootVC];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




#pragma mark - 封装方法调用集合

- (void)setRootVC {

#if (TabBarType == 2)
    NSArray *vcNames = @[@"BookShelfVC",@"RecommendVC",@"ClassifyVC",@"PersonalVC"];
    NSArray *titles = @[@"书架",@"精选",@"分类",@"我的"];
    NSArray *images = @[@"1",@"2",@"3",@"4"];
    NSArray *selectImages = @[@"11",@"22",@"33",@"44"];
#elif (TabBarType == 21)
    NSArray *vcNames = @[@"BookShelfVC",@"RecommendVC",@"SpecialVC",@"ClassifyVC",@"PersonalVC"];
    NSArray *titles = @[@"书架",@"精选",@"Special",@"分类",@"我的"];
    NSArray *images = @[@"1",@"2",@"special_hump",@"3",@"4"];
    NSArray *selectImages = @[@"11",@"22",@"special_s",@"33",@"44"];
#endif
    UIColor *titleColor = [UIColor blackColor];
    UIColor *selectTitleColor = [UIColor purpleColor];
    
    
//点击动画和双击刷新建议分开单独使用；若要一起使用，需要考虑某些动画效果和双击刷新的兼容性
#if (TabBarType == 0)
    FZTabBarVC *tabBar = [[FZTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"ClassifyVC",@"PersonalVC"] titles:@[@"书架",@"精选",@"分类",@"我的"] images:@[@"1",@"2",@"3",@"4"] selectedImages:@[@"11",@"22",@"33",@"44"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:nil];
    tabBar.animationType = ImageAnimation;
//    tabBar.animationType = ImageTitleAnimation;
//    tabBar.selectedIndex = 2;
#elif (TabBarType == 1)
    SubmitTabBarVC *tabBar = [[SubmitTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"ClassifyVC",@"PersonalVC"] titles:@[@"书架",@"精选",@"分类",@"我的"] images:@[@"1",@"2",@"3",@"4"] selectedImages:@[@"11",@"22",@"33",@"44"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:nil];
#elif (TabBarType == 2)
    WLSystemNomalTabBarVC *tabBar = [[WLSystemNomalTabBarVC alloc] initWithVCNames:vcNames titles:titles images:images selectedImages:selectImages selectedTitleColor:selectTitleColor unSelectedTitleColor:titleColor];
#elif (TabBarType == 21)
    WLSystemSpecialTabBarVC *tabBar = [[WLSystemSpecialTabBarVC alloc] initWithVCNames:vcNames titles:titles images:images selectedImages:selectImages selectedTitleColor:selectTitleColor unSelectedTitleColor:titleColor specialItemIndex:2 specialItemStyle:WLTabBarItemHump showVCWhenSpecialItemCliked:YES];
#elif (TabBarType == 3)
    WLKvcTabBarVC *tabBar = [[WLKvcTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC"] titles:@[@"书架",@"精选"] images:@[@"1",@"2"] selectedImages:@[@"11",@"22"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor] centerStyle:WLCenterStyleHump];
#elif (TabBarType == 4)
       WLCustomTabBarVC *tabBar = [[WLCustomTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC"] titles:@[@"书架",@"精选"] images:@[@"1",@"2"] selectedImages:@[@"11",@"22"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor] centerStyle:WLCenterStyleNormal];
#else
    WLDrawTabBarVC *tabBar = [[WLDrawTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"ClassifyVC"] titles:@[@"书架",@"精选",@"分类"] images:@[@"1",@"2",@"3"] selectedImages:@[@"11",@"22",@"33"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor]];
#endif
    self.window.rootViewController = tabBar;
}



@end
