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
    circleMaskLayer.frame = self.bounds;
    circleMaskLayer.lineWidth = 2;
    circleMaskLayer.fillColor = [UIColor whiteColor].CGColor;
    circleMaskLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.backgroundColor = [UIColor clearColor];
    
    circleFrame = maskFrame;
    self.superview.layer.mask = circleMaskLayer;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    circleMaskLayer.frame = self.bounds;
    circleMaskLayer.path = [UIBezierPath bezierPathWithOvalInRect:circleFrame].CGPath;
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
        fromPath = circleMaskLayer.path;
        fromLineWidth = circleMaskLayer.lineWidth;
        
        // 3
        [CATransaction begin];
        [CATransaction setValue:kCFBooleanTrue forKey:kCATransactionDisableActions];
        circleMaskLayer.lineWidth = 2*finalRadius;
        circleMaskLayer.path = toPath;
        [CATransaction commit];
        
        // 4
        CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
        lineWidthAnimation.fromValue = @(fromLineWidth);
        lineWidthAnimation.toValue = @(2*finalRadius);
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.fromValue = (__bridge id)fromPath;
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
        /*
        self.hidden = false
        backgroundColor = UIColor.clearColor()
        // 2
        // 3
        circleMaskLayer.removeFromSuperlayer()
        superview?.layer.mask = circleMaskLayer
        
        isRevealing = false
        // 1
        let toPath = self.fromPath
        let toWidth = self.fromLineWidth
        
        // 2
        let fromPath = circleMaskLayer.path
        let fromLineWidth = circleMaskLayer.lineWidth
        
        // 3
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        circleMaskLayer.lineWidth = toWidth
        circleMaskLayer.path = toPath
        CATransaction.commit()
        
        // 4
        // 4
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.fromValue = fromLineWidth
        lineWidthAnimation.toValue = 0
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = fromPath
        pathAnimation.toValue = toPath
        
        // 5
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 1
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.animations = [pathAnimation, lineWidthAnimation]
        groupAnimation.delegate = self
        groupAnimation.fillMode = kCAFillModeBoth
        circleMaskLayer.addAnimation(groupAnimation, forKey: "strokeWidth")        
         */
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (isRevealing) {
        self.superview.layer.mask = nil;
        self.hidden = true;
    }
}

@end
