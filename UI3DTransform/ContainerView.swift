//
//  ContainerView.swift
//  UI3DTransform
//
//  Created by Inam Ahmad-zada on 2017-05-28.
//  Copyright © 2017 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class ContainerView: UIView, UIGestureRecognizerDelegate {

    var savedOriginY: CGFloat = 0.0
    var parentView: SwitcherView
    var isFullScreen: Bool = false
    var index = 0
    var savedTransform: CATransform3D = CATransform3DIdentity
    var tapRecognizer: UITapGestureRecognizer!

    init(frame: CGRect, parentView: SwitherView){
        self.parentView = parenView
        super.init(frame: frame)
        self.parentView = parentView
        savedOriginY = frame.origin.y
        
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleAnimation))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20.0
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        layer.edgeAntialiasingMask = CAEdgeAntialiasingMask(rawValue:
            CAEdgeAntialiasingMask.layerLeftEdge.rawValue |
            CAEdgeAntialiasingMask.layerTopEdge.rawValue |
            CAEdgeAntialiasingMask.layerRightEdge.rawValue |
            CAEdgeAntialiasingMask.layerBottomEdge.rawValue)
    }
    
    convenience init(frame: CGRect, parentView: SwitcherView, urlString: String){
        self.init(frame: frame, parentView: parentView)
        let webSubview = UIWebView(frame: bounds)
        webSubview.isUserInteractionEnabled = SwitcherView.enableUserInteractionInSwitcher
        addSubview(webSubview)
        if let url = URL(string: urlString){
            webSubview.loadRequest(URLRequest(url: url))
        }else{
            fatalError("<!> could not create url with string: `\(urlString)`")
        }
    }
    
    convenience init(frame: CGRect, parentView: SwitcherView, customView: UIView){
        self.init(frame: frame, parentView: parentView)
        customView.isUserInteractionEnabled = SwitcherView.enableUserInteractionInSwitcher
        addSubview(customView)
    }
    
    convenience init(frame: CGRect, parentView: SwitcherView, imageName: String){
        self.init(frame: frame, parentView: parentView)
        self.layer.contents = UIImage(named: imageName)!.cgImage!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
