//
//  XZButton.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/17.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZButton : UIButton


-(instancetype)initWithTitle:(NSString*)title;

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title;

+(id)buttonWithType:(UIButtonType)buttonType andTitle:(NSString*)title;


@end
