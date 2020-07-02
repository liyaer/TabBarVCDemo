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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"1111111");
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 60)];
    [btn setTitle:@"同一个btn的单双击时间" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)pushVC {
    UIViewController *vc = [UIViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
