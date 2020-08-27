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


static const NSInteger cDTagAddedValue = 10; //设置btn tag时所加的固定值


@interface WLCustomTabBar () {
    NSInteger _itemCounts;
    UIButton *_lastClickBtn;
}

@property (nonatomic, strong) UIButton *centerBtn;

@end


@implementation WLCustomTabBar

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
                barItemTitles:(NSArray<NSString *> *)itemTitles
    barItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
  barItemTitleUnselectedColor:(UIColor *)itemTitleUnselectedColor
    barItemSelectedImageNames:(NSArray<NSString *> *)itemSelectedImageNames
  barItemUnselectedImageNames:(NSArray<NSString *> *)itemUnselectedImageNames {
    
    if (self = [super initWithFrame:frame]) {
                
        _itemCounts = itemTitles.count;
        
        [self addSubview:self.centerBtn];
        
        for (int i = 0; i < itemTitles.count; i++) {
            
            WLCustomBtn *btn = [WLCustomBtn customWithTitle:itemTitles[i] titleColor:itemTitleUnselectedColor titleSelectColor:itemTitleSelectedColor image:itemUnselectedImageNames[i] selectImage:itemSelectedImageNames[i] tag:(i + cDTagAddedValue)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            //设置初始选中值
            if (i == 0) {
                btn.selected = YES;
                _lastClickBtn = btn;
            }
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
        _centerBtn.center = CGPointMake(tabBarWidth/2, cDTabBarHeight/2);
//    }
    
    //设置其他tabBarItem的位置
    CGFloat itemWidth = tabBarWidth/(_itemCounts + 1);
    CGFloat itemX = 0.0;
    for (int i = 0; i < _itemCounts; i++) {
        
        UIButton *btn = [self viewWithTag:(i + cDTagAddedValue)];
        itemX = itemWidth * (i>(_itemCounts/2-1) ? i+1 : i);
        btn.frame = CGRectMake(itemX, 0, itemWidth, cDTabBarHeight);
    }
}

#pragma mark - 点击事件

- (void)btnClicked:(UIButton *)btn {
    
    if (btn.tag == 10086) {
        
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectIndexFrom:to:)]) {
            [self.delegate tabBar:self didSelectIndexFrom:(_lastClickBtn.tag - cDTagAddedValue) to:btn.tag];
        }
    } else {

        if (btn == _lastClickBtn) {
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectIndexFrom:to:)]) {
            
            [self.delegate tabBar:self didSelectIndexFrom:(_lastClickBtn.tag - cDTagAddedValue) to:(btn.tag - cDTagAddedValue)];
            
            btn.selected = !btn.selected;
            _lastClickBtn.selected = !_lastClickBtn.selected;
            _lastClickBtn = btn;
        }
    }
}

#pragma mark - 以下方法，无法解决特殊按钮凸起部分的点击响应，自己去看事件传递和响应者链的知识

//这些方法之所以不会走，是因为将self添加在了tabBarVC.tabBar上
//你也许会想，那我把self添加在tabBarVC.view上不就可以了么？的确，这样可以解决凸起点击问题，但是当push时需要隐藏tabBar，此时需要自己处理self的隐藏和显示

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//
//    return [super pointInside:point withEvent:event];
//}
//
////重写hitTest方法，去监听中间按钮的点击，目的是为了让凸出的部分点击也有反应
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    return [super hitTest:point withEvent:event];
//}
//
////解决中间特殊按钮凸起部分不能响应点击事件
////该次点击没有其他事件响应时，才会调用下面的方法（比如点击tabBarItem，会拦截响应该方法）
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    [super touchesBegan:touches withEvent:event];
//}

#pragma mark - 懒加载

- (UIButton *)centerBtn {
    
    if (!_centerBtn) {
        
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(0, 0, cDTabBarHeight, cDTabBarHeight);
        [_centerBtn setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        _centerBtn.adjustsImageWhenHighlighted = NO;
        _centerBtn.tag = 10086;
        [_centerBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerBtn;
}

@end
