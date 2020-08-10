//
//  BookShelfVC.m
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import "BookShelfVC.h"

@interface BookShelfVC ()

@end

@implementation BookShelfVC

- (instancetype)init {
    
    if (self = [super init]) {
        //在init（包括重写、指定初始化）操作 View，会导致viewDidLoad提前调用（原因可参考笔记中 UIViewController生命周期）
        self.view.backgroundColor = [UIColor whiteColor];
        
        NSLog(@"%@ init", [self class]);
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVC)];
    [self.view addGestureRecognizer:tap];
    
    NSLog(@"111111 %@ viewDidLoad", [self class]);
}

- (void)pushVC {
    
    UIViewController *vc = [UIViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
