//
//  RecordCell.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/17/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    weak var delegate: matchSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(player:String){
        playerImg.frame = CGRectMake(0, 0, 65, 65)
        playerImg.image = UIImage(named: "placeholder")
        
    }
    
    @IBAction func matchBtnPressed(sender: AnyObject) {
       
        self.delegate?.matchSelected()
    }
    

}
