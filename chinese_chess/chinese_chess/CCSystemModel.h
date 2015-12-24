//
//  CCSystemModel.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/9.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZChessPiece.h"
#import "common.h"
#import "CCActionQueue.h"



// 象棋系统模型
@interface CCSystemModel : NSObject <ChessPieceDelegate>
{
@public
    id matrix[YLENGTH][XLENGTH];//棋盘矩阵,所有棋规判断都是基于这个矩阵完成
}

@property(nonatomic,assign)CCROLE_t myselfRole; // 已方角色,即棋盘下半部分的角色
@property(nonatomic,retain)NSMutableArray* cpList; //棋子列表
@property(nonatomic,assign)XZChessPiece* currentCP; //当前被选中的棋子
@property(nonatomic,assign)CCROLE_t role;//当前可下棋的角色 红方，绿方
@property(nonatomic,assign)CCPLAY_MODEL_t playModel; //下棋模式(分局域网对战，人机对象，棋路研究等各种模式)
@property(nonatomic,assign)BOOL stop; //非活跃状态 ,即是否开始下棋
@property(nonatomic,assign)BOOL pause; //暂停状态
@property(nonatomic,retain)CCActionQueue* actionQueue;  //动作序列容器,用于后退，前进

//初始化系统模型,  参数说明:  role： 代表己方角色值,  playModel： 下棋模式: 分为打谱，人机对弈，局域网对战，连网对战
-(id)initWithRole:(CCROLE_t)role andPlayModel:(CCPLAY_MODEL_t)playModel;

//移动棋子分析逻辑
-(CCANALYSE_RESULT_t)analyseForMotionToDestination:(CCPos_t)position;


// 获取棋子模型
-(XZChessPiece*)chessPieceForTag:(NSInteger)tag;

// 选中一个棋子
-(BOOL)selectChessPiece:(XZChessPiece*)cp;

//吃子分析逻辑
-(CCANALYSE_RESULT_t)analyseForKillChessPiece:(XZChessPiece*)cp;

//  模型分析棋局状态，返回胜负，将军等状态信息
-(CCSITUATION_TYPE_t)checkForSituation;

//  模型分析:如果走这一步棋，会有什么结果
-(CCSITUATION_TYPE_t)checkForSituationIfTheChessPiece:(XZChessPiece*)cp MoveToPosition:(CCPos_t)position;

//  模型分析: 如果吃这个棋子，会有什么结果
-(CCSITUATION_TYPE_t)checkForSituationIfTheChessPiece:(XZChessPiece *)cp killAnther:(XZChessPiece*)anther;

//  在模型中,移动一颗棋子的过程
-(void)actionChessPiece:(XZChessPiece*)cp moveToPosition:(CCPos_t)position;

//  在模型中，吃掉一颗棋子的过程
-(void)actionChessPiece:(XZChessPiece*)cp replaceWithAnther:(XZChessPiece*)anther;

// 交换角色下棋
-(void)exchangeRole;

// 后退一步
-(CCActionStep*)backStep;

//前进一步
-(CCActionStep*)forwardStep;


// 生成棋谱
-(NSArray*)expressListOfAllSteps;


@end
