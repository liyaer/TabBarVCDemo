//
//  WLCustomBtn.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomBtn.h"


static const CGFloat ButtonImageRatio = 0.6; //图片文字上下方式排列时，图片高度所占的比例


@implementation WLCustomBtn

#pragma mark - 初始化

+ (instancetype)customWithTitle:(NSString *)title
                     titleColor:(UIColor *)color
               titleSelectColor:(UIColor *)selectColor
                          image:(NSString *)image
                    selectImage:(NSString *)selectImage
                            tag:(NSInteger)tag {
    
    WLCustomBtn *btn = [WLCustomBtn buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    btn.tag = tag;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
    
    // 重写了titleRectForContentRect、imageRectForContentRect方法，需要设置这两项
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.imageView.contentMode = UIViewContentModeCenter;
    
    return btn;
}

#pragma mark - 重写

// 设置 button 中 image 的 frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    [super imageRectForContentRect:contentRect];

    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width;
    CGFloat imageH = self.frame.size.height * ButtonImageRatio;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

// 设置 button 中 title 的 frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    [super titleRectForContentRect:contentRect];

    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height * ButtonImageRatio;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height - titleY;

    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {

    // 不调用super，防止按钮高亮
//    [super setHighlighted:highlighted];
}

@end
