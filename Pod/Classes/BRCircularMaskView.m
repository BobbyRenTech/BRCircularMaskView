//
//  BRCircularMaskView.m
//  Pods
//
//  Created by Bobby Ren on 6/14/15.
//
//

#import "BRCircularMaskView.h"

@implementation BRCircularMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configure:(CGRect)maskFrame {
    circleMaskLayer = [[CAShapeLayer alloc] init];
    circleMaskLayer.frame = self.bounds;
    circleMaskLayer.lineWidth = 2;
    circleMaskLayer.fillColor = [UIColor blackColor].CGColor;
    circleMaskLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    
    circleFrame = maskFrame;
    self.superview.layer.mask = circleMaskLayer;
    
    // once superview is masked, it should not be interactive
    self.superview.userInteractionEnabled = false;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    circleMaskLayer.frame = self.bounds;
    circleMaskLayer.path = [self circlePath];
}

-(CGPathRef)circlePath {
    return [UIBezierPath bezierPathWithOvalInRect:circleFrame].CGPath;
}

-(void)reveal {
    if (isRevealing == false) {
        isRevealing = true;
        
        // 1
        self.backgroundColor = UIColor.clearColor;
        // 2
        // 3
        [circleMaskLayer removeFromSuperlayer];
        self.superview.layer.mask = circleMaskLayer;
        
        // 1
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat finalRadius = sqrt((center.x*center.x) + (center.y*center.y));
        CGFloat radiusInset = finalRadius - 20;
        CGRect outerRect = CGRectInset(circleFrame, -radiusInset, -radiusInset);
        CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
        
        // 2
        originalPath = circleMaskLayer.path;
        originalLineWidth = circleMaskLayer.lineWidth;
        
        // 3
        [CATransaction begin];
        [CATransaction setValue:kCFBooleanTrue forKey:kCATransactionDisableActions];
        circleMaskLayer.lineWidth = 2*finalRadius;
        circleMaskLayer.path = toPath;
        [CATransaction commit];
        
        // 4
        CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
        lineWidthAnimation.fromValue = @(originalLineWidth);
        lineWidthAnimation.toValue = @(2*finalRadius);
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)originalPath;
        pathAnimation.toValue = (__bridge id)toPath;
        
        // 5
        CAAnimationGroup * groupAnimation = [[CAAnimationGroup alloc] init];
        groupAnimation.duration = 1;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
        groupAnimation.delegate = self;
        [circleMaskLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
    }
    else {
        self.hidden = false;
        self.backgroundColor = UIColor.clearColor;
        // 2
        // 3
        [circleMaskLayer removeFromSuperlayer];
        self.superview.layer.mask = circleMaskLayer;
        
        isRevealing = false;
        // 1
        // 2
        CGPathRef fromPath = circleMaskLayer.path;
        CGFloat fromLineWidth = circleMaskLayer.lineWidth;
        
        // 3
        [CATransaction begin];
        [CATransaction setValue:kCFBooleanTrue forKey: kCATransactionDisableActions];
        circleMaskLayer.lineWidth = originalLineWidth;
        circleMaskLayer.path = [self circlePath];
        [CATransaction commit];
        
        // 4
        // 4
        CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
        lineWidthAnimation.fromValue = @(fromLineWidth);
        lineWidthAnimation.toValue = @0;
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)fromPath;
        pathAnimation.toValue = (__bridge id)[self circlePath];
        
        // 5
        CAAnimationGroup * groupAnimation = [[CAAnimationGroup alloc] init];
        groupAnimation.duration = 1;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
        groupAnimation.delegate = self;
        groupAnimation.fillMode = kCAFillModeBoth;
        [circleMaskLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (isRevealing) {
        self.superview.layer.mask = nil;
        self.hidden = true;
        
        // reenable this view from being able to be clicked
        self.superview.userInteractionEnabled = true;
    }
    else {
        // prevent masked view from being clickable
        self.superview.userInteractionEnabled = false;
    }
}

@end
