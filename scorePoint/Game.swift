//
//  Game.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/29/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import Foundation

class Game {
    
    private var _date: NSDate
    private var _pointsPerSet = 0
    private var _totalSets = 0
    private var _setsToWin = 0
    private var _sets: SetType!
    private var _playerA: Player
    private var _playerB: Player
    private var _winner: Player?
    private var _originalPointsPerSet = 0
    private var _gameEnded = false

    var pointsPerSet: Int{
        get {
            return _pointsPerSet
        }
    }
    
    var winner: Player{
        get {
            return _winner!
        }
    }
    
    var gameEnded: Bool{
        get {
            return _gameEnded
        }
    }
    
    
    var sets: SetType{
        get {
            return _sets
        }
    }
    
    var originalPointsPerSet: Int{
        get {
            return _originalPointsPerSet
        }
    }
    
    var playerA: Player{
        get {
            return _playerA
        }
    }

    
    var playerB: Player{
        get {
            return _playerB
        }
    }

    
    init(date: NSDate, pointsPerSet: Int, sets: SetType, playerA: Player, playerB: Player){
        self._date = date
        self._pointsPerSet = pointsPerSet
        self._totalSets = sets.totalSets
        self._setsToWin = sets.setsToWin
        self._sets = sets
        self._playerA = playerA
        self._playerB = playerB
        self._originalPointsPerSet = pointsPerSet
    }
    
    func scoreUpdatePlayerA(amount: Int){
        // Add 1 point to Player A
        self._playerA.updateScore(amount)
        print("Score A: \(self._playerA.score)   Score B: \(self._playerB.score)")
        
        checkForTie()
        if (checkForEndOfSet() == true){
            if checkForEndOfGame() == true {
                endGame()
            }
        }
        


    }
    
    func scoreUpdatePlayerB(amount: Int){
        // Add 1 point to Player b
        self._playerB.updateScore(amount)
        print("Score A: \(self._playerA.score)   Score B: \(self._playerB.score)")
        
        checkForTie()
        if (checkForEndOfSet() == true){
            if checkForEndOfGame() == true {
                endGame()
            }
        }

    }
    
    func checkForTie() -> Bool{
        if self._playerA.score == _pointsPerSet - 1 && self._playerB.score == _pointsPerSet - 1 {
            // There is a tie, looking for a two point difference
            _pointsPerSet = _pointsPerSet + 1
            print("There is a tie, looking for a two point difference")
            return true
        }else{
            return false
        }
    }
    
    func checkForEndOfSet() -> Bool{
        if self._playerA.score == self._pointsPerSet{
            // Player A won the set
            self._playerA.updateSetsWon()
            self._playerA.resetScore()
            self._playerB.resetScore()
            self._pointsPerSet = originalPointsPerSet
            print("Player A won the set, currently has \(self._playerA.setsWon) sets won")
            return true
        }else if  self._playerB.score == self._pointsPerSet{
            // Player B won the set
            self._playerB.updateSetsWon()
            self._playerA.resetScore()
            self._playerB.resetScore()
            self._pointsPerSet = originalPointsPerSet

            print("Player B won the set, currently has \(self._playerB.setsWon) sets won")
            return true
        }else{
            return false
        }
    }
    
    func checkForEndOfGame() -> Bool {
        if self._playerA.setsWon == self._setsToWin{
            // Player A won the game
            self._winner = self._playerA
            //self._playerA.resetSets()
            //self._playerB.resetSets()
            self._gameEnded = true
            print("Player A won the game")
            return true
        }else if self._playerB.setsWon == self._setsToWin{
            // Player B won the game
            self._winner = self._playerB
            //self._playerA.resetSets()
            //self._playerB.resetSets()
            self._gameEnded = true
            print("Player B won the game")
            return true
        }else{
            return false
        }
    }
    
    func endGame() {
        print("Game has ended")
    }
    
    func clearAll(){
        self._gameEnded = false
        self._playerA.resetScore()
        self._playerB.resetScore()
        self._playerA.resetSets()
        self._playerB.resetSets()
    }
    
    
}