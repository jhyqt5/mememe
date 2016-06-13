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
    
    var selectedMeme: Meme?
    
    @IBOutlet weak var memeTable: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell", forIndexPath: indexPath)
        
        cell.imageView!.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = memes[indexPath.row].topText
        cell.detailTextLabel?.text = memes[indexPath.row].botText
        return cell
    } // end function

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedMeme = memes[indexPath.row]
        performSegueWithIdentifier("showTableDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTableDetail" {
            let vc = segue.destinationViewController as! DetailedTableMemeViewController
            vc.meme = selectedMeme
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memeTable.reloadData()
    }
}
