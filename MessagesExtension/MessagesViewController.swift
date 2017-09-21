//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by indianic on 20/09/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

    @IBOutlet var viewSegment: UIView!
    
    @IBOutlet weak var viewStickers: UIView!
    
    // MARK: - Variables
    var arrSticker :[MSSticker] = []
    var item  =  [String]()
    var isLoad: Bool = false
    var selectedType : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        if isLoad  == false
//        {
//            self.setUPSegementControlle()
//            self.view.layoutIfNeeded()
//            isLoad = true
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isLoad  == false
        {
            self.setUPSegementControlle()
            isLoad = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//            if isLoad  == false
//            {
//                self.setUPSegementControlle()
//                isLoad = true
//            }
    }
    
    
    func setUPSegementControlle()
    {
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
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: 0 , y: 0 , width: view.frame.width * 0.6, height: frame.height * 0.05)
        customSC.center = viewSegment.center
        
        
        
        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor.black
        customSC.tintColor = UIColor.init(red: 113.0/255.0, green: 207.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        
        // Add target action method
        customSC.addTarget(self, action: #selector(MessagesViewController.changeColor(sender:)), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        viewSegment.addSubview(customSC)
    }
    
    //MARK:- UISegmentedControl Selected Value
    func changeColor(sender: UISegmentedControl) {
        
        let title: String = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        switch title {
        case "Stickers":
            print("Stickers")
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: title)
            break
        case "GIFs":
            print("GIFS")
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: title)
            break
        case "VIDEO":
            print("VIDEOS")
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: title)
            break
        default:
            break
        }
        
    }
    
    private func update(selectedSections:[Int]) {
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(selectedSections, forKey: "selectedSections")
//        userDefaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        
        self.present(with: presentationStyle)
        
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.

        super.didTransition(to: presentationStyle)
        self.present(with: presentationStyle)
    }
   
    
    private func present(with presentationStyle:MSMessagesAppPresentationStyle) {
        // Remove any existing child controllers.
        let viewController:UIViewController
        switch presentationStyle {
        case .compact:
            viewController = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: String(describing: StickersVC.self)) as! StickersVC
            break
        case .expanded:
            viewController = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: String(describing: StickersVC.self)) as! StickersVC
            break
        }
            
        
//        for child in childViewControllers {
//            child.willMove(toParentViewController: nil)
//            child.view.removeFromSuperview()
//            child.removeFromParentViewController()
//        }
//        // Embed the new controller.
//        addChildViewController(viewController)
        
        viewController.view.frame = viewStickers.bounds
//        viewController.view.translatesAutoresizingMaskIntoConstraints = false
////        viewStickers.addSubview(viewController.view)
//        
//        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        viewController.didMove(toParentViewController: self)

        
       
        displayChildController(ChildVC: viewController, toViewController: self)
        if item.contains("Stickers"){
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: "Stickers")
            return
        }
        
        if item.contains("GIFs"){
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: "GIFs")
            return
        }

    }
    
    func displayChildController(ChildVC: UIViewController , toViewController  RootVC : UIViewController){
        
        RootVC.addChildViewController(ChildVC)
        viewStickers.addSubview(ChildVC.view)
        ChildVC.didMove(toParentViewController: RootVC)
    }
    
    func hideChildController(ChildVC: UIViewController) {
        ChildVC.willMove(toParentViewController: nil)
        ChildVC.view.removeFromSuperview()
        ChildVC.removeFromParentViewController()
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
