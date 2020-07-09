//
//  WLTabBar.m
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomTabBar.h"
//#import "Header.h"


@implementation WLCustomTabBar

//+ (instancetype)creat {
//    return [[self alloc] init];
//}
//
//- (instancetype)init {
//    return [self initWithFrame:CGRectMake(0, 0, DScreenWidth, TabBarHeight)];
//}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self.frame = CGRectMake(0, 0, DScreenWidth, TabBarHeight);
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
                barItemTitles:(NSArray<NSString *> *)itemTitles
    barItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
  barItemTitleUnselectedColor:(UIColor *)itemTitleUnselectedColor
    barItemSelectedImageNames:(NSArray<NSString *> *)itemSelectedImageNames
  barItemUnselectedImageNames:(NSArray<NSString *> *)itemUnselectedImageNames
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
