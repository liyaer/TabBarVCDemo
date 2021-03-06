//
//  WLKvcTabBar_.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/4.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLKvcTabBar.h"


@interface WLKvcTabBar () {
    WLTabBarItemStyle _centerStyle;
    NSInteger _itemCounts;
    NSInteger _specialIndex;
}
@property (nonatomic, strong) UIButton *centerBtn;

@end


@implementation WLKvcTabBar

#pragma mark - 初始化

+ (instancetype)tabBarWithCenterStyle:(WLTabBarItemStyle)centerStyle
                        barItemCounts:(NSInteger)itemCounts
                     specialItemIndex:(NSInteger)specialIndex {
    
    WLKvcTabBar *tabBar = [[self alloc] init];
    tabBar -> _centerStyle = centerStyle;
    tabBar -> _itemCounts = itemCounts;
    tabBar -> _specialIndex = specialIndex;
    return tabBar;
}

- (instancetype)init{
    
    if (self = [super init]) {
        [self addSubview:self.centerBtn];
    }
    return self;
}

#pragma mark - 重设子视图frame

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat tabBarWidth = CGRectGetWidth(self.frame);
    CGFloat itemWidth = tabBarWidth/(_itemCounts + 1);

    //设置特殊按钮的位置
    CGFloat centerX = itemWidth*_specialIndex + itemWidth/2;
    if (_centerStyle == WLTabBarItemHump) {
        _centerBtn.center = CGPointMake(centerX, 0);
    } else {
        _centerBtn.center = CGPointMake(centerX, cDTabBarHeight/2);
    }
    
    //设置其他tabBarItem的位置
    CGFloat itemX = 0.0;
    NSInteger index = 0;
    for (UIControl *item in self.subviews) {
        //过滤掉非tabBarItem类型的子视图
        if (![item isKindOfClass:[UIControl class]] || item == _centerBtn) {
            continue;
        }
        
        itemX = itemWidth * (index>=_specialIndex ? index+1 : index);
        item.frame = CGRectMake(itemX, 0, itemWidth, cDTabBarHeight);
        
        index++;
    }
}

#pragma mark - 点击事件

- (void)centerBtnClicked {
    
    NSLog(@"中间特殊按钮点击");
}

//重写hitTest方法，去监听特殊按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    if (_centerStyle == WLTabBarItemHump) {
        //判断当前手指是否点击到中间按钮上，如果是，则响应按钮点击，其他则系统处理
        //首先判断当前View是否被隐藏了，隐藏了就不需要处理了
        if (self.isHidden == NO) {
            //将当前tabbar的触摸点转换坐标系，转换到中间按钮的身上，生成一个新的点
            CGPoint newP = [self convertPoint:point toView:self.centerBtn];

            //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
            if ([self.centerBtn pointInside:newP withEvent:event]) {
                return self.centerBtn;
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - 懒加载

- (UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.frame = CGRectMake(0, 0, cDTabBarHeight, cDTabBarHeight);
        [_centerBtn setImage:[UIImage imageNamed:@"special_hump"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(centerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _centerBtn.adjustsImageWhenHighlighted = NO;
    }
    return _centerBtn;
}

@end
