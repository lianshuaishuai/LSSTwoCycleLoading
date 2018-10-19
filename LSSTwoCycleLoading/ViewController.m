//
//  ViewController.m
//  LSSTwoCycleLoading
//
//  Created by 连帅帅 on 2018/10/19.
//  Copyright © 2018年 连帅帅. All rights reserved.
//

#import "ViewController.h"
#import "LSSTwoBallLoading.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)start{
    
    LSSTwoBallTool * tool = [[LSSTwoBallTool alloc]init];
    tool.oneBallCor = [UIColor grayColor];
    tool.twoBallCor = [UIColor orangeColor];
    [LSSTwoBallLoading showLoading:self.view andTool:tool];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [LSSTwoBallLoading hideLoading:self.view];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
