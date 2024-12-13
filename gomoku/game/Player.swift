//
//  Player.swift
//  gomoku
//
//  Created by student on 13.12.2024.
//

import Foundation

class Player {
    var color: PlaceState

    init(color: PlaceState) {
        self.color = color
    }

    func doStep(possibleSteps: Set<Place>) -> Place? {
        let chosenStep = possibleSteps.randomElement()
        print("\(color) do step \(chosenStep!)")
        return chosenStep
    }
}
