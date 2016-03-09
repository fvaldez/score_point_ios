//
//  GameVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var playerOneImg: UIImageView!
    @IBOutlet weak var playerTwoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerOneImg.layer.cornerRadius = playerOneImg.frame.size.width / 2
        playerOneImg.clipsToBounds = true
        playerTwoImg.layer.cornerRadius = playerTwoImg.frame.size.width / 2
        playerTwoImg.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closeBtnPressed(sender: AnyObject) {
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
