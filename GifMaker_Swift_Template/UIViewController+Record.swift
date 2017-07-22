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
    
    @IBAction func launchVideCamer() {
        // create image picker 
        let recordVideoController = UIImagePickerController()
        recordVideoController.sourceType = UIImagePickerControllerSourceType.camera
        recordVideoController.mediaTypes = [kUTTypeMovie as String]
        recordVideoController.allowsEditing = false // TODO: UPDATE TO TRUE
        recordVideoController.delegate = self
        
        present(recordVideoController, animated: true, completion: nil)
    }
    
    @IBAction func presentVideoOptions() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            doPhotoLibrary()

        } else {
            let gifActionSheet = UIAlertController(title: "Create new Gif", message: nil, preferredStyle: .actionSheet)
            let recordVideo = UIAlertAction(title: "Record a Video", style: .default, handler: { (UIAlertAction) in
                self.launchVideCamer()
            })
            
            let chooseFromExisting = UIAlertAction(title: "Choose from Existing", style: .default, handler: { (UIAlertAction) in
                self.doPhotoLibrary()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            gifActionSheet.addAction(recordVideo)
            gifActionSheet.addAction(chooseFromExisting)
            gifActionSheet.addAction(cancel)
            present(gifActionSheet, animated: true, completion: nil)
            //adjust button colors in action sheet
            let pink = UIColor(red: 255.0/255.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1)
            gifActionSheet.view.tintColor = pink
            
        }
        
    }
    
    
    // MARK: Launch Photo Library
    
    func doPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    // MARK: ImagePickerDelegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        //let mediaType = info[UIImagePickerControllerMediaURL] as! String
        let mediaType = info[UIImagePickerControllerMediaType] as! String
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

