//
//  Tools.m
//  MannerBar
//
//  Created by liangw on 13-1-7.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "Tools.h"
#import "MBProgressHUD.h"

@implementation Tools

//在view中显示提示文字
+ (void)showSpinnerInView:(UIView *)view
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
    }
}
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        if (prompt.length > 0) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = prompt;
            if (prompt.length > 12) {
                hud.labelFont = [UIFont systemFontOfSize:12];
            }
            else {
                hud.labelFont = [UIFont systemFontOfSize:14];
            }
        }
//        [UIView animateWithDuration:10 delay:20 options:0 animations:^(){
//            [self hideSpinnerInView:view];
//        } completion:nil];
    }
}
+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt delay:(NSTimeInterval)delay
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        if (prompt.length > 0) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = prompt;
            if (prompt.length > 12) {
                hud.labelFont = [UIFont systemFontOfSize:12];
            }
            else {
                hud.labelFont = [UIFont systemFontOfSize:14];
            }
        }
        //最佳的延迟时间是1.4s
        [hud hide:YES afterDelay:delay];
    }
}

+ (void)showSpinnerInView:(UIView *)view prompt:(NSString *)prompt delay:(NSTimeInterval)delay positionY:(float)positionY
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        hud.yOffset = positionY;
        if (prompt.length > 0) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = prompt;
            if (prompt.length > 12) {
                hud.labelFont = [UIFont systemFontOfSize:12];
            }
            else {
                hud.labelFont = [UIFont systemFontOfSize:14];
            }
        }
        //最佳的延迟时间是1.4s
        [hud hide:YES afterDelay:delay];
    }
}

+ (void)hideSpinnerInView:(UIView *)view
{
    if (view != nil) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    }
}

@end
