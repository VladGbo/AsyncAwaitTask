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
            VStack(alignment: .leading, spacing: 20) {
                firstSampleView
                secondSampleView
            }
        }.navigationTitle("List of samples")
    }
    private var firstSampleView: some View {
        NavigationLink {
            FirstSampleView()
        } label: {
            Text("Load image with Async Await")
        }
    }
    private var secondSampleView: some View {
        NavigationLink {
            SecondSampleView()
        } label: {
            Text("Load image with Task")
        }
    }
}

#Preview {
    ContentView()
}
