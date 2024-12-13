//
//  Field.swift
//  gomoku
//
//  Created by student on 13.12.2024.
//

import Foundation

class Field {
    let size = 15
    let winningLineLength = 5
    var grid = [[PlaceState]]()
    var emptyPlaces = Set<Place>()
    
    init() {
        for i in 0..<size {
            grid.append([PlaceState]())
            for j in 0..<size {
                grid[i].append(PlaceState.EMPTY)
                emptyPlaces.insert(Place(x: i, y: j))
            }
        }
    }
    
    struct CheckResult {
        var state: PlaceState
        var counter: Int
        var hasWinner: Bool
        var winner: PlaceState
    }
    
    private func checkState(i: Int, j: Int, state: PlaceState, counter: Int) -> CheckResult {
        var hasWinner = false
        var winner = PlaceState.EMPTY
        var currState = state
        var currCounter = counter
        
        switch grid[i][j] {
            case PlaceState.EMPTY:
                currState = PlaceState.EMPTY
            case PlaceState.WHITE:
                if currState == PlaceState.WHITE {
                    currCounter += 1
                } else {
                    currCounter = 1
                    currState = PlaceState.WHITE
                }
                if currCounter >= winningLineLength {
                    hasWinner = true
                    winner = PlaceState.WHITE
                }
            case PlaceState.BLACK:
                if currState == PlaceState.BLACK {
                    currCounter += 1
                } else {
                    currCounter = 1
                    currState = PlaceState.BLACK
                }
                if currCounter >= winningLineLength {
                    hasWinner = true
                    winner = PlaceState.BLACK
                }
        }
        
        return CheckResult(state: currState, counter: currCounter, hasWinner: hasWinner, winner: winner)
    }
    
    func findWinner() -> (Bool, PlaceState, String) {
        //проверка строк
        for i in 0..<size {
            var state = PlaceState.EMPTY
            var counter = 0
            for j in 0..<size {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken row")
                }
                state = res.state
                counter = res.counter
            }
        }
        
        //проверка столбцов
        for j in 0..<size {
            var state = PlaceState.EMPTY
            var counter = 0
            for i in 0..<size {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken column")
                }
                state = res.state
                counter = res.counter
            }
        }
        
        //проверка диагоналей под главной
        var start_i = 0
        var start_j = 0
        var end_i = size - 1
        var end_j = size - 1
        while start_i < size && end_j >= 0 {
            var state = PlaceState.EMPTY
            var counter = 0
            var i = start_i
            var j = start_j
            while i <= end_i && j <= end_j {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken main diagonal")
                }
                state = res.state
                counter = res.counter
                i += 1
                j += 1
            }
            start_i += 1
            end_j -= 1
        }
        
        //проверка диагоналей над главной
        start_i = 0
        start_j = 0
        end_i = size - 1
        end_j = size - 1
        while start_j < size && end_i >= 0 {
            var state = PlaceState.EMPTY
            var counter = 0
            var i = start_i
            var j = start_j
            while i <= end_i && j <= end_j {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken main diagonal")
                }
                state = res.state
                counter = res.counter
                i += 1
                j += 1
            }
            start_j += 1
            end_i -= 1
        }
        
        //проверка диагоналей под побочной
        start_i = size - 1
        start_j = 0
        end_i = 0
        end_j = size - 1
        while start_j < size && end_i < size {
            var state = PlaceState.EMPTY
            var counter = 0
            var i = start_i
            var j = start_j
            while i >= end_i && j <= end_j {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken side diagonal")
                }
                state = res.state
                counter = res.counter
                i -= 1
                j += 1
            }
            start_j += 1
            end_i += 1
        }
        
        //проверка диагоналей над побочной
        start_i = size - 1
        start_j = 0
        end_i = 0
        end_j = size - 1
        while start_i >= 0 && end_j >= 0 {
            var state = PlaceState.EMPTY
            var counter = 0
            var i = start_i
            var j = start_j
            while i >= end_i && j <= end_j {
                let res = checkState(i: i, j: j, state: state, counter: counter)
                if res.hasWinner {
                    return (true, res.winner, "Has found continuous unbroken side diagonal")
                }
                state = res.state
                counter = res.counter
                i -= 1
                j += 1
            }
            start_i -= 1
            end_j -= 1
        }
        
        return (false, PlaceState.EMPTY, "")
    }
    
    func isOver() -> Bool {
        return emptyPlaces.isEmpty
    }
    
    func acceptStep(player: Player) {
        let chosenStep = player.doStep(possibleSteps: emptyPlaces)
        if chosenStep != nil {
            grid[chosenStep!.x][chosenStep!.y] = player.color
            emptyPlaces.remove(chosenStep!)
        }
    }
    
    func toString() -> String {
        var output = ""
        for row in 0..<size {
            for col in 0..<size {
                var sym = ""
                switch grid[row][col] {
                    case PlaceState.BLACK:
                        sym = "⚫"
                    case PlaceState.WHITE:
                        sym = "⚪"
                    case PlaceState.EMPTY:
                        sym = "⭕"
                }
                output += sym + " "
            }
            output += "\n"
        }
        return output
    }
}
