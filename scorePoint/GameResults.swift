//
//  GameResults.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/30/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

protocol ResultsDelegate: class {
    func closeResults(_ rematch:Bool)
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
    
    @IBAction func rematchBtnPressed(_ sender: AnyObject) {
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.delegate?.closeResults(true)
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: AnyObject) {
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.delegate?.closeResults(false)
        }
    }
}
