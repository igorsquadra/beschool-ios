//
//  ProfessorRouter.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

enum ProfessorRouter: BaseRouter {
    case fetchProfessors
    case editProfessor(id: String, professor: ProfessorData)
    case deleteProfessor(id: String)
    
    var baseUrl: String { Utils.currentEnvironment.baseURL }
    
    var path: String {
        switch self {
        case .fetchProfessors:
            return "/professors"
        case .editProfessor(let id, _):
            return "/professors/\(id)"
        case .deleteProfessor(let id):
            return "/professors/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchProfessors:
            return .get
        case .editProfessor:
            return .put
        case .deleteProfessor:
            return .delete
        }
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var parameters: Encodable? {
        switch self {
        case .editProfessor(_, let professor):
            return professor
        default:
            return nil
        }
    }
    
    var apiKey: String? { Utils.currentEnvironment.apiKey }
}
