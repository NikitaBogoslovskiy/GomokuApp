//
//  ContentView.swift
//  gomoku
//
//  Created by student on 13.12.2024.
//

import SwiftUI

struct ContentView: View {
    var game = Game()
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.05)) {_ in
            VStack {
                Text(game.getOutput()).font(.system(size: 10))
                Text(game.getResult())
                Text(game.getMessage())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
