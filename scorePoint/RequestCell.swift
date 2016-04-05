//
//  RequestCell.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 4/4/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

protocol requestSelectedDelegate: class {
    func requestSelected(delete delete: Bool, index: Int)
}

class RequestCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainBtn: CustomButton!
    weak var delegate: requestSelectedDelegate?
    var receivedType: Bool!

    override func awakeFromNib() {
        super.awakeFromNib()
        playerImg.layer.cornerRadius = playerImg.frame.size.width / 2
        playerImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(player:String, received: Bool){
        playerImg.frame = CGRectMake(0, 0, 65, 65)
        lblName.text = player
        playerImg.image = UIImage(named: "placeholder")
        receivedType = received
        if(received == true){
            mainBtn.backgroundColor = GREEN_COLOR
            mainBtn.setTitle("Accept", forState: .Normal)
        }else{
            mainBtn.backgroundColor = RED_COLOR
            mainBtn.setTitle("Cancel", forState: .Normal)
        }
        
    }

    @IBAction func requestBtnPressed(sender: AnyObject) {
        if(receivedType == true){
            self.delegate?.requestSelected(delete: false, index: mainBtn.tag)

        }else{
            self.delegate?.requestSelected(delete: true, index: mainBtn.tag)

        }


    }
    
}
