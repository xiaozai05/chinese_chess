//
//  XZButton.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/17.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "XZButton.h"

@implementation XZButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)buttonWithType:(UIButtonType)buttonType andTitle:(NSString *)title {
    XZButton* button =[XZButton buttonWithType:buttonType];
//    button.backgroundColor=[UIColor colorWithRed:0.123 green:0.874 blue:1.000 alpha:1.000];
    button.backgroundColor=[UIColor blackColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius=3;
    return button;
}

-(instancetype)initWithTitle:(NSString *)title{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.123 green:0.874 blue:1.000 alpha:1.000];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.cornerRadius=3;
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.123 green:0.874 blue:1.000 alpha:1.000];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.layer.cornerRadius=3;
    }
    return self;
}

@end
