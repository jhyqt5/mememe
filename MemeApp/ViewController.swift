//
//  ViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/11/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeView: UIImageView!
    
    let picker = UIImagePickerController()
    
    @IBAction func getAlbum(sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func getCamera(sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    func setFont() {
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Futura-CondensedExtraBold", size: 30)!
        ]
        
        topTextField.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)!
        bottomTextField.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)!
        
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes:attributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes:attributes)
    }
    
    func dismissKeyboard () {
        view.endEditing(true)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setFont()
    }
    
    //MARK: Delegates
    func imagePickerController( picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        memeView.contentMode = .ScaleAspectFit
        memeView.image = selectedImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 0 {
            topTextField.placeholder = nil
        } else if textField.tag == 1 {
            bottomTextField.placeholder = nil
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
} //End View Controller

