//
//  CCBoardView.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/11.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

#import "CPView.h"



// 棋盘视图数据源代理协议
@protocol CCBoardViewDataSource <NSObject>

#pragma mark -创建棋子视图的代理方法，以下两个方法任用一个
// 设置棋子视图的代理方法
-(void)setCPView:(CPView*)view inIndexX:(int)x andIndexY:(int)y;
// 返回棋子视图的代理方法
-(CPView*)CPViewIndexX:(int)x andIndexY:(int)y;


@end

#pragma mark -棋盘视图类
@interface CCBoardView : UIView

@property(nonatomic,assign)id<CCBoardViewDataSource>dataSource;

//用数据源代理来构造棋盘视图
-(id)initWithDataSource:(id<CCBoardViewDataSource>)dataSource;
-(id)initWithFrame:(CGRect)frame andDataSource:(id<CCBoardViewDataSource>)dataSource;

// 通过位置获取棋子视图对象
-(CPView*)viewWithPosition:(CCPos_t)position;

// 获取当前被设置为选中状态的视图   
-(CPView*)viewIsSelected;


@end
