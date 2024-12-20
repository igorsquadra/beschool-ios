//
//  NetworkError.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFormatError
    case encodingError
    case responseError(statusCode: Int? = nil)
    case noData
    case decodingError
    case unknownError(description: String)
}
