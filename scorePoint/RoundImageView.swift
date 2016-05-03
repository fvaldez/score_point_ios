//
//  RoundImageView.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 5/3/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit
@IBDesignable
class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.layer.masksToBounds = true
        
    }
}
