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
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - ( 2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemedCollectionViewCell", for: indexPath) as! MemedCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memedImageView.image = meme.memedImage
        
        return cell
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    
}
