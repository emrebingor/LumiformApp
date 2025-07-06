//
//  ImageLoader.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = true
    
    private var cancellable: AnyCancellable?
    
    func load(from url: URL) {
        let cacheKey = url.lastPathComponent
        
        if let cached = CommonImageCache.shared.getImage(forKey: cacheKey) {
            self.image = cached
            self.isLoading = false
            return
        }
        
        self.isLoading = true
        print("Image is going to be downloaded")
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] downloadedImage in
                CommonImageCache.shared.saveImage(downloadedImage, forKey: cacheKey)
                self?.image = downloadedImage
                self?.isLoading = false
            })
    }
    
    deinit {
        cancellable?.cancel()
    }
}

private class CommonImageCache {
    static let shared = CommonImageCache()
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let cachePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cachePath.appendingPathComponent("ImageCache", isDirectory: true)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        
        let filePath = cacheDirectory.appendingPathComponent(key)
        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        let filePath = cacheDirectory.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: filePath)
        }
    }
}

