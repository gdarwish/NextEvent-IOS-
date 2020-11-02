//
//  Event.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-10-29.
//

import Foundation

class Event{
    var title: String
    var date: String
    var address: String
    
    init(title: String, date: String, address: String) {
        self.title = title
        self.date = date
        self.address = address
    }
}
