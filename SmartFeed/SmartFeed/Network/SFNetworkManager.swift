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

    
    func feelFeed(feed: SFFeed) {
        
//        Alamofire.request(.GET, feed.url, parameters: nil)
//            .responseObject { (aRequset, aResponse, result) -> Void in
//                print(result)
//        }


        Alamofire.request(.GET, feed.url).responseObject { (result: Result<SFFeed, NSError>) -> Void in
            print(result)
            switch result {
            case .Success(let feed):
                print("feed: \(feed)\n")
                break
            case .Failure(let error):
                print("\(error)\n")
                break
            }
        }
        

        
//        Alamofire.request(.GET, feed.url, encoding: .PropertyList(.XMLFormat_v1_0, 0)).responsePropertyList { response in
//            if let error = response.result.error {
//                print("Error: \(error)")
//                
//                // parsing the data to an array
//            } else if let array = response.result.value as? [[String: String]] {
//                
//                if array.isEmpty {
//                    print("No data")
//                    
//                } else {
//                    //Do whatever you want to do with the array here
//                }
//            }
//        }
        
        
//        Alamofire.request(.GET, feed.url).responseArray(completionHandler: { (Response<[SFArticle], NSError>) -> Void in
//            <#code#>
//            }) {
//                //            (response: Response<[SFArticle], NSError>) in
//                //
//                //            let forecastArray = response.result.value
//                //
//                ////            if let forecastArray = forecastArray {
//                ////                for forecast in forecastArray {
//                ////                    print(forecast.day)
//                ////                    print(forecast.temperature)
//                ////                }
//                ////            }
//        }
    }

}
