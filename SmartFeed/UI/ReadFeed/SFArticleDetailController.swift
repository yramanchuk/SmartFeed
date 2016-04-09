//
//  SFArticleDetailController.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/24/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import UIKit
import WebKit

class SFArticleDetailController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var webView: WKWebView!
    var readability: DZReadability?


    var article: SFArticleProtocol! {
        didSet {
            // Update the view.
            self.configureView()
            SFModelManager.sharedInstance.setReadArticleSync(article.linkURL!, isNew: false)
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if (self.article) != nil {
            if let wv = self.webView {
////                let req = NSURLRequest(URL:NSURL(string:"http://www.readability.com/m?url=\(article.linkURL!)")!)
//                wv.loadRequest(req)

                self.readability = DZReadability.init(URLToDownload: NSURL(string: article.linkURL!), options: nil, completionHandler: { (sender, content, error) in
                    if content != nil {
                        wv.loadHTMLString(content, baseURL: nil)
                    } else {
                        wv.loadHTMLString("<h1>Can not display content</h1>", baseURL: nil)
                    }
                })
                self.readability?.start()

            }

            self.title = article.title

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initWebView()
        
        self.configureView()
        
        self.webView!.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
    }
    
    func initWebView() {
        
        let contentController = WKUserContentController();
//        contentController.addUserScript(self.getUserScript("readability"))
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        self.containerView.addSubview(self.webView!)
        
        self.webView!.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self.webView!, attribute: .Height, relatedBy: .Equal, toItem: self.containerView, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self.webView!, attribute: .Width, relatedBy: .Equal, toItem: self.containerView, attribute: .Width, multiplier: 1, constant: 0)
        self.containerView.addConstraints([height, width])

    }
    
//    func getUserScript(jsFileName: String) -> WKUserScript {
//        let path = NSBundle.mainBundle().pathForResource(jsFileName, ofType: "js")
//        var scriptData: String
//        do {
//            scriptData = try String(contentsOfFile: path!)
//        } catch {
//            scriptData = ""
//        }
//        
//        let userScript = WKUserScript(
//            source: scriptData as String,
//            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
//            forMainFrameOnly: true
//        )
//
//        return userScript
//    }
    
    deinit {
        self.webView!.removeObserver(self, forKeyPath: "loading", context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "loading" && !self.webView!.loading) {
            debugPrint("loaded")
        }
    }


}

