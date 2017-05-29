//
//  SwitcherView.swift
//  UI3DTransform
//
//  Created by Inam Ahmad-zada on 2017-05-28.
//  Copyright © 2017 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import MapKit

class SwitcherView: UIView, UIScrollViewDelegate {

    static let enableUserInteractionInSwitcher = true
    
    let animationDuration: TimeInterval = 0.2
    let angle: CGFloat = 55.0
    let scale: CGFloat = 0.8
    
    var containerView: [ContainerView] = []
    var scrollView: UIScrollView!
    
    var switcherViewPadding: CGFloat = 0.0
    let seperatorDivisor: CGFloat = 3.0
    var translationDivisors: CGFloat {
        get{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return 4.46
            }else{
                return 4.13
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        standardInitialize()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        standardInitialize()
    }
    
    func standardInitialize(){
        
    }
}
