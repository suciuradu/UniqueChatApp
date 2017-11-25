//
//  Message.swift
//  Unique
//
//  Created by Suciu Radu on 22/11/2017.
//  Copyright © 2017 Suciu Radu. All rights reserved.
//

import Foundation


class Message {
    
    private var _content : String
    private var _senderID : String
    
    var content : String {
        return _content
    }
    var senderID : String {
        return _senderID
    }
    
    init(content: String, senderID: String) {
        self._content = content
        self._senderID = senderID
    }
    
    
    
}
