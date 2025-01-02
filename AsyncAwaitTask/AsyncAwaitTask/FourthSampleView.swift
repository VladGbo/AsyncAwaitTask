//
//  FourthSampleView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 02.01.2025.
//

import SwiftUI

final class FourthSampleModel: ObservableObject {
    @Published var images: [UIImage] = []
    private let url = URL(string: "https://picsum.photos/300")
    
    func onAppear() async {
        guard let images = try? await loadTaskGroup() else { return }
        self.images.append(contentsOf: images)
    }
    
    private func loadTaskGroup() async throws -> [UIImage] {
        try await withThrowingTaskGroup(of: UIImage?.self) { group in
            let ar = Array(0...9)
            var images = [UIImage]()
            images.reserveCapacity(ar.count)
            ar.forEach { _ in
                group.addTask { [weak self] in
                    guard let self else { return nil }
                    return try? await self.loadImage()
                }
            }
            for try await taskResult in group {
                guard let taskResult else { continue }
                images.append(taskResult)
            }
            return images
        }
    }
    
    private func loadImages() async throws -> [UIImage] {
        async let loadImage1 = loadImage()
        async let loadImage2 = loadImage()
        async let loadImage3 = loadImage()
        async let loadImage4 = loadImage()
        async let loadImage5 = loadImage()
        
        return await [
            try loadImage1,
            try loadImage2,
            try loadImage3,
            try loadImage4,
            try loadImage5
        ]
    }
    
    private func loadImage() async throws -> UIImage {
        guard let url else { throw URLError(.badURL) }
        do {
            let res = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: res.0) else { throw URLError(.badServerResponse) }
            return image
        } catch {
            throw URLError(.badURL)
        }
    }
}

struct FourthSampleView: View {
    @StateObject var model: FourthSampleModel = .init()
    let columns: [GridItem] = [.init(.flexible()), .init(.flexible()) ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(model.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150.0)
                    }
                }
            }
            .navigationTitle("Async Group")
            .task {
                await model.onAppear()
            }
        }
    }
}

#Preview {
    FourthSampleView()
}
