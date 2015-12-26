//
//  ExpressView.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "ExpressView.h"

@implementation ExpressView

-(instancetype)init{
    if (self=[super init]) {
        self.layer.cornerRadius=5;
        self.clipsToBounds=YES;
        self.alpha=0.9;
        self.backgroundColor=[UIColor colorWithRed:0.385 green:0.299 blue:0.130 alpha:1.000];
        
        self.bounds=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width*0.8, self.bounds.size.height*0.9) style:UITableViewStylePlain];
        self.tableView.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.closeButton setTitle:@"关 闭" forState:UIControlStateNormal];
        self.closeButton.backgroundColor=self.backgroundColor;
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.closeButton.frame=CGRectMake(0, self.bounds.size.height*0.9, self.bounds.size.width, self.bounds.size.height*0.1);
        [self addSubview:self.tableView];
        [self addSubview: self.closeButton];
    }
    return self;
}

-(instancetype)initWithDelegate:(id<UITableViewDelegate>)delegate andDataSource:(id<UITableViewDataSource>)dataSource{
    if (self = [self init]) {
        self.tableView.delegate=delegate; //设置tableView的代理
        self.tableView.dataSource=dataSource; //设置tableView的数据源代理
    }
    return self;
}

// 关闭tableView视图对象的方法
-(void)closeButtonClick:(UIButton*)btn{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
