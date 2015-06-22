//
//  JSONInteraction.swift
//  VisionQuestion
//
//  Created by Kyle Brooks Robinson on 6/18/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

private let defaults = NSUserDefaults.standardUserDefaults()
private let _singleton = RailsRequest()

let API_URL = "https://vast-wildwood-6662.herokuapp.com"

class RailsRequest: NSObject {
    
    class func session() -> RailsRequest { return _singleton }
    
    var token: String? {
        
        get {
            
            return defaults.objectForKey("TOKEN") as? String
            
        }
        
        set {
            
            defaults.setValue(newValue, forKey: "TOKEN")
            defaults.synchronize()
            
        }
        
    }
    
    var username: String!
    var email: String!
    var firstName: String!
    var lastName: String!
    var password: String!
    
    func logOut() {
        
        username = ""
        token = nil
        
        
    }
    
    func registerWithCompletion(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/register",
            "parameters" : [
                
                "user_name" : username,
                "password" : password,
                "first_name" : firstName,
                "last_name" : lastName,
                "email" : email,
                
            ],
            
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
    }
    
    func login(completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/users/login",
            "parameters" : [
                
                "user_name" : username,
                "password" : password,
                
            ],
            
            ] as [String:AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)


            if let accessToken = responseInfo?["access_token"] as? String {
                
                self.token = accessToken
                
                completion()
                
            }
            
        })
        
    }
    
    func postImage(imageURL: String, answer: String, completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/posts/new",
            "parameters" : [
                
                "image_url":imageURL,
                "answer":answer
            
            ]
            
        ] as [String: AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
        })
        
    }
    
    func guessImage(postId: String, guess: String, completion: () -> Void) {
        
        var isCorrect: Bool?
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/guesses",
            "parameters" : [
                
                "post_id":postId,
                "guess":guess
                
            ]
            
            ] as [String: AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
            isCorrect = responseInfo?["won"] as? Bool
            
            completion()
            
        })
        
    }
    
    func getPosts(completion: () -> Void) {
        
        var postID: Int?
        var imageURL: String?
        var answer: String?
        
        var info = [
            
            "method" : "GET",
            "endpoint" : "/posts/user",
            
            ] as [String: AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            
            println(responseInfo)
            
            println("This section is indeed running.")
            
        })
        
    }
    
    
    
    func scoreboard(username: String, score: String, completion: () -> Void) {
        
        var info = [
            
            "method" : "POST",
            "endpoint" : "/topscores",
            "parameters" : [
                
                "user_name":username,
                "score":score
                
            ]
            
            ] as [String: AnyObject]
        
        requestWithInfo(info, andCompletion: { (responseInfo) -> Void in
            
            println(responseInfo)
            
        })
        
    }
    
    func requestWithInfo(info: [String:AnyObject], andCompletion completion: ((responseInfo: [String:AnyObject]?) -> Void)?) {
        
        let endpoint = info["endpoint"] as! String
        
        if let url = NSURL(string: API_URL + endpoint) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = info["method"] as! String
            
            ///////HEADER
            
            if let token = token {
                
                request.setValue(token, forHTTPHeaderField: "Access-Token")
                
            }
            
            /////// BODY
            
            if let bodyInfo = info["parameters"] as? [String:AnyObject] {
                
                let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
                
                let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
                
                let postLength = "\(jsonString!.length)"
                
                request.setValue(postLength, forHTTPHeaderField: "Content-Length")
                
                let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.HTTPBody = postData
                
            }
            
            ////// BODY
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                
                if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    completion?(responseInfo: json)
                    
                }
                
            })
            
        }
        
    }
    
}