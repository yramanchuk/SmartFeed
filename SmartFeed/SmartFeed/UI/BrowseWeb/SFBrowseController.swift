//
//  SFBrowseController.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit
import WebKit

class SFBrowseController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView = WKWebView()
        self.containerView.addSubview(self.webView)
        
        self.webView!.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self.webView, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.containerView, attribute: .Width, relatedBy: .Equal, toItem: self.webView, attribute: .Width, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self.containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.webView, attribute: .Bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: self.containerView, attribute: .Left, relatedBy: .Equal, toItem: self.webView, attribute: .Left, multiplier: 1, constant: 0)
        self.containerView.addConstraints([height, width, bottom, left])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject) {
    }
    @IBAction func onForward(sender: AnyObject) {
    }
    @IBAction func onClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func urlWasSet(sender: AnyObject) {
        let tv = sender as! UITextField;
        let url = tv.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if url.characters.count > 0 {
            self.webView.stopLoading()
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://\(url)")!))
        }
        
        
    }

    @IBAction func onAdd(sender: AnyObject) {
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
