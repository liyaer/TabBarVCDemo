//
//  WLSystemNomalTabBarVC.m
//  PayReader
//
//  Created by DuBenben on 2020/8/7.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLSystemNomalTabBarVC.h"

@interface WLSystemNomalTabBarVC ()

@end

@implementation WLSystemNomalTabBarVC

#pragma mark - 题外话：测试这几个方法调用顺序。测试结果：看打印结果即可；除了得出调用顺序关系外，还能得到指定初始化方法最终不会调用init方法的结论

//+ (void)load {
//    
//    NSLog(@"load");//类被加载到内存（runtime）时调用
//}
//
//+ (void)initialize {
//    
//    NSLog(@"initalize");//调用方法前最先执行的（线程安全的）
//}
//
//- (instancetype)init {
//    
//    if (self = [super init]) {
//        NSLog(@"init");
//    }
//    return self;
//}

#pragma mark - 初始化

- (instancetype)initWithVCNames:(NSArray<NSString *> *)names
                         titles:(NSArray<NSString *> *)titles
                         images:(NSArray<NSString *> *)images
                 selectedImages:(NSArray<NSString *> *)selectedImages
             selectedTitleColor:(UIColor *)selectedColor
           unSelectedTitleColor:(UIColor *)unSelectedColor {
    
    if (self = [super init]) {
        NSLog(@"custom init");
                
        BOOL countEqual = (names.count == titles.count) && (titles.count == images.count) && (images.count == selectedImages.count);
        BOOL countNoZero = names.count > 0;
        if (countEqual && countNoZero) {
            for (int i = 0; i < names.count; i++) {                
                [self addChildVC:[NSClassFromString(names[i]) new] title:titles[i] image:images[i] selectedImage:selectedImages[i] useNav:YES];
            }
            
            [self modifyBarTitleSelectedColor:selectedColor unSelectedColor:unSelectedColor];
        } else {
            NSLog(@"%@ 入参异常", [self class]);
        }
    }
    return self;
}

@end
