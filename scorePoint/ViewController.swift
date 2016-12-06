//
//  ViewController.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 5
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }

    @IBAction func btnPressed(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.tabBarController
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            }, completion: nil)

    }

}

