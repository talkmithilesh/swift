//
//  ViewController.swift
//  Test
//
//  Created by Mithilesh on 03/06/14.
//  Copyright (c) 2014 Mithilesh. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var flowers: NSArray = []
    var currentIndexPath: NSIndexPath = NSIndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Flowers"
        
        var error: NSError?
        var path: String? = NSBundle.mainBundle().pathForResource("flowers", ofType: "json")
        var data: NSData? = NSData.dataWithContentsOfFile(path, options: NSDataReadingOptions.DataReadingUncached, error: &error)
        if (data != nil) {
            self.flowers = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSArray
            //self.flowers = result
//            print(self.flowers.count)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellId") as UITableViewCell
        
        var flower: NSDictionary = self.flowers[indexPath.row] as NSDictionary
        cell.textLabel.text = flower["commonName"] as String
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.flowers.count
        //return 0;
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.currentIndexPath = indexPath
        self.performSegueWithIdentifier("showDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var destinationVC: DetailViewController = segue.destinationViewController as DetailViewController
        
        destinationVC.flower = self.flowers[self.currentIndexPath.row] as NSDictionary
    }
    
}

