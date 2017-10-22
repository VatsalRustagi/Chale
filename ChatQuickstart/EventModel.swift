//
//  HomeModel.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class EventModel {
    
    private var _eventName: String!
    private var _dateTime: String!
    private var _location: String!
    private var _people: [String]!
    private var _description: String!
    
    var eventName: String {
        get{
            if _eventName == nil {
                _eventName = ""
            }
            return _eventName
        }
        set{
            _eventName = newValue
        }
    }
    
    var dateTime: String {
        get{
            if _dateTime == nil {
                _dateTime = ""
            }
            return _dateTime
        }
        set{
            _dateTime = newValue
        }
    }
    
    var location: String {
        get{
            if _location == nil {
                _location = ""
            }
            return _location}
        set{
            _location = newValue
        }
    }
    
    var people: [String] {
        get{
            if _people == nil {
                _people = []
            }
            return _people
        }
        set{
            _people = newValue
        }
    }
    
    var description: String {
        if _description == nil {
            _description = "There was no description provided."
        }
        return _description
    }

    init(eventName: String, dateTime: String, location: String, description: String) {
        _eventName = eventName
        _dateTime = dateTime
        _location = location
        _description = description
    }
    
    init(){
        
    }
}
