//
//  ExpressView.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/24.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressView : UIView

@property(nonatomic,retain)UITableView* tableView;
@property(nonatomic,retain)UIButton* closeButton;


-(instancetype)initWithDelegate:(id<UITableViewDelegate>)delegate andDataSource:(id<UITableViewDataSource>)dataSource;


@end
