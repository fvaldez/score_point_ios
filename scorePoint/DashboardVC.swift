//
//  DashboardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource, matchSelectedDelegate {

    var playersArray = ["Some Player", "Some Player", "Some Player", "Some Player"]
    
    @IBOutlet weak var playerOneImg: UIImageView!
    @IBOutlet weak var playerTwoImg: UIImageView!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var playingNowView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinBtn.layer.cornerRadius = 5
        joinBtn.layer.masksToBounds = true
        
        playingNowView.layer.cornerRadius = 5
        playingNowView.layer.masksToBounds = true
        
        playerOneImg.layer.cornerRadius = playerOneImg.frame.size.width/2
        playerOneImg.layer.masksToBounds = true
        
        playerTwoImg.layer.cornerRadius = playerTwoImg.frame.size.width/2
        playerTwoImg.layer.masksToBounds = true
        
        view1.layer.cornerRadius = view1.frame.size.width/2
        view1.layer.masksToBounds = true
        
        view2.layer.cornerRadius = view2.frame.size.width/2
        view2.layer.masksToBounds = true
        
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
              
        self.title = "Matches"
        self.tabBarItem.title = ""

        let backView = UIView(frame: self.tableView.bounds)
        backView.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundView = backView
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "VSCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "VSCell")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let player = playersArray[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("VSCell") as? VSCell {
            cell.delegate = self
            cell.configureCell(player)
            cell.selectionStyle = .None
            return cell
        }else {
            let cell = VSCell()
            cell.delegate = self
            cell.configureCell(player)
            cell.selectionStyle = .None
            return cell
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func matchSelected() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("GameSetupVC")
        //self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)

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
