//
//  ThirdSampleView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 02.01.2025.
//

import SwiftUI
import UIKit.UIImage

final class ThirdSampleModel: ObservableObject {
    @Published var images: [UIImage] = []
    private let url = URL(string: "https://picsum.photos/300")
    
    func loadImages() async throws -> UIImage {
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

struct ThirdSampleView: View {
    @StateObject var model: ThirdSampleModel = .init()
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
            .navigationTitle("Async let")
            .onAppear {
                Task {
                    do {
                        async let loadImage1 = model.loadImages()
                        async let loadImage2 = model.loadImages()
                        async let loadImage3 = model.loadImages()
                        async let loadImage4 = model.loadImages()
                        let images = await [
                            try loadImage1,
                            try loadImage2,
                            try loadImage3,
                            try loadImage4
                        ]
                        model.images += images

                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ThirdSampleView()
}
