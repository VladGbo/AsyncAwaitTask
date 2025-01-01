//
//  SecondSampleView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 01.01.2025.
//

import SwiftUI

final class SecondSampleModel: ObservableObject {
    @Published var image1: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func loadImage1() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            try Task.checkCancellation()
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let response = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image1 = UIImage(data: response.0)
                print("IMAGE RETURNED SUCCESSFULLY")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            try Task.checkCancellation()
            let response = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image2 = UIImage(data: response.0)
//                print("IMAGE RETURNED SUCCESSFULLY")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct SecondSampleView: View {
    @ObservedObject var model: SecondSampleModel = .init()
    var body: some View {
        VStack(spacing: 40) {
            getImage(model.image1)
            getImage(model.image2)
        }
        .task {
            await model.loadImage1()
            
        }
        .task {
            await model.loadImage2()
        }
//        .onAppear {
//            Task(priority: .low) {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await model.loadImage1()
//            }
//            Task(priority: .medium) {
//                print(Thread.current)
//                print(Task.currentPriority)
//                await model.loadImage2()
//            }
//            Task(priority: .high) {
//                await Task.yield()
//                try? await Task.sleep(nanoseconds: 2_000_000_000)
//                print(Thread.current)
//                print(Task.currentPriority)
//                
//            }
//            Task(priority: .low) {
//                print(Thread.current)
//                print(Task.currentPriority)
//                Task.detached {
//                    print(Thread.current)
//                    print(Task.currentPriority)
//                }
//            }
//        }
    }
    @ViewBuilder
    private func getImage(_ image: UIImage?) -> some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    SecondSampleView()
}
