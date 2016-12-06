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
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ player:String){
        playerImg.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        lblName.text = player
        playerImg.image = UIImage(named: "placeholder")

    }
    
    @IBAction func matchBtnPressed(_ sender: AnyObject) {
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.delegate?.matchSelected()
        }
    }
    
    
}
