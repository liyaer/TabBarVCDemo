//
//  Header.h
//  PayReader
//
//  Created by DuBenben on 2020/6/29.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#ifndef Header_h
#define Header_h


static const CGFloat cDNavBarHeight = 44;
static const CGFloat cDTabBarHeight = 49;


//keyWindow
#define kDWindow [UIApplication sharedApplication].keyWindow
//屏幕的高、宽
#define kDScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kDScreenWidth  ([UIScreen mainScreen].bounds.size.width)
//粪叉适配
#define kDIsiPhoneX               ((kDScreenHeight >= 812) ? YES : NO)
#define kDStatusBarHeight         (kDIsiPhoneX ? 44 : 20)
#define kDNavHeightAll            (kDStatusBarHeight + cDNavBarHeight)
#define kDBottomSafeAreaHeight    (kDIsiPhoneX ? 34 : 0)
#define kDTabBarHeightAll         (kDBottomSafeAreaHeight + cDTabBarHeight)


#endif /* Header_h */
