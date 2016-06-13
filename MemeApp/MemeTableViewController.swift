//
//  MemeTableViewController.swift
//  MemeApp
//
//  Created by Daniel Huang on 6/12/16.
//  Copyright © 2016 Daniel Huang. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath)
        
        cell.imageView!.image = memes[indexPath.row].memedImage
        
        return cell
    } // end function


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
