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
    @IBOutlet weak var logoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoView.layer.cornerRadius = logoView.frame.size.width / 2
        logoView.clipsToBounds = true

       
        startBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5

        
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
