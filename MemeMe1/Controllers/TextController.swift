//
//  TextController.swift
//  MemeMe1
//
//  Created by João Ponte on 11/04/2023.
//

import UIKit

class TextController: NSObject, UITextFieldDelegate {
        
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(-5.0)
    ]
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 && textField.text == "TOP" {
            textField.text = ""
        } else if textField.tag == 2 && textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupTextField(_ textField: UITextField, withText text: String, tag: Int) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
        textField.tag = tag
    }
}





