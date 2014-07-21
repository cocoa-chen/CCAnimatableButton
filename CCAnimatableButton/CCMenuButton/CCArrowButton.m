//
//  CCArrowButton.m
//  CCFunnyApp
//
//  Created by 陈 爱彬 on 14-7-16.
//  Copyright (c) 2014年 陈爱彬. All rights reserved.
//

#import "CCArrowButton.h"

@interface CCArrowButton()

@property (nonatomic) CAShapeLayer *leftLayer;
@property (nonatomic) CAShapeLayer *rightLayer;
@property (nonatomic) BOOL menuOpen;
@end

@implementation CCArrowButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}
- (void)setup
{
    CGMutablePathRef leftPath = CGPathCreateMutable();
    CGPathMoveToPoint(leftPath, nil, 2, 20);
    CGPathAddLineToPoint(leftPath, nil, 20, 10);
    
    CGMutablePathRef rightPath = CGPathCreateMutable();
    CGPathMoveToPoint(rightPath, nil, 20, 10);
    CGPathAddLineToPoint(rightPath, nil, 38, 20);

    self.leftLayer = [CAShapeLayer layer];
    self.rightLayer = [CAShapeLayer layer];
    _leftLayer.path = leftPath;
    _rightLayer.path = rightPath;
    
    for (CAShapeLayer *layer in @[_leftLayer,_rightLayer]) {
        layer.fillColor = nil;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = 2;
        layer.miterLimit = 2;
        layer.lineCap = kCALineCapRound;
        layer.masksToBounds = YES;
        
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 2, kCGLineCapRound, kCGLineJoinMiter, 2);
        layer.bounds = CGPathGetBoundingBox(strokingPath);
        
        [self.layer addSublayer:layer];
    }
    CGPathRelease(leftPath);
    CGPathRelease(rightPath);
    
    self.leftLayer.position = CGPointMake(11, 20);
    self.rightLayer.position = CGPointMake(29, 20);
    
    [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchUpInsideHandler:(CCArrowButton *)sender
{
    if (self.menuOpen) {
        [self animateToOpenMenu];
    } else {
        [self animateToCloseMenu];
    }
    self.menuOpen = !self.menuOpen;
}
- (void)animateToOpenMenu
{
    CABasicAnimation *leftTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    leftTransform.duration = 0.3;
    leftTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *rightTransform = [leftTransform copy];
    
    leftTransform.fromValue = [_leftLayer.presentationLayer valueForKey:@"transform"];
    leftTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    leftTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    rightTransform.fromValue = [_rightLayer.presentationLayer valueForKey:@"transform"];
    rightTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    rightTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    [_leftLayer addAnimation:leftTransform forKey:@"transform"];
    [_rightLayer addAnimation:rightTransform forKey:@"transform"];
    [_leftLayer setValue:leftTransform.toValue forKeyPath:@"transform"];
    [_rightLayer setValue:rightTransform.toValue forKeyPath:@"transform"];
    
}
- (void)animateToCloseMenu
{
    CABasicAnimation *leftTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    leftTransform.duration = 0.3;
    leftTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *rightTransform = [leftTransform copy];
    
    leftTransform.fromValue = [_leftLayer.presentationLayer valueForKey:@"transform"];
    leftTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * 0.32, 0, 0, 1)];
    leftTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    rightTransform.fromValue = [_rightLayer.presentationLayer valueForKey:@"transform"];
    rightTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI * 0.32, 0, 0, 1)];
    rightTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    [_leftLayer addAnimation:leftTransform forKey:@"transform"];
    [_rightLayer addAnimation:rightTransform forKey:@"transform"];
    [_leftLayer setValue:leftTransform.toValue forKeyPath:@"transform"];
    [_rightLayer setValue:rightTransform.toValue forKeyPath:@"transform"];
}

@end
