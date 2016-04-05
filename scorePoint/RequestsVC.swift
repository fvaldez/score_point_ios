//
//  RequestsVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 4/4/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class RequestsVC: UIViewController,  UITableViewDelegate, UITableViewDataSource, requestSelectedDelegate {

    @IBOutlet weak var tableView: UITableView!
    var requestsArray = ["Some Player", "Some Player"]
    var requestsSentArray = ["Some Player", "Some Player"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Match Requests"
        self.tabBarItem.title = ""
        
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "RequestCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "RequestCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Received"
        }else{
            return "Sent"
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return requestsArray.count
        }else{
            return requestsSentArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let player = requestsArray[indexPath.row]
        let playerSent = requestsSentArray[indexPath.row]

        if let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell") as? RequestCell {
            cell.delegate = self
            cell.mainBtn.tag = indexPath.row
            if(indexPath.section == 0){
                cell.configureCell(player, received: true )
            }else{
                cell.configureCell(playerSent, received: false)
            }
            cell.selectionStyle = .None
            return cell
        }else {
            let cell = RequestCell()
            cell.delegate = self
            cell.mainBtn.tag = indexPath.row
            if(indexPath.section == 0){
                cell.configureCell(player, received: true )
            }else{
                cell.configureCell(playerSent, received: false)
            }
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

    func requestSelected(delete delete: Bool, index: Int) {
        let indexPath = NSIndexPath(forRow: index, inSection: 1)
        let indexSet = NSIndexSet(index: 1)
        if(delete == true){
            requestsSentArray.removeAtIndex(indexPath.row)
            tableView.beginUpdates()
            tableView.reloadSections(indexSet, withRowAnimation: .Fade)
            tableView.endUpdates()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("GameSetupVC") as! GameSetupVC
            vc.sendingRequest = false
            self.presentViewController(vc, animated: true, completion: nil)

        }
        
    }
    
}
