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
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Leaderboard"
        self.tabBarItem.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.title = ""

        let backView = UIView(frame: self.tableView.bounds)
        backView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = backView

        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "RankCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "RankCell")
        searchBar.searchBarStyle = .minimal
        searchBar.isUserInteractionEnabled = false
        searchBar.backgroundColor = UIColor.white
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RankCell") as? RankCell {
            cell.configureCell(player)
            cell.badgeImg.image = UIImage(named: name)
            cell.rankLbl.text = "\(indexPath.row+1)"
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = RankCell()
            cell.badgeImg.image = UIImage(named: name)
            cell.rankLbl.text = "\(indexPath.row+1)"
            cell.configureCell(player)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VersusVC")
        self.navigationController?.pushViewController(vc, animated: true)
        //self.presentViewController(vc, animated: true, completion: nil)
    }
}
