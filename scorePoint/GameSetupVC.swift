//
//  GameSetupVC.swift
//  scorePoint
//
//  Created by Adriana Gonzalez on 3/10/16.
//  Copyright © 2016 Adriana Gonzalez. All rights reserved.
//

import UIKit

class GameSetupVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var logoback: UIView!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var firstPlayerImg: UIImageView!
    
    @IBOutlet weak var secondPlayerImg: UIImageView!
    
    @IBOutlet weak var gameToBtn: UIButton!
    
    @IBOutlet weak var setbtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titlelbl: UILabel!
    
    var pickerView: UIView!
    var picker: UIPickerView!
    var activePicker = 1

    
    let points = [11, 21]
    let sets = ["Single Set", "3 out of 5", "4 out of 7", "5 out of 9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstPlayerImg.layer.cornerRadius = firstPlayerImg.frame.size.width / 2
        firstPlayerImg.clipsToBounds = true

        secondPlayerImg.layer.cornerRadius = secondPlayerImg.frame.size.width / 2
        secondPlayerImg.clipsToBounds = true

       
        startBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5
        gameToBtn.layer.cornerRadius = 5
        setbtn.layer.cornerRadius = 5

        let attr = NSDictionary(object: UIFont(name: "Open Sans", size: 15.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject] , forState: .Normal)
        createPicker()

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
        close.action = Selector("closePicker")
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startBtnPressed(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("BoardVC")
        //self.navigationController?.pushViewController(vc, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

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
            
        }else{
            
            setbtn.setTitle("\(sets[row])", forState: .Normal)
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
            titleData = "\(sets[row])"
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
