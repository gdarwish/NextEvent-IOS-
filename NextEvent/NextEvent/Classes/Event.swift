//
//  Event.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import Foundation

class Event{
    internal init(title: String, date: String, address: String, imageUrl: String) {
        self.title = title
        self.date = date
        self.address = address
        self.imageUrl = imageUrl
    }
    
    
    var title: String
    var date: String
    var address: String
    var imageUrl: String
}
