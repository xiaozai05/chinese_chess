//
//  CCActionQueue.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCActionStep.h"


//动作序列
@interface CCActionQueue : NSObject

@property(nonatomic,retain)NSMutableArray* actionList;
@property(nonatomic,assign)NSInteger currentIndex; //当前所处的动作序列中的下标

-(CCActionStep*)actionStepAtIndex:(NSInteger)index;

-(CCActionStep*)actionStepBack;

-(CCActionStep*)actionStepForward;

-(void)appendActionStep:(CCActionStep*)actionStep;


@end
