//
//  MemeController.swift
//  MemeMe1
//
//  Created by João Ponte on 12/04/2023.
//

import UIKit

class MemeController {
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
        
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        // Create the meme object
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerVIew.image!, memedImage: generateMemedImage())
        
        // Add meme to memes array in App Delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
}
