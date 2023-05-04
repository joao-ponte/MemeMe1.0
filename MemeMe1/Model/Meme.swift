//
//  Meme.swift
//  MemeMe1
//
//  Created by João Ponte on 29/04/2023.
//

import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.topText == rhs.topText &&
        lhs.bottomText == rhs.bottomText &&
        lhs.originalImage == rhs.originalImage &&
        lhs.memedImage == rhs.memedImage
    }
}

