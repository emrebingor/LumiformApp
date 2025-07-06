//
//  Endpoint.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

struct Endpoints {
    static let baseURL = "https://mocki.io"
}

struct Endpoint<T> {
    var method: HttpMethod
    var url: String
    typealias ResponseType = T
    
    init(method: HttpMethod, url: String) {
        self.method = method
        self.url = url
    }
    
    func getUrlRequest() -> URLRequest? {
        guard let urlComponents = URLComponents(string: self.url) else {
            print("Endpoint failed - Invalid URL \(self.url)")
            return nil
        }
        
        guard let finalUrl = urlComponents.url else {
            print("Endpoint failed - Unable to create final URL")
            return nil
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = self.method.rawValue
        
        configureJSONRequest(&request)
        
        return request
    }
}

extension Endpoint {
    
    private func configureJSONRequest(_ request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

enum HttpMethod : String {
    case GET = "GET"
}
