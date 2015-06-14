//
//  BRViewController.swift
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

import UIKit

class BRViewController: UIViewController {
    var expandableController: ExpandableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // add the controller as a subview programmatically
        expandableController = storyboard!.instantiateViewControllerWithIdentifier("ExpandableViewController") as? ExpandableViewController
        var frame = self.view.frame
        self.addChildViewController(expandableController!)
        expandableController!.view.frame = frame
        self.view.addSubview(expandableController!.view)
        expandableController!.didMoveToParentViewController(self)
        
        // disable touch on the controller so that the current controller can still have interaction
        expandableController!.view.userInteractionEnabled = false
        
        let maskFrame = CGRectMake(0, 300, 150, 150)
        expandableController!.addMask(maskFrame)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
