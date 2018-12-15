//
//  TumblrPost.swift
//  TumblrFeed
//
//  Created by Brian Casipit on 12/14/18.
//  Copyright © 2018 Brian Casipit. All rights reserved.
//

import Foundation

class TumblrPost {
    
    // TODO
    // - create properties for tumblr posts from api
    
    let id: Int?
    let post_url: String?
    let date: String?
    let summary: String?
    var caption: String?
    let original_size_photo_url: String?
    
    init(dictionary: [String: Any]) {
        // CREDIT: https://stackoverflow.com/questions/25607247/how-do-i-decode-html-entities-in-swift?answertab=votes#tab-top
        // options used for entity reference conversion
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.characterEncoding.rawValue): String.Encoding.utf8.rawValue
        ]
        
        id = dictionary["id"] as? Int ?? -1
        post_url = dictionary["post_url"] as? String ?? ""
        date = dictionary["date"] as? String ?? ""
        summary = dictionary["summary"] as? String ?? ""
        
        let prepareCaption = (dictionary["caption"] as? String ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        caption = prepareCaption
        if let captionData = prepareCaption.data(using: .utf8) {
            if let attributedString = try? NSAttributedString(data: captionData, options: options, documentAttributes: nil) {
                let convertedString = attributedString.string
                caption = convertedString
            }
        }
        
        // Navigate to original_size dictionary
        if let photos = dictionary["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let original_size = photo["original_size"] as? [String: Any]
            original_size_photo_url = original_size?["url"] as? String
        }
        else {
            original_size_photo_url = "https://raw.githubusercontent.com/motiveg/TumblrFeed/master/ImageNotLoaded.png"
            
        }
    }

    class func tumblrPosts(dictionaries: [[String: Any]]) -> [TumblrPost] {
        var tumblrPosts: [TumblrPost] = []
        for dictionary in dictionaries {
            let tumblrPost = TumblrPost(dictionary: dictionary)
            tumblrPosts.append(tumblrPost)
        }
        return tumblrPosts
    }
    
}
