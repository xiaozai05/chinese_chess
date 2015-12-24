//
//  CCActionStep.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "common.h"

@interface CCActionStep : NSObject
@property(nonatomic,assign)CCPos_t srcPosition;  //源坐标
@property(nonatomic,assign)CCPos_t dstPosition;  //目的坐标
@property(nonatomic,assign)CCACTION_TYPE_t actType; //动作类型(吃子还是移动)
@property(nonatomic,assign)NSInteger tag; //行动棋子的tag值
@property(nonatomic,assign)NSInteger tagOfBeKilled; //被杀的棋子的tag值

-(instancetype)initWithSrcPosition:(CCPos_t)srcPosition andDstPosition:(CCPos_t)dstPosition andActType:(CCACTION_TYPE_t)actType andTag:(NSInteger)tag andTagOfBeKilled:(NSInteger)tagOfBeKilled;




@end
