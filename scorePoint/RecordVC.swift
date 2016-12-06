//
//  RecordVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class RecordVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource, matchSelectedDelegate {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var chartView2: UIView!
    @IBOutlet weak var lblChart1: UILabel!
    @IBOutlet weak var lblChart2: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var backView: UIView!
    
    var playersArray = ["Some Player", "Some Player", "Some Player", "Some Player"]
    var slicesData:Array<Data> = Array<Data>()
    var slicesData2:Array<Data> = Array<Data>()
    var pieChart:MDRotatingPieChart!
    var pieChart2:MDRotatingPieChart!
    var chart = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        let logoutBtn : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecordVC.logout))
        self.navigationItem.rightBarButtonItem = logoutBtn

        self.title = "Record"
        self.tabBarItem.title = ""
        
        userImg.image = SharedData.sharedInstance.downloadedImg
        lblName.text = SharedData.sharedInstance.completeName
        
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "RecordCell", bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "RecordCell")
        
        pieChart = MDRotatingPieChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.width))
        
        slicesData = [
            Data(myValue: 60.0, myColor: GREEN_COLOR, myLabel:"Won 60%"),
            Data(myValue: 40.0, myColor: LIGHT_GRAY, myLabel:"Lost 40%"),
        ]
        pieChart.isUserInteractionEnabled = false
        //pieChart.delegate = self
        pieChart.datasource = self
        
        var properties = Properties()
        
        properties.smallRadius = 45
        properties.bigRadius = 55
        properties.expand = 10
        properties.animationDuration = 1.0

        
        pieChart.properties = properties
        chartView.addSubview(pieChart)
        
        pieChart2 = MDRotatingPieChart(frame: CGRect(x: 0, y: 0, width: chartView2.frame.width, height: chartView2.frame.width))
        
        slicesData2 = [
            Data(myValue: 40.0, myColor: RED_COLOR, myLabel:"Won 60%"),
            Data(myValue: 60.0, myColor: LIGHT_GRAY, myLabel:"Lost 40%"),
        ]
        pieChart2.isUserInteractionEnabled = false
        //pieChart.delegate = self
        pieChart2.datasource = self
        pieChart2.properties = properties

        
        chartView2.addSubview(pieChart2)

        lblChart1.text = "60%\nWon"
        lblChart2.text = "40%\nLost"
        refresh()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let player = playersArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell") as? RecordCell {
            cell.configureCell(player)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = RecordCell()
            cell.configureCell(player)
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    //Datasource
    func colorForSliceAtIndex(_ index:Int) -> UIColor {
        if(chart == 1) {
            return slicesData[index].color
        }else{
            return slicesData2[index].color
        }
    }
    
    func valueForSliceAtIndex(_ index:Int) -> CGFloat {
        if(chart == 1) {
            return slicesData[index].value
        }else{
            return slicesData2[index].value
        }
    }
    
    func labelForSliceAtIndex(_ index:Int) -> String {
        if(chart == 1) {
            return slicesData[index].label
        }else{
            return slicesData2[index].label
        }    }
    
    func numberOfSlices() -> Int {
        if(chart == 1) {
            return slicesData.count
        }else{
            return slicesData2.count
        }    }
    
    func refresh()  {
        chart = 1
        pieChart.build()
        chart = 2
        pieChart2.build()

    }
    
    //Delegate
    //some sample messages when actions are triggered (open/close slices)
    func didOpenSliceAtIndex(_ index: Int) {
        print("Open slice at \(index)")
    }
    
    func didCloseSliceAtIndex(_ index: Int) {
        print("Close slice at \(index)")
    }
    
    func willOpenSliceAtIndex(_ index: Int) {
        print("Will open slice at \(index)")
    }
    
    func willCloseSliceAtIndex(_ index: Int) {
        print("Will close slice at \(index)")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }


    func logout(){
        GIDSignIn.sharedInstance().signOut()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.loginVC
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transition(with: appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            }, completion: nil)

    }
    
    func matchSelected() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameSetupVC")
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

class Data {
    var value:CGFloat
    var color:UIColor = UIColor.gray
    var label:String = ""
    
    init(myValue:CGFloat, myColor:UIColor, myLabel:String) {
        value = myValue
        color = myColor
        label = myLabel
    }
}

