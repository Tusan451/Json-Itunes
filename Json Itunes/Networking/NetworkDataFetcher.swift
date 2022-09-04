//
//  NetworkDataFetcher.swift
//  Json Itunes
//
//  Created by Olegio on 04.09.2022.
//

import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, responce: @escaping (SearchResponce?) -> Void) {
        networkService.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponce.self, from: data)
                    responce(tracks)
                } catch let jsonError {
                    print("Failed to decode Json", jsonError)
                }
            case .failure(let error):
                print("Error recieved requesting data: \(error.localizedDescription)")
                responce(nil)
            }
        }
    }
}
