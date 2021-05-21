//
//  Result.swift
//  NextEvent
//
//  Created by gaith darwish on 2020-11-09.
//

import Foundation

class Result: Codable {
    init(count: Int, overflow: Bool, results: [Event]) {
        self.count = count
        self.overflow = overflow
        self.results = results
    }
    
    let count: Int
    let overflow: Bool
    let results: [Event]
}
