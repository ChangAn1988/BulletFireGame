//
//  ViewController.swift
//  TopeakTestGame
//
//  Created by 陳昶安 on 2017/7/27.
//  Copyright © 2017年 ChangAn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var planeUIView :UIView!
    
    var fullSize :CGSize!
    
    var bulletImage = UIImage(named: "missile1")
    
    var bulletCount = 100
    
    var bulletSpeeds = 1
    
    var autoFireStatus = false
    
    var timer:Timer!
    
    @IBOutlet weak var autoBtnSet: UIButton!
    
    @IBOutlet weak var planeImageView: UIImageView!
    
    @IBOutlet weak var bulletCountValue: UILabel!
    
    @IBOutlet weak var bulletImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoBtnSet.setImage(UIImage(named: "AutoFire")?.withRenderingMode(.alwaysOriginal), for: .application)
        
        // 取得螢幕的尺寸
        fullSize = UIScreen.main.bounds.size
        
        // 產生一個可供移動的 UIView
        planeUIView = UIView(frame: CGRect(
                                           x: fullSize.width * 0.5 - 40,
                                           y: fullSize.height * 0.5 + 90,
                                           width: 80,
                                           height: 101))
        
        planeUIView.backgroundColor = UIColor(patternImage: UIImage(named: "plane")!)
        
        self.view.addSubview(planeUIView)
        
        // 拖曳手勢
        let moveGesture = UIPanGestureRecognizer(
            target:self,
            action:#selector(self.gesture(recognizer:)))
        
        // 最少可以用幾指拖曳
        moveGesture.minimumNumberOfTouches = 1
        
        // 最多可以用幾指拖曳
        moveGesture.maximumNumberOfTouches = 1
        
        // 為這個可移動的 UIView 加上監聽手勢
        planeUIView.addGestureRecognizer(moveGesture)
        
        
    }
    
    // 觸發拖曳手勢後 執行的動作
    func gesture(recognizer:UIPanGestureRecognizer) {
        // 設置 UIView 新的位置
        let point = recognizer.location(in: self.view)
        planeUIView.center = point
    }
    

    
    @IBAction func select_Type1_Bullet_Btn(_ sender: Any) {
        
        bulletImage = UIImage(named: "missile1")
        bulletImageView.image = UIImage(named: "missile1")
        bulletSpeeds = 1
        
    }
    
    @IBAction func select_Type2_Bullet_Btn(_ sender: Any) {
        
        bulletImage = UIImage(named: "missile2")
        bulletImageView.image = UIImage(named: "missile2")
        bulletSpeeds = 3

    }
    
    @IBAction func select_Type3_Bullet_Btn(_ sender: Any) {
        
        bulletImage = UIImage(named: "missile3")
        bulletImageView.image = UIImage(named: "missile3")
        bulletSpeeds = 5
        
    }
    
    

    @IBAction func fireBtn(_ sender: Any) {
        
        self.fireStart()
        
    }
    
    @IBAction func autoBtn(_ sender: Any) {
        
        let auto = sender as! UIButton
        
        if autoFireStatus {
            
            auto.setImage(UIImage(named:"AutoFire"),for:UIControlState.normal)
            
            //設定按下按鈕未放開時按鈕的圖片
            //self.autoBtnSet.setImage(UIImage(named: "AutoFire")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
            self.autoFireStatus = false
            
            timer.invalidate()
            
            
        } else {
            
            auto.setImage(UIImage(named:"StopFire"),for:UIControlState.normal)
            
            //self.autoBtnSet.setImage(UIImage(named: "StopFire")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
            
            self.autoFireStatus = true
            
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                                           target:self,selector:#selector(ViewController.fireStart),
                                                           userInfo:nil,repeats:true)
            
            
        }
        
    }
    
    func fireStart() {
        
        let bullet = Bullet()
        
        bullet.fire(planeUIView_x: self.planeUIView.frame.origin.x,
                    planeUIView_y: self.planeUIView.frame.origin.y,
                    planeUIView_width: self.planeUIView.frame.size.width,
                    bulletView: UIImageView(image: bulletImage),
                    myView: self.view,
                    bulletSpeeds:self.bulletSpeeds)
        
        
        if self.bulletCount == 0 {
            
            self.bulletCount = 100
            
        } else {
            
            self.bulletCount -= 1
            
        }
        
        self.bulletCountValue.text = String(self.bulletCount)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
