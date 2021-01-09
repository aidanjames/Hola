//
//  NetworkingManager.swift
//  Hola (iOS)
//
//  Created by Aidan Pendlebury on 09/01/2021.
//

import Foundation

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
      
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // the task has completed – push our work back to the main thread
            DispatchQueue.main.async {
                if let data = data {
                    // success: convert the data to a string and send it back
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // any sort of network failure
                    completion(.failure(.requestFailed))
                } else {
                    // this ought not to be possible, yet here we are
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}
