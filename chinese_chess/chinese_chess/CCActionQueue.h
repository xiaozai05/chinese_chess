//
//  CCActionQueue.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCActionStep.h"


//将所有下棋的动作全部添加到CCActionQueue类的对象中,
@interface CCActionQueue : NSObject

@property(nonatomic,retain)NSMutableArray* actionList; //数组，用于装 CCActionStep类对象
@property(nonatomic,assign)NSInteger currentIndex; //当前所处的动作序列中的下标

// 指下序号返回某一步
-(CCActionStep*)actionStepAtIndex:(NSInteger)index;
// 回退一步
-(CCActionStep*)actionStepBack;
// 前进一步
-(CCActionStep*)actionStepForward;

// 将每个动作都加到本对象的方法
-(void)appendActionStep:(CCActionStep*)actionStep;


@end
