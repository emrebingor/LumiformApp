//
//  RepositoryContentData.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation
import CoreData

protocol ContentDataRepositoryProtocol {
    func getContentData() async throws -> ModelContentItem
}

struct RepositoryContentData: ContentDataRepositoryProtocol {
    private let network = Network()
    private let networkMonitor = NetworkMonitor()
    private let coreDataManager = CoreDataManager()
    
    func getContentData() async throws -> ModelContentItem {
        if networkMonitor.isConnected {
            let endpoint = Endpoints.getContentData()
            let data = try await network.execute(endpoint: endpoint)
            saveToCoreData(item: data)
            return data
        } else {
            guard let cachedData = fetchSavedData() else {
                throw NetworkError.invalidResponse
            }
            return cachedData
        }
    }
        
    private func saveToCoreData(item: ModelContentItem) {
        let newData = ContentEntity(context: coreDataManager.context)
        newData.id = item.id
        newData.title = item.title
        newData.src = item.src
        
        if let items = item.items {
            do {
                let jsonData = try JSONEncoder().encode(items)
                newData.items = jsonData
            } catch {
                print("Failed to encode items: \(error)")
                newData.items = nil
            }
        } else {
            newData.items = nil
        }
        
        coreDataManager.saveContext()
    }
    
    private func fetchSavedData() -> ModelContentItem? {
        let request: NSFetchRequest<ContentEntity> = ContentEntity.fetchRequest()
        
        do {
            let results = try coreDataManager.context.fetch(request)
            guard let entity = results.first else {
                  return nil
              }
            
            var itemsArray: [ModelContentItem]? = nil
            
            if let itemsData = entity.items {
                itemsArray = try? JSONDecoder().decode([ModelContentItem].self, from: itemsData)
            }
            
            let contentItem = ModelContentItem(
                type: .text,
                title: entity.title,
                src: entity.src,
                items: itemsArray
            )
            
            return contentItem
            
        } catch {
            print("Error fetching saved data: \(error.localizedDescription)")
            return nil
        }
    }
}

private extension Endpoints{
    static func getContentData() -> Endpoint<ModelContentItem>{
        let url = baseURL + "/v1/f118b9f0-6f84-435e-85d5-faf4453eb72a"
        return Endpoint<ModelContentItem>(method: .GET, url: url)
    }
}
