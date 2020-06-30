//
//  Header.h
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#ifndef Header_h
#define Header_h


static const CGFloat NavBarHeight = 44;
static const CGFloat TabBarHeight = 49;


//keyWindow
#define DWindow [UIApplication sharedApplication].keyWindow
//全屏的高、宽
#define DScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define DScreenWidth  ([UIScreen mainScreen].bounds.size.width)
//粪叉适配
#define IsiPhoneX             ((DScreenHeight >= 812) ? YES : NO)
#define StatusBarHeight       (IsiPhoneX ? 44 : 20)
#define NavHeightAll          (StatusBarHeight + 44)
#define BottomSafeAreaHeight  (IsiPhoneX ? 34 : 0)
#define TabBarHeightAll       (BottomSafeAreaHeight + 49)
//#define HasNavAndTabBarRect   CGRectMake(0, NavHeight, DScreenWidth, DScreenHeight -NavHeight -TabBarHeight)
//#define HasNavRect            CGRectMake(0, NavHeight, DScreenWidth, DScreenHeight -NavHeight -BottomSafeAreaHeight)


#endif /* Header_h */
