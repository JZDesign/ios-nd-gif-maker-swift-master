//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by JacobRakidzich on 7/22/17.
//  Copyright © 2017 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var gifImageView: UIImageView!
    var gif: Gif?
    let keyboardSlider = KeyboardSlider()
    
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.image = gif?.gifImage
        keyboardSlider.subscribeToKeyboardNotifications(view: view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardSlider.unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Preview
    
    func doPreview() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as! PreviewViewController
        //self.gif?.caption = self.captionTextField.text!
        let regift = Regift.init(sourceFileURL: (gif?.url)!, frameCount: frameCount, delayTime: delayTime)
        let url = regift.createGif(caption: captionTextField.text, font: captionTextField.font)
        let newGif = Gif.init(url: url!, videoURL: (gif?.videoURL)!, caption: captionTextField.text)
        vc.gif = newGif
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // MARK: TextfieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO:
        textField.placeholder = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if view.frame.origin.y != 0 {
            // smooth animation to hide the keyboard in place of the observer
            // using the observer was choppy
            UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
            UIView.animate(withDuration: 0.2) {
                self.view.frame.origin.y = 0
            }
        }

        return true
    }
    
}
