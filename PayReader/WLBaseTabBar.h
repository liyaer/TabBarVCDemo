//
//  WLBaseTabBar.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, WLCenterStyle) {
    WLCenterStyleNormal = 1,
    WLCenterStyleHump
};


@interface WLBaseTabBar : UITabBar

@end

NS_ASSUME_NONNULL_END
