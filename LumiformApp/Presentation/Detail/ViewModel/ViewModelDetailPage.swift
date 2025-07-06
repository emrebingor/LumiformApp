//
//  ViewModelDetailPage.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

class ViewModelDetailPage: ObservableObject {
    var contentItem: ModelContentItem
    @Published var pageTitle: String = ""
    @Published var imageSource: String = ""
    
    init(contentItem: ModelContentItem) {
        self.contentItem = contentItem
        
        if let title = contentItem.title {
            self.pageTitle = title
        }
        
        if let imageSource = contentItem.src {
            self.imageSource = imageSource
        }
    }
}
