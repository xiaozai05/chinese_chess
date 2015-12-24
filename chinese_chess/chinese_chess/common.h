//
//  common.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/14.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#ifndef chinese_chess_common_h
#define chinese_chess_common_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 棋子名称
typedef enum chess_name{
    // 绿方:
    G_MARSHAL = 1,  // 帅
    G_SERGEANCY,    // 士
    G_ELEPHANT,     // 象
    G_HORSE,        // 马
    G_GHARRY,       // 车
    G_CANNON,       // 炮
    G_SOLDIER,      // 兵
    
    //红方
    R_MARSHAL,      // 帅
    R_SERGEANCY,    // 士
    R_ELEPHANT,     // 象
    R_HORSE,        // 马
    R_GHARRY,       // 车
    R_CANNON,       // 炮
    R_SOLDIER,      // 兵
} CPName_t;


typedef enum{
    RED_ROLE=-1,
    GREEN_ROLE=1,
}CCROLE_t;


// 棋局状态，
typedef enum {
    CCWIN,  //已分胜负
    CCWILLWIN,// 正在将军
    CCWILL_DEFEATED, //正在被将军
    CCFACE_TO_FACE, //将帅会面
    CCNULL, //无明显局势
} CCSITUATION_TYPE_t;

typedef enum {
    LAN_PLAY_MODEL, //局域网对战模式
    SINGLE_PLAY_MODEL, //棋路研究模式
    PM_MODEL, //人模对战模式
}CCPLAY_MODEL_t;

// 落子点坐标，整型x,y
typedef struct {
    int x,y;
}CCPos_t;

typedef unsigned char CPPower_t;


//走棋逻辑分析结果
typedef enum {
    CCANALYSE_RESULT_OK=1,
    CCANALYSE_RESULT_FAIL,
    CCANALYSE_WILL_BE_KILLED,
    CCANALYSE_WILL_KILL_ENEMY,
}CCANALYSE_RESULT_t;

#define XZMakePos(x,y) ((CCPos_t){x,y})




//棋子数量
#define CPTOTAL 32

//  绿子在上方的初始化顺序
#define CPNAMES @[@1,@2,@2,@3,@3,@4,@4,@5,@5,@6,@6,@7,@7,@7,@7,@7,@8,@9,@9,@10,@10,@11,@11,@12,@12,@13,@13,@14,@14,@14,@14,@14]

//  红子在上方的初始化顺序
#define R_CPNAMES @[@8,@9,@9,@10,@10,@11,@11,@12,@12,@13,@13,@14,@14,@14,@14,@14,@1,@2,@2,@3,@3,@4,@4,@5,@5,@6,@6,@7,@7,@7,@7,@7]

#define CPNAMESS @[@"将",@"士",@"士",@"象",@"象",@"马",@"马",@"车",@"车",@"炮",@"炮",@"兵",@"兵",@"兵",@"兵",@"兵", @"帅",@"士",@"士",@"象",@"象",@"马",@"马",@"车",@"车",@"炮",@"炮",@"卒",@"卒",@"卒",@"卒",@"卒"]

#define CPPOWERS @[@1,@2,@2,@3,@3,@6,@6,@12,@12,@6,@6,@1,@1,@1,@1,@1,@1,@2,@2,@3,@3,@6,@6,@12,@12,@6,@6,@1,@1,@1,@1,@1]


#define XPS @[@4,@3,@5,@2,@6,@1,@7,@0,@8,@1,@7,@0,@2,@4,@6,@8,@4,@3,@5,@2,@6,@1,@7,@0,@8,@1,@7,@0,@2,@4,@6,@8]

#define YPS @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@2,@2,@3,@3,@3,@3,@3,@9,@9,@9,@9,@9,@9,@9,@9,@9,@7,@7,@6,@6,@6,@6,@6]


//图片文件名
#define CP_IMAGE_NAMES @[@"1_1.png",@"2_1.jpg",@"2_1.jpg",@"3_1.jpg",@"3_1.jpg",@"4_1.jpg",@"4_1.jpg",@"5_1.jpg",@"5_1.jpg",@"6_1.jpg",@"6_1.jpg",@"7_1.jpg",@"7_1.jpg",@"7_1.jpg",@"7_1.jpg",@"7_1.jpg",@"8_1.jpg",@"9_1.jpg",@"9_1.jpg",@"10_1.jpg",@"10_1.jpg",@"11_1.jpg",@"11_1.jpg",@"12_1.jpg",@"12_1.jpg",@"13_1.jpg",@"13_1.jpg",@"14_1.jpg",@"14_1.jpg",@"14_1.jpg",@"14_1.jpg",@"14_1.jpg"]

#define XLENGTH 9
#define YLENGTH 10


UIImage* drawchessPieceImageWithCPName(NSString*name, CGSize size, BOOL select, UIColor* wordColor);



#endif
