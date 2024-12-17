//
//  BaseRouter.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

protocol BaseRouter {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Encodable? { get }
    var contentType: String { get }
    var apiKey: String? { get }
}

extension BaseRouter {
    var parameters: Encodable? { nil }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(path) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if let apiKey {
            urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        if let parameters {
            switch method {
            case .get:
                try configureURLParameters(request: &urlRequest, parameters: parameters)
            case .post, .put:
                try configureBodyParameters(request: &urlRequest, parameters: parameters)
            default:
                throw NetworkError.requestFormatError
            }
        }
        
        return urlRequest
    }
    
    private func configureURLParameters(request: inout URLRequest, parameters: Encodable) throws {
        guard let queryParams = parameters.asDictionary else {
            throw NetworkError.encodingError
        }
        var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
        components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        request.url = components?.url
    }
    
    private func configureBodyParameters(request: inout URLRequest, parameters: Encodable) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(parameters)
            request.httpBody = data
        } catch {
            throw NetworkError.encodingError
        }
    }
}
