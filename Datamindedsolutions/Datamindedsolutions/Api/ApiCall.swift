//
//  ApiCall.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//

import Foundation

class ApiCall {
    
    static func getItemsCall(_ lastAutorId: String = "",  onSuccess: @escaping (_ data: RedditResponse?) -> Void)  {
        
        let endpoint: String = NetworkConstans.baseURL + lastAutorId
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                onSuccess(RedditResponse(json: todo))
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
}
