//
//  VersusVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 4/28/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class VersusVC: UIViewController, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource {

    var slicesData:Array<Data> = Array<Data>()
    var pieChart:MDRotatingPieChart!

    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var firstPlayerImg: UIImageView!
    @IBOutlet weak var secondPlayerImg: UIImageView!
    @IBOutlet weak var firstPlayerLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Head 2 Head"
        rankView.layer.cornerRadius = 5
        rankView.layer.masksToBounds = true
        dispatch_async(dispatch_get_main_queue()) {
            self.firstPlayerImg.layer.cornerRadius = self.firstPlayerImg.frame.size.width/2
            self.firstPlayerImg.layer.masksToBounds = true
            self.secondPlayerImg.layer.cornerRadius = self.secondPlayerImg.frame.size.width/2
            self.secondPlayerImg.layer.masksToBounds = true
        }

    
        pieChart = MDRotatingPieChart(frame: CGRectMake(0, 0, chartView.frame.width, chartView.frame.width))


        slicesData = [
            Data(myValue: 93.0, myColor: GREEN_COLOR, myLabel:""),
            Data(myValue: 3.0, myColor: RED_COLOR, myLabel:""),
        ]
        pieChart.userInteractionEnabled = false
        pieChart.datasource = self
        
        var properties = Properties()
        
        properties.smallRadius = 45
        properties.bigRadius = 55
        properties.expand = 10
        properties.animationDuration = 1.0

        pieChart.properties = properties
        chartView.addSubview(pieChart)

        refresh()
        
        firstPlayerImg.image = SharedData.sharedInstance.downloadedImg
        firstPlayerLbl.text = SharedData.sharedInstance.completeName

    }
    //Datasource
    func colorForSliceAtIndex(index:Int) -> UIColor {
        return slicesData[index].color
    }
    
    func valueForSliceAtIndex(index:Int) -> CGFloat {
        return slicesData[index].value
        
    }
    
    func labelForSliceAtIndex(index:Int) -> String {
        return slicesData[index].label
        
    }
    
    func numberOfSlices() -> Int {
        return slicesData.count
        
    }
    
    func refresh()  {
        pieChart.build()
        
        
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


}
