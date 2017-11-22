//
//  UIViewExt.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import UIKit

extension UIView {  //Extindem capabilitatile lui uiview
    
    func bindToKeyboard() { //observer sa vedem cand tastatura se ridica si o legam de buton
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)) , name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)  //in selector pune functia care o chemam cand vrem sa se intample bind to keyboard
        
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double //aceeasi duration ca si aceea a tastaturii sa se reidice
        let curve =  notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt //de la viteza mica la maxima ca si keyboaard
        let begininFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFramee = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFramee.origin.y - begininFrame.origin.y  //cat de intalta e tastatura

       
        UIView.animateKeyframes(withDuration: duration, delay: 0.0 , options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY  //miscam in sus view-ul cu cat e de mare tastatura
        }, completion: nil)
    }
    
}
