import SwiftUI

struct CustomThumbnailView: View {
    let url: URL
    @State private var image: UIImage?
    @State private var isLoading = true
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            } else {
                ProgressView()
                    .frame(width: 150)
            }
        }
        .onAppear {
            loader.load(from: url)
        }
    }
}
