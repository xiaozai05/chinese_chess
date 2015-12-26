//
//  CCActionQueue.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "CCActionQueue.h"

@implementation CCActionQueue


-(instancetype)init{
    if (self=[super init]) {
        self.actionList=[NSMutableArray new];
        self.currentIndex=0;
    }
    return self;
}

-(CCActionStep *)actionStepAtIndex:(NSInteger)index{
    // 如果队列为空，即刻返回nil
    if (index<0||index>=self.actionList.count) {
        return nil;
    }
    self.currentIndex=index;
    return self.actionList[index];
}

#pragma mark -后退一步
-(CCActionStep *)actionStepBack{
    // 如果还能后退，就后退一步
    if (self.actionList.count>0&& self.currentIndex>0) {
        self.currentIndex--;
        return self.actionList[self.currentIndex];
    }
    return nil;
}

#pragma mark -前进一步
-(CCActionStep *)actionStepForward{
    // 如果还能前进，就前进一步
    if (self.currentIndex<self.actionList.count) {
        return self.actionList[self.currentIndex++];
    }
    return nil;
}

#pragma mark -将一个动作加入队列中
-(void)appendActionStep:(CCActionStep *)actionStep{
    //  先删除从当前位置往后的动作序列
    [self.actionList removeObjectsInRange:NSMakeRange(self.currentIndex, self.actionList.count-self.currentIndex)];
    [self.actionList addObject:actionStep];
    self.currentIndex++;
    NSLog(@"正在增加:index=%li",self.currentIndex);
}

@end
