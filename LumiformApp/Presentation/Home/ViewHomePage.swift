//
//  ViewHomePage.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct ViewHomePage: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel = ViewModelHomePage()
    
    var body: some View {
        VStack {
            contentView
        }
        .onAppear {
            Task {
                await viewModel.getContentItem()
            }
        }
        .alert("Error", isPresented: $viewModel.showingAlert) {
            Button("Try Again") {
                Task {
                    await viewModel.getContentItem()
                }
            }
            Button("OK", role: .cancel) {
                viewModel.showingAlert = false
            }
        } message: {
            DescriptionTextView(text: viewModel.errorMessage)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if viewModel.list.isEmpty {
            CustomUnavailableView(
                title: "No data available",
                description: "There is no data to display at the moment.",
                imageName: "swiftdata"
            )
        } else {
            TitleTextView(text: viewModel.pageTitle)
            CustomListView(items: viewModel.list) { item in
                coordinator.push(.viewDetailPage(contentItem: item))
            }
        }
    }
}


