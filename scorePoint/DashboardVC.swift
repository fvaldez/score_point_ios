//
//  DashboardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/7/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit
import Alamofire

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource, matchSelectedDelegate {

    var playersArray = ["Some Player", "Some Player", "Some Player", "Some Player"]
    
    @IBOutlet weak var playerOneImg: UIImageView!
    @IBOutlet weak var playerTwoImg: UIImageView!
    @IBOutlet weak var playingNowView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var waitingLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
              
        self.title = "Matches"
        self.tabBarItem.title = ""

        let backView = UIView(frame: self.tableView.bounds)
        backView.backgroundColor = UIColor.clear
        self.tableView.backgroundView = backView
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "VSCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "VSCell")
        
        Alamofire.request("http://172.16.6.119:8080/user").responseJSON { response in
            print(response.request ?? "")  // original URL request

            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let player = playersArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VSCell") as? VSCell {
            cell.delegate = self
            cell.configureCell(player)
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = VSCell()
            cell.delegate = self
            cell.configureCell(player)
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func matchSelected() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameSetupVC")
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)

    }
   
    @IBAction func joinBtnPressed(_ sender: AnyObject) {
    }
}
