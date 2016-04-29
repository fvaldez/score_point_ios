//
//  GameResults.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/30/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

protocol ResultsDelegate: class {
    func closeResults(rematch:Bool)
}

class GameResults: UIView {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var rematchBtn: UIButton!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var winnerlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    weak var delegate:ResultsDelegate?

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        if self.subviews.count == 0 {
            setup()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
    
        winnerlbl.layer.cornerRadius = winnerlbl.frame.size.height/2
        winnerlbl.layer.masksToBounds = true
        
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        rematchBtn.layer.cornerRadius = 5
        rematchBtn.layer.masksToBounds = true
        closeBtn.layer.cornerRadius = 5
        closeBtn.layer.masksToBounds = true
        
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        imgView.layer.masksToBounds = true
        
        photoView.layer.cornerRadius = photoView.frame.size.width/2
        photoView.layer.masksToBounds = true
    
    }
    
    @IBAction func rematchBtnPressed(sender: AnyObject) {
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.delegate?.closeResults(true)
        }
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.delegate?.closeResults(false)
        }
    }
}
