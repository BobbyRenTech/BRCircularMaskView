//
//  BRCircularMaskView.h
//  Pods
//
//  Created by Bobby Ren on 6/14/15.
//
//

#import <UIKit/UIKit.h>

@protocol BRCircularMaskViewDelegate <NSObject>

-(void)didFinishAppearAnimation:(BOOL)didReveal;

@end

@interface BRCircularMaskView : UIView
{
    CAShapeLayer *circleMaskLayer;
    CGRect circleFrame;
    CGPathRef originalPath;
    CGFloat originalLineWidth;
    BOOL isRevealing;
}

@property (weak, nonatomic) id<BRCircularMaskViewDelegate>delegate;

-(void)configure:(CGRect)frame;
-(void)reveal;
@end
