//
//  ContentView.swift
//  Screenshot Prevention
//
//  Created by Marius Preikschat on 24.05.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .preventScreenshot()
            Text("Hello, world!")
                .screenshotProtected(isProtected: true)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
