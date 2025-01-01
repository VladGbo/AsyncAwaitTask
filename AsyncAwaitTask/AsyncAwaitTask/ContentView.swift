//
//  ContentView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 01.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            firstSampleView
        }.navigationTitle("List of samples")
    }
    private var firstSampleView: some View {
        NavigationLink {
            FirstSampleView()
        } label: {
            Text("Load image with Async Await")
        }
    }
}

#Preview {
    ContentView()
}
