//
//  UIViewController+Record.swift
//  GifMaker_Swift_Template
//
//  Created by JacobRakidzich on 7/22/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

// regift constants
let frameCount = 16
let delayTime: Float = 0.2
let loopCount = 0 // 0 = loop forever

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func launchVideCamer(sender: AnyObject) {
        // create image picker 
        let recordVideoController = UIImagePickerController()
        recordVideoController.sourceType = UIImagePickerControllerSourceType.camera
        recordVideoController.mediaTypes = [kUTTypeMovie as String]
        recordVideoController.allowsEditing = false // TODO: UPDATE TO TRUE
        recordVideoController.delegate = self
        
        present(recordVideoController, animated: true, completion: nil)
    }
    
    
    // MARK: ImagePickerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaURL] as! String
        
        if mediaType == kUTTypeMovie as String {
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            convertVideoToGif(videoURL: videoURL)
            //UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, nil, nil, nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Gif Conversion
    
    func convertVideoToGif(videoURL: URL) {
        let regift = Regift(sourceFileURL: videoURL, frameCount: frameCount, delayTime: delayTime)
        let gifURL = regift.createGif()
        let gif = Gif(url: gifURL!, videoURL: videoURL, caption: nil)
        displayGIF(gif: gif)
    }
    
    func displayGIF(gif: Gif) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        vc.gif = gif
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

