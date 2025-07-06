//
//  ViewModelHomePage.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

class ViewModelHomePage: ObservableObject {
    private let useCase: ContentDataUseCaseProtocol
    
    @Published var isLoading: Bool = false
    @Published var showingAlert: Bool = false
    @Published var pageTitle: String = ""
    @Published var errorMessage: String = ""
    @Published var list: [ModelContentItem] = []
    
    init(useCase: ContentDataUseCaseProtocol = UseCaseContentData(repository: RepositoryContentData())) {
        self.useCase = useCase
    }
    
    @MainActor
    func getContentItem() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await useCase.getContentData()
            
            if let title = response.title {
                self.pageTitle = title
            }
            if let list = response.items {
                self.list = list
            }
            
        } catch {
            self.showingAlert = true
            self.errorMessage = error.localizedDescription
        }
    }
}
