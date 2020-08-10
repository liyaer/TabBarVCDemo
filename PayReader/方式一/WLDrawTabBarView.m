//
//  WLDrawTabBarView.m
//  PayReader
//
//  Created by DuBenben on 2020/7/22.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import "WLDrawTabBarView.h"


static const CGFloat lineWidth = 1;


@implementation WLDrawTabBarView

- (void)drawRect:(CGRect)rect {
    
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    
    CGPoint circleCenter = CGPointMake(width/2, height/2); //圆心
    CGFloat radiu = (height - lineWidth)/2; //半径
    CGFloat lineY = height - kDTabBarHeightAll; //横线（绘制点）的Y值
    CGFloat toLine = circleCenter.y - lineY; //圆心到横线（绘制点）的垂直距离
    CGFloat missingLineWidth = sqrt(pow(radiu, 2) - pow(toLine, 2));
    missingLineWidth = missingLineWidth * 2; //利用勾股定理，计算圆弧对应的弦长（ = 横线缺失部分长度）
    CGFloat lineW = (width - missingLineWidth)/2.0; //横线（需要绘制的）长度
    CGPoint roundLeftPoint = CGPointMake(lineW, lineY); //圆弧左节点
    CGPoint roundRightPoint = CGPointMake(width - lineW, lineY); //圆弧右节点
    
    
    //左边横线
    UIBezierPath *leftLinePath = [UIBezierPath bezierPath];
    [leftLinePath moveToPoint:CGPointMake(0, lineY)];
    [leftLinePath addLineToPoint:roundLeftPoint];
    
    //圆弧
    CGFloat pi = acos(toLine / radiu); //入参：角度对应的余弦值 返回：角度对应的弧度值
    
    UIBezierPath *roundLinePath = [UIBezierPath bezierPath];
    [roundLinePath moveToPoint:roundLeftPoint];
    [roundLinePath addArcWithCenter:circleCenter radius:radiu startAngle:-pi - M_PI_2 endAngle:pi - M_PI_2 clockwise:true]; //clockwise:是否顺时针绘圆
    
    //右边横线
    UIBezierPath *rightLinePath = [UIBezierPath bezierPath];
    [rightLinePath moveToPoint:roundRightPoint];
    [rightLinePath addLineToPoint:CGPointMake(width, lineY)];
    
    //path append
    [leftLinePath appendPath:roundLinePath];
    [leftLinePath appendPath:rightLinePath];
    
    
    //stroke
    UIColor *strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    [strokeColor set];
    leftLinePath.lineWidth = lineWidth;
    leftLinePath.lineCapStyle = kCGLineCapRound; //线条拐角
    leftLinePath.lineJoinStyle = kCGLineJoinRound; //终点处理
    [leftLinePath stroke];
    

    //mask
    //获取直线下面矩形范围路径
    UIBezierPath *bottomRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, lineY, width, height-lineY)];
    //UIBezierPath描述的是绘制点所形成的shape，而绘制点的宽度忽略不计。lineWidth属性以绘制点为中点，上下\左右 延伸lineWidth/2
    [bottomRect appendPath:leftLinePath];

    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bottomRect.CGPath;
    
    self.layer.mask = shapeLayer;
}

@end
