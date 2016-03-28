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
    var webView: WKWebView?

    var article: SFArticle! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let article = self.article {
            if let wv = self.webView {
                let req = NSURLRequest(URL:NSURL(string:article.linkURL!)!)
                wv.loadRequest(req)
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = WKWebView(frame: self.view.frame)
        self.containerView.addSubview(self.webView!)
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

