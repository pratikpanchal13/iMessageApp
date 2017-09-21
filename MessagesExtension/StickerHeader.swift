//
//  StickerHeader.swift
//  iMessageApp
//
//  Created by indianic on 20/09/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class StickerHeader: UICollectionReusableView {
 
    var item  =  [String]()

    @IBOutlet var sectionTitle: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    func configure() {
//        self.sectionTitle.text = title
        
        
        let imagesPNGCount = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "ImagesPNG")
        let imagesGIFCount = Bundle.main.paths(forResourcesOfType: "gif", inDirectory: "ImagesGIF")
        let videoCount = Bundle.main.paths(forResourcesOfType: "mp4", inDirectory: "Videos")
        
        if (imagesPNGCount.count > 1){
            item.append("Stickers")
        }
        if (imagesGIFCount.count > 1){
            item.append("GIFs")
        }
        if (videoCount.count > 1){
            item.append("VIDEO")
        }
        
        
        // Initialize
        let customSC = UISegmentedControl(items: item)
        customSC.selectedSegmentIndex = 0
        
        // Set up Frame and SegmentedControl
        let frame = viewHeader.bounds
        customSC.frame = CGRect(x: 0 , y: 0 , width: viewHeader.frame.width * 0.6, height: 40)
//        customSC.center = viewHeader.center
        
        viewHeader.clipsToBounds = true
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor.black
        customSC.tintColor = UIColor.init(red: 113.0/255.0, green: 207.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        
        // Add target action method
        //        customSC.addTarget(self, action: #selector(MessagesViewController.changeColor(sender:)), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        viewHeader.addSubview(customSC)
    }
}

