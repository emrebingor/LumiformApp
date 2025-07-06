//
//  Network.swift
//  LumiformApp
//
//  Created by Emre Bingor on 7/6/25.
//

import Foundation

struct Network {
    func execute<T: Decodable>(endpoint: Endpoint<T>) async throws -> T {
        
        guard let request = endpoint.getUrlRequest() else { throw NetworkError.URLError }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let validatedData = try validateHTTPResponse(response as? HTTPURLResponse, data: data)
            return try decodeData(validatedData, as: T.self)
        } catch {
            throw resolve(error: error)
        }
    }
    
    private func validateHTTPResponse(_ response: HTTPURLResponse?, data: Data) throws -> Data {
        guard let response = response else {
            throw NetworkError.decodingFailed
        }
        
        switch response.statusCode {
        case 200...299:
            return data
        case 401:
            throw try handleErrorResponse(response, data: data)
        case 400...599:
            throw try handleErrorResponse(response, data: data)
        default:
            throw NetworkError.invalidResponse
        }
    }
    
    private func handleErrorResponse(_ response: HTTPURLResponse, data: Data) throws -> NetworkError {
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        } else {
            print("Data is not a valid UTF-8 string")
        }
        return NetworkError.invalidResponse
    }
    
    private func decodeData<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Decoding error: \(error)")
            throw NetworkError.decodingFailed
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }
        
        let code = (error as NSError).code
        switch code {
        case NSURLErrorNotConnectedToInternet:
            return NetworkError.invalidResponse
        case NSURLErrorCancelled:
            return NetworkError.invalidResponse
        default:
            return NetworkError.unknownError(code)
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case URLError
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response received from the server."
        case .URLError:
            return "Invalid response received from the server."
        case .decodingFailed:
            return "Failed to decode the response data."
        case .clientError(let statusCode):
            return "Client error occurred. Status code: \(statusCode)"
        case .serverError(let statusCode):
            return "Server error occurred. Status code: \(statusCode)"
        case .unknownError(let statusCode):
            return "An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
