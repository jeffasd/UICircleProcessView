//
//  ViewController.m
//  test_round_process_o1
//
//  Created by jeffasd on 16/7/27.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "ViewController.h"
#import "UICircleProcessView.h"



@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UICircleProcessView *processView = [[UICircleProcessView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    processView.center = self.view.center;
    
    processView.processStr = @"123";
    
    [self.view addSubview:processView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
