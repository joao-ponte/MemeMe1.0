//
//  SentMemesCollectionVC.swift
//  MemeMe1
//
//  Created by João Ponte on 27/04/2023.
//

import UIKit

class SentMemesCollectionVC: UICollectionViewController {
    
    var memes: [Meme]! {
        return MemeRepository.shared.getAll()
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let space:CGFloat = 5.0
        let dimension = (view.frame.size.width - ( 2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    @IBAction func newMeme(_ sender: Any) {
    }
    
    @IBAction func editMeme(_ sender: Any) {
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
