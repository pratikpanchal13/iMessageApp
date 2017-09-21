//
//  cellStickers.swift
//  iMessageApp
//
//  Created by indianic on 20/09/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Messages

class cellStickers: UICollectionViewCell {
    
    @IBOutlet weak var stickerView: MSStickerView!
    
    func configure(usingImageName imageName:String , ofTypeFormate : String) {
        
        
            guard let imagePath = Bundle.main.path(forResource: imageName, ofType: ofTypeFormate) else {
                return
            }
            let path =  URL(fileURLWithPath: imagePath)
            do {
                let description = NSLocalizedString("Food Sticker", comment: "")
                let sticker = try MSSticker(contentsOfFileURL: path , localizedDescription: description)
                stickerView.sticker = sticker
            }
            catch {
                fatalError("Failed to create sticker: \(error)")
            }
    
    }
}
