//
//  CustomListView.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

struct CustomListView: View {
    let items: [ModelContentItem]
    let onImageTapped: (ModelContentItem) -> Void

    var body: some View {
        List(items, children: \.items) { item in
            ContentRowView(for: item)
        }
    }

    @ViewBuilder
    private func ContentRowView(for item: ModelContentItem) -> some View {
        switch item.type {
            
        case .text:
            DescriptionTextView(text: item.title ?? "")

        case .image:
            VStack(spacing: 8) {
                if let urlString = item.src,
                   let url = URL(string: urlString) {
                    CustomThumbnailView(url: url)
                        .onTapGesture {
                            onImageTapped(item)
                        }
                }
                DescriptionTextView(text: item.title ?? "")
            }
            
        case .section, .page:
            Label {
                SectionTextView(text: item.title ?? "")
            } icon: {
                Image(systemName: item.type == .page ? "doc.text" : "folder")
            }
            
        }
    }
}
