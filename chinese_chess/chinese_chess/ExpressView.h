//
//  ExpressView.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于显示棋谱的类
@interface ExpressView : UIView

@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,retain)UIButton* closeButton;


-(instancetype)initWithDelegate:(id<UITableViewDelegate>)delegate andDataSource:(id<UITableViewDataSource>)dataSource;


@end
