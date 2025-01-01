//
//  FirstSampleView.swift
//  AsyncAwaitTask
//
//  Created by Vladyslav Horbenko on 01.01.2025.
//

import SwiftUI

final class FirstSampleModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    private let url = "https://picsum.photos/200"
    
    func loadImage() async {
        guard let url = URL(string: url) else { return }
        let request = try? await URLSession.shared.data(from: url)
        guard let data = request?.0,
              let image = UIImage(data: data) else { return }
        await MainActor.run {
            self.image = image
        }
    }
}

struct FirstSampleView: View {
    @StateObject private var model = FirstSampleModel()
    var body: some View {
        ZStack {
            image
        }
        .onAppear {
            Task {
                await model.loadImage()
            }
        }
    }
    @ViewBuilder
    private var image: some View {
        if let image = model.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    FirstSampleView()
}
