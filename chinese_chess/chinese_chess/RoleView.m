//
//  RoleView.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/20.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "RoleView.h"

@implementation RoleView

-(instancetype)init{
    self=[super init];
    if (self) {
        self.redImage=drawchessPieceImageWithCPName(@"帅", CGSizeMake(160,160), NO, [UIColor redColor]);
        self.greenImage=drawchessPieceImageWithCPName(@"将", CGSizeMake(160,160), NO, [UIColor greenColor]);
        [self displayRedRole];
    }
    return  self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.redImage=drawchessPieceImageWithCPName(@"帅", CGSizeMake(160,160), NO, [UIColor redColor]);
        self.greenImage=drawchessPieceImageWithCPName(@"将", CGSizeMake(160,160), NO, [UIColor greenColor]);
        [self displayRedRole];
    }
    return self;
    
}

-(id)initWithRedImage:(UIImage *)redImage andGreenImage:(UIImage *)greenImage{
    self=[super init];
    if (self) {
        if (redImage) {
            self.redImage=redImage;
        }else{
            self.redImage=drawchessPieceImageWithCPName(@"帅", CGSizeMake(320,320), NO, [UIColor redColor]);
        }
        if (greenImage) {
            self.greenImage=greenImage;
        }else{
            self.greenImage=drawchessPieceImageWithCPName(@"将", CGSizeMake(320,320), NO, [UIColor greenColor]);
        }
        [self displayRedRole];
    }
    return self;
}

#pragma mark -展示红方图标
-(void)displayRedRole{
    self.role=RED_ROLE;
    self.layer.contents=(id)self.redImage.CGImage;

    NSLog(@"完成红色图标设置\n");
}

#pragma mark -展示绿方图标
-(void)displayGreenRole{
    self.role=GREEN_ROLE;
    self.layer.contents=(id)self.greenImage.CGImage;
}


#pragma mark -切换角色图标
-(void)turnRole{
    self.role=-self.role;
    if (self.role==RED_ROLE) {
        self.layer.contents=(id)self.redImage.CGImage;
    }else{
        self.layer.contents=(id)self.greenImage.CGImage;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
