//
//  AppDelegate.h
//  PayReader
//
//  Created by 杜文亮 on 2017/10/13.
//  Copyright © 2017年 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//如果入口设置删除了Main,那么使用window属性时需要初始化，并且最后调用 [self.window makeKeyAndVisible]；这里我们从Main.storyBoard加载，所以不用初始化window
@property (strong, nonatomic) UIWindow *window;

@end

