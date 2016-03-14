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
        playerImg.layer.cornerRadius = playerImg.frame.size.width / 2
        playerImg.clipsToBounds = true
        
        rankView.layer.cornerRadius = rankView.frame.size.width / 2
        rankView.clipsToBounds = true

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
    
}
