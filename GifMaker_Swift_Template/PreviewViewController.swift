//
//  PreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by JacobRakidzich on 7/22/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    var gif: Gif?
    
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.image = gif?.gifImage
    }
    
    
    
    
    // MARK: Buttons
    
    @IBAction func doShareButton(_ sender: Any) {
        let url: URL = (self.gif?.url)!
        let animatedGIF = NSData(contentsOf: url)
        let itemsToShare = [animatedGIF]
        
        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func doSaveButton(_ sender: Any) {
    }

}
