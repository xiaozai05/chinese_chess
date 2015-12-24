//
//  HomeViewController.m
//  chinese_chess
//
//  Created by xiaozai on 15/12/16.
//  Copyright (c) 2015年 xiaozai. All rights reserved.
//

#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "XZCCViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
-(void)createButtons{
    NSLog(@"创建button\n");
    UIButton* button1 =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.layer.cornerRadius=3;
    button1.backgroundColor=[UIColor colorWithRed:0.160 green:0.529 blue:1.000 alpha:1.000];
    [button1 setTitle:@"对 弈" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.bounds=CGRectMake(0, 0, 100, 30);
    CGSize size = [UIScreen mainScreen].bounds.size;
    button1.center=CGPointMake(size.width/2, size.height/2-100);
    
    [self.view addSubview:button1];
    
    UIButton* button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.layer.cornerRadius=3;
    button2.center=CGPointMake(button1.center.x, button1.center.y+50);
    button2.bounds=CGRectMake(0, 0, 100, 30);
    button2.backgroundColor=[UIColor colorWithRed:0.160 green:0.529 blue:1.000 alpha:1.000];
    [button2 setTitle:@"挑 战" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    
    UIButton* button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button3.layer.cornerRadius=3;
    button3.center=CGPointMake(button2.center.x, button2.center.y+50);
    button3.bounds=CGRectMake(0, 0, 100, 30);
    button3.backgroundColor=[UIColor colorWithRed:0.160 green:0.529 blue:1.000 alpha:1.000];
    [button3 setTitle:@"打 谱" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(button3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton* button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button4.layer.cornerRadius=3;
    button4.center=CGPointMake(button3.center.x-35, button3.center.y+50);
    button4.bounds=CGRectMake(0, 0, 50, 30);
    button4.backgroundColor=[UIColor colorWithRed:0.160 green:0.529 blue:1.000 alpha:1.000];
    [button4 setTitle:@"联 网" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    UIButton* button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button5.layer.cornerRadius=3;
    button5.center=CGPointMake(button3.center.x+35, button3.center.y+50);
    button5.bounds=CGRectMake(0, 0, 50, 30);
    button5.backgroundColor=[UIColor colorWithRed:0.160 green:0.529 blue:1.000 alpha:1.000];
    [button5 setTitle:@"联 机" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button5];
    
    
}

-(void)button3Clicked:(UIButton*)btn{
    XZCCViewController* vcr = [XZCCViewController new];
    [self presentViewController:vcr animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage* homeImage = [UIImage imageNamed:@"home.png"];
    self.view.layer.contents=(id)homeImage.CGImage;
    [self createButtons];

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

@end
