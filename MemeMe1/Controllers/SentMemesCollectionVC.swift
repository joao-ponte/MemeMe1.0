//
//  SentMemesCollectionVC.swift
//  MemeMe1
//
//  Created by João Ponte on 27/04/2023.
//

import UIKit

class SentMemesCollectionVC: UICollectionViewController {
    
    var memes: [ViewController.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
        
    }
}
