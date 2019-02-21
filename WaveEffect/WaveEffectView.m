//
//  WaveEffectView.m
//  WaveEffect
//
//  Created by caimao on 2019/2/19.
//  Copyright © 2019 sunhw. All rights reserved.
//

#import "WaveEffectView.h"

@interface WaveEffectView ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *firstLayer;
@property (nonatomic, strong) CAShapeLayer *secondLayer;
@property (nonatomic, strong) UIBezierPath *firstPath;
@property (nonatomic, strong) UIBezierPath *secondPath;
@end

@implementation WaveEffectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _firstLayer = [CAShapeLayer layer];
        _firstLayer.frame = self.layer.frame;
        [self.layer addSublayer:_firstLayer];
        _firstLayer.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.5].CGColor;
        
        _secondLayer = [CAShapeLayer layer];
        _secondLayer.frame = self.layer.frame;
        [self.layer addSublayer:_secondLayer];
        _secondLayer.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.5].CGColor;
    }
    return self;
}

- (void)startAnimation {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)endAnimation {
    [_displayLink invalidate];
    _displayLink = nil;
}

- (void)drawPath {
    static double i = 0;
    
    CGFloat A = 10.f;
    CGFloat k = 0;
    CGFloat ω = 0.03;
    CGFloat φ = 0 + i;
    
    _firstPath = [UIBezierPath bezierPath];
    _secondPath = [UIBezierPath bezierPath];
    
    [_firstPath moveToPoint:CGPointZero];
    [_secondPath moveToPoint:CGPointZero];
    
    for (int i = 0; i < 376; i++) {
        CGFloat x = i;
        
        CGFloat firstY = A * sin(ω*x+φ)+k;
        CGFloat secondY = A * cos(ω*x+φ)+k;
        
        [_firstPath addLineToPoint:CGPointMake(x, firstY)];
        [_secondPath addLineToPoint:CGPointMake(x, secondY)];
    }
    
    [_firstPath addLineToPoint:CGPointMake(self.frame.size.width, -100)];
    [_firstPath addLineToPoint:CGPointMake(0, -100)];
    _firstPath.lineWidth = 1;
    _firstLayer.path = _firstPath.CGPath;
    
    [_secondPath addLineToPoint:CGPointMake(self.frame.size.width, -100)];
    [_secondPath addLineToPoint:CGPointMake(0, -100)];
    _secondPath.lineWidth = 1;
    _secondLayer.path = _secondPath.CGPath;
    
    i += 0.1;
    if (i > M_PI * 2) {
        i = 0;//防止i越界
    }
}

@end
