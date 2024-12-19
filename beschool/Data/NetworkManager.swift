//
//  NetworkManager.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private func performRequest<T: Decodable>(router: BaseRouter) async throws -> T {
        let request = try router.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.responseError(statusCode: (response as? HTTPURLResponse)?.statusCode)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    private func performRequest(router: BaseRouter) async throws {
        let request = try router.asURLRequest()
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.responseError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
}

extension NetworkManager {
    
    func fetchClassrooms() async throws -> [ClassroomData]? {
        let response: ClassroomResponse = try await performRequest(router: ClassroomRouter.getClassrooms)
        return response.classrooms
    }
    
    func createClassroom(_ classroom: ClassroomData) async throws -> ClassroomData {
        let response: ClassroomData = try await performRequest(
            router: ClassroomRouter.createClassroom(id: classroom.id, parameters: classroom)
        )
        return response
    }
    
    func editClassroom(_ classroom: ClassroomData) async throws -> ClassroomData  {
        return try await performRequest(
            router: ClassroomRouter.updateClassroom(
                id: classroom.id,
                parameters: classroom
            )
        )
    }
    
    func deleteClassroom(id: String) async throws -> Bool {
        let response: DeleteResponse = try await performRequest(router: ClassroomRouter.deleteClassroom(id: id))
        return response.deleted
    }
}
