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
    @IBOutlet weak var urlTextFiled: UITextField!
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var detectedFeeds: Dictionary<String, [String]>?
    
    var completionHandler: ((Dictionary<String, [String]>) -> Void)?

    deinit {
        self.webView!.removeObserver(self, forKeyPath: "loading", context: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = WKUserContentController();
        contentController.addUserScript(self.getUserScript("script"))
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: CGRectZero, configuration: config)

        self.containerView.addSubview(self.webView)
        
        self.webView!.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self.containerView, attribute: .Height, relatedBy: .Equal, toItem: self.webView, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.containerView, attribute: .Width, relatedBy: .Equal, toItem: self.webView, attribute: .Width, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self.containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self.webView, attribute: .Bottom, multiplier: 1, constant: 0)
        let left = NSLayoutConstraint(item: self.containerView, attribute: .Left, relatedBy: .Equal, toItem: self.webView, attribute: .Left, multiplier: 1, constant: 0)
        self.containerView.addConstraints([height, width, bottom, left])
        
        self.webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        
        let initUrl = "tut.by"
        self.urlTextFiled.text = initUrl
        self.webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://\(initUrl)")!))
        

        self.btnAdd.enabled = false;
        self.btnBack.enabled = false;
        self.btnForward.enabled = false;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "loading" && !self.webView.loading) {

            self.btnBack.enabled = self.webView.canGoBack
            self.btnForward.enabled = self.webView.canGoForward
            self.btnAdd.enabled = false;
            
            self.urlTextFiled.text = self.webView.URL?.absoluteString
            
            self.webView.evaluateJavaScript("getRssLinks(\'\(FeedType.kRSS)\', \'\(FeedType.kAtom)\')", completionHandler: { (result, error) in
                if (error == nil) {
                    if let resultDict: Dictionary<String, [String]> = result as? Dictionary {
                        print(resultDict)
                        self.detectedFeeds = resultDict
                        
//                        self.btnAdd.enabled = (!self.detectedFeeds![FeedType.kAtom]?.isEmpty || !self.detectedFeeds![FeedType.kRSS]?.isEmpty)
                        self.btnAdd.enabled = !((self.detectedFeeds![FeedType.kAtom]?.isEmpty)! && (self.detectedFeeds![FeedType.kRSS]?.isEmpty)!)

                    
                    } else {
                        self.detectedFeeds = nil
                    }
                } else {
                    debugPrint(error!)
                    self.detectedFeeds = nil
                }
                
                
            })
        }
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.webView.goBack()
    }
    @IBAction func onForward(sender: AnyObject) {
        self.webView.goForward()
    }
    @IBAction func onClose(sender: AnyObject? = nil) {
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
        if completionHandler != nil && self.detectedFeeds != nil {
            self.completionHandler!(self.detectedFeeds!)
        }
        
        
        self.onClose(nil)
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
    
    func getUserScript(jsFileName: String) -> WKUserScript {
        let path = NSBundle.mainBundle().pathForResource(jsFileName, ofType: "js")
        var scriptData: String
        do {
            scriptData = try String(contentsOfFile: path!)
        } catch {
            scriptData = ""
        }

        let userScript = WKUserScript(
            source: scriptData as String,
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: true
        )

        return userScript
    }


}
