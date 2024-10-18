//
//  Item.swift
//  WorkTimer
//
//  Created by Дмитрий Шибанов on 18.10.2024.
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
