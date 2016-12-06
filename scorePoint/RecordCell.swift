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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(_ player:String){
        playerImg.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        playerImg.image = UIImage(named: "placeholder")
        
    }
    
    @IBAction func matchBtnPressed(_ sender: AnyObject) {
       
        self.delegate?.matchSelected()
    }
    

}
