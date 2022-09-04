//
//  NetworkService.swift
//  Json Itunes
//
//  Created by Olegio on 04.09.2022.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping (Result<SearchResponce, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let tracks = try JSONDecoder().decode(SearchResponce.self, from: data)
                    completion(.success(tracks))
                } catch let jsonError {
                    print("Failed to decode Json", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
