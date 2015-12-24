//
//  CCActionStep.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "CCActionStep.h"

@implementation CCActionStep

-(instancetype)initWithSrcPosition:(CCPos_t)srcPosition andDstPosition:(CCPos_t)dstPosition andActType:(CCACTION_TYPE_t)actType andTag:(NSInteger)tag andTagOfBeKilled:(NSInteger)tagOfBeKilled{
    if (self=[super init]) {
        self.srcPosition=srcPosition;
        self.dstPosition=dstPosition;
        self.actType=actType;
        self.tag=tag;
        self.tagOfBeKilled=tagOfBeKilled;
    }
    return self;
}






@end
