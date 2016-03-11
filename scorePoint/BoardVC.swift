//
//  BoardVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/11/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class BoardVC: UIViewController {

    @IBOutlet weak var turnSecondPlayerImg: UIImageView!
    @IBOutlet weak var turnFirstPlayerImg: UIImageView!
    @IBOutlet weak var colorSecondPlayer: UIView!
    @IBOutlet weak var colorFirstPlayer: UIView!
    
    @IBOutlet weak var scoreSecondPlayer: UIView!
    @IBOutlet weak var scoreFirstPlayer: UIView!
    
    @IBOutlet weak var txtScoreSecond: UILabel!
    @IBOutlet weak var txtScoreFirst: UILabel!
    
    var scoreFirst = 0
    var scoreSecond = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maskLayerFirst = CAShapeLayer()
        maskLayerFirst.path = UIBezierPath(roundedRect: colorFirstPlayer.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(5, 5)).CGPath
        colorFirstPlayer.layer.mask = maskLayerFirst
      
        let maskLayerSecond = CAShapeLayer()
        maskLayerSecond.path = UIBezierPath(roundedRect: colorSecondPlayer.bounds, byRoundingCorners: UIRectCorner.TopLeft.union(.BottomLeft), cornerRadii: CGSizeMake(5, 5)).CGPath
        colorSecondPlayer.layer.mask = maskLayerSecond
        
        scoreSecondPlayer.layer.cornerRadius = 5
        scoreSecondPlayer.clipsToBounds = true
        scoreFirstPlayer.layer.cornerRadius = 5
        scoreFirstPlayer.clipsToBounds = true
        
        addGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }

    @IBAction func closeBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func respondToSwipeGestureFirst(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                scoreFirst++
            case UISwipeGestureRecognizerDirection.Down:
                if scoreFirst > 0{
                    scoreFirst--
                }
            case UISwipeGestureRecognizerDirection.Left:
                if scoreFirst > 0{
                    scoreFirst--
                }
             case UISwipeGestureRecognizerDirection.Up:
                scoreFirst++
            default:
                break
            }
        }
        
        txtScoreFirst.text = "\(scoreFirst)"
    }
    
    func respondToSwipeGestureSecond(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                scoreSecond++
            case UISwipeGestureRecognizerDirection.Down:
                if scoreSecond > 0{
                    scoreSecond--
                }
            case UISwipeGestureRecognizerDirection.Left:
                if scoreSecond > 0{
                    scoreSecond--
                }
            case UISwipeGestureRecognizerDirection.Up:
                scoreSecond++
            default:
                break
            }
        }
        
        txtScoreSecond.text = "\(scoreSecond)"
    }

    
    func addGestures() {
        
        let swipeRightFirst = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureFirst:")
        swipeRightFirst.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightFirst)
        
        let swipeLeftFirst = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureFirst:")
        swipeLeftFirst.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftFirst)
        
        let swipeUpFirst = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureFirst:")
        swipeUpFirst.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpFirst)
        
        let swipeDownFirst = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureFirst:")
        swipeDownFirst.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownFirst)
        
        scoreFirstPlayer.addGestureRecognizer(swipeRightFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeLeftFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeUpFirst)
        scoreFirstPlayer.addGestureRecognizer(swipeDownFirst)
        
        let swipeRightSecond = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureSecond:")
        swipeRightSecond.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRightSecond)
        
        let swipeLeftSecond = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureSecond:")
        swipeLeftSecond.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeftSecond)
        
        let swipeUpSecond = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureSecond:")
        swipeUpSecond.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpSecond)
        
        let swipeDownSecond = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGestureSecond:")
        swipeDownSecond.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownSecond)
        
        scoreSecondPlayer.addGestureRecognizer(swipeRightSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeLeftSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeUpSecond)
        scoreSecondPlayer.addGestureRecognizer(swipeDownSecond)

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
