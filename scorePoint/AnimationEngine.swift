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
        
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
        
    }
    
    class var offScreenLeftPosition: CGPoint{
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))

    }
    
    class var screenCenterPosition: CGPoint{
        return CGPointMake(CGRectGetMidY(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    let ANIM_DELAY: Int = 1
    var originalConstants = [CGFloat]()
    var contraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]){
        for con in constraints {
            originalConstants.append(con.constant)
            if(constraints.indexOf(con) == 0){
                con.constant = AnimationEngine.offScreenLeftPosition.x
            }else{
                con.constant = AnimationEngine.offScreenRightPosition.x
            }
        }
        
        self.contraints = constraints
    }
    
    func animateOnScreen(delay: Int){
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()){
            var index = 0
            repeat {
                
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                moveAnim.dynamicsFriction += 5 + CGFloat(index)
                
                let con = self.contraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")
                
                index = index + 1
                
            }while (index < self.contraints.count)

        }
    }
}
