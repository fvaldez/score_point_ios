////
//  VSCell.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

protocol matchSelectedDelegate: class {
    func matchSelected()
}

class VSCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    weak var delegate: matchSelectedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        playerImg.layer.cornerRadius = playerImg.frame.size.width / 2
        playerImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(player:String){
        playerImg.frame = CGRectMake(0, 0, 65, 65)
        lblName.text = player
        playerImg.image = UIImage(named: "placeholder")

    }
    
    @IBAction func matchBtnPressed(sender: AnyObject) {
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.delegate?.matchSelected()
        }
    }
    
    
}
