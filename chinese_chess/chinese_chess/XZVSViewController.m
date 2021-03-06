//
//  XZVSViewController.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/20.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "XZVSViewController.h"
#import "CCSystemModel.h"
#import "CCBoardView.h"
#import "XZButton.h"
#import "MBProgressHUD.h"

#import "Tools.h"

@interface XZVSViewController () <CCBoardViewDataSource>

@property(nonatomic,retain)CCSystemModel* model; //模型
@property(nonatomic,retain)UIView * topRect; // 棋盘上方区域
@property(nonatomic,retain)CCBoardView* boardView; //棋盘区域视图
@property(nonatomic,retain)UIView * bottomRect; //棋盘下方区域
@property(nonatomic,retain)UILabel * statusRect; //状态区域


@end

@implementation XZVSViewController


-(void)createData{
    self.model = [[CCSystemModel alloc]initWithRole:RED_ROLE andPlayModel:SINGLE_PLAY_MODEL];
}

-(void)createUI{
    //添加背景
    UIImage* bgImage = [UIImage imageNamed:@"bg.png"];
    self.view.layer.contents=(id)bgImage.CGImage;
    
    self.topRect=[UIView new]; //棋盘上边区域
    //    self.topRect.backgroundColor=[UIColor blueColor];
    self.bottomRect=[UIView new]; //棋盘下边域
    //    self.bottomRect.backgroundColor=[UIColor redColor];
    self.boardView=[[CCBoardView alloc]initWithDataSource:self]; //棋盘
    self.statusRect=[UILabel new];  // 状态区
    //    self.statusRect.backgroundColor=[UIColor greenColor];
    self.statusRect.text=@"状态栏";
    [self.view addSubview:self.topRect];
    [self.view addSubview:self.bottomRect];
    [self.view addSubview:self.boardView];
    [self.view addSubview:self.statusRect];
    
    // 布局子视图
    [self autoLayoutViews];
    //创建按钮
    [self createBottomButtons];
    [self createTopButtons];
}

// 布局
-(void)autoLayoutViews{
    // 添加布局约束
    // 布局棋盘
    self.boardView.translatesAutoresizingMaskIntoConstraints=NO;
    // 宽度保持比例
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.boardView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    //  高度和宽度应该是: 10:9
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.boardView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    //  中心横坐标保持在中心点
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.boardView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    //    //  中心纵坐标保持在某位置
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.boardView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    //布局棋盘上方
    self.topRect.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topRect attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeTop multiplier:1 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topRect attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topRect attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:40]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topRect attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    // 布局棋盘下方
    self.bottomRect.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomRect attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeRight multiplier:1.0/3 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomRect attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomRect attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomRect attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
    
    // 布局状态区域
    self.statusRect.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.statusRect attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.statusRect attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeRight multiplier:1.0/3 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.statusRect attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.boardView attribute:NSLayoutAttributeBottom multiplier:1 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.statusRect attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
}


//创建底部按钮
-(void)createBottomButtons{
    
    //父视图
    UIView* fatherView =self.bottomRect;
    XZButton* undoBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"回 退"];
    [fatherView addSubview:undoBtn];
    undoBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    XZButton* redoBtn = [XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"前 进"];
    [fatherView addSubview:redoBtn];
    redoBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    
    XZButton* autoBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"自 动"];
    [fatherView addSubview:autoBtn];
    autoBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSArray* btns =@[undoBtn,redoBtn,autoBtn];
    for (int i=0; i<btns.count; i++) {
        XZButton* btn = btns[i];
        
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeWidth multiplier:1.0/5 constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeRight multiplier:(i+0.5)*1.0/btns.count constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }
}


//创建顶部按钮
-(void)createTopButtons{
    
    //父视图
    UIView* fatherView =self.topRect;
    
    XZButton *loadBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"载 入"];
    [fatherView addSubview:loadBtn];
    loadBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    XZButton *menuBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"菜 单"];
    [fatherView addSubview:menuBtn];
    menuBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    
    XZButton* traceBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"棋 谱"];
    [fatherView addSubview:traceBtn];
    traceBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    XZButton* gotoBtn = [XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"跳 转"];
    [fatherView addSubview:gotoBtn];
    gotoBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    
    XZButton* backBtn =[XZButton buttonWithType:UIButtonTypeRoundedRect andTitle:@"返 回"];
    [fatherView addSubview:backBtn];
    backBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray* btns =@[loadBtn,menuBtn,traceBtn,gotoBtn,backBtn];
    for (int i=0; i<btns.count; i++) {
        XZButton* btn = btns[i];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeWidth multiplier:1.0/(btns.count+1) constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeHeight multiplier:0.4 constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeRight multiplier:(i+0.5)*1.0/btns.count constant:0]];
        [fatherView addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:fatherView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }
}


// 返回按钮
-(void)backButtonClicked:(UIButton*)btn{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    self.view.backgroundColor=[UIColor redColor];
    NSLog(@"视图宽:%f,高:%f\n",self.view.bounds.size.width,self.view.bounds.size.height);
    [self createData];
    [self createUI];
}


//响应棋子被点击
-(void)respondCPViewClicked:(UITapGestureRecognizer*)tap{
    if (self.model.stop||self.model.pause) {
        return;
    }
    NSLog(@"view=%@\n",tap.view);
    // 如果是局域网对战或人机对战，且现在时刻不是轮到自己下棋时，模型不做响应
    if (self.model.playModel==LAN_PLAY_MODEL && self.model.myselfRole!=self.model.role) {
        return;
    }
    switch (self.model.playModel) {
        case LAN_PLAY_MODEL: //局域网对战
            break;
        case PM_MODEL:  //人机对战
            break;
        case SINGLE_PLAY_MODEL: //打谱
        {
            if([self singlePlayModelRespondCPViewClicked:tap]){
                // 如果发生落子或吃子动作，模型作棋局检查
                CCSITUATION_TYPE_t situation = [_model checkForSituation];
                switch (situation) {
                    case CCFACE_TO_FACE:
                        break;
                    case CCWILL_DEFEATED:
                    {
                        NSLog(@"正在被将军...\n");
                        [Tools showSpinnerInView:self.view prompt:@"已被将军" delay:2];
                    }
                        break;
                    case CCWILLWIN:
                    {
                        [Tools showSpinnerInView:self.view prompt:@"正在将军" delay:2];
                    }
                        break;
                    case CCWIN:
                        break;
                    default:
                        break;
                }
                [self.model exchangeRole]; //交换角色
            }
            break;
        }
        default:
            break;
    }
};


// 棋路研究模式下的响应方法
-(BOOL)singlePlayModelRespondCPViewClicked:(UITapGestureRecognizer*)tap{
    
    BOOL result=NO;//result为标志，如果为YES,说明下棋动作成功(即成功落子或吃子),选子不算动作
    
    // 获取被点击的视图对象
    CPView* view = (CPView*)tap.view;
    // 获取相应的棋子模型，注意，有可能获取不到，即该视图没有对应的模型，透明视图
    XZChessPiece* cp = [_model chessPieceForTag:view.tag];
    
    // 如果点击的是棋子
    if (cp && cp.active) {
        //        NSLog(@"棋子名称:%@ tag:%li\n",cp.cpName,cp.tag);
        NSLog(@"cp=%@\n",cp);
        // 如果是选子动作
        if (cp.role==_model.role) {
            // 如果之前也选中过棋子
            if (_model.currentCP) {
                //记录下之前选中的棋子的tag值，用于恢复视图
                NSInteger oldTag =_model.currentCP.tag;
                // 模型选中棋子
                [_model selectChessPiece:cp];
                //上次选中的棋子视图恢复到非选中状态
                CPView* oldView = (CPView*)[self.boardView viewWithTag:oldTag];
                [oldView becomeUnselected];
                //本次点击的棋子视图设置成选中状态
                [view becomeSelected];
            }else{
                [_model selectChessPiece:cp];
                [view becomeSelected];
            }
        }else{  //说明是吃子动作
            if (_model.currentCP && _model.currentCP.role==_model.role) {
                // 如果吃子成功
            
                
            }else{
                NSLog(@"不能选择对方棋子\n");
            }
        }
    }
    // 点击的空白处
    else{
        // 如果当前还没有被选中的棋子，则该次点击不作响应
        if (_model.currentCP.role!=_model.role) {
            return result;
        }
        // 执行分析是否可以移动棋子
        if([_model analyseForMotionToDestination:view.position]){
            result=YES;
            CPView* activeView = (CPView*)[self.boardView viewWithTag:_model.currentCP.tag];
            // 交换两个棋子视图的中心点，整型坐标值等
            [self exchangeCPView:activeView andAntherCPView:view];
        }
    }
    return  result;
}



#pragma mark -交换两个棋子视图的位置和逻辑坐标
-(void)exchangeCPView:(CPView*)view andAntherCPView:(CPView*)anther{
    CGPoint temp=view.center;
    CCPos_t tempPos=view.position;
    //采用block动画
    [UIView animateWithDuration:0.3 animations:^(){
        view.center=anther.center;
        view.position=anther.position;
        anther.center=temp;
        anther.position=tempPos;
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark -数据源代理方法，用于初始化棋子视图的特定属性

-(CPView *)CPViewIndexX:(int)x andIndexY:(int)y{
    CPView* view = [CPView new];
    [self setCPView:view inIndexX:x andIndexY:y];
    return view;
}

-(void)setCPView:(CPView *)view inIndexX:(int)x andIndexY:(int)y{
    //取出棋子模型
    XZChessPiece* cp = self.model->matrix[y][x];
    //初始化视图的整型下标坐标
    view.position=(CCPos_t){x,y};
    //如果没有棋子模型，则视图对象的背景为透明色
    if (!cp) {
        view.backgroundColor=[UIColor clearColor];
        view.image=nil; //不添加图片
        view.selectImage=nil; //不添加选中时的图片
        view.tag=-(100+x*9+y); //不是正常棋子对应的视图，就将tag值给负数
    }else{
        //  添加图片
        view.image= drawchessPieceImageWithCPName(cp.cpName, CGSizeMake(80, 80),NO, cp.role==GREEN_ROLE?[UIColor greenColor]:[UIColor redColor]);
        // 添加选中时的图片
        view.selectImage=drawchessPieceImageWithCPName(cp.cpName, CGSizeMake(80,80), YES, cp.role==GREEN_ROLE?[UIColor greenColor]:[UIColor redColor]);
        // 默认贴上非选中时的图片显示
        view.layer.contents=(id)view.image.CGImage;
        view.tag=cp.tag;
    }
    //添加手势
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(respondCPViewClicked:)];
    [view addGestureRecognizer:tap];
    
}



@end
