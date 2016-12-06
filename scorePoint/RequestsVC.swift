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
        self.tableView.register(nibName, forCellReuseIdentifier: "RequestCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Received"
        }else{
            return "Sent"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return requestsArray.count
        }else{
            return requestsSentArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let player = requestsArray[indexPath.row]
        let playerSent = requestsSentArray[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as? RequestCell {
            cell.delegate = self
            cell.mainBtn.tag = indexPath.row
            if(indexPath.section == 0){
                cell.configureCell(player, received: true )
            }else{
                cell.configureCell(playerSent, received: false)
            }
            cell.selectionStyle = .none
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
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func requestSelected(delete: Bool, index: Int) {
        let indexPath = IndexPath(row: index, section: 1)
        let indexSet = IndexSet(integer: 1)
        if(delete == true){
            requestsSentArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.reloadSections(indexSet, with: .fade)
            tableView.endUpdates()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GameSetupVC") as! GameSetupVC
            vc.sendingRequest = false
            self.present(vc, animated: true, completion: nil)

        }
        
    }
    
}
