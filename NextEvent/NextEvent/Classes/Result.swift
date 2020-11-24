//
//  Result.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-09.
//

import Foundation

class Result: Codable {
    init(count: Int, overflow: Bool, next: String, results: [Event]) {
        self.count = count
        self.overflow = overflow
        self.next = next
        self.results = results
    }
    
    let count: Int
    let overflow: Bool
    let next: String
    let results: [Event]
}
