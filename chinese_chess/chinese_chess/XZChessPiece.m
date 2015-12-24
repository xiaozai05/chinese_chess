//
//  XZChessPiece.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/9.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "XZChessPiece.h"
#import "XZCPCannon.h"
#import "XZCPGharry.h"
#import "XZCPElephant.h"
#import "XZCPSergeancy.h"
#import "XZCPMarshal.h"
#import "XZCPHorse.h"
#import "XZCPSoldier.h"



NSString* CPClassNameFormCPName(CPName_t name){
    switch (name) {
            
            // 绿方:
        case G_MARSHAL:     // 帅
        case R_MARSHAL:   return @"XZCPMarshal";  // 帅
        case G_SERGEANCY:    // 士
        case R_SERGEANCY: return @"XZCPSergeancy";  // 士
        case G_ELEPHANT:     // 象
        case R_ELEPHANT:  return @"XZCPElephant";   // 象
        case G_HORSE:        // 马
        case R_HORSE:     return @"XZCPHorse";   // 马
    
        case G_GHARRY:      // 车
        case R_GHARRY:    return @"XZCPGharry";   // 车
        case G_CANNON:       // 炮
        case R_CANNON:    return @"XZCPCannon";   // 炮
        case G_SOLDIER:      // 兵
        case R_SOLDIER:   return @"XZCPSoldier";
        default:  return nil;
    }
}


@implementation XZChessPiece


// 棋子的构造方法，采用工厂模式创建其具体子类
-(id)initWithPosition:(CCPos_t)position andName:(CPName_t)name andPower:(CPPower_t)power andTag:(NSInteger)tag andCPName:(NSString *)cpName{
    
    NSString* cpClassName =CPClassNameFormCPName(name);
    Class cpClass = NSClassFromString(cpClassName);
    self =[[cpClass alloc]init];
    if (self) {
        self.position=position;
        self.name=name;
        self.power=power;
        self.tag=tag;
        self.cpName=cpName;
        // 如果tag值小于16，是绿方棋子,否则是红方棋子
        if (name<R_MARSHAL) {
            self.role=GREEN_ROLE;
        }else{
            self.role=RED_ROLE;
        }
        self.active=YES;
    }
    return self;
}

-(BOOL)moveToPosition:(CCPos_t)position{
    return YES;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"[%@:%i:(%i,%i):%li]", self.cpName,self.name,self.position.x,self.position.y,self.tag];
}


@end
