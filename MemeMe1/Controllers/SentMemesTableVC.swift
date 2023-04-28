//
//  SentMemesTableVC.swift
//  MemeMe1
//
//  Created by João Ponte on 27/04/2023.
//

import UIKit

class SentMemesTableVC: UITableViewController {
    
    var memes: [ViewController.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
    }
    
    
    @IBAction func newMeme(_ sender: Any) {
    }
    
    
    @IBAction func editMeme(_ sender: Any) {
    }
    
    
    
}
