//
//  DetailedTableMemeViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/13/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class DetailedTableMemeViewController: UIViewController {

    var meme: Meme?
    
    @IBOutlet weak var memeImage: UIImageView!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        memeImage.image = meme?.memedImage
    }
    
}
