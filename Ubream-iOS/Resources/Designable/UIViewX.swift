//
//  UIViewX.swift
//  DesignableX
//
//  Created by Mark Moeykens on 12/31/16.
//  Copyright © 2016 Mark Moeykens. All rights reserved.
//


import UIKit

@IBDesignable
class UIViewX: UIView {
    
    // MARK: - Gradient
    
    @IBInspectable var horizontalGradientStartPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradientEndPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var verticalGradientStartPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var verticalGradientEndPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ firstColor.cgColor, secondColor.cgColor ]
        
        if (horizontalGradient) {
            layer.startPoint = horizontalGradientStartPoint //CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = horizontalGradientEndPoint //CGPoint(x: 1.0, y: 0.5)
        } else {
            layer.startPoint = verticalGradientStartPoint//CGPoint(x: 0, y: 0)
            layer.endPoint =  verticalGradientEndPoint//CGPoint(x: 0, y: 0.5)
        }
    }
    
    // MARK: - Border
    
//    @IBInspectable public var borderColor: UIColor = UIColor.clear {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
    
//    @IBInspectable public var borderWidth: CGFloat = 0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            //            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    // MARK: - Shadow
    
    @IBInspectable public var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
//    @IBInspectable public var shadowColor: UIColor = UIColor.clear {
//        didSet {
//            layer.shadowColor = shadowColor.cgColor
//        }
//    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat = 0 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
}
