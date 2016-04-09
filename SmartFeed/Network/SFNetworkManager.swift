//
//  SFNetworkManager.swift
//  SmartFeed
//
//  Created by Yury Ramanchuk on 3/25/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

import Alamofire
import AlamofireXmlToObjects
import EVReflection
import XMLDictionary

class SFNetworkManager {
    static let sharedInstance = SFNetworkManager()

    
    func feelFeedAtom(url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
        Alamofire.request(.GET, url).responseObject
            {(result: Result<SFFeedAtom, NSError>) -> Void in
                completionHandler(result: result.value, error: result.error)
        }
    }

    
//    func feelFeed<T: EVObject>(type: T.Type, url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
    func feelFeedRss(url: String, completionHandler: (result: SFFeed?, error: NSError?) -> Void) {
        debugPrint("test: \(isTestMode)")
        
        if !isTestMode {
            Alamofire.request(.GET, url).responseObjectCustom
                {(result: Result<SFRss, NSError>) -> Void in
                    let feed = result.value?.channel
                    if result.error == nil {
                        
                        if feed!.link == nil {
                            feed?.link = url
                        }
                        
                        //can improve with async; use completion block as param
                        feed!.feedId = SFModelManager.sharedInstance.updateFeedSync(feed!)
                        
                    }
                    
                    completionHandler(result: feed, error: result.error)
            }
        } else {
            let feed = SFFeed()
            completionHandler(result: feed, error: nil)
            
        }
        
        
    }


}

extension Request {
    
    public func responseObjectCustom<T:EVObject>(completionHandler: (Result<T, NSError>) -> Void) -> Self {
        return responseObjectCustom(nil) { (request, response, data) in
            completionHandler(data)
        }
    }
    
    public func responseObjectCustom<T:EVObject>(queue: dispatch_queue_t?, completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<T, NSError>) -> Void) -> Self {
        return responseString(queue: nil, encoding: NSUTF8StringEncoding, completionHandler: { (response) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                dispatch_async(queue ?? dispatch_get_main_queue()) {
                    switch response.result {
                    case .Success(let xml):
                        let result = NSDictionary(XMLString: xml)
                        completionHandler(self.request, self.response, Result.Success(T(dictionary: result)))
                    case .Failure(let error):
                        completionHandler(self.request, self.response, Result.Failure(error ?? NSError(domain: "NaN", code: 1, userInfo: nil)))
                    }
                }
            }
        } )
    }
}