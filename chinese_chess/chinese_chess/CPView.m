//
//  CPView.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/11.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "CPView.h"

@implementation CPView


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews=YES; //自动缩放子视图
        self.userInteractionEnabled=YES; //打开用户交互，需要响应手势
        self->_selectStatus=NO;
    }
    return self;
}

-(instancetype)init{
    if (self=[super init]) {
        self.autoresizesSubviews=YES;
        self.userInteractionEnabled=YES;
        self->_selectStatus=NO;
    }
    return self;
}

#pragma mark -棋子视图设置为选中状态
-(void)becomeSelected{
    self->_selectStatus=YES;
    self.layer.contents=(id)self.selectImage.CGImage;
}

#pragma mark -棋子视图设置为非选中状态
-(void)becomeUnselected{
    self->_selectStatus=NO;
    self.layer.contents=(id)self.image.CGImage;
}

#pragma mark -让棋子视图不可见
-(void)disappear{
    self.layer.contents=nil;
}


-(NSString *)description{
    return [NSString stringWithFormat:@"[(%d,%d):tag=%li]",self.position.x,self.position.y,self.tag];
}

@end
