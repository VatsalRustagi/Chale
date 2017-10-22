//
//  Backend.swift
//  ChatQuickstart
//
//  Created by Vishnu on 10/22/17.
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

import Foundation
import Alamofire

protocol BackendDelegate {
    func processData(JSON: Dictionary<String, Any>)
}

class Backend {
    
    private let baseURL = "http://localhost:3000/"
    
    var delegate: BackendDelegate? = nil
    
    func getJSONData(from url: String, withParams params: Dictionary<String, Any>) {
        
        var dataURL = URLComponents(string: baseURL + url)!
        
        var items: [URLQueryItem] = []
        for (name,value) in params {
            items.append(URLQueryItem(name: name, value: value as! String))
        }
        
        if items != [] {
            dataURL.queryItems = items
        }
        
        Alamofire.request(dataURL).responseJSON { response in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                if let del = self.delegate {
                    del.processData(JSON: dict)
                }
            }
        }
    }
    
    func postJSONData(to url: String, withParams params: Dictionary<String, Any>) {
        
        let dataURL = URLComponents(string: baseURL + url)
        
        let headers: HTTPHeaders = ["Content-Type": "application/json; charset=utf-8"]
        
        Alamofire.request(dataURL!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                if let del = self.delegate {
                    del.processData(JSON: dict)
                }
            }
        }
        
    }
    
    
}
