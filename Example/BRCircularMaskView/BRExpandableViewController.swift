//
//  BRExpandableViewController.swift
//  BRCircularMaskView
//
//  Created by Bobby Ren on 6/14/15.
//  Copyright (c) 2015 Bobby Ren. All rights reserved.
//

import UIKit
import BRCircularMaskView

class BRExpandableViewController: UIViewController {

    let maskView = BRCircularMaskView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMask(frame:CGRect) {
        self.view.addSubview(self.maskView)
        maskView.frame = self.view.bounds
        maskView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.maskView.configure(frame)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
