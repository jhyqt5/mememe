//
//  ViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/11/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var memedImageView: UIView!
    @IBOutlet var completeView: UIView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeView: UIImageView!
    
    
    let picker = UIImagePickerController()
    var activityViewController: UIActivityViewController?
    let attributes = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "Futura-CondensedExtraBold", size: 30)!
    ]
    
    //Open Photo Library
    @IBAction func getAlbum(sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    //Open Camera (does not work with simulator)
    @IBAction func getCamera(sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    //Cancel and clear image and text
    @IBAction func clearMeme(sender: AnyObject) {
        //if keyboard is shown, hide it.
        dismissKeyboard()
        
        //Clear text and replace placeholder and clear image
        topTextField.text = nil
        bottomTextField.text = nil
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes:attributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes:attributes)
        memeView.image = nil
    }
    
    //Generate, save, and share meme
    @IBAction func saveShare(sender: AnyObject) {
        //save image
        let generatedMemeImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, botText: bottomTextField.text!, image: memeView.image!, memedImage: generatedMemeImage)
        
        
        // share image
        let activityViewController = UIActivityViewController( activityItems: [meme.memedImage as UIImage], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    //generate the meme
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(completeView.frame.size)
        memedImageView.drawViewHierarchyInRect(memedImageView.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    //setting the font attributes
    func setFont() {
        //setting font and size
        topTextField.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)!
        bottomTextField.font = UIFont(name: "Futura-CondensedExtraBold", size: 30)!
        
        //placeholder fonts and attributes
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes:attributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes:attributes)
        
        
        //Adding shadow/outline to font
        let txtFields = [topTextField, bottomTextField]
        
        for field in txtFields {
            field.layer.shadowOpacity = 1.0
            field.layer.shadowRadius = 1.0
            field.layer.shadowColor = UIColor.blackColor().CGColor
            field.layer.shadowOffset = CGSizeMake(2.0, -2.0)
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
        
        #if arch(i386) || arch(x86_64)
            camera.enabled = false
        #endif
            
        
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


struct Meme {
    let topText: String
    let botText: String
    let image: UIImage
    let memedImage: UIImage
}

