//
//  RoundView.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 5/3/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

    var makeCircle = false
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var fullCircle: Bool = false{
        didSet{
            makeCircle = fullCircle
            setupView()
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
        if(makeCircle == true){
            self.layer.cornerRadius = self.frame.size.width/2
            self.layer.masksToBounds = true
        }else{
            self.layer.cornerRadius = cornerRadius
        }
    }


}
