//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Adriana Gonzalez on 3/31/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import Foundation
import pop

@IBDesignable
class CustomButton: UIButton{
    
    var willAnimate: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{
            setupView()
        }
    }

    @IBInspectable var fontColor: UIColor = UIColor.white{
        didSet{
            self.tintColor = fontColor
        }
    }
    
    @IBInspectable var withAnimation: Bool = false {
        didSet{
           self.willAnimate = withAnimation
        }
    }

    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius

        if(willAnimate == true){
            self.addTarget(self, action: #selector(CustomButton.scaleAnimation), for: .touchUpInside)
            self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragExit)
        }
       
    }
    
    func scaleToSmall(){
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation(){
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
        
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleDefaultAnimation")
    }
}
