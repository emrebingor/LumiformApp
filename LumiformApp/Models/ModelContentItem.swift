//
//  ModelContentItem.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

struct ModelContentItem: Codable, Hashable, Identifiable {
    enum ItemType: String, Codable {
        case text, image, section, page
    }
    
    let id = UUID()
    let type: ItemType
    let title: String?
    let src: String?
    let items: [ModelContentItem]?
}
