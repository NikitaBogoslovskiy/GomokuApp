//
//  Game.swift
//  gomoku
//
//  Created by student on 13.12.2024.
//

import Foundation

class Game : ObservableObject {
    let board = Field()
    let whitePlayer = Player(color: PlaceState.WHITE)
    let blackPlayer = Player(color: PlaceState.BLACK)
    var nowIsWhite = false
    var player = Player(color: PlaceState.EMPTY)
    var output = ""
    var result = ""
    var message = ""
    var gameOver = false
    
    func getOutput() -> String {
        if !gameOver {
            playStep()
            check()
        }
        return output
    }
    
    func getResult() -> String {
        return result
    }
    
    func getMessage() -> String {
        return message
    }
    
    func check() {
        let res = board.findWinner()
        if res.0 {
            result = "\(res.1) has won"
            message = res.2
            gameOver = true
        }
        if (board.isOver()) {
            result = "Board is full. The draw"
            gameOver = true
        }
    }
    
    func playStep() {
        if nowIsWhite {
            player = whitePlayer
        } else {
            player = blackPlayer
        }
        board.acceptStep(player: player)
        output = board.toString()
        nowIsWhite = !nowIsWhite
    }
}
