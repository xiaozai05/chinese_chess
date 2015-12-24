//
//  common.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/15.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "common.h"


//将浮点坐标转成整型下标
CCPos_t positionFromCGPoint(CGPoint point){
    CCPos_t pos;
    pos.x=(int)point.x/40;
    pos.y=(int)point.y/40;
    return pos;
}

CGPoint centerPointFromCCPosition(CCPos_t position){
    CGPoint center =CGPointMake(position.x*40.0+20, position.y*40.0+20);
    return center;
}

// 绘制棋子的函数,传入棋子名称，尺寸，是否为选中状态，字体颜色
UIImage* drawchessPieceImageWithCPName(NSString*name, CGSize size, BOOL select, UIColor* wordColor){
    
    // 创建画布
    UIGraphicsBeginImageContext(size);
    // 获取画布
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    // 画圆
    CGContextAddEllipseInRect(con, CGRectMake(5, 5, size.width-10, size.height-10));
    // 设置填充色
    CGContextSetFillColorWithColor(con, [UIColor colorWithRed:0.581 green:0.435 blue:0.199 alpha:1.000].CGColor);
    // 填充
    CGContextFillPath(con);
    
    // 设置字体
    UIFont *font = [UIFont fontWithName:@"Chalkboard SE" size:size.width/2];
    NSAttributedString* attName =[[NSAttributedString alloc]initWithString:name attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:wordColor}];
    // 画字
    [attName drawInRect:CGRectMake(size.width/4,size.height/10, size.width, size.height)];
    
    // 判断是否为选中状态，如果为选中状态的棋子，就补画一个方框
    if (select ) {
        CGContextSetStrokeColorWithColor(con, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(con, 8);
        CGContextStrokeRect(con, CGRectMake(0, 0, size.width, size.height));
        CGContextStrokePath(con);
    }
    
    // 从画布了获取一幅图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭画布
    UIGraphicsEndImageContext();
    // 将图片返回
    return image;
}


