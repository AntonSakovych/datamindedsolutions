//
//  RedditItem.swift
//  Datamindedsolutions
//
//  Created by Anton Sakovych on 7/2/19.
//  Copyright © 2019 Anton Sakovych. All rights reserved.
//


class RedditItem  {
    var itemId: String?
    var likes: String?
    var name: String?
    var title: String?
    var thumbnailWidth: String?
    var thumbnailLink: String?
    var comentsCount: String?
    var isHidden: Bool?
    var pwls: String?
    var authorFullname: String?
    var permalink: String?
    var whitelistStatus: String?
    var author: String?
    var clicked:Int?
    var score:Int?
    var edited:Int?
    var saved:Int?
    var awardsReceived:Int?
    var domain: String?
    var url: String?
    var isvisited: Bool?
    
    init(json: [String: Any]) {
        
        if  let test = json["data"] as? [String: Any] {
            
            for (key,value) in test {
                
                if key == "id" {
                    itemId = value as? String ?? ""
                }
                
                if key == "url" {
                    url = value as? String ?? ""
                }
                
                if key == "saved" {
                    saved = value as? Int ?? 0
                }
                
                if key == "total_awards_received" {
                    awardsReceived = value as? Int ?? 0
                }
                
                if key == "edited" {
                    edited = value as? Int ?? 0
                }
                
                if key == "score" {
                    score = value as? Int ?? 0
                }
                
                if key == "clicked" {
                    clicked = value as? Int ?? 0
                }
                
                if key == "domain" {
                    domain = value as? String ?? ""
                }
                
                if key == "author" {
                    author = value as? String ?? ""
                }
                
                if key == "author" {
                    author = value as? String ?? ""
                }
                
                if key == "likes" {
                    likes = value as? String ?? ""
                }
                
                if key == "name" {
                    name = value as? String ?? ""
                }
                
                if key == "name" {
                    title = value as? String ?? ""
                }
                
                if key == "thumbnail_width" {
                    thumbnailWidth = value as? String ?? ""
                }
                
                if key == "thumbnail" {
                    thumbnailLink = value as? String ?? ""
                }
                
                if key == "num_comments" {
                    comentsCount = value as? String ?? ""
                }
                
                if key == "hidden" {
                    isHidden = value as? Bool ?? false
                }
                
                if key == "visited" {
                    isvisited = value as? Bool ?? false
                }
                
                if key == "pwls" {
                    pwls = value as? String ?? ""
                }
                
                if key == "author_fullname" {
                    authorFullname = value as? String ?? ""
                }
                
                if key == "permalink" {
                    permalink = value as? String ?? ""
                }
            }
        }
    }
}
