//
//  Bullet.swift
//  TopeakTestGame
//
//  Created by 陳昶安 on 2017/7/31.
//  Copyright © 2017年 ChangAn. All rights reserved.
//

import Foundation
import UIKit

struct Bullet {
    
    func fire(planeUIView_x : CGFloat, planeUIView_y : CGFloat, planeUIView_width : CGFloat, bulletView : UIImageView, myView : UIView, bulletSpeeds : Int) {
        
        bulletView.frame = CGRect(
            
            x: planeUIView_x + (planeUIView_width / 2) - 9 ,
            y: planeUIView_y - 40 ,
            width: 18,
            height: 40)
        
        myView.superview?.addSubview(bulletView)
        
        UIView.animate(
            
            withDuration: TimeInterval(bulletSpeeds),
            delay: 0,
            options: UIViewAnimationOptions.curveLinear,
            animations:
            {
                bulletView.frame = CGRect(x: planeUIView_x + (planeUIView_width / 2) - 9,
                                          y: 0,
                                          width: bulletView.frame.size.width,
                                          height: bulletView.frame.size.height)
            },
            completion: {
                
                result -> Void in
                
                bulletView.removeFromSuperview()
                
        })
        
    }
    
}
