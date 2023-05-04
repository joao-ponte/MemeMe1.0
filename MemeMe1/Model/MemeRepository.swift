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
}


