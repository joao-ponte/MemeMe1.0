//
//  ViewController.swift
//  MemeMe1
//
//  Created by João Ponte on 11/04/2023.
//

import UIKit

class CreateEditMemeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerVIew: UIImageView!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let imageController = ImageController()
    var textController: TextController = TextController()
    let memesRepository = MemeRepository.shared
    var memeToEdit: Meme?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        #if targetEnvironment(simulator)
    // Code to be executed only in the simulator
            cameraButton.isEnabled = false
        #else
    // Code to be executed on a real device
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        #endif
            subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(textField: topText, text: "TOP")
        setupTextField(textField: bottomText, text: "BOTTOM")
        if let meme = memeToEdit {
            imagePickerVIew.image = meme.originalImage
            topText.text = meme.topText
            bottomText.text = meme.bottomText
        }
    }
    
    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = imageController
        switch sender {
        case cameraButton:
            imagePicker.sourceType = .camera
        default:
            imagePicker.sourceType = .photoLibrary
        }
        imageController.imageView = imagePickerVIew
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
        memesRepository.add(meme: meme)
        
    }
    
    func setupTextField(textField: UITextField, text: String) {
        textField.delegate = textController
        textField.defaultTextAttributes = textController.memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
        textField.tag = textField == topText ? 1 : 2
    }
}


