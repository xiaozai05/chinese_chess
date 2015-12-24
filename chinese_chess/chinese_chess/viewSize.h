//
//  viewSize.h
//  chinese_chess
//
//  Created by xiaozai on 15/12/15.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#ifndef chinese_chess_viewSize_h
#define chinese_chess_viewSize_h


#define SCALE_OF_BOARDVIEW 0.9

#define UP_SPACE_DIS  50

#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height
#define XDIS (VIEW_WIDTH/20.0)
#define BOARDWIDTH (VIEW_WIDTH-2*XDIS)
#define BOARDHEIGHT BOARDWIDTH*10/9
#define RECT_CPWIDTH BOARDWIDTH/9
#define RECT_CPHEIGHT BOARDHEIGHT/10
#define CPVIEW_SCALE 0.9
#define CPWIDTH RECT_CPWIDTH*SCALE
#define CPHEIGHT RECT_CPHEIGHT*SCALE

#define BTN_WIDTH 70
#define BTN_HEIGHT 40
#define BTN_XDIS 10
#define BTN_YDIS 10

#endif
