//
//  ImageController.swift
//  MemeMe1
//
//  Created by João Ponte on 11/04/2023.
//

import UIKit

class ImageController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView?.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
