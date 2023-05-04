//
//  MemeRepository.swift
//  MemeMe1
//
//  Created by João Ponte on 29/04/2023.
//

import UIKit

class MemeRepository {
    private var memes: [Meme] = []
    static let shared = MemeRepository()
    private init() {}
    
    func getAll() -> [Meme] {
        memes
    }
    
    func add(meme: Meme) {
        memes.append(meme)
    }
    
    
    func deleteMeme(_ memeToDelete: Meme) {
        if let indexToDelete = memes.firstIndex(where: { $0 == memeToDelete }) {
            memes.remove(at: indexToDelete)
        }
    }
    
    static func performActionOnMeme(_ meme: Meme, inViewController viewController: UIViewController, atIndexPath indexPath: IndexPath, completion: (() -> Void)? = nil) {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            MemeRepository.shared.deleteMeme(meme)
            if let completion = completion {
                completion()
            } else {
                viewController.navigationController?.popViewController(animated: true)
            }
        }))

        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { action in
            let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
            viewController.present(activityViewController, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
            let createEditMemeVC = viewController.storyboard?.instantiateViewController(withIdentifier: "CreateEditMemeVC") as! CreateEditMemeVC
            createEditMemeVC.memeToEdit = meme
            viewController.navigationController?.pushViewController(createEditMemeVC, animated: true)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
    }
}

