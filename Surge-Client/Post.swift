//
//  Post.swift
//  Surge-Client
//
//  Created by Manuel Sanchez Munoz on 5/18/15.
//  Copyright (c) 2015 Team-Surge. All rights reserved.
//

import Foundation
import JSONJoy

class Post : JSONJoy {
  var content: String!
  var id: Int!
  var timestamp: NSDate!
  var handle: String?
  var voteCount: Int!
  var voteState: String!
  var commentCount: Int?
  var comments: [Post]?
  var type: String?
  var userResponse: Int?
  var poll: Poll?
  var tags: Array<String>?
  
  required init(_ decoder: JSONDecoder) {
    content = decoder["content"].string
    id = decoder["id"].integer
    handle = decoder["handle"].string
    voteCount = decoder["voteCount"].integer
    voteState = decoder["userVote"].string
    commentCount = decoder["commentCount"].integer
    type = decoder["type"].string
    userResponse = decoder["userResponse"].integer
    poll = Poll(decoder["poll"])
    decoder["tags"].getArray(&tags)
    
    
    if let postDecoders = decoder["comments"].array {
      comments = [Post]()
      for postDecoder in postDecoders {
        comments!.append(Post(postDecoder))
      }
    }
    
    let created_at = decoder["created_at"].string
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
    timestamp = dateFormatter.dateFromString(created_at!)
    
  }
}
