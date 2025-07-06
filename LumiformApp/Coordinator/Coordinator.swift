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
        }
    }
}

enum Page: Identifiable, Hashable {
    case viewHomePage
    
    var id: String{
        switch self {
        case .viewHomePage:
            return "viewHomePage"
        }
    }
}
