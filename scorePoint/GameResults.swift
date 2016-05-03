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
