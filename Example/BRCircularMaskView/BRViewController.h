//
//  BRViewController.h
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRExpandableViewController.h"

@interface BRViewController : UIViewController

@property (nonatomic) BRExpandableViewController *expandableController;

-(IBAction)didClickShow:(id)sender;
@end
