//
//  LoginVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/18/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loginBtn.layer.cornerRadius = 5
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnPresed(sender: AnyObject) {
        loginGoogle()
        //enterApp()
    }
    
    func loginGoogle(){
        GIDSignIn.sharedInstance().signIn()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)

    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                
                let completename = GIDSignIn.sharedInstance().currentUser.profile.name
                let fullNameArr = completename.characters.split{$0 == " "}.map(String.init)
                
                SharedData.sharedInstance.idnum = "\(GIDSignIn.sharedInstance().currentUser.userID)"
                SharedData.sharedInstance.mail = GIDSignIn.sharedInstance().currentUser.profile.email
                SharedData.sharedInstance.firstName = fullNameArr[0]
                SharedData.sharedInstance.lastName = fullNameArr[1]
                SharedData.sharedInstance.completeName = completename
                
                if("\(GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(100))" != nil){
                    SharedData.sharedInstance.imgString = "\(GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(200))"
                    let url = NSURL(string: SharedData.sharedInstance.imgString)
                    let data = NSData(contentsOfURL: url!)
                    SharedData.sharedInstance.downloadedImg = UIImage(data: data!)
                }else{
                    self.generateProfileImage()
                }
                
                self.enterApp()
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
    }
    
    func enterApp(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.tabBarController
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            }, completion: nil)

    }
    
    func generateProfileImage(){
        let first = SharedData.sharedInstance.firstName.characters.first
        let second = SharedData.sharedInstance.lastName.characters.first
        
        let lbl = UILabel(frame: CGRectMake(0,0,100,100))
        lbl.text = "\(first!)\(second!)"
        lbl.font =  UIFont(name: "OpenSans-Semibold", size: 50)
        lbl.backgroundColor = BLUE_COLOR
        lbl.textAlignment = NSTextAlignment.Center
        lbl.textColor = UIColor.whiteColor()
        
        UIGraphicsBeginImageContextWithOptions(lbl.bounds.size, true, 0)
        lbl.drawViewHierarchyInRect(lbl.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        SharedData.sharedInstance.downloadedImg = image
        
    }

}
