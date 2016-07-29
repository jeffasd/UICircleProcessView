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

@property (nonatomic, strong) CAShapeLayer *shapeLayerl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(prcessView)];
    
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
    
//    [self initUI1];
    
//    [self initUI2];
    
    [self createImage];
    
}

- (void)initUI2{
    
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.view.frame, 100, 100)];
    
//    UIBezierPath *smallPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.view.frame, 150, 150)];
    
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 400, 400)];

//    [bigPath appendPath:smallPath];
    
    [smallPath addClip];
    
    _shapeLayerl = [CAShapeLayer layer];
    
    

    _shapeLayerl.path = bigPath.CGPath;
    
    _shapeLayerl.fillRule = kCAFillRuleEvenOdd;
    
    
    
    _shapeLayerl.fillColor = [UIColor cyanColor].CGColor;
    
    [self.view.layer addSublayer:_shapeLayerl];
    
    
    
}

- (UIImage *)createImage{
    
    CGSize size = CGSizeMake(200, 200);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef content = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(content);
    
    CGContextSetFillColorWithColor(content, [UIColor cyanColor].CGColor);
    
    CGContextFillRect(content, CGRectMake(0, 0, size.width, size.height));
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    
#if 1
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    UIBezierPath *pathBig = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 130, 130)];
    pathBig.usesEvenOddFillRule = YES;
    
    UIBezierPath *pathsmall = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 50, 50)];
    [pathBig appendPath:pathsmall];
    [pathBig addClip];

    [image drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
#endif

    
#if 0
    
    [image drawAtPoint:CGPointZero];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *pathBig = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 130, 130)];
    [[UIColor orangeColor] set];
    [pathBig fill];
    
    UIBezierPath *pathsmall = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 50, 50)];
    [[UIColor lightGrayColor] set];//会被image draw 覆盖
    [pathsmall fill];
    
    [pathsmall addClip];
    
//    [image drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
#endif
    
    return image;
    
}

- (void)initUI1{
    
    self.shapeLayerl = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.frame];
    
    UIBezierPath *pathAdd = [UIBezierPath bezierPathWithRect:CGRectMake(200, 200, 100, 100)];
    
    UIBezierPath *pathAdd1 = [UIBezierPath bezierPathWithRect:CGRectMake(250, 200, 100, 100)];
    
//    UIBezierPath *pathAdd = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [path appendPath:pathAdd];
    
    [path appendPath:pathAdd1];
    
    pathAdd.usesEvenOddFillRule = NO;
//    path.usesEvenOddFillRule = YES;
    
//    fillRule.
    
//    NSString *const strPointer = @"sdfsf";
//    
//    strPointer = @"sdfsfd";
//    
//    NSString const * point = @"sdfsfd";
//    point = @"sdfsf";
    
//    CGContextScaleCTM
    
    _shapeLayerl.fillRule = kCAFillRuleEvenOdd;
    
    NSString *str = kCAFillRuleNonZero;
    
    NSLog(@"str is %@", str);
    
    
    _shapeLayerl.fillColor = [UIColor cyanColor].CGColor;
    
    _shapeLayerl.fillColor = [UIColor redColor].CGColor;
    
    _shapeLayerl.path = path.CGPath;
    
    [self.view.layer addSublayer:_shapeLayerl];
    
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
