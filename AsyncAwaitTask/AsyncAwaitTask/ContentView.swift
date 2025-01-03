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
                thirdSampleView
                fourthSampleView
                fifthSampleView
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
    private var thirdSampleView: some View {
        NavigationLink {
            ThirdSampleView()
        } label: {
            Text("Load images with Async let")
        }
    }
    private var fourthSampleView: some View {
        NavigationLink {
            FourthSampleView()
        } label: {
            Text("Load images with Async Group")
        }
    }
    private var fifthSampleView: some View {
        NavigationLink {
            FifthSampleView()
        } label: {
            Text("Continuations")
        }
    }
}

#Preview {
    ContentView()
}
