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
#import "WLMemoryTabBarVC.h"
#import "WLKvcTabBarVC.h"
#import "WLCustomTabBarVC.h"


#define TabBarType 4


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

-(void)setRootVC
{
//点击动画和双击刷新建议分开单独使用；若要一起使用，需要考虑某些动画效果和双击刷新的兼容性
#if (TabBarType == 0)
    FZTabBarVC *tabBar = [[FZTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"ClassifyVC",@"PersonalVC"] titles:@[@"书架",@"精选",@"分类",@"我的"] images:@[@"1",@"2",@"3",@"4"] selectedImages:@[@"11",@"22",@"33",@"44"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:nil];
    tabBar.animationType = ImageAnimation;
//    tabBar.animationType = ImageTitleAnimation;
//    tabBar.selectedIndex = 2;
#elif (TabBarType == 1)
    SubmitTabBarVC *tabBar = [[SubmitTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"ClassifyVC",@"PersonalVC"] titles:@[@"书架",@"精选",@"分类",@"我的"] images:@[@"1",@"2",@"3",@"4"] selectedImages:@[@"11",@"22",@"33",@"44"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:nil];
#elif (TabBarType == 2)
    WLMemoryTabBarVC *tabBar = [[WLMemoryTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC",@"",@"ClassifyVC",@"PersonalVC"] titles:@[@"书架",@"精选",@"",@"分类",@"我的"] images:@[@"1",@"2",@"",@"3",@"4"] selectedImages:@[@"11",@"22",@"",@"33",@"44"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor] centerStyle:WLCenterStyleNormal];
#elif (TabBarType == 3)
    WLKvcTabBarVC *tabBar = [[WLKvcTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC"] titles:@[@"书架",@"精选"] images:@[@"1",@"2"] selectedImages:@[@"11",@"22"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor] centerStyle:WLCenterStyleNormal];
#else
       WLCustomTabBarVC *tabBar = [[WLCustomTabBarVC alloc] initWithVCNames:@[@"BookShelfVC",@"RecommendVC"] titles:@[@"书架",@"精选"] images:@[@"1",@"2"] selectedImages:@[@"11",@"22"] selectedTitleColor:[UIColor orangeColor] unSelectedTitleColor:[UIColor blackColor] centerStyle:WLCenterStyleNormal];
#endif
    self.window.rootViewController = tabBar;
}



@end
