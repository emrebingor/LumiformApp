//
//  Coordinator.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .viewHomePage:
            ViewHomePage()
        case .viewDetailPage(let contentItem):
            ViewDetailPage(viewModel: ViewModelDetailPage(contentItem: contentItem))
        }
    }
    
    func push(_ page: Page) {
        path.append(page)
    }
}

enum Page: Identifiable, Hashable {
    case viewHomePage, viewDetailPage(contentItem: ModelContentItem)
    
    var id: String{
        switch self {
        case .viewHomePage:
            return "viewHomePage"
        case .viewDetailPage(let contentItem):
            return "viewDetailPage_\(contentItem.id)"
        }
    }
}
