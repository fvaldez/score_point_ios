//
//  VersusVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 4/28/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class VersusVC: UIViewController, MDRotatingPieChartDelegate, MDRotatingPieChartDataSource {

    var slicesData:Array<DataEntry> = Array<DataEntry>()
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
        DispatchQueue.main.async {
            self.firstPlayerImg.layer.cornerRadius = self.firstPlayerImg.frame.size.width/2
            self.firstPlayerImg.layer.masksToBounds = true
            self.secondPlayerImg.layer.cornerRadius = self.secondPlayerImg.frame.size.width/2
            self.secondPlayerImg.layer.masksToBounds = true
        }

    
        pieChart = MDRotatingPieChart(frame: CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.width))


        slicesData = [
            DataEntry(myValue: 93.0, someColor: GREEN_COLOR, myLabel:""),
            DataEntry(myValue: 3.0, someColor: RED_COLOR, myLabel:""),
        ]
        pieChart.isUserInteractionEnabled = false
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
    func colorForSliceAtIndex(_ index:Int) -> UIColor {
        return slicesData[index].color
    }
    
    func valueForSliceAtIndex(_ index:Int) -> CGFloat {
        return slicesData[index].value
        
    }
    
    func labelForSliceAtIndex(_ index:Int) -> String {
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


}
