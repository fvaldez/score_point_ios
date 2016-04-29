//
//  AppDelegate.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate, GIDSignInDelegate  {

    var window: UIWindow?
    let tabBarController = UITabBarController()
    var loginVC : UIViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.statusBarStyle = UIStatusBarStyle.LightContent

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard.instantiateViewControllerWithIdentifier("DashboardVC")
        let leaderBoardVC = storyboard.instantiateViewControllerWithIdentifier("LeaderboardVC")
        let recordVC = storyboard.instantiateViewControllerWithIdentifier("RecordVC")
        let requestsVC = storyboard.instantiateViewControllerWithIdentifier("RequestsVC")
        loginVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC")

        let dashboardImg = UIImage(named: "vs-icon")
        let leaderBoardImg = UIImage(named: "leaderboard-icon")
        let recordImg = UIImage(named: "clock-icon")
        let requestsImg = UIImage(named: "bell-icon")

        dashboardVC.tabBarItem = UITabBarItem(title: "", image: dashboardImg, tag: 1)
        leaderBoardVC.tabBarItem = UITabBarItem(title: "", image: leaderBoardImg, tag:2)
        recordVC.tabBarItem = UITabBarItem(title: "", image: recordImg, tag: 3)
        requestsVC.tabBarItem = UITabBarItem(title: "", image: requestsImg, tag: 4)
        
        let navController1 = UINavigationController(rootViewController: dashboardVC)
        let navController2 = UINavigationController(rootViewController: leaderBoardVC)
        let navController3 = UINavigationController(rootViewController: recordVC)
        let navController4 = UINavigationController(rootViewController: requestsVC)
        
        dashboardVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        leaderBoardVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        recordVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
        requestsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)

        tabBarController.delegate = self
        tabBarController.viewControllers = [navController1, navController2, navController3, navController4]
        
        UITabBar.appearance().barTintColor = PURPLE_COLOR
        UITabBar.appearance().translucent = false 
        //TabBar items selected color
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().barTintColor = PURPLE_COLOR
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Open Sans", size: 18)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        GIDSignIn.sharedInstance().clientID = "543549798477-t7subuthvsceif8eiqh9k9b5vr0osci2.apps.googleusercontent.com"

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return  GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
        
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                //let userId = user.userID                  // For client-side use only!
                //let idToken = user.authentication.idToken // Safe to send to the server
                //let name = user.profile.name
                //let email = user.profile.email
                // ...
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
    }
    
    func showAlert(message: NSString, vc: UIViewController){
        
        let alertController = UIAlertController(title: "Message", message: message as String, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
        }
        alertController.addAction(OKAction)
        
        self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
}

