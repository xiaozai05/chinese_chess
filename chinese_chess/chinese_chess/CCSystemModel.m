//
//  CCSystemModel.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/9.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "CCSystemModel.h"



@implementation CCSystemModel


//初始化模型
-(id)initWithRole:(CCROLE_t)role andPlayModel:(CCPLAY_MODEL_t)playModel{
    self=[super init];
    if (self) {
        // 设置己方角色
        self.myselfRole=role;
        // 设置下棋模式
        self.playModel=playModel;
        self.stop=NO; // 设置为非停止状态
        self.pause=NO; // 设置为非暂停状态
        bzero(matrix, sizeof(matrix)); //清零矩阵
        
        // 创建一个可变数组，用来装32个棋子模型
        self.cpList=[NSMutableArray new];
        NSArray* cpnames = ( role==RED_ROLE? CPNAMES:R_CPNAMES );
        // 循环创建所有棋子
        for (NSInteger i=0; i<[cpnames count]; i++) {
            CPName_t name =[cpnames[i] intValue]; //棋子名称
            CPPower_t power = [CPPOWERS[i] charValue]; //棋子棋力值
            CCPos_t pos = XZMakePos([XPS[i] intValue], [YPS[i] intValue]);//棋子坐标
            XZChessPiece* cp =[[XZChessPiece alloc]initWithPosition:pos andName:name andPower:power andTag:i andCPName:CPNAMESS[i]];//创建棋子
            matrix[pos.y][pos.x]=cp;// 初始化矩阵的每个点
            [self.cpList addObject:cp];//将棋子加入数组
        }
        //默认为红方先下
        self.role=RED_ROLE;
        //默认没有棋子被选中
        // TODO
        self.currentCP=nil;
        //创建动作序列容器
        self.actionQueue=[[CCActionQueue alloc]init];
    }
    return self;
}

#pragma mark -通过tag值获取棋子模型
-(XZChessPiece*)chessPieceForTag:(NSInteger)tag{
    for (XZChessPiece* cp in self.cpList) {
        if (cp.tag==tag) {
            return cp;
        }
    }
    return nil;
}

#pragma mark -选中己方棋子,返回YES表示成功选择一个棋子
-(BOOL)selectChessPiece:(XZChessPiece*)cp{
    self.currentCP=cp;
    return YES;
}

#pragma mark -吃掉对方棋子，返回YES表示成功吃掉
-(CCANALYSE_RESULT_t)analyseForKillChessPiece:(XZChessPiece *)cp{
    // 如果能吃棋子
    if([self canChessPiece:self.currentCP killAntherChessPiece:cp]){
        CCSITUATION_TYPE_t situation =[self checkForSituationIfTheChessPiece:self.currentCP killAnther:cp];
        if (situation==CCWILL_DEFEATED) {
            return CCANALYSE_WILL_BE_KILLED;
        }
        if (situation==CCWILLWIN) {
            NSLog(@"will kill enemy......\n");
            return CCANALYSE_WILL_KILL_ENEMY;
        }
        return CCANALYSE_RESULT_OK;
    }else{
        return CCANALYSE_RESULT_FAIL;
    }
}

#pragma mark -吃子动作过程(即替换棋子过程)


-(void)actionChessPiece:(XZChessPiece *)cp replaceWithAnther:(XZChessPiece*)anther{
    

    //将本次下标动作加入动作序列容器
    CCActionStep* step = [[CCActionStep alloc]initWithSrcPosition:anther.position andDstPosition:cp.position andActType:CCACTION_REPLACE andTag:anther.tag andTagOfBeKilled:cp.tag];
    [self.actionQueue appendActionStep:step];
    [self chessPiece:cp replaceWithAnther:anther];
}

-(void)chessPiece:(XZChessPiece*)cp replaceWithAnther:(XZChessPiece*)anther{
    cp.active=NO;// 设置被吃的棋子为死亡状态[注意:保留该棋子的死亡位置]
    // 在矩阵上将该位置设为新的棋子anther
    matrix[cp.position.y][cp.position.x]=anther;
    // 清除新棋子在原位置的痕迹
    matrix[anther.position.y][anther.position.x]=nil;
    // 将新棋子的属性position设为当前位置
    anther.position=cp.position;
}





#pragma mark - 判断一个棋子是否能吃掉另一个棋子
-(BOOL)canChessPiece:(XZChessPiece*)cp killAntherChessPiece:(XZChessPiece*)anther{
    switch (cp.name) {
        case G_MARSHAL:
        case R_MARSHAL: return [self canMarshal:cp KillAntherChessPiece:anther];
        case G_SERGEANCY:
        case R_SERGEANCY: return [self canSergeancy:cp KillAntherChessPiece:anther];
        case G_ELEPHANT:
        case R_ELEPHANT:  return [self canElephant:cp KillAntherChessPiece:anther];
        case G_HORSE:
        case R_HORSE:   return [self canHorse:cp KillAntherChessPiece:anther];
        case G_GHARRY:
        case R_GHARRY:  return [self canGharry:cp KillAntherChessPiece:anther];
        case G_CANNON:
        case R_CANNON:  return [self canCannon:cp KillAntherChessPiece:anther];
        case G_SOLDIER:
        case R_SOLDIER: return [self canSoldier:cp KillAntherChessPiece:anther];
        default:
            return NO;
    }
}


#pragma mark -行棋规则方法:

#pragma mark -  "将" 吃子动作判断
-(BOOL)canMarshal:(XZChessPiece*)marshal KillAntherChessPiece:(XZChessPiece*)anther{
    if (!marshal||marshal.role==anther.role) {
        return NO;
    }
    return [self canMarshal:marshal MoveToPosition:anther.position];
}

#pragma mark -  "士" 吃子动作判断
-(BOOL)canSergeancy:(XZChessPiece*)sergeancy KillAntherChessPiece:(XZChessPiece*)anther{
    if (!sergeancy||sergeancy.role==anther.role) {
        return NO;
    }
    return [self canSergeancy:sergeancy MoveToPosition:anther.position];
}

#pragma mark -  "象" 吃子动作判断
-(BOOL)canElephant:(XZChessPiece*)elephant KillAntherChessPiece:(XZChessPiece*)anther{
    if (!elephant||elephant.role==anther.role) {
        return NO;
    }
    return [self canElephant:elephant MoveToPosition:anther.position];
}

#pragma mark -  "马" 吃子动作判断
-(BOOL)canHorse:(XZChessPiece*)horse KillAntherChessPiece:(XZChessPiece*)anther{
    if (!horse|| horse.role==anther.role) {
        return NO;
    }
    return [self canHorse:horse MoveToPosition:anther.position];
}

#pragma mark -  "车" 吃子动作判断
-(BOOL)canGharry:(XZChessPiece*)gharry KillAntherChessPiece:(XZChessPiece*)anther{
    
    if (!gharry||gharry.role==anther.role) {
        return NO;
    }
    return [self canGharry:gharry MoveToPosition:anther.position];
}

#pragma mark -  "炮" 吃子动作判断
-(BOOL)canCannon:(XZChessPiece*)cannon KillAntherChessPiece:(XZChessPiece*)anther{
    if (!cannon||cannon.role==anther.role) {
//        NSLog(@"出口2\n");
        return NO;
    }
    int x1=cannon.position.x;
    int y1=cannon.position.y;
    int x2=anther.position.x;
    int y2=anther.position.y;
    if (x1!=x2&& y1!=y2){
//        NSLog(@"出口3\n");
        return NO;
    }
    if (x1==x2){
        int count=0;
        int yMax=y1>y2?y1:y2;
        int yMin=y1<y2?y1:y2;
        for (int y=yMin+1; y<yMax; y++) {
            if (matrix[y][x1]) {
                count++;
                if (count>1) {
//                    NSLog(@"出口4\n");
                    return NO;
                }
            }
        }
        if (count==0) {
//            NSLog(@"出口5\n");
            return NO;
        }
    }
    if (y1==y2) {
        int count=0;
        int xMax=x1>x2?x1:x2;
        int xMin=x1<x2?x1:x2;
        for (int x=xMin+1; x<xMax; x++) {
            if (matrix[y1][x]) {
                count++;
                if (count>1) {
//                    NSLog(@"出口6\n");
                    return NO;
                }
            }
        }
        if (count==0) {
//            NSLog(@"出口7\n");
            return NO;
        }
    }
    return YES;
    
}

#pragma mark -  "兵" 吃子动作判断
-(BOOL)canSoldier:(XZChessPiece*)soldier KillAntherChessPiece:(XZChessPiece*)anther{
    if (!soldier||soldier.role==anther.role) {
        return NO;
    }
    return [self canSoldier:soldier MoveToPosition:anther.position];
}


#pragma mark   "将" 是否移动到目标位置
-(BOOL)canMarshal:(XZChessPiece*)marshal MoveToPosition:(CCPos_t)position{

    int x1=marshal.position.x;
    int y1=marshal.position.y;
    int x2=position.x;
    int y2=position.y;
    
    // 如果在正中间的三列上
    if (x2<6&&x2>2 ) {
        //  如果是己方棋子:
        if (marshal.role==self.myselfRole) {
            if (y2>6 &&((x1==x2&&abs(y1-y2)==1)||(y1==y2&&abs(x1-x2)==1 ) )) {
                return YES;
            }
        }else{ //棋盘上方
            if (y2<3&&((x1==x2&&abs(y1-y2)==1)||(y1==y2&&abs(x1-x2)==1 ) )) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark   "士" 是否移动到目标位置
-(BOOL)canSergeancy:(XZChessPiece*)sergeancy MoveToPosition:(CCPos_t)position{
    int x1=sergeancy.position.x;
    int y1=sergeancy.position.y;
    int x2=position.x;
    int y2=position.y;
    // 如果在正中间的三列上
    if (x2<6&&x2>2 ) {
        //  如果是己方棋子:
        if (sergeancy.role==self.myselfRole) {
            if (y2>6 &&abs(x1-x2)==1&&abs(y1-y2)==1&& !(y2==8&&x2!=4)) {
                return YES;
            }
        }else{ //棋盘上方
            if (y2<3 && abs(x1-x2)==1 && abs(y1-y2)==1 && !(y2==1&&x2!=4)) {
                return YES;
            }
        }
    }

    return NO;
}

#pragma mark   "象" 是否移动到目标位置
-(BOOL)canElephant:(XZChessPiece*)elephant MoveToPosition:(CCPos_t)position{
    int x1=elephant.position.x;
    int y1=elephant.position.y;
    int x2=position.x;
    int y2=position.y;
    if (x2-x1==2 && y2-y1==2 && !matrix[y1+1][x1+1]) {
        return YES;
    }
    if (x2-x1==2 && y2-y1==-2 && !matrix[y1-1][x1+1]) {
        return YES;
    }
    if (x2-x1==-2 && y2-y1==2 && !matrix[y1+1][x1-1]) {
        return YES;
    }
    if (x2-x1==-2 && y2-y1==-2 && !matrix[y1-1][x1-1]) {
        return YES;
    }
    
    return NO;
}

#pragma mark   "马" 是否移动到目标位置
-(BOOL)canHorse:(XZChessPiece*)horse MoveToPosition:(CCPos_t)position{
    int x1=horse.position.x;
    int y1=horse.position.y;
    int x2=position.x;
    int y2=position.y;
    if (1==abs(x1-x2) && ((y2-y1==2&&!matrix[y1+1][x1]) || (y1-y2==2&&!matrix[y1-1][x1]   ) ) )
        return YES;
    if (1==abs(y1-y2) &&((x2-x1==2&&!matrix[y1][x1+1]) ||(x1-x2==2&&!matrix[y1][x1-1])   ))
        return YES;
    return NO;
}

#pragma mark   "车" 是否移动到目标位置
-(BOOL)canGharry:(XZChessPiece*)gharry MoveToPosition:(CCPos_t)position{
    int x1=gharry.position.x;
    int y1=gharry.position.y;
    int x2=position.x;
    int y2=position.y;
    
    //禁止不走直线
    if (x1!=x2&& y1!=y2)
        return NO;
    //纵向移动，如果有隔子，禁止移动
    if (x1==x2){
        int yMax=y1>y2?y1:y2;
        int yMin=y1<y2?y1:y2;
        for (int y=yMin+1; y<yMax; y++) {
            if (matrix[y][x1]) {
                return NO;
            }
        }
    }
    // 横向移动，如果有隔子，禁止移动
    if (y1==y2) {
        int xMax=x1>x2?x1:x2;
        int xMin=x1<x2?x1:x2;
        for (int x=xMin+1; x<xMax; x++) {
            if (matrix[y1][x]) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark   "炮" 是否移动到目标位置,和“车”的走法一样
-(BOOL)canCannon:(XZChessPiece*)cannon MoveToPosition:(CCPos_t)position{
    int x1=cannon.position.x;
    int y1=cannon.position.y;
    int x2=position.x;
    int y2=position.y;
    
    // 如果不走直线，禁止移动
    if (x1!=x2&& y1!=y2)
        return NO;
    if (x1==x2){
        int yMax=y1>y2?y1:y2;
        int yMin=y1<y2?y1:y2;
        for (int y=yMin+1; y<yMax; y++) {
            if (matrix[y][x1]) {
                return NO;
            }
        }
    }
    if (y1==y2) {
        int xMax=x1>x2?x1:x2;
        int xMin=x1<x2?x1:x2;
        for (int x=xMin+1; x<xMax; x++) {
            if (matrix[y1][x]) {
                return NO;
            }
        }
    }
    return YES;
}

#pragma mark   "兵" 是否移动到目标位置
-(BOOL)canSoldier:(XZChessPiece*)soldier MoveToPosition:(CCPos_t)position{
    int x1=soldier.position.x;
    int y1=soldier.position.y;
    int x2=position.x;
    int y2=position.y;
    
    // 如果是已方的兵要移动
    if (self.myselfRole==self.role) {
        // 允许前进一步
        if (y2+1==y1 &&x1==x2)
            return YES;
        // 如果过河了，允许横移1步
        if (y1<5 && y1==y2 && (x1-x2==1||x1-x2==-1))
            return YES;
    }else{
        //允许前进一步
        if (y2-1==y1 && x1==x2) {
            return YES;
        }
        if (y1>4 && y1==y2 &&(x1-x2==1||x1-x2==-1)) {
            return YES;
        }
    }
    return NO;
}




#pragma mark -模型分析当前选中的棋子是否能移动到目标位置
-(CCANALYSE_RESULT_t)analyseForMotionToDestination:(CCPos_t)position{
    if( [self canChessPiece:self.currentCP moveToPosition:position]){
        CCSITUATION_TYPE_t situation =[self checkForSituationIfTheChessPiece:self.currentCP MoveToPosition:position];
        if(situation==CCWILL_DEFEATED) {
            return CCANALYSE_WILL_BE_KILLED;
        }
        return CCANALYSE_RESULT_OK;
    }else{
        return CCANALYSE_RESULT_FAIL;
    }
}


#pragma mark -移动棋子的过程
-(void)actionChessPiece:(XZChessPiece*)cp moveToPosition:(CCPos_t)position{
    
    // 将本次下棋动作加入动作序列容器
    CCActionStep* step = [[CCActionStep alloc]initWithSrcPosition:cp.position andDstPosition:position andActType:CCACTION_MOVE andTag:cp.tag andTagOfBeKilled:-1];
    NSLog(@"开始调appendActionStep:");
    [self.actionQueue appendActionStep:step];
    
    [self chessPiece:cp moveToPosition:position];
    
//    //在矩阵上的新位置设置该棋子
//    matrix[position.y][position.x]=cp;
//    //清除原来的痕迹
//    matrix[cp.position.y][cp.position.x]=nil;
//    // 将棋子的位置属性更新
//    cp.position=position;
}

#pragma mark -棋子回退到原来的位置
-(void)chessPiece:(XZChessPiece*)cp moveToPosition:(CCPos_t)position{
    //在矩阵上的新位置设置该棋子
    matrix[position.y][position.x]=cp;
    //清除原来的痕迹
    matrix[cp.position.y][cp.position.x]=nil;
    // 将棋子的位置属性更新
    cp.position=position;
}

#pragma mark -判断一个棋子是否能移动到某个位置去
-(BOOL)canChessPiece:(XZChessPiece*)cp moveToPosition:(CCPos_t)position{
    switch (cp.name) {
        case G_MARSHAL:
        case R_MARSHAL: return [self canMarshal:cp MoveToPosition:position];
        case G_SERGEANCY:
        case R_SERGEANCY: return [self canSergeancy:cp MoveToPosition:position];
        case G_ELEPHANT:
        case R_ELEPHANT:  return [self canElephant:cp MoveToPosition:position];
        case G_HORSE:
        case R_HORSE:   return  [self canHorse:cp MoveToPosition:position];
        case G_GHARRY:
        case R_GHARRY:  return [self canGharry:cp MoveToPosition:position];
        case G_CANNON:
        case R_CANNON:  return [self canCannon:cp MoveToPosition:position];
        case G_SOLDIER:
        case R_SOLDIER: return [self canSoldier:cp MoveToPosition:position];
    }
    return NO;
}


#pragma mark -模型中交换当前可下棋的角色
-(void)exchangeRole{
    self.role=-self.role;
//    if (self.role==RED_ROLE) {
//        NSLog(@"************轮到红方下棋*******");
//    }else{
//        NSLog(@"************轮到绿方下棋*******");
//    }
    NSNumber *isRed = [NSNumber numberWithBool:self.role==RED_ROLE];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"角色切换" object:self userInfo:@{@"isRed":isRed}];

}


#pragma mark -如果移动这颗棋子cp到position，会有什么结果
-(CCSITUATION_TYPE_t)checkForSituationIfTheChessPiece:(XZChessPiece*)cp MoveToPosition:(CCPos_t)position{
    CCSITUATION_TYPE_t situation;
    CCPos_t srcPos=cp.position;
    [self chessPiece:cp moveToPosition:position];
    situation=[self checkForSituation];
    [self chessPiece:cp moveToPosition:srcPos];
    return situation;
}

#pragma mark -如果吃掉棋子，会有什么结果
-(CCSITUATION_TYPE_t)checkForSituationIfTheChessPiece:(XZChessPiece *)cp killAnther:(XZChessPiece*)anther{
    CCSITUATION_TYPE_t situation;
    CCPos_t srcPos =cp.position;
//    [self replaceChessPiece:anther withAnther:cp];
    [self chessPiece:anther replaceWithAnther:cp];
    //                        cp               anther
    /*
     cp.active=NO;// 设置被吃的棋子为死亡状态[注意:保留该棋子的死亡位置]
     // 在矩阵上将该位置设为新的棋子anther
     matrix[cp.position.y][cp.position.x]=anther;
     // 清除新棋子在原位置的痕迹
     matrix[anther.position.y][anther.position.x]=nil;
     // 将新棋子的属性position设为当前位置
     anther.position=cp.position;
     */
    situation =[self checkForSituation];
    cp.position=srcPos;
    matrix[cp.position.y][cp.position.x]=cp;
    matrix[anther.position.y][anther.position.x]=anther;
    cp.active=YES;
    return situation;
}

#pragma mark -棋局分析,是否将军，是否分出胜负等情况
-(CCSITUATION_TYPE_t)checkForSituation{
    //获取当前角色
    CCROLE_t activeRole = self.role;
    
    //先判断将帅是否会面
    CCPos_t position1 = [self chessPieceForTag:0].position;
    CCPos_t position2 = [self chessPieceForTag:16].position;
    if (position1.x==position2.x) {
        int yMax=position1.y>position2.y?position1.y:position2.y;
        int yMin=position1.y<position2.y?position1.y:position2.y;
        BOOL faceToFace=YES;
        for (int y=yMin+1; y<yMax; y++) {
            if (matrix[y][position1.x]) {
                faceToFace=NO;
                break;
            }
        }
        if(faceToFace)
            return CCFACE_TO_FACE;
    }
    
    // 判断activeRole方的将帅是否在对方的口中，即正在被将军
    XZChessPiece* marshal = [self chessPieceForTag: activeRole==self.myselfRole?16:0];
    for (int i=0; i<32; i++) {
            XZChessPiece* cp = (XZChessPiece*)self.cpList[i];
            if (cp.active && [self canChessPiece:cp killAntherChessPiece:marshal]) {
//                NSLog(@"....正在被将军...\n");
                return CCWILL_DEFEATED;
            }
    }
    
    // 判断是不是将对方军
    // 判断activeRole方的将帅是否在对方的口中，即正在被将军
    XZChessPiece*  enemyMarshal = [self chessPieceForTag: activeRole==self.myselfRole?0:16];
    for (int i=0; i<32; i++) {
        XZChessPiece* cp = (XZChessPiece*)self.cpList[i];
        if (cp.active && [self canChessPiece:cp killAntherChessPiece:enemyMarshal]) {
//            NSLog(@"...正在将军...\n");
            return CCWILLWIN;
        }
    }
    // 默认返回空，即正常状态，没有将军，没有被将军   
    return CCNULL;
}

-(CCActionStep*)backStep{
    CCActionStep* step =[self.actionQueue actionStepBack];
    if (!step) {
        return nil;
    }
    if (step.actType==CCACTION_MOVE) {
        [self chessPiece:[self chessPieceForTag:step.tag] moveToPosition:step.srcPosition];
    }else if (step.actType==CCACTION_REPLACE){
        XZChessPiece* cp = [self chessPieceForTag:step.tag];
        XZChessPiece* deadCp = [self chessPieceForTag:step.tagOfBeKilled];
        cp.position=step.srcPosition;
        matrix[cp.position.y][cp.position.x]=cp;
        deadCp.active=YES;
        deadCp.position=step.dstPosition;
        matrix[deadCp.position.y][deadCp.position.x]=deadCp;
    }
    self.currentCP=[self chessPieceForTag:step.tag];
    [self exchangeRole];
    return step;
}



-(CCActionStep*)forwardStep{
    CCActionStep* step = [self.actionQueue actionStepForward];
    if (!step) {
        return nil;
    }
    self.currentCP=[self chessPieceForTag:step.tag];
    if (step.actType==CCACTION_MOVE) {
        [self chessPiece:self.currentCP moveToPosition:step.dstPosition];
    }else if(step.actType==CCACTION_REPLACE){
        XZChessPiece* deadCp =[self chessPieceForTag:step.tagOfBeKilled];
        [self chessPiece:deadCp replaceWithAnther:self.currentCP];
        
    }
    [self exchangeRole];
    return step;
}

-(NSArray *)expressListOfAllSteps{
    NSMutableArray* array=[NSMutableArray new];
    for (int i=0; i<self.actionQueue.actionList.count; i++) {
        CCActionStep* step = self.actionQueue.actionList[i];
        if (!step) {
            return nil;
        }
        NSMutableString* string = [NSMutableString new];
        XZChessPiece* cp = [self chessPieceForTag:step.tag];
        [string appendString:cp.cpName];
        int x1 = step.srcPosition.x;
        int y1 = step.srcPosition.y;
        int x2 = step.dstPosition.x;
        int y2 = step.dstPosition.y;

        // 如果红方在下
        if (self.myselfRole==RED_ROLE) {
            if (cp.role==RED_ROLE) {
                [string appendFormat:@"%@",NUMBERS[9-x1]];
                if (y2<y1) {
                    [string appendString:@"进"];
                }else if(y2==y1){
                    [string appendString:@"平"];
                }else{
                    [string appendString:@"退"];
                }
                if (x1==x2) {
                    [string appendFormat:@"%@",NUMBERS[abs(y2-y1)] ];
                }else{
                    [string appendFormat:@"%@",NUMBERS[9-x2] ];
                }
            }else{
                [string appendFormat:@"%i",x1+1];
                if (y2<y1) {
                    [string appendString:@"退"];
                }else if( y2==y1){
                    [string appendString:@"平"];
                }else{
                    [string appendString:@"进"];
                }
                if (x1==x2) {
                    [string appendFormat:@"%u",abs(y2-y1) ];
                }else{
                    [string appendFormat:@"%u",x2+1];
                }
            }
            
        }else{  //绿方在下
            if (cp.role==GREEN_ROLE) {
                [string appendFormat:@"%u",9-x1];
                if (y2<y1) {
                    [string appendString:@"进"];
                }else if(y2==y1){
                    [string appendString:@"平"];
                }else{
                    [string appendString:@"退"];
                }
                if (x1==x2) {
                    [string appendFormat:@"%u",abs(y2-y1) ];
                }else{
                    [string appendFormat:@"%u",9-x2 ];
                }
            }else{
                [string appendFormat:@"%@",NUMBERS[x1+1]];
                if (y2<y1) {
                    [string appendString:@"退"];
                }else if( y2==y1){
                    [string appendString:@"平"];
                }else{
                    [string appendString:@"进"];
                }
                if (x1==x2) {
                    [string appendFormat:@"%@",NUMBERS[abs(y2-y1)] ];
                }else{
                    [string appendFormat:@"%@",NUMBERS[x2+1]];
                }
            }
        }
        [array addObject:string];
    }
    
    if (array.count==0) {
        return nil;
    }
    NSArray* retArray = [NSArray arrayWithArray:array];
    return retArray;
}

@end
