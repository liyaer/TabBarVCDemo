//
//  WLTabBar.h
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLCustomTabBar : UIView

//+ (instancetype)creat;

- (instancetype)initWithFrame:(CGRect)frame
                barItemTitles:(NSArray<NSString *> *)itemTitles
    barItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
  barItemTitleUnselectedColor:(UIColor *)itemTitleUnselectedColor
    barItemSelectedImageNames:(NSArray<NSString *> *)itemSelectedImageNames
  barItemUnselectedImageNames:(NSArray<NSString *> *)itemUnselectedImageNames;

@end

NS_ASSUME_NONNULL_END
