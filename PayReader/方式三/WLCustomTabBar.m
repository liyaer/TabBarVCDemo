//
//  WLTabBar.m
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomTabBar.h"
#import "WLCustomBtn.h"
#import "Header.h"


@interface WLCustomTabBar () {
    NSInteger _itemCounts;
}

@end


@implementation WLCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame
                barItemTitles:(NSArray<NSString *> *)itemTitles
    barItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
  barItemTitleUnselectedColor:(UIColor *)itemTitleUnselectedColor
    barItemSelectedImageNames:(NSArray<NSString *> *)itemSelectedImageNames
  barItemUnselectedImageNames:(NSArray<NSString *> *)itemUnselectedImageNames {
    
    if (self = [super initWithFrame:frame]) {
        
        _itemCounts = itemTitles.count;
        
        for (int i = 0; i < itemTitles.count; i++) {
            WLCustomBtn *btn = [WLCustomBtn customWithTitle:itemTitles[i] titleColor:itemTitleUnselectedColor titleSelectColor:itemTitleSelectedColor image:itemUnselectedImageNames[i] selectImage:itemSelectedImageNames[i]];
            btn.tag = i;
            [self addSubview:btn];
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat tabBarWidth = CGRectGetWidth(self.frame);
    
    //设置中间特殊按钮的位置
//    if (_centerStyle == WLCenterStyleHump) {
//        _centerBtn.center = CGPointMake(tabBarWidth/2, 0);
//    } else {
//        _centerBtn.center = CGPointMake(tabBarWidth/2, TabBarHeight/2);
//    }
    
    //设置其他tabBarItem的位置
    CGFloat itemWidth = tabBarWidth/_itemCounts;
    CGFloat itemX = 0.0;
    
    for (int i = 0; i < _itemCounts; i++) {
        
        WLCustomBtn *btn = [self viewWithTag:i];
        itemX = itemWidth * i;
        btn.frame = CGRectMake(itemX, 0, itemWidth, TabBarHeight);
    }
}



@end
