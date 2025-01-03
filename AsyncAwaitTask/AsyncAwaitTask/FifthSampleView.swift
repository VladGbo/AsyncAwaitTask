//
//  FifthSampleView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 03.01.2025.
//

import SwiftUI

class FifthSampleModel: ObservableObject {
    @Published var image: UIImage?
    func updateImage() async {
        guard let data = try? await getData() else { return }
        if let image = UIImage(data: data) {
            await MainActor.run { [weak self] in
                self?.image = image
            }
        }
    }
    private func getData() async throws -> Data {
        guard let url = URL(string: "https://picsum.photos/300") else {
            throw URLError(.badURL)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data {
                    continuation.resume(returning: data)
                } else if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }.resume()
        }
    }
}

struct FifthSampleView: View {
    @StateObject var model: FifthSampleModel = .init()
    var body: some View {
        ZStack {
            if let image = model.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }.task {
            await model.updateImage()
        }
    }
}

#Preview {
    FifthSampleView()
}
