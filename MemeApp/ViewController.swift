//
//  ViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/11/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let attributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Futura-CondensedExtraBold", size: 30)!
    ]
    
    @IBOutlet var completeView: UIView!
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
    
    @IBAction func clearMeme(sender: AnyObject) {
        dismissKeyboard()
        
        topTextField.text = nil
        bottomTextField.text = nil
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes:attributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes:attributes)

        memeView.image = nil    
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
        
        
        //Adding shadow to font
        let txtFields = [topTextField, bottomTextField]
        
        for field in txtFields {
            field.layer.shadowOpacity = 1.0
            field.layer.shadowRadius = 1.0
            field.layer.shadowColor = UIColor.blackColor().CGColor
            field.layer.shadowOffset = CGSizeMake(1.0, -1.0)
        }
    }
    
    func dismissKeyboard () {
        view.endEditing(true)
        keyboardDisappears ()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        completeView.frame.origin.y = completeView.frame.origin.y - getKeyboardHeight(notification)
    }
    
    func keyboardDisappears () {
        completeView.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
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
            topTextField.placeholder = ""
        } else if textField.tag == 1 {
            bottomTextField.placeholder = ""
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 1 {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        keyboardDisappears()
        return true
    }
    
} //End View Controller

