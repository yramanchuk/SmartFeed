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

    
    
    func feelFeedRss(url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
        Alamofire.request(.GET, url).responseObject
            {(result: Result<SFRss, NSError>) -> Void in
                if result.error == nil {
                    SFModelManager.sharedInstatnce.updateFeedAsync((result.value?.channel)!)

                }
                
                completionHandler(result: result.value?.channel, error: result.error)
        }
    }

}
