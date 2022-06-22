//
//  NetworkService.swift
//  MyCryptoProject
//
//  Created by Grekhem on 21.06.2022.
//

import Foundation

protocol INetworkService {
    func loadData<T:Decodable>(completion: @escaping (Result<T, Error>) -> ())
}

final class NetworkService {
    
    
    
}

extension NetworkService: INetworkService {
    
    func loadData<T:Decodable>(completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else { assert( false ) }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
