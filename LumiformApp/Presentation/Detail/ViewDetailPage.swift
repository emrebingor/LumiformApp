//
//  ViewDetailPage.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct ViewDetailPage: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject var viewModel: ViewModelDetailPage
    
    var body: some View {
        VStack {
            TitleTextView(text: viewModel.pageTitle)
            
            if let url = URL(string: viewModel.imageSource) {
                CustomFullScreenImageView(url: url)
            }
        }
        .padding()
    }
}

