//
//  RecommendVC.m
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "RecommendVC.h"
#import "UITabBar+WLBadge.h"


@interface RecommendVC ()

@end


@implementation RecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"222222 %@ viewDidLoad", [self class]);
}

#pragma mark - Test BadgeValue

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    [self.tabBarController.tabBar hiddenBadgeWithIndex:1 animation:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar showBadgeWithIndex:1 badgeColor:[UIColor orangeColor] animation:YES];
}

@end
