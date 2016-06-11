//
//  ViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/11/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func getAlbum(sender: AnyObject) {
        print("album")
    }
    
    @IBAction func getCamera(sender: AnyObject) {
        print("hello")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

