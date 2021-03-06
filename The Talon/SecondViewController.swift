//
//  SecondViewController.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/24/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController, XMLParserDelegate {
    
    
    
    
    var xmlParser : XMLParser!
    
   
    @IBOutlet weak var navigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationBar.title = "Loading"
        let url = NSURL(string: "http://twitrss.me/twitter_user_to_rss/?user=shstalon")
        xmlParser = XMLParser()
        xmlParser.delegate = self
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), {
            self.xmlParser.startParsingWithContentsOfURL(url!)
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: XMLParserDelegate method implementation
    
    func parsingWasFinished() {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
             self.navigationBar.title = "The Talon"
        })
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlParser.arrParsedData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCell", forIndexPath: indexPath)
        
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel?.text = currentDictionary["title"]
        cell.detailTextLabel?.text = currentDictionary["pubDate"]
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let tutorialLink = dictionary["link"]
        let publishDate = dictionary["pubDate"]
        
        let tutorialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idTutorialViewController") as! TutorialViewController
        
        tutorialViewController.tutorialURL = NSURL(string: tutorialLink!)
        tutorialViewController.publishDate = publishDate
        
        showDetailViewController(tutorialViewController, sender: self)
        
    }
    
}

