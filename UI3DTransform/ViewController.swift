//
//  ViewController.swift
//  UI3DTransform
//
//  Created by Inam Ahmad-zada on 2017-05-28.
//  Copyright © 2017 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(SwitcherView(frame: UIScreen.main.bounds))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool {
        get{return false}
    }

    override var prefersStatusBarHidden: Bool{
        get{return true}
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{return .portrait}
    }
}

