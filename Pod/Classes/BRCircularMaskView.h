//
//  BRCircularMaskView.h
//  Pods
//
//  Created by Bobby Ren on 6/14/15.
//
//

#import <UIKit/UIKit.h>

@interface BRCircularMaskView : UIView
{
    CAShapeLayer *circleMaskLayer;
    CGRect circleFrame;
    CGPathRef originalPath;
    CGFloat originalLineWidth;
    BOOL isRevealing;
}

-(void)configure:(CGRect)frame;
-(void)reveal;
@end
