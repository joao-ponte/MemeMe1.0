//
//  SentMemesTableVC.swift
//  MemeMe1
//
//  Created by João Ponte on 27/04/2023.
//

import UIKit

class SentMemesTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme] {
        return MemeRepository.shared.getAll()
    }
    
    @IBOutlet var memedTV: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memedTV.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memedTV.dataSource = self
        memedTV.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemedTableViewCell", for: indexPath) as! MemedTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memedImageView.image = meme.memedImage
        cell.bottomText.text = meme.bottomText
        cell.topText.text = meme.topText
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let meme = memes[indexPath.row]
        MemeRepository.performActionOnMeme(meme, inViewController: self, atIndexPath: indexPath) {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
