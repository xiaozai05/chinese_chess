//
//  CCBoardView.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/11.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "CCBoardView.h"

#import "CPView.h"


@implementation CCBoardView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        // 设置一些外观属性
        [self setGeneralProperties];
    }
    return self;
}

// 初始化时添加代理
-(id)initWithDataSource:(id<CCBoardViewDataSource>)dataSource{
    self=[super init];
    if (self) {
        [self setGeneralProperties];
        self.dataSource=dataSource; //设置数据源代理
        [self createCPViews];//创建所有棋子视图
           }
    return self;
}

-(id)initWithFrame:(CGRect)frame andDataSource:(id<CCBoardViewDataSource>)dataSource{
    self=[super initWithFrame:frame];
    if (self) {
        [self setGeneralProperties];//常用的属性设置
        self.dataSource=dataSource; //数据源代理
        [self createCPViews]; //创建所有棋子视图
    }
    return self;
}

-(instancetype)init{
    if (self=[super init]) {
        [self setGeneralProperties];
    }
    return self;
}

#pragma mark -设置棋盘视图的常用属性
-(void)setGeneralProperties{
    self.tag=-1000; //设置棋盘视图的tag值，防止和棋子视图对象的tag值相互干扰
    self.layer.cornerRadius=3; //设置棋盘圆角半径
    self.clipsToBounds=YES; // 裁剪子视图
    //设置棋盘背景图片
    self.layer.contents=(id)[UIImage imageNamed:@"board.jpeg"].CGImage;
}

//创建棋子视图，注意需要使用数据源代理来完成创建
-(void)createCPViews{
    // 双层循环遍历模型中的二维数组
    for (int i=0; i<YLENGTH; i++) {
        for (int j=0; j<XLENGTH; j++) {
            // 通过数据源代理方法获取棋子视图对象
            CPView * view = [self.dataSource CPViewIndexX:j andIndexY:i];
            // 将view加入子视图列表
            [self addSubview:view];
            // 添加布局约束
            view.translatesAutoresizingMaskIntoConstraints=NO;
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:CPVIEW_SCALE* 1.0/9 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:CPVIEW_SCALE* 1.0/9 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:((CGFloat)j+0.5)*1.0/9 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:((CGFloat)i+0.5)*1.0/10 constant:0]];
        }
    }
}


-(CPView *)viewWithPosition:(CCPos_t)position{
    for (CPView* view in self.subviews) {
        if (view.position.x==position.x && view.position.y==position.y) {
            return view;
        }
    }
    return nil;
}

-(CPView *)viewIsSelected{
    for (CPView* view  in self.subviews) {
        if ([view isSelected]) {
            return view;
        }
    }
    return nil;
}

@end
