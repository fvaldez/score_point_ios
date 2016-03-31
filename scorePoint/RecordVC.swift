//
//  RecordVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class RecordVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource {

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

        
        let logoutBtn : UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout")
        self.navigationItem.rightBarButtonItem = logoutBtn

        self.title = "Record"
        self.tabBarItem.title = ""
        
        
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
        
        userImg.image = SharedData.sharedInstance.downloadedImg
        userImg.layer.cornerRadius = userImg.frame.size.width / 2
        userImg.clipsToBounds = true
        
        
        lblName.text = SharedData.sharedInstance.completeName
        
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "RecordCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "RecordCell")
        
        pieChart = MDRotatingPieChart(frame: CGRectMake(0, 0, chartView.frame.width, chartView.frame.width))
        
        slicesData = [
            Data(myValue: 60.0, myColor: GREEN_COLOR, myLabel:"Won 60%"),
            Data(myValue: 40.0, myColor: LIGHT_GRAY, myLabel:"Lost 40%"),
        ]
        pieChart.userInteractionEnabled = false
        //pieChart.delegate = self
        pieChart.datasource = self
        
        var properties = Properties()
        
        properties.smallRadius = 45
        properties.bigRadius = 55
        properties.expand = 10
        properties.animationDuration = 1.0

        
        pieChart.properties = properties
        chartView.addSubview(pieChart)
        
        pieChart2 = MDRotatingPieChart(frame: CGRectMake(0, 0, chartView2.frame.width, chartView2.frame.width))
        
        slicesData2 = [
            Data(myValue: 40.0, myColor: RED_COLOR, myLabel:"Won 60%"),
            Data(myValue: 60.0, myColor: LIGHT_GRAY, myLabel:"Lost 40%"),
        ]
        pieChart2.userInteractionEnabled = false
        //pieChart.delegate = self
        pieChart2.datasource = self
        pieChart2.properties = properties

        
        chartView2.addSubview(pieChart2)

        lblChart1.text = "60%\nWon"
        lblChart2.text = "40%\nLost"


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let player = playersArray[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecordCell") as? RecordCell {
            cell.configureCell(player)
            cell.selectionStyle = .None
            return cell
        }else {
            let cell = RecordCell()
            cell.configureCell(player)
            cell.selectionStyle = .None
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    //Datasource
    func colorForSliceAtIndex(index:Int) -> UIColor {
        if(chart == 1) {
            return slicesData[index].color
        }else{
            return slicesData2[index].color
        }
    }
    
    func valueForSliceAtIndex(index:Int) -> CGFloat {
        if(chart == 1) {
            return slicesData[index].value
        }else{
            return slicesData2[index].value
        }
    }
    
    func labelForSliceAtIndex(index:Int) -> String {
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
    func didOpenSliceAtIndex(index: Int) {
        print("Open slice at \(index)")
    }
    
    func didCloseSliceAtIndex(index: Int) {
        print("Close slice at \(index)")
    }
    
    func willOpenSliceAtIndex(index: Int) {
        print("Will open slice at \(index)")
    }
    
    func willCloseSliceAtIndex(index: Int) {
        print("Will close slice at \(index)")
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }


    func logout(){
        GIDSignIn.sharedInstance().signOut()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window!.rootViewController = appDelegate.loginVC
        appDelegate.tabBarController.selectedIndex = 0
        
        UIView.transitionWithView(appDelegate.window!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            }, completion: nil)

    }
    
}

class Data {
    var value:CGFloat
    var color:UIColor = UIColor.grayColor()
    var label:String = ""
    
    init(myValue:CGFloat, myColor:UIColor, myLabel:String) {
        value = myValue
        color = myColor
        label = myLabel
    }
}

