//
//  RepositoryContentData.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

protocol ContentDataRepositoryProtocol {
    func getContentData() async throws -> ModelContentItem
}

struct RepositoryContentData: ContentDataRepositoryProtocol {
    private let network = Network()
    
    func getContentData() async throws -> ModelContentItem {
        let endpoint = Endpoints.getContentData()
        let data = try await network.execute(endpoint: endpoint)
        return data
    }
}

private extension Endpoints{
    static func getContentData() -> Endpoint<ModelContentItem>{
        let url = baseURL + "/v1/f118b9f0-6f84-435e-85d5-faf4453eb72a"
        return Endpoint<ModelContentItem>(method: .GET, url: url)
    }
}
