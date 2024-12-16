//
//  Item.swift
//  ShuttleU
//
//  Created by Wilson Beima on 12/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
