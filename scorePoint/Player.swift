//
//  Player.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/29/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import Foundation

class Player {
    
     fileprivate var _firstName = ""
     fileprivate var _lastName = ""
     fileprivate var _score = 0
     fileprivate var _setsWon = 0
     fileprivate var _image: UIImage!
    
    var score: Int {
        get{
            return _score
        }
    }
    
    var setsWon: Int {
        get{
            return _setsWon
        }
    }
    
    var firstName: String {
        get{
            return _firstName
        }
    }
    
    var lastName: String {
        get{
            return _lastName
        }
    }
    
    var image: UIImage {
        get{
            return _image
        }
    }
    
    init(firstName: String, lastName: String, score: Int, setsWon: Int, image: UIImage){
        self._firstName = firstName
        self._lastName = lastName
        self._score = score
        self._setsWon = setsWon
        self._image = image
    }
    
    func updateScore(_ amount: Int){
        self._score = self._score + amount
    }
    
    func resetScore(){
        self._score = 0
    }
    
    func updateSetsWon(){
        self._setsWon = self.setsWon + 1
    }
    
    func resetSets(){
        self._setsWon = 0
    }
    
}
