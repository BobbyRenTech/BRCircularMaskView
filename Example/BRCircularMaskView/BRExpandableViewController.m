//
//  BRExpandableViewController.m
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

#import "BRExpandableViewController.h"

@interface BRExpandableViewController ()

@end

@implementation BRExpandableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addMask:(CGRect)maskFrame {
    maskView = [[BRCircularMaskView alloc] init];
    [self.view addSubview:maskView];
    
    maskView.frame = self.view.bounds;
    maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [maskView configure:maskFrame];
}

-(IBAction)didClickButton:(UIButton *)sender {
    NSLog(@"Button: %d", sender.tag);
}

-(IBAction)toggleReveal {
    [maskView reveal];
}
@end
