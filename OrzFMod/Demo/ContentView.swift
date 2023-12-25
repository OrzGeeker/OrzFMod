//
//  ContentView.swift
//  Demo
//
//  Created by joker on 12/26/23.
//  Copyright © 2023 joker. All rights reserved.
//

import SwiftUI
import FModAPI

struct ContentView: View {
    
    private let player = FModCapsule()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            player.playDemoMusic()
        }
    }
}

#Preview {
    ContentView()
}
