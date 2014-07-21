//
//  CCAnimatedButton.m
//  CCFunnyApp
//
//  Created by 陈 爱彬 on 14-7-16.
//  Copyright (c) 2014年 陈爱彬. All rights reserved.
//

#import "CCAnimatedButton.h"

@interface CCAnimatedButton()

@property (nonatomic) CAShapeLayer *topLayer;
@property (nonatomic) CAShapeLayer *middleLayer;
@property (nonatomic) CAShapeLayer *bottomLayer;
@property (nonatomic) BOOL showMenu;

@end

@implementation CCAnimatedButton

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
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 2, 2);
    CGPathAddLineToPoint(path, nil, 28, 2);
    
    self.topLayer = [CAShapeLayer layer];
    self.middleLayer = [CAShapeLayer layer];
    self.bottomLayer = [CAShapeLayer layer];
    for (CAShapeLayer *layer in @[_topLayer,_middleLayer,_bottomLayer]) {
        layer.path = path;
        layer.fillColor = nil;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineWidth = 3;
        layer.miterLimit = 3;
        layer.lineCap = kCALineCapRound;
        layer.masksToBounds = YES;
        
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 3, kCGLineCapRound, kCGLineJoinMiter, 3);
        layer.bounds = CGPathGetBoundingBox(strokingPath);
        
        [self.layer addSublayer:layer];
    }
    CGPathRelease(path);
    
    self.topLayer.anchorPoint = CGPointMake(2.0 / 30.0, 0.5);
    self.topLayer.position = CGPointMake(7, 10);
    
    self.middleLayer.anchorPoint = CGPointMake(2.0 / 30.0, 0.5);
    self.middleLayer.position = CGPointMake(7, 19);
    
    self.bottomLayer.anchorPoint = CGPointMake(2.0 / 30.0, 0.5);
    self.bottomLayer.position = CGPointMake(7, 28);
    
    [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchUpInsideHandler:(CCAnimatedButton *)sender
{
    if (self.showMenu) {
        [self animateToMenu];
    } else {
        [self animateToClose];
    }
    self.showMenu = !self.showMenu;
}
- (void)animateToMenu
{
    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.85];
    topTransform.duration = 0.3;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    CABasicAnimation *middleTransform = [CABasicAnimation animationWithKeyPath:@"opacity"];
    middleTransform.duration = 0.3;
    middleTransform.fillMode = kCAFillModeBackwards;

    topTransform.fromValue = [_topLayer.presentationLayer valueForKey:@"transform"];
    topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    topTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    bottomTransform.fromValue = [_bottomLayer.presentationLayer valueForKey:@"transform"];
    bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    middleTransform.fromValue = [_middleLayer.presentationLayer valueForKey:@"opacity"];
    middleTransform.toValue = [NSNumber numberWithFloat:1.0];
    middleTransform.beginTime = CACurrentMediaTime() + 0.25;

    [_topLayer addAnimation:topTransform forKey:@"transform"];
    [_bottomLayer addAnimation:bottomTransform forKey:@"transform"];
    [_middleLayer addAnimation:middleTransform forKey:@"opacity"];
    [_topLayer setValue:topTransform.toValue forKeyPath:@"transform"];
    [_bottomLayer setValue:bottomTransform.toValue forKeyPath:@"transform"];
    [_middleLayer setValue:[NSNumber numberWithFloat:1.0] forKeyPath:@"opacity"];

}
- (void)animateToClose
{
    CATransform3D translation = CATransform3DMakeTranslation(4, 0, 0);

    CABasicAnimation *topTransform = [CABasicAnimation animationWithKeyPath:@"transform"];
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.8 :0.5 :1.85];
    topTransform.duration = 0.3;
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    CABasicAnimation *middleTransform = [CABasicAnimation animationWithKeyPath:@"opacity"];
    middleTransform.duration = 0.3;
    middleTransform.fillMode = kCAFillModeBackwards;
    
    topTransform.fromValue = [_topLayer.presentationLayer valueForKey:@"transform"];
    topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.79, 0, 0, 1)];
    topTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    bottomTransform.fromValue = [_bottomLayer.presentationLayer valueForKey:@"transform"];
    bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.79, 0, 0, 1)];
    bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    middleTransform.fromValue = [_middleLayer.presentationLayer valueForKey:@"opacity"];
    middleTransform.toValue = [NSNumber numberWithFloat:0.0];
    middleTransform.beginTime = CACurrentMediaTime() + 0.25;
    
    [_topLayer addAnimation:topTransform forKey:@"transform"];
    [_bottomLayer addAnimation:bottomTransform forKey:@"transform"];
    [_middleLayer addAnimation:middleTransform forKey:@"opacity"];
    [_topLayer setValue:topTransform.toValue forKeyPath:@"transform"];
    [_bottomLayer setValue:bottomTransform.toValue forKeyPath:@"transform"];
    [_middleLayer setValue:middleTransform.toValue forKeyPath:@"opacity"];
}

@end
