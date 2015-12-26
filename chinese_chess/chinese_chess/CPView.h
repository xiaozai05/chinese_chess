//
//  CPView.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/11.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewSize.h"
#import "common.h"


//棋子视图类
@interface CPView : UIView
{
    @private
    BOOL _selectStatus; //选中状态标志,私有成员
}

@property(nonatomic,retain)UIImage* selectImage; //棋子选中时的图片
@property(nonatomic,retain)UIImage* image; //棋子非选中时的图片
@property(nonatomic,assign)CCPos_t position;//在象棋逻辑矩阵中的下标坐标
@property(nonatomic,readonly,assign,getter=isSelected)BOOL selectStatus;
// 棋子视图设置为非选中状态
-(void)becomeUnselected;
// 棋子视图设置为选中状态
-(void)becomeSelected;

// 让棋子视图消失(注意: 即变成空白视图，而不是从父视图内移出)
-(void)disappear;

@end
