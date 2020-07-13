//
//  WLCustomBtn.m
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLCustomBtn.h"

@implementation WLCustomBtn

+ (instancetype)customWithTitle:(NSString *)title
                     titleColor:(UIColor *)color
               titleSelectColor:(UIColor *)selectColor
                          image:(NSString *)image
                    selectImage:(NSString *)selectImage {
    
    WLCustomBtn *btn = [WLCustomBtn buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    return btn;
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    
//    [super imageRectForContentRect:contentRect];
//
//
//}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//
//    [super titleRectForContentRect:contentRect];
//
//
//}

@end
