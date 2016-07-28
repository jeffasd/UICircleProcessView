//
//  UICircleProcessView.m
//  test_round_process_o1
//
//  Created by jeffasd on 16/7/28.
//  Copyright © 2016年 jeffasd. All rights reserved.
//

#import "UICircleProcessView.h"

#define kViewWidth      self.frame.size.width
#define kViewHeight     kViewWidth

#define kLineWidth      (6.0)



@interface UICircleProcessView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, weak) UIView *backgroundView;

@property (nonatomic, weak) UILabel *processLabel;

@property(nonatomic, strong) UIColor *processColor;

@end

@implementation UICircleProcessView

- (instancetype)initWithFrame:(CGRect)frame ProcessColor:(UIColor *)processColor{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.processColor = processColor;
        [self initBackgroundView];
        [self initUI];
        [self initAnimation];
        self.clipsToBounds = YES;
//        self.backgroundColor = [UIColor orangeColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initBackgroundView{
    
    UIView *bgView = [UIView new];
    bgView.frame = self.bounds;
    [self addSubview:bgView];
    self.backgroundView = bgView;
    
    UILabel *label = [UILabel new];
    label.frame = self.bounds;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"百分比";
    [self addSubview:label];
    self.processLabel = label;
}

- (void)setProcessStr:(NSString *)processStr{
    self.processLabel.text = processStr;
}

- (void)initUI{
    
    _shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kViewWidth/2, kViewWidth/2) radius:kViewWidth/2 - kLineWidth/2 startAngle:-M_PI/2 endAngle:M_PI/2 + M_PI clockwise:YES];
    
    _shapeLayer.path = path.CGPath;
//    _shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //mask层特点 背景不透明其背后的图层能显示 背景透明(clearColor)其背后的图层不能显示 这里strokeColor只要不是clearColor就行 其他任何颜色只起到不透明的作用
    _shapeLayer.strokeColor = [UIColor cyanColor].CGColor;//这个颜色无所谓 放在converLayer的mask层
    _shapeLayer.lineWidth = kLineWidth;
    
    _shapeLayer.lineCap = @"round";
    
    _shapeLayer.strokeStart   = 0.02f;
    _shapeLayer.strokeEnd     = 0.98f;
    
    CALayer *converLayer = [CALayer layer];
    
    if (_processColor == nil) {
        _processColor = [UIColor redColor];
    }
    
    CAGradientLayer *rightGradLayer = [CAGradientLayer layer];
    rightGradLayer.frame = CGRectMake(kViewWidth/2, 0, kViewWidth/2, kViewWidth*2);
    rightGradLayer.locations = @[@0, @1];
    id rightcolor1 = (__bridge id)[UIColor clearColor].CGColor;
    id rightcolor2 = (__bridge id)_processColor.CGColor;
    id rightcolorCenter = (__bridge id)[_processColor colorWithAlphaComponent:0.5].CGColor;
    rightGradLayer.startPoint = CGPointMake(0, 0);
    rightGradLayer.endPoint = CGPointMake(0, 1);
    rightGradLayer.colors = @[rightcolor1, rightcolorCenter, rightcolor2];
    float ceterRate= (kViewWidth - kLineWidth/2.0)/(kViewWidth*2.0);
//    rightGradLayer.locations = @[@(0), @(1)];
//    rightGradLayer.locations = @[@(0), @(0.5), @(1)];
    
    rightGradLayer.locations = @[@(0), @(ceterRate), @(1)];
    
    CAGradientLayer *leftGradLayer = [CAGradientLayer layer];
    leftGradLayer.frame = CGRectMake(0, 0, kViewWidth/2, kViewWidth*2);
    leftGradLayer.locations = @[@0, @1];
    id leftcolor1 = (__bridge id)_processColor.CGColor;
    id leftcolor2 = (__bridge id)[UIColor clearColor].CGColor;
    leftGradLayer.startPoint = CGPointMake(0, 0);
    leftGradLayer.endPoint = CGPointMake(0, 1);
    leftGradLayer.colors = @[leftcolor1, rightcolorCenter, leftcolor2];
//    leftGradLayer.locations = @[@(0), @(0.5), @(1)];
    leftGradLayer.locations = @[@(0), @(ceterRate), @(1)];
    
    [converLayer addSublayer:rightGradLayer];
    [converLayer addSublayer:leftGradLayer];
    
//    [rightGradLayer setMask:_shapeLayer];
//    [self.layer addSublayer:rightGradLayer];
//    [self.layer addSublayer:leftGradLayer];
    [converLayer setMask:_shapeLayer];
//    [self.layer addSublayer:converLayer];
    [self.backgroundView.layer addSublayer:converLayer];
//    [self.layer addSublayer:_shapeLayer];
}

- (void)initAnimation{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = 0;
    animation.toValue = @(M_PI * 2);
    animation.repeatCount = CGFLOAT_MAX;
    animation.duration = 0.9;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.backgroundView.layer addAnimation:animation forKey:@"rotation"];
    
}

@end
