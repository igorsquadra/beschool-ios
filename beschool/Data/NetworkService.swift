//
//  NetworkService.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

class NetworkService {
    static func performRequest<T: Decodable>(router: BaseRouter, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let request = try router.asURLRequest()
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(.failure(.responseError()))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    completion(.failure(.responseError()))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        } catch {
            completion(.failure(.requestFormatError))
        }
    }
}
