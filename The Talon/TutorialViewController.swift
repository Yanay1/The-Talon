//
//  TutorialViewController.swift
//  The Talon
//
//  Created by Yanay Rosen on 12/24/15.
//  Copyright © 2015 Yanay Rosen. All rights reserved.
//
import UIKit

class TutorialViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    
    
    
    var tutorialURL : NSURL!
    
    var publishDate : String!
    
    var tutorialsButtonItem : UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        webview.hidden = true
        toolbar.hidden = true
        
        tutorialsButtonItem = UIBarButtonItem(title: "Tutorials", style: UIBarButtonItemStyle.Plain, target: self, action: "showTutorialsViewController")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleFirstViewControllerDisplayModeChangeWithNotification:"), name: "PrimaryVCDisplayModeChangeNotification", object: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if tutorialURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: tutorialURL)
            webview.loadRequest(request)
            
            if webview.hidden {
                webview.hidden = false
                toolbar.hidden = false
            }
            
            
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    func showTutorialsViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.integerValue
        
        if toolbar.items?.count == 3{
            toolbar.items?.removeAtIndex(0)
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            toolbar.items?.insert(tutorialsButtonItem, atIndex: 0)
        }
        else{
            toolbar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        }
    }
    
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
            
        }
        else if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Regular{
            if toolbar.items?.count == 3{
                toolbar.items?.removeAtIndex(0)
            }
            
            if splitViewController?.displayMode == UISplitViewControllerDisplayMode.PrimaryHidden {
                toolbar.items?.insert(tutorialsButtonItem, atIndex: 0)
            }
            else{
                toolbar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }
    }
    
    
    
    
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}

