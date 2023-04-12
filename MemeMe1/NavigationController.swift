//
//  NavigationController.swift
//  MemeMe1
//
//  Created by João Ponte on 11/04/2023.
//
//
//import UIKit
//
//class NavigationController: NSObject, UINavigationControllerDelegate {
//    
//    var view: UIView?
//    weak var viewController: UIViewController?
//    
//    @objc func keyboardWillShow(_ notification:Notification) {
//        guard let view = notification.object as? UIView else {
//            return
//        }
//        self.view = view
//        view.frame.origin.y -= getKeyboardHeight(notification)
//    }
//
//    @objc func keyboardWillHide(_ notification:Notification) {
//        guard let view = notification.object as? UIView else {
//            return
//        }
//        self.view = view
//        view.frame.origin.y = 0
//    }
//
//    
//    func subscribeToKeyboardNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: viewController)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: viewController)
//    }
//
//    
//    func unsubscribeFromKeyboardNotifications() {
//        
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        
//    }
//    
//    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
//
//        let userInfo = notification.userInfo
//        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
//        return keyboardSize.cgRectValue.height
//    }
//    
//}
