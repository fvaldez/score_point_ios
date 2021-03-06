//
//  BoardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/11/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit
import pop

class BoardVC: UIViewController, ResultsDelegate {

    @IBOutlet weak var txtFirstPlayer: UITextField!
    @IBOutlet weak var txtSecondPlayer: UITextField!
    @IBOutlet weak var turnSecondPlayerImg: UIImageView!
    @IBOutlet weak var turnFirstPlayerImg: UIImageView!
    @IBOutlet weak var colorSecondPlayer: UIView!
    @IBOutlet weak var colorFirstPlayer: UIView!
    
    @IBOutlet weak var scoreSecondPlayer: RoundView!
    @IBOutlet weak var scoreFirstPlayer: RoundView!
    
    @IBOutlet weak var txtScoreSecond: UILabel!
    @IBOutlet weak var txtScoreFirst: UILabel!
    
    @IBOutlet weak var txtSetsFirst: UILabel!
    @IBOutlet weak var txtSetsSecond: UILabel!
    @IBOutlet weak var setsViewfirst: RoundView!
    @IBOutlet weak var setsViewSecond: RoundView!
    
    @IBOutlet weak var lblSetup: UILabel!
    @IBOutlet weak var lblPTW: UILabel!
    
    @IBOutlet weak var serveFirst: UIImageView!
    
    @IBOutlet weak var serveSecond: UIImageView!
    var scoreFirst = 0
    var scoreSecond = 0
    
    var game: Game!
    var serveCount = 0
    
    @IBOutlet weak var secondPlayerNameView: RoundView!
    @IBOutlet weak var firstPlayerNameView: RoundView!
    var gameResults: GameResults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtScoreFirst.adjustsFontSizeToFitWidth = true
        txtScoreFirst.numberOfLines = 0
        
        txtScoreSecond.adjustsFontSizeToFitWidth = true
        txtScoreSecond.numberOfLines = 0
        
        let maskLayerFirst = CAShapeLayer()
        maskLayerFirst.path = UIBezierPath(roundedRect: colorFirstPlayer.bounds, byRoundingCorners: UIRectCorner.topLeft.union(.bottomLeft), cornerRadii: CGSize(width: 5, height: 5)).cgPath
        colorFirstPlayer.layer.mask = maskLayerFirst
      
        let maskLayerSecond = CAShapeLayer()
        maskLayerSecond.path = UIBezierPath(roundedRect: colorSecondPlayer.bounds, byRoundingCorners: UIRectCorner.topLeft.union(.bottomLeft), cornerRadii: CGSize(width: 5, height: 5)).cgPath
        colorSecondPlayer.layer.mask = maskLayerSecond
        
        lblSetup.text = "Setup: \(game.sets.shortString)"
        lblPTW.text = "Points to win: \(game.pointsPerSet)"
        txtFirstPlayer.text = "\(game.playerA.firstName) \(game.playerA.lastName)"
        txtSecondPlayer.text = "\(game.playerB.firstName) \(game.playerB.lastName)"
        addGestures()
        
        gameResults = Bundle.main.loadNibNamed("GameResults", owner: self, options: nil)?.first as? GameResults
        
        gameResults.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(gameResults)
        gameResults.alpha = 0
        gameResults.delegate = self
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":gameResults]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":gameResults]))
        gameResults.setup()
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }

    @IBAction func restartBtnPressed(_ sender: AnyObject) {
        game.clearAll()
        updateBoard(addPoint: false)
    }
    
    @IBAction func closeBtnPressed(_ sender: AnyObject) {
        game.clearAll()
        updateBoard(addPoint: false)
        self.dismiss(animated: true, completion: nil)

    }
    
    func closeResults(_ rematch: Bool) {
        
        game.clearAll()

        if(rematch == true){
            updateBoard(addPoint: false)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        closeResultsAnimation()
        
    }
    
    func closeResultsAnimation(){
        UIView.animate(withDuration: 0.4, animations: {
            self.gameResults.alpha = 0
        })
    }
    
    func respondToSwipeGestureFirst(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.down:
                if game.playerA.score > 0{
                    game.scoreUpdatePlayerA(-1)
                    updateBoard(addPoint: false)
                }
            case UISwipeGestureRecognizerDirection.left:
                if game.playerA.score > 0{
                    game.scoreUpdatePlayerA(-1)
                    updateBoard(addPoint: false)
                }
            default:
                break
            }
        }
        
    }
    
    func respondToSwipeGestureSecond(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
           
            case UISwipeGestureRecognizerDirection.down:
                if game.playerB.score > 0{
                    game.scoreUpdatePlayerB(-1)
                    updateBoard(addPoint: false)
                }
            case UISwipeGestureRecognizerDirection.left:
                if game.playerB.score > 0{
                    game.scoreUpdatePlayerB(-1)
                    updateBoard(addPoint: false)
                }

            default:
                break
            }
        }
    }

    func addGestures() {
        
        let swipeRightFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeRightFirst.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRightFirst)
        
        let swipeLeftFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeLeftFirst.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeftFirst)
        
        let swipeUpFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeUpFirst.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpFirst)
        
        let swipeDownFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeDownFirst.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDownFirst)
        
        scoreFirstPlayer.addGestureRecognizer(swipeRightFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeLeftFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeUpFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeDownFirst)
        
        let swipeRightSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeRightSecond.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRightSecond)
        
        let swipeLeftSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeLeftSecond.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeftSecond)
        
        let swipeUpSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeUpSecond.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpSecond)
        
        let swipeDownSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeDownSecond.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDownSecond)
        
        scoreSecondPlayer.addGestureRecognizer(swipeRightSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeLeftSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeUpSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeDownSecond)
        
        let tapFirst = UITapGestureRecognizer(target: self, action: #selector(BoardVC.addPointFirst))
        scoreFirstPlayer.addGestureRecognizer(tapFirst)
        
        let tapSecond = UITapGestureRecognizer(target: self, action: #selector(BoardVC.addPointSecond))
        scoreSecondPlayer.addGestureRecognizer(tapSecond)
        
        let tapServeFirst = UITapGestureRecognizer(target: self, action: #selector(BoardVC.toggleServe))
        colorFirstPlayer.addGestureRecognizer(tapServeFirst)
        
        let tapServeSecond = UITapGestureRecognizer(target: self, action: #selector(BoardVC.toggleServe))
        colorSecondPlayer.addGestureRecognizer(tapServeSecond)

    }
    
    func toggleServe(){

        if serveFirst.alpha == 0{
            
            UIView.animate(withDuration: 0.1, animations: {
                self.serveFirst.alpha = 1
                self.serveSecond.alpha = 0
            })
            
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                self.serveFirst.alpha = 0
                self.serveSecond.alpha = 1
            })
        }
    }
    
    func addPointFirst(){
        game.scoreUpdatePlayerA(1)
        updateBoard(addPoint: true)
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        txtScoreFirst.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")

    }
    
    func addPointSecond(){
        game.scoreUpdatePlayerB(1)
        updateBoard(addPoint: true)
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        txtScoreSecond.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func updateBoard(addPoint: Bool){
        if(addPoint == true){
            changeServe()
            
        }else{
            if(serveCount >= 0){
                serveCount = serveCount - 1
            }
        }
        txtScoreFirst.text = "\(game.playerA.score)"
        txtScoreSecond.text = "\(game.playerB.score)"
        txtSetsFirst.text = "\(game.playerA.setsWon)"
        txtSetsSecond.text = "\(game.playerB.setsWon)"
        lblPTW.text = "Points to win: \(game.pointsPerSet)"
        
        if(game.gameEnded == true){
            gameResults.photoView.image = game.winner.image
            gameResults.namelbl.text = "\(game.winner.firstName) \(game.winner.lastName)"
            UIView.animate(withDuration: 0.4, animations: {
                self.gameResults.alpha = 1
            })

        }
    }
    
    func changeServe(){
        serveCount = serveCount + 1
        
        if serveCount == 2 {
            if serveFirst.alpha == 0{
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.serveFirst.alpha = 1
                    self.serveSecond.alpha = 0
                })
                
            }else{
                UIView.animate(withDuration: 0.1, animations: {
                    self.serveFirst.alpha = 0
                    self.serveSecond.alpha = 1
                })
            }
            serveCount = 0
        }
    }
}
