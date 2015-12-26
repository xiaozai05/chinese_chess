//
//  XZChessPiece.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/9.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "common.h"


@protocol ChessPieceDelegate <NSObject>



@end


// 棋子类基类
@interface XZChessPiece : NSObject

@property(nonatomic,assign)CCPos_t position; //棋子坐标
@property(nonatomic,assign)CPName_t name;   // 棋子名称,整型
@property(nonatomic,assign)NSInteger tag;//棋子唯一的标识号
@property(nonatomic,assign)CPPower_t power;//棋力值
@property(nonatomic,assign)CCROLE_t role;//红方，绿方
@property(nonatomic,copy)NSString* cpName;//棋子名称,字符串形式
@property(nonatomic,assign)BOOL active; //生死状态  YES为生

// 代理  执行逻辑
@property(nonatomic,assign)id<ChessPieceDelegate> delegate;

-(id)initWithPosition:(CCPos_t)position andName:(CPName_t)name andPower:(CPPower_t)power andTag:(NSInteger)tag andCPName:(NSString*)cpName;




@end
