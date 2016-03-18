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
        
        loginBtn.layer.cornerRadius = 5
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
    }
    
    func loginGoogle(){
        GIDSignIn.sharedInstance().signIn()
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)

    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                let email = user.profile.email
                print(userId)
                print(idToken)
                print(name)
                print(email)
                
                let completename = GIDSignIn.sharedInstance().currentUser.profile.name
                let fullNameArr = completename.characters.split{$0 == " "}.map(String.init)
                
                SharedData.sharedInstance.idnum = "\(GIDSignIn.sharedInstance().currentUser.userID)"
                SharedData.sharedInstance.mail = GIDSignIn.sharedInstance().currentUser.profile.email
                SharedData.sharedInstance.firstName = fullNameArr[0]
                SharedData.sharedInstance.lastName = fullNameArr[1]
                
                self.enterApp()
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    func enterApp(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.tabBarController
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            }, completion: nil)

    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
