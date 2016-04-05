//
//  GameSetupVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

struct SetType {
    var stringToShow: String
    var totalSets: Int
    var setsToWin: Int
    var shortString: String
}

class GameSetupVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var logoback: UIView!
    @IBOutlet weak var firstPlayerImg: UIImageView!
    @IBOutlet weak var secondPlayerImg: UIImageView!
    @IBOutlet weak var gameToBtn: UIButton!
    @IBOutlet weak var setbtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var firstPlayerConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondPlayerConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstPlayerLbl: UILabel!
    @IBOutlet weak var secondPlayerLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    
    var sendingRequest = true
    
    var animEngine: AnimationEngine!

    var pickerView: UIView!
    var picker: UIPickerView!
    var activePicker = 1

    var game: Game!
    let points = [11, 21]
    
    let sets = [SetType(stringToShow: "Single Set", totalSets: 1, setsToWin: 1, shortString: "Single"),
                SetType(stringToShow: "3 out of 5", totalSets: 5, setsToWin: 3, shortString: "3/5"),
                SetType(stringToShow: "4 out of 7", totalSets: 7, setsToWin: 4, shortString: "4/7"),
                SetType(stringToShow: "5 out of 9", totalSets: 9, setsToWin: 5, shortString: "5/9")]
    
    var selectedPoints = 11
    var setsSelected: SetType!
    
    var playerA: Player!
    var playerB: Player!
    
    var gameVC: BoardVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        gameVC = storyboard.instantiateViewControllerWithIdentifier("BoardVC") as! BoardVC
        
        setsSelected = sets[0]
        playerA = Player(firstName: SharedData.sharedInstance.firstName, lastName: SharedData.sharedInstance.lastName, score: 0, setsWon: 0, image: SharedData.sharedInstance.downloadedImg!)
        playerB = Player(firstName: "Other", lastName: "Player", score: 0, setsWon: 0, image: UIImage(named: "placeholder")!)

        firstPlayerImg.layer.cornerRadius = firstPlayerImg.frame.size.width / 2
        firstPlayerImg.clipsToBounds = true

        secondPlayerImg.layer.cornerRadius = secondPlayerImg.frame.size.width / 2
        secondPlayerImg.clipsToBounds = true
       
        gameToBtn.layer.cornerRadius = 5
        setbtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5
        startBtn.layer.cornerRadius = 5
        
        if(sendingRequest == true) {
            startBtn.setTitle("SEND", forState: .Normal)
        }else{
            gameToBtn.userInteractionEnabled = false
            setbtn.userInteractionEnabled = false
            startBtn.setTitle("START", forState: .Normal)
        }

        let attr = NSDictionary(object: UIFont(name: "Open Sans", size: 15.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , forState: .Normal)
        createPicker()
        
        self.animEngine = AnimationEngine(constraints: [firstPlayerConstraint, secondPlayerConstraint])
        
        firstPlayerImg.image = SharedData.sharedInstance.downloadedImg
        firstPlayerLbl.text = "\(SharedData.sharedInstance.firstName) \(SharedData.sharedInstance.lastName)"
    

    }
    
    override func viewDidAppear(animated: Bool) {
        self.animEngine.animateOnScreen(0)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func createPicker(){
        
        pickerView = UIView(frame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200))
        pickerView.backgroundColor = UIColor.whiteColor()
        
        picker = UIPickerView(frame: CGRectMake(0, 0, 320, 200))
        picker.delegate = self
        picker.dataSource = self
        picker.tintColor = GREEN_COLOR
        pickerView.addSubview(picker)
        self.view.addSubview(pickerView)
        
        let toolbar = UIToolbar()
        toolbar.barTintColor = LIGHT_GRAY
        toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44)
        
        
        let close = UIBarButtonItem()
        close.title = "Close"
        close.tintColor = GREEN_COLOR
        close.target = self
        close.action = #selector(GameSetupVC.closePicker)
        
        let toolbarButtonItems = [
            close
        ]
        toolbar.setItems(toolbarButtonItems, animated: true)
        
        pickerView.addSubview(toolbar)
        
        
    }
    
    func closePicker(){
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        UIView.animateWithDuration(0.2, animations: {
            
            self.pickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.2, animations: {
                    
                    self.titlelbl.alpha = 1

                    }, completion: {
                        (value: Bool) in
                })
        })
    }

    @IBAction func startBtnPressed(sender: AnyObject) {
        
        if(sendingRequest == true){
            let delay = 0.3 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                
                self.dismissViewControllerAnimated(true, completion: {
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.showAlert("Match request sent", vc: self)
                    }
                )
            }
        }else{
            game = Game(date: NSDate(), pointsPerSet: selectedPoints, sets: setsSelected , playerA: playerA, playerB: playerB)
            
            gameVC.game = game
            //self.navigationController?.pushViewController(vc, animated: true)
            UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
            let delay = 0.3 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    self.presentViewController(self.gameVC, animated: true, completion: nil)
                }
            }

        }
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }


    }
    
    @IBAction func setupBtnPressed(sender: AnyObject) {
        if(sender.tag == 1) {
            activePicker = 1
        }else{
            activePicker = 2
        }
        titlelbl.alpha = 0
        
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: {
            self.pickerView.frame = CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)
            }, completion: nil)

    }
    
    //MARK: - PickerView delegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(activePicker == 1){
            return points.count
        }else {
            return sets.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(activePicker == 1){
            
            gameToBtn.setTitle("Game to \(points[row])", forState: .Normal)
            selectedPoints = points[row]
            
        }else{
            
            setbtn.setTitle("\(sets[row].stringToShow)", forState: .Normal)
            setsSelected = sets[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView{
        
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
        }
        let titleData: String!
        if(activePicker == 1){
            titleData = "Game to \(points[row])"
        }else {
            titleData = "\(sets[row].stringToShow)"
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Open Sans", size: 15.0)!,NSForegroundColorAttributeName:BLACK_COLOR])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width
    }

    
}
