//
//  StudentRouter.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//


import Foundation

enum StudentRouter: BaseRouter {
    case fetchStudents
    case editStudent(id: String, student: StudentData)
    case deleteStudent(id: String)
    
    var baseUrl: String { Utils.currentEnvironment.baseURL }
    
    var path: String {
        switch self {
        case .fetchStudents:
            return "/students"
        case .editStudent(let id, _):
            return "/students/\(id)"
        case .deleteStudent(let id):
            return "/students/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchStudents:
            return .get
        case .editStudent:
            return .put
        case .deleteStudent:
            return .delete
        }
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var parameters: Encodable? {
        switch self {
        case .editStudent(_, let student):
            return student
        default:
            return nil
        }
    }
    
    var apiKey: String? { Utils.currentEnvironment.apiKey }
}
