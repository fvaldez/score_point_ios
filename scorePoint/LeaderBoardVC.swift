//
//  LeaderBoardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class LeaderBoardVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var playersArray = ["Some Player", "Some Player", "Some Player", "Some Player"]

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Leaderboard"
        self.tabBarItem.title = ""
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.title = ""

        let backView = UIView(frame: self.tableView.bounds)
        backView.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundView = backView

        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "RankCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "RankCell")
        searchBar.searchBarStyle = .Minimal
        searchBar.userInteractionEnabled = false
        searchBar.backgroundColor = UIColor.whiteColor()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // For testing purposes
        
        var name = ""
        switch(indexPath.row){
        case 0:
            name = "badge-4"
        case 1:
            name = "badge-3"
        case 2:
            name = "badge-2"
        default:
            name = "badge-1"
        }
        
        let player = playersArray[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("RankCell") as? RankCell {
            cell.configureCell(player)
            cell.badgeImg.image = UIImage(named: name)
            cell.rankLbl.text = "\(indexPath.row+1)"
            cell.selectionStyle = .None
            return cell
        }else {
            let cell = RankCell()
            cell.badgeImg.image = UIImage(named: name)
            cell.rankLbl.text = "\(indexPath.row+1)"
            cell.configureCell(player)
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("VersusVC")
        self.navigationController?.pushViewController(vc, animated: true)
        //self.presentViewController(vc, animated: true, completion: nil)
    }
}
