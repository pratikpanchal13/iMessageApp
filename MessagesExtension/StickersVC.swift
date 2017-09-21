//
//  StickersVC.swift
//  iMessageApp
//
//  Created by indianic on 20/09/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StickersVC: UICollectionViewController {

    
    let interItemSpacing = 1.0 as CGFloat
    let interRowSpacing = 1.0 as CGFloat
    let sectionTitleKey = "SectionTitle"
    let sectionItemsKey = "Items"
//    var data = [Dictionary<String,AnyObject>]()
    
    var item  =  [String]()

    var stickrType : String = ""

    
    var data = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if item.contains("Stickers"){
            self.getStickers(objResourcesType: "png", objInDirectory: "ImagesPNG")
            return
        }
        
        if item.contains("GIFs"){
            self.getStickers(objResourcesType: "gif", objInDirectory: "ImagesGIF")
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(StickersVC.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        self.getStickers(objResourcesType: "png", objInDirectory: "ImagesPNG")

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    func methodOfReceivedNotification(notification: Notification){

        let stickers : String = notification.object as! String
        switch stickers {
        case "Stickers":
            self.getStickers(objResourcesType: "png", objInDirectory: "ImagesPNG")
                stickrType  = ".png"
                collectionView?.reloadData( )
            break
        case "GIFs":
            self.getStickers(objResourcesType: "gif", objInDirectory: "ImagesGIF")
            stickrType  = ".gif"
            collectionView?.reloadData()
            break
        case "VIDEO":
//            self.getStickersVideo(objResourcesType: "mp4", objInDirectory: "Videos")
            break
        default:
            break
        }
    }

    
    func getStickers(objResourcesType: String ,objInDirectory : String){
        self.data.removeAll()
        
        let imagesCount = Bundle.main.paths(forResourcesOfType: objResourcesType, inDirectory: objInDirectory)
        if imagesCount.count > 1
        {
            for i in 1...imagesCount.count {
                if let url = Bundle.main.url(forResource:  objInDirectory + "/img_\(i)", withExtension: objResourcesType) {
                    //            if let url = Bundle.main.url(forResource:  objInDirectory + "/\(objResourcesType)_\(i)", withExtension: objResourcesType) {
                    print("url is ",url)
                    do {
                        //                    let sticker = try MSSticker(contentsOfFileURL: url, localizedDescription: "")
                        let data : String  = objInDirectory + "/img_\(i)"
                        self.data.append(data)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : cellStickers = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! cellStickers
        let imageName = self.data[indexPath.row]
        cell.configure(usingImageName: imageName, ofTypeFormate: stickrType)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
