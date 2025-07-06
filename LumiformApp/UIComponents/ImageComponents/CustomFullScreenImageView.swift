//
//  CustomFullScreenImageView.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct CustomFullScreenImageView: View {
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
            } else {
                ProgressView()
            }
        }
        .onAppear{
            loader.load(from: url)
        }
    }
}
