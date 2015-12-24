//
//  Tools.h
//  MannerBar
//
//  Created by liangw on 13-1-7.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

/**
 * Description : 工具类，创建一些通用的视图或者字符串处理
 *
 */

@interface Tools : NSObject

//在view中显示提示文字
+ (void)showSpinnerInView:(UIView *)view;
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt;
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt delay:(NSTimeInterval)delay;
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt delay:(NSTimeInterval)delay positionY:(float)positionY;
+ (void)hideSpinnerInView:(UIView *)view;
@end
