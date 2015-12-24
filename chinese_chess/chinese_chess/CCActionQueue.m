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
    if (index<0||index>=self.actionList.count) {
        return nil;
    }
    self.currentIndex=index;
    return self.actionList[index];
}

-(CCActionStep *)actionStepBack{
//    NSLog(@"currentIndex=%li",self.currentIndex);
    if (self.actionList.count>0&& self.currentIndex>0) {
        self.currentIndex--;
        return self.actionList[self.currentIndex];
    }
    return nil;
}

-(CCActionStep *)actionStepForward{
    if (self.currentIndex<self.actionList.count) {
        return self.actionList[self.currentIndex++];
    }
    return nil;
}

-(void)appendActionStep:(CCActionStep *)actionStep{
    [self.actionList removeObjectsInRange:NSMakeRange(self.currentIndex, self.actionList.count-self.currentIndex)];
    [self.actionList addObject:actionStep];
    self.currentIndex++;
    NSLog(@"正在增加:index=%li",self.currentIndex);
}

@end
