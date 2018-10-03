//
//  CustomAnimator.swift
//  ihere
//
//  Created by abdelrahman on 10/21/17.
//  Copyright © 2017 abdelrahman. All rights reserved.
//

import Foundation
import CoreGraphics
import Foundation
import UIKit

public struct CustomAnimator {
    
    public init() {
        
    }
    
    // MARK: - Group
    
    public func animate(layer: CAShapeLayer ,Duration:CFTimeInterval,strokeDuration:CFTimeInterval,opacityDuration:CFTimeInterval) {
        let stroke = self.stroke(layer: layer,strokeDuration: strokeDuration)
        let opacity = self.opacity(layer: layer,opacityDuration: strokeDuration)
        
        let group = CAAnimationGroup()
        group.duration = Duration
        group.animations = [stroke, opacity]
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.add(group, forKey: nil)
    }
    
    // MARK: - Animations
    
    public func stroke(layer: CAShapeLayer ,strokeDuration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = strokeDuration
        
        return animation
    }
    
    public func opacity(layer: CAShapeLayer ,opacityDuration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = opacityDuration
        return animation
    }
}



