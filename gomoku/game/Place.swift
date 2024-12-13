//
//  Place.swift
//  gomoku
//
//  Created by student on 13.12.2024.
//

import Foundation

enum PlaceState {
    case EMPTY, WHITE, BLACK
}

struct Place: Hashable, CustomStringConvertible {
    var x: Int
    var y: Int

    public var description: String {
        return "(\(x), \(y))"
    }

    var hashValue: Int {
        return (x + y).hashValue
    }

    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
