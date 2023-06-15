import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @State private var image: UIImage?
    private let urlString: String
    private let placeholder: Placeholder

    init(urlString: String, @ViewBuilder placeholder: () -> Placeholder) {
        self.urlString = urlString
        self.placeholder = placeholder()
    }

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            placeholder
                .onAppear {
                    loadImage()
                }
        }
    }

    private func loadImage() {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

