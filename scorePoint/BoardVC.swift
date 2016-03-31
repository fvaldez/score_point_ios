//
//  BoardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/11/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class BoardVC: UIViewController, ResultsDelegate {

    @IBOutlet weak var txtFirstPlayer: UITextField!
    @IBOutlet weak var txtSecondPlayer: UITextField!
    @IBOutlet weak var turnSecondPlayerImg: UIImageView!
    @IBOutlet weak var turnFirstPlayerImg: UIImageView!
    @IBOutlet weak var colorSecondPlayer: UIView!
    @IBOutlet weak var colorFirstPlayer: UIView!
    
    @IBOutlet weak var scoreSecondPlayer: UIView!
    @IBOutlet weak var scoreFirstPlayer: UIView!
    
    @IBOutlet weak var txtScoreSecond: UILabel!
    @IBOutlet weak var txtScoreFirst: UILabel!
    
    @IBOutlet weak var txtSetsFirst: UILabel!
    @IBOutlet weak var txtSetsSecond: UILabel!
    @IBOutlet weak var setsViewfirst: UIView!
    @IBOutlet weak var setsViewSecond: UIView!
    
    @IBOutlet weak var lblSetup: UILabel!
    @IBOutlet weak var lblPTW: UILabel!
    
    @IBOutlet weak var serveFirst: UIImageView!
    
    @IBOutlet weak var serveSecond: UIImageView!
    var scoreFirst = 0
    var scoreSecond = 0
    
    var game: Game!
    var serveCount = 0
    
    @IBOutlet weak var secondPlayerNameView: UIView!
    @IBOutlet weak var firstPlayerNameView: UIView!
    var gameResults: GameResults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let maskLayerFirst = CAShapeLayer()
        maskLayerFirst.path = UIBezierPath(roundedRect: colorFirstPlayer.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(5, 5)).CGPath
        colorFirstPlayer.layer.mask = maskLayerFirst
      
        let maskLayerSecond = CAShapeLayer()
        maskLayerSecond.path = UIBezierPath(roundedRect: colorSecondPlayer.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(5, 5)).CGPath
        colorSecondPlayer.layer.mask = maskLayerSecond
        
        
        firstPlayerNameView.layer.cornerRadius = 5
        firstPlayerNameView.clipsToBounds = true
        secondPlayerNameView.layer.cornerRadius = 5
        secondPlayerNameView.clipsToBounds = true

        
        scoreSecondPlayer.layer.cornerRadius = 5
        scoreSecondPlayer.clipsToBounds = true
        scoreFirstPlayer.layer.cornerRadius = 5
        scoreFirstPlayer.clipsToBounds = true
        setsViewfirst.layer.cornerRadius = 5
        setsViewfirst.clipsToBounds = true
        setsViewSecond.layer.cornerRadius = 5
        setsViewSecond.clipsToBounds = true
        
        
        lblSetup.text = "Setup: \(game.sets.shortString)"
        lblPTW.text = "Points to win: \(game.pointsPerSet)"
        txtFirstPlayer.text = "\(game.playerA.firstName)"
        txtSecondPlayer.text = "\(game.playerB.firstName)"
        addGestures()
        
        gameResults = NSBundle.mainBundle().loadNibNamed("GameResults", owner: self, options: nil).first as? GameResults
        
        gameResults.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(gameResults)
        gameResults.alpha = 0
        gameResults.delegate = self
        //self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":gameResults]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":gameResults]))
        gameResults.setup()

        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }

    @IBAction func restartBtnPressed(sender: AnyObject) {
        game.clearAll()
        updateBoard()
    }
    
    @IBAction func closeBtnPressed(sender: AnyObject) {
        game.clearAll()
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func closeResults(rematch: Bool) {
        
        game.clearAll()

        if(rematch == true){
            updateBoard()
        }else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        closeResultsAnimation()
        
    }
    
    func closeResultsAnimation(){
        UIView.animateWithDuration(0.4, animations: {
            self.gameResults.alpha = 0
        })
    }
    
    func respondToSwipeGestureFirst(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                game.scoreUpdatePlayerA(1)
                updateBoard()
            case UISwipeGestureRecognizerDirection.Down:
                if game.playerA.score > 0{
                    game.scoreUpdatePlayerA(-1)
                    updateBoard()
                }
            case UISwipeGestureRecognizerDirection.Left:
                if game.playerA.score > 0{
                    game.scoreUpdatePlayerA(-1)
                    updateBoard()
                }
             case UISwipeGestureRecognizerDirection.Up:
                    game.scoreUpdatePlayerA(1)
                    updateBoard()
            default:
                break
            }
        }
        
    }
    
    func respondToSwipeGestureSecond(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                game.scoreUpdatePlayerB(1)
                updateBoard()

            case UISwipeGestureRecognizerDirection.Down:
                if game.playerB.score > 0{
                    game.scoreUpdatePlayerB(-1)
                    updateBoard()

                }
            case UISwipeGestureRecognizerDirection.Left:
                if game.playerB.score > 0{
                    game.scoreUpdatePlayerB(-1)
                    updateBoard()

                }
            case UISwipeGestureRecognizerDirection.Up:
                game.scoreUpdatePlayerB(1)
                updateBoard()

            default:
                break
            }
        }
        
    }

    
    func addGestures() {
        
        let swipeRightFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeRightFirst.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightFirst)
        
        let swipeLeftFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeLeftFirst.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftFirst)
        
        let swipeUpFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeUpFirst.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpFirst)
        
        let swipeDownFirst = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureFirst(_:)))
        swipeDownFirst.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownFirst)
        
        scoreFirstPlayer.addGestureRecognizer(swipeRightFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeLeftFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeUpFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeDownFirst)
        
        let swipeRightSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeRightSecond.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightSecond)
        
        let swipeLeftSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeLeftSecond.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftSecond)
        
        let swipeUpSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeUpSecond.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpSecond)
        
        let swipeDownSecond = UISwipeGestureRecognizer(target: self, action: #selector(BoardVC.respondToSwipeGestureSecond(_:)))
        swipeDownSecond.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownSecond)
        
        scoreSecondPlayer.addGestureRecognizer(swipeRightSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeLeftSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeUpSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeDownSecond)

    }
    
    func updateBoard(){
        changeServe()
        txtScoreFirst.text = "\(game.playerA.score)"
        txtScoreSecond.text = "\(game.playerB.score)"
        txtSetsFirst.text = "\(game.playerA.setsWon)"
        txtSetsSecond.text = "\(game.playerB.setsWon)"
        lblPTW.text = "Points to win: \(game.pointsPerSet)"
        
        if(game.gameEnded == true){
            gameResults.photoView.image = game.winner.image
            gameResults.namelbl.text = "\(game.winner.firstName) \(game.winner.lastName)"
            UIView.animateWithDuration(0.4, animations: {
                self.gameResults.alpha = 1
            })

        }
    }
    
    func changeServe(){
        serveCount = serveCount + 1
        
        if serveCount == 2 {
            if serveFirst.alpha == 0{
                
                UIView.animateWithDuration(0.1, animations: {
                    self.serveFirst.alpha = 1
                    self.serveSecond.alpha = 0
                })
                
            }else{
                UIView.animateWithDuration(0.1, animations: {
                    self.serveFirst.alpha = 0
                    self.serveSecond.alpha = 1
                })
            }
            serveCount = 0

        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
