//
//  RoleView.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/20.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

//角色视图类 [说明:  用于在棋盘左下方显示当前应该下棋的角色]
@interface RoleView : UIView

@property(nonatomic,assign)CCROLE_t role;  // 角色枚举值
@property(nonatomic,retain)UIImage* redImage; // 红方标志图标
@property(nonatomic,retain)UIImage* greenImage; // 绿方标志图标


// 可以使用图标素材来初始化，如果传入的两个参数是nil,则采用内部创建的默认图标
-(id)initWithRedImage:(UIImage*)redImage andGreenImage:(UIImage*)greenImage;


// 展示红方标志视图
-(void)displayRedRole;
// 展示绿方标志视图
-(void)displayGreenRole;

// 转换角色视图
-(void)turnRole;

@end
