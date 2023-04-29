//
//  SentMemesTableVC.swift
//  MemeMe1
//
//  Created by João Ponte on 27/04/2023.
//

import UIKit

class SentMemesTableVC: UITableViewController {
    
    var memes: [Meme] {
        return MemeRepository.shared.getAll()
    }
    
    
    @IBAction func newMeme(_ sender: Any) {
    }
    
    
    @IBAction func editMeme(_ sender: Any) {
    }
    
    
    
}
