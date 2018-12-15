//
//  TumblrAPI.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 12/14/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import Foundation

class TumblrAPI {
    
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func fetchPosts(completion: @escaping ([TumblrPost]?, Error?) -> ()) {
        
        // Network request snippet
        let urlString = "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                print(dataDictionary)
                
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in posts property
                let posts = responseDictionary["posts"] as! [[String: Any]]
                // Get each post
                let tumblrPosts = TumblrPost.tumblrPosts(dictionaries: posts)
                completion(tumblrPosts, nil)
            }
        }
        task.resume()
    }
}
