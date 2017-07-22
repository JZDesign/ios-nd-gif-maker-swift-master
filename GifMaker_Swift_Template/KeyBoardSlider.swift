//
//  KeyBoardSlider.swift
//  GifMaker_Swift_Template
//
//  Created by JacobRakidzich on 7/22/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

//extension MemeViewController {

class KeyboardSlider: NSObject {
    
    // variables to hold and process information from the view using this class
    weak var view: UIView?
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        // selector method to move keyboard up
        view?.frame.origin.y = 0 - getKeyboardHeight(notification as Notification)
    }
    
    /*
     
     '''this function was choppy, even with a UIView animation'''
     
     func keyboardWillDissapear(_ notification: NSNotification) {
     view.frame.origin.y = 0
     }
     */
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        // get exact height of keyboard on all devices and convert to float value to return for use
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications(view: UIView) {
        // assigning view to class' counterpart
        self.view = view
        // when UIKeyboardWillShow do keyboardWillShow function
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
}









/*
 
 // udacity solution
 // Methods to adjust the keyboard
 extension GifEditorViewController {
 func subscribeToKeyboardNotifications() {
 NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GifEditorViewController.keyboardWillShow(_:)),
 name: UIKeyboardWillShowNotification,
 object: nil)
 NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GifEditorViewController.keyboardWillHide(_:)),
 name: UIKeyboardWillHideNotification,
 object: nil)
 }
 
 func unsubscribeFromKeyboardNotifications() {
 NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
 NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
 }
 
 func keyboardWillShow(notification: NSNotification) {
 if view.frame.origin.y >= 0 {
 view.frame.origin.y -= getKeyboardHeight(notification)
 }
 }
 
 func keyboardWillHide(notification: NSNotification) {
 if (self.view.frame.origin.y < 0) {
 view.frame.origin.y += getKeyboardHeight(notification)
 }
 }
 
 func getKeyboardHeight(notification: NSNotification) -> CGFloat {
 let userInfo = notification.userInfo
 let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
 return keyboardSize.CGRectValue().height
 }
 }
 
 */


