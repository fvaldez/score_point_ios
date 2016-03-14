//
//  GameSetupVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class GameSetupVC: UIViewController {

    @IBOutlet weak var logoback: UIView!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var firstPlayerImg: UIImageView!
    
    @IBOutlet weak var secondPlayerImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstPlayerImg.layer.cornerRadius = firstPlayerImg.frame.size.width / 2
        firstPlayerImg.clipsToBounds = true

        secondPlayerImg.layer.cornerRadius = secondPlayerImg.frame.size.width / 2
        secondPlayerImg.clipsToBounds = true

       
        startBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5

        let attr = NSDictionary(object: UIFont(name: "Open Sans", size: 15.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , forState: .Normal)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startBtnPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("BoardVC")
        //self.navigationController?.pushViewController(vc, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
}
