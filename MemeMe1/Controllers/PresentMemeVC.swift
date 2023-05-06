//
//  PresentMemeVC.swift
//  MemeMe1
//
//  Created by João Ponte on 06/05/2023.
//

import UIKit

class PresentMemeVC: UIViewController {
    
    @IBOutlet weak var memedImage: UIImageView!
    
    var presentMeme: Meme?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let meme = presentMeme {
            memedImage.image = meme.memedImage
        }
    }
}
