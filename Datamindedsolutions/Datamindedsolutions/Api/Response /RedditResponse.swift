//
//  RedditResponse.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import Foundation


class RedditResponse {
    
    var responseItems = [RedditItem]()
    
    public init?(json: [String: Any]) {
        
        if let jsonData = json["data"]  as? [String: Any] {
            
            let redditItems = jsonData["children"]  as? [Any]
            
            for redditItem in redditItems! {
                
                let item = RedditItem(json: redditItem as! [String : Any])
                
                responseItems.append(item)
            }
        }
    }
}
