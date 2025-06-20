//
//  NetworkManager.swift
//  CombineSwiftUI
//
//  Created by Sanket Vaghela on 20/06/25.
//

import Foundation
import Combine

enum Endpoint:String {
    case products
    case details
}

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case unknown
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private var cancellables: Set<AnyCancellable> = []
    private let baseURL = URL(string: "https://fakestoreapi.com/")!
    
    func getData<T: Decodable>(from endpoint: Endpoint) -> Future<T, Error> {
        
        return Future { promise in
            let url = self.baseURL.appendingPathComponent(endpoint.rawValue)
            guard let url = URL(string: url.absoluteString) else {
                promise(.failure(NetworkError.invalidURL))
                return
            }

            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) in
                    guard let httpResponse = response as? HTTPURLResponse else{
                        throw NetworkError.unknown
                    }
                    
                    switch httpResponse.statusCode {
                    case 200..<300:
                        return data
                    default:
                        throw NetworkError.unknown
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(NetworkError.noData))
                    }
                } receiveValue: { decodedData in
                    promise(.success(decodedData))
                }
                .store(in: &self.cancellables)
        }
    }
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The provided URL is invalid.", comment: "Invalid URL error")
        case .decodingFailed:
            return NSLocalizedString("Failed to decode the response.", comment: "Decoding error")
        case .noData:
            return NSLocalizedString("No data was received.", comment: "No data error")
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "Unknown error")
        }
    }
}
