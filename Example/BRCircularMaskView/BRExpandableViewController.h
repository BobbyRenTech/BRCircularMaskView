//
//  BRExpandableViewController.h
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
@import BRCircularMaskView;

@interface BRExpandableViewController : UIViewController
{
    BRCircularMaskView *maskView;
}

-(void)addMask:(CGRect)maskFrame;

-(void)toggleReveal;
@end
