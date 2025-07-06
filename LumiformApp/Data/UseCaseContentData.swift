//
//  UseCaseContentData.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

protocol ContentDataUseCaseProtocol {
    func getContentData() async throws -> ModelContentItem
}

struct UseCaseContentData: ContentDataUseCaseProtocol {
    private let repository: ContentDataRepositoryProtocol
    
    init(repository: ContentDataRepositoryProtocol) {
        self.repository = repository
    }
    
    func getContentData() async throws -> ModelContentItem {
        try await repository.getContentData()
    }
}
