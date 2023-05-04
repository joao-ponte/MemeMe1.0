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
        
        //        let layout = UICollectionViewFlowLayout()
        //               layout.itemSize = CGSize(width: view.frame.width / 3, height: view.frame.height / 3)
        //               collectionView.collectionViewLayout = layout
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        collectionView.collectionViewLayout = collectionViewFlowLayout
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
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(action) in MemeRepository.shared.deleteMeme(meme)
        
            collectionView.deleteItems(at: [indexPath])
        }))
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: {(action) in let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        present(alert, animated: true, completion: nil)
        
    }
}
