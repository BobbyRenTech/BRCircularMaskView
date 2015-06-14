//
//  BRViewController.m
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

#import "BRViewController.h"

@interface BRViewController ()

@end

@implementation BRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.expandableController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BRExpandableViewController"];
    CGRect frame = self.view.frame;
    [self addChildViewController:self.expandableController];
    self.expandableController.view.frame = frame;
    [self.view addSubview:self.expandableController.view];
    [self.expandableController didMoveToParentViewController:self];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect maskFrame = CGRectMake(0, 300, 150, 150);
    [self.expandableController addMask:maskFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didClickShow:(id)sender {
    [self.expandableController toggleReveal];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
