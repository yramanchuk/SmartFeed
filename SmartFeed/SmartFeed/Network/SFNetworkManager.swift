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

    
    func feelFeed(feed: SFFeed, completionHandler: (Result<SFFeed, NSError>) -> Void) {
        Alamofire.request(.GET, feed.url).responseObject
            {(result: Result<SFFeed, NSError>) -> Void in
//                print(result)
//                switch result {
//                case .Success:
//                    debugPrint("feed: \(result.value)\n")
//                    completionHandler(result)
//                case .Failure(let error):
//                    print("\(error)\n")
//                }
                completionHandler(result)
        }
    }

}
