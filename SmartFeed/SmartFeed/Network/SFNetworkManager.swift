//
//  SFNetworkManager.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/25/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import Alamofire
import AlamofireXmlToObjects

class SFNetworkManager {
    static let sharedInstatnce = SFNetworkManager()

    
    func feelFeedAtom(url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
        Alamofire.request(.GET, url).responseObject
            {(result: Result<SFFeedAtom, NSError>) -> Void in
                completionHandler(result: result.value, error: result.error)
        }
    }

    
//    func feelFeed<T: EVObject>(type: T.Type, url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
    
    func feelFeedRss(url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
        Alamofire.request(.GET, url).responseObject
            {(result: Result<SFRss, NSError>) -> Void in
                let feed = result.value?.channel
                if result.error == nil {
                    
                    if feed!.link == nil {
                        feed?.link = url
                    }
                    
                    //can improve with async; use completion block as param
                    feed!.feedId = SFModelManager.sharedInstatnce.updateFeedSync(feed!)
                    
                }
                
                completionHandler(result: feed, error: result.error)
        }
    }

}
