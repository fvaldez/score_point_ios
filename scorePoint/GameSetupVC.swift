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
        gameVC = storyboard.instantiateViewController(withIdentifier: "BoardVC") as! BoardVC
        
        setsSelected = sets[0]
        playerA = Player(firstName: SharedData.sharedInstance.firstName, lastName: SharedData.sharedInstance.lastName, score: 0, setsWon: 0, image: SharedData.sharedInstance.downloadedImg!)
        playerB = Player(firstName: "Other", lastName: "Player", score: 0, setsWon: 0, image: UIImage(named: "placeholder")!)

        if(sendingRequest == true) {
            startBtn.setTitle("SEND", for: UIControlState())
        }else{
            gameToBtn.isUserInteractionEnabled = false
            setbtn.isUserInteractionEnabled = false
            startBtn.setTitle("START", for: UIControlState())
        }

        let attr = NSDictionary(object: UIFont(name: "Open Sans", size: 15.0)!, forKey: NSFontAttributeName as NSCopying)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as? [AnyHashable: Any] , for: UIControlState())
        createPicker()
        
        self.animEngine = AnimationEngine(constraints: [firstPlayerConstraint, secondPlayerConstraint])
        
        firstPlayerImg.image = SharedData.sharedInstance.downloadedImg
        firstPlayerLbl.text = "\(SharedData.sharedInstance.firstName) \(SharedData.sharedInstance.lastName)"
    

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.animEngine.animateOnScreen(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func createPicker(){
        
        pickerView = UIView(frame:CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 200))
        pickerView.backgroundColor = UIColor.white
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
        picker.delegate = self
        picker.dataSource = self
        picker.tintColor = GREEN_COLOR
        pickerView.addSubview(picker)
        self.view.addSubview(pickerView)
        
        let toolbar = UIToolbar()
        toolbar.barTintColor = LIGHT_GRAY
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44)
        
        
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

        UIView.animate(withDuration: 0.2, animations: {
            
            self.pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 200)
            }, completion: {
                (value: Bool) in
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.titlelbl.alpha = 1

                    }, completion: {
                        (value: Bool) in
                })
        })
    }

    @IBAction func startBtnPressed(_ sender: AnyObject) {
        
        if(sendingRequest == true){
            let delay = 0.3 * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) {
                
                self.dismiss(animated: true, completion: {
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.showAlert("Match request sent", vc: self)
                    }
                )
            }
        }else{
            game = Game(date: Date(), pointsPerSet: selectedPoints, sets: setsSelected , playerA: playerA, playerB: playerB)
            
            gameVC.game = game
            //self.navigationController?.pushViewController(vc, animated: true)
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
            let delay = 0.3 * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) {
                DispatchQueue.main.async { [unowned self] in
                    self.present(self.gameVC, animated: true, completion: nil)
                }
            }

        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        
        let delay = 0.3 * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.dismiss(animated: true, completion: nil)
        }


    }
    
    @IBAction func setupBtnPressed(_ sender: AnyObject) {
        if(sender.tag == 1) {
            activePicker = 1
        }else{
            activePicker = 2
        }
        titlelbl.alpha = 0
        
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: false)
        scrollView.setContentOffset(CGPoint(x: 0, y: 80), animated: true)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.frame.size.height-200, width: self.view.frame.size.width, height: 200)
            }, completion: nil)

    }
    
    //MARK: - PickerView delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(activePicker == 1){
            return points.count
        }else {
            return sets.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(activePicker == 1){
            
            gameToBtn.setTitle("Game to \(points[row])", for: UIControlState())
            selectedPoints = points[row]
            
        }else{
            
            setbtn.setTitle("\(sets[row].stringToShow)", for: UIControlState())
            setsSelected = sets[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
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
        pickerLabel!.textAlignment = .center
        return pickerLabel!
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width
    }

    
}
