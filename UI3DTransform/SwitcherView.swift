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
    let scaleOut: CGFloat = 0.8
    
    var containerViews: [ContainerView] = []
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
        layer.backgroundColor = UIColor.darkGray.cgColor
        
        switcherViewPadding = bounds.size.height / seperatorDivisor
        scrollView = UIScrollView(frame: bounds)
        scrollView.isUserInteractionEnabled = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: bounds.size.width, height: bounds.size.height)
        scrollView.delegate = self
        addSubview(scrollView)
        
        addContainerView(ContainerView(frame: bounds, parentView: self, imageName: "image1.jpg"))
        addContainerView(ContainerView(frame: bounds, parentView: self, customView: MKMapView(frame: self.bounds)))
        addContainerView(ContainerView(frame: bounds, parentView: self, imageName: "image2.jpg"))
        addContainerView(ContainerView(frame: bounds, parentView: self, urlString: "http://www.apple.com"))
        addContainerView(ContainerView(frame: bounds, parentView: self, imageName: "image3.jpg"))
    }
    
    func radians(degree: CGFloat) -> CGFloat {
        return (degree * CGFloat.pi) / 180.0
    }
    
    func addContainerView(_ view: ContainerView) {
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowColor = UIColor.black.cgColor
        
        view.frame = CGRect(x: 0.0, y: CGFloat(scrollView.subviews.count) * switcherViewPadding,
                            width: frame.size.width, height: frame.size.height)
        scrollView.addSubview(view)
        view.index = containerViews.count
        containerViews.append(view)
        
        view.layer.transform = getTransform(translateToY: 0, isScale:true, isRotate: true)
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height + switcherViewPadding)
    }
    
    func getTransform(translateToY: CGFloat, isScale: Bool, isRotate: Bool) -> CATransform3D{
        var transform = CATransform3DIdentity
        
        transform.m34 = 1 / -2000
        
        if isRotate {
            transform = CATransform3DRotate(transform, -radians(degree: angle), 1.0, 0.0, 0.0)
        }
        if isScale {
            transform = CATransform3DScale(transform, scaleOut, scaleOut, scaleOut)
        }
        if translateToY != 0.0 {
            transform = CATransform3DTranslate(transform, 0.0, translateToY, 0.0)
        }
        return transform
    }
    
    func animate(transform: CATransform3D, view: UIView){
        let basicAnim = CABasicAnimation(keyPath: "transform")
        basicAnim.fromValue = view.layer.transform
        basicAnim.toValue = transform
        basicAnim.duration = animationDuration
        view.layer.add(basicAnim, forKey: nil)
        
        CATransaction.setDisableActions(true)
        view.layer.transform = transform
        CATransaction.setDisableActions(false)
    }
    
    func animate(view: ContainerView, isFullScreen: Bool) {
        
        if isFullScreen {
            
            for i in 0..<view.index {
                animate(transform: getTransform(translateToY: -bounds.size.height, isScale: true, isRotate: false), view: containerViews[i])
            }
            animate(transform: getTransform(translateToY: scrollView.contentOffset.y - (view.frame.origin.y - view.bounds.size.height / translationDivisors), isScale: false, isRotate: false), view: view)
            
            for i in (view.index + 1)..<containerViews.count {
                animate(transform: getTransform(translateToY: 2.0*bounds.size.height, isScale: true, isRotate: true), view: containerViews[i])
            }
        }else{
            for i in 0..<view.index {
                animate(transform: getTransform(translateToY: 0.0,
                                                isScale: true,
                                                isRotate: true),
                        view: containerViews[i])
            }
            
            animate(transform: getTransform(translateToY: 0.0,
                                            isScale: true,
                                            isRotate: true),
                    view: view)
            
            for i in (view.index + 1)..<containerViews.count {
                animate(transform: getTransform(translateToY: 0.0,
                                                isScale: true,
                                                isRotate: true),
                        view: containerViews[i])
            }
        }
    }
}
