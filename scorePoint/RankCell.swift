//
//  RankCell.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/14/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class RankCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var badgeImg: UIImageView!
    
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var rankLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        rankView.layer.cornerRadius = rankView.frame.size.width / 2
        rankView.clipsToBounds = true

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
    
}
