//
//  SharedData.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/18/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import Foundation


class SharedData {
    
    static var sharedInstance: SharedData = SharedData()

    var firstName = ""
    var lastName = ""
    var imgString = ""
    var idnum = ""
    var mail = ""
    
    init() {
        
    }
}