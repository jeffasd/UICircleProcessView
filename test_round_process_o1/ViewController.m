//
//  ViewController.m
//  test_round_process_o1
//
//  Created by jeffasd on 16/7/27.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "ViewController.h"
#import "UICircleProcessView.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong)CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    @property(readonly, nonatomic) CFTimeInterval timestamp;
//    @property(readonly, nonatomic) CFTimeInterval duration;
//    @property(getter=isPaused, nonatomic) BOOL paused;
//    @property(nonatomic) NSInteger frameInterval;
    
    
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(prcessView)];
    
    _displayLink.frameInterval = 60;
    
    NSLog(@"time is %f", _displayLink.timestamp);
    NSLog(@"duration is %f", _displayLink.duration);
    
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    UICircleProcessView *processView = [[UICircleProcessView alloc] initWithFrame:CGRectMake(100, 200, 60, 60) ProcessColor:[UIColor yellowColor]];
    processView.processStr = @"123";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    objc_setAssociatedObject(self, _cmd, processView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = processView;
    hud.detailsLabelText = @"正在处理";
    [hud setRemoveFromSuperViewOnHide:YES];
    
}

- (void)prcessView{
    
    NSLog(@"time is %f", _displayLink.timestamp);
    NSLog(@"duration is %f", _displayLink.duration);
    
//    time is 153705.495990
//    2016-07-28 17:05:28.378 test_round_process_o1[58982:1764192] duration is 0.016667
    
    UICircleProcessView *processView = objc_getAssociatedObject(self, @selector(viewDidLoad));
    static int i = 0;
    i++;
    NSString *str = [NSString stringWithFormat:@"%d", i];
    processView.processStr = str;
    
    
//    for (int i = 0; i < 1000 * 100; i++) {
//        NSLog(@"--@__");
//    }
    
    if (i == 300) {
        _displayLink.paused = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
