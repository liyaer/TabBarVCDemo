//
//  WLTabBar.h
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class WLCustomTabBar;
@protocol WLCustomTabBarDelegate <NSObject>

- (void)tabBar:(WLCustomTabBar *)tabBar didSelectIndexFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface WLCustomTabBar : UIView

- (instancetype)initWithFrame:(CGRect)frame
                barItemTitles:(NSArray<NSString *> *)itemTitles
    barItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
  barItemTitleUnselectedColor:(UIColor *)itemTitleUnselectedColor
    barItemSelectedImageNames:(NSArray<NSString *> *)itemSelectedImageNames
  barItemUnselectedImageNames:(NSArray<NSString *> *)itemUnselectedImageNames;

@property (nonatomic, weak) id<WLCustomTabBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
