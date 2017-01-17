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
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }

    @IBAction func loginBtnPresed(_ sender: AnyObject) {
        loginGoogle()
        //enterApp()
    }
    
    func loginGoogle(){
        GIDSignIn.sharedInstance().signIn()
        //UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
        withError error: Error!) {
            if (error == nil) {
                
                let completename = GIDSignIn.sharedInstance().currentUser.profile.name
                let fullNameArr = completename?.characters.split{$0 == " "}.map(String.init)
                
                SharedData.sharedInstance.idnum = "\(GIDSignIn.sharedInstance().currentUser.userID)"
                SharedData.sharedInstance.mail = GIDSignIn.sharedInstance().currentUser.profile.email
                SharedData.sharedInstance.firstName = (fullNameArr?[0])!
                SharedData.sharedInstance.lastName = (fullNameArr?[1])!
                SharedData.sharedInstance.completeName = completename!
                print("token: \(user.authentication.accessToken)")
                if(GIDSignIn.sharedInstance().currentUser.profile.hasImage){
                    if let imgString = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 200){
                        SharedData.sharedInstance.imgString = imgString
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: imgString) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            DispatchQueue.main.async {
                                SharedData.sharedInstance.downloadedImg = UIImage(data: data!)
                            }
                        }

                    }
                    
                   
                }else{
                    self.generateProfileImage()
                }

                self.generateProfileImage()
                self.enterApp()
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    internal func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
        withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
    }
    
    func enterApp(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.tabBarController
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            }, completion: nil)

    }
    
    func generateProfileImage(){
        let first = SharedData.sharedInstance.firstName.characters.first
        let second = SharedData.sharedInstance.lastName.characters.first
        
        let lbl = UILabel(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
        lbl.text = "\(first!)\(second!)"
        lbl.font =  UIFont(name: "OpenSans-Semibold", size: 50)
        lbl.backgroundColor = BLUE_COLOR
        lbl.textAlignment = NSTextAlignment.center
        lbl.textColor = UIColor.white
        
        UIGraphicsBeginImageContextWithOptions(lbl.bounds.size, true, 0)
        lbl.drawHierarchy(in: lbl.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        SharedData.sharedInstance.downloadedImg = image
        
    }

}
