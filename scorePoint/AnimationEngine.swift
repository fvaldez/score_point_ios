//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Adriana Gonzalez on 4/1/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//


import UIKit
import pop

class AnimationEngine{
    
    class var offScreenRightPosition: CGPoint{
        
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
        
    }
    
    class var offScreenLeftPosition: CGPoint{
        return CGPoint(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)

    }
    
    class var screenCenterPosition: CGPoint{
        return CGPoint(x: UIScreen.main.bounds.midY, y: UIScreen.main.bounds.midY)
    }
    
    let ANIM_DELAY: Int = 1
    var originalConstants = [CGFloat]()
    var contraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]){
        for con in constraints {
            originalConstants.append(con.constant)
            if(constraints.index(of: con) == 0){
                con.constant = AnimationEngine.offScreenLeftPosition.x
            }else{
                con.constant = AnimationEngine.offScreenRightPosition.x
            }
        }
        
        self.contraints = constraints
    }
    
    func animateOnScreen(_ delay: Int){
        let time = DispatchTime.now() + Double(Int64(Double(delay) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time){
            var index = 0
            repeat {
                
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim?.toValue = self.originalConstants[index]
                moveAnim?.springBounciness = 12
                moveAnim?.springSpeed = 12
                
                moveAnim?.dynamicsFriction += 5 + CGFloat(index)
                
                let con = self.contraints[index]
                con.pop_add(moveAnim, forKey: "moveOnScreen")
                
                index = index + 1
                
            }while (index < self.contraints.count)

        }
    }
}
