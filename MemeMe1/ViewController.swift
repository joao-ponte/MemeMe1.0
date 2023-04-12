//
//  ViewController.swift
//  MemeMe1
//
//  Created by João Ponte on 11/04/2023.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerVIew: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let imageController = ImageController()
    var textController: TextController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textController = TextController()
        topText.delegate = textController
        bottomText.delegate = textController
        topText.defaultTextAttributes = textController.memeTextAttributes
        bottomText.defaultTextAttributes = textController.memeTextAttributes
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topText.tag = 1
        bottomText.tag = 2
    }
    
    @IBAction func cameraImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imageController.imageView = imagePickerVIew
        imagePicker.delegate = imageController
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func libraryImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imageController.imageView = imagePickerVIew
        imagePicker.delegate = imageController
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        // Generate the memed image
        let memedImage = generateMemedImage()
        
        // Create an activity view controller
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // Define a completion handler for activity view controller
        activityViewController.completionWithItemsHandler = { (activityType, completed, returnedItems, error) in
            if completed {
                // Save the meme if the activity was completed
                self.saveMeme()
            }
        }
        
        // Present the activity view controller
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomText!.isEditing && view.frame.origin.y == 0 {
                let userInfo = notification.userInfo
                let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                let kbSize = keyboardSize.cgRectValue.height
                view.frame.origin.y -= kbSize
            }
        }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
        
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

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


