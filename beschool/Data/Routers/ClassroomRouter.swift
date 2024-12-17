//
//  ClassroomRouter.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation


enum ClassroomRouter: BaseRouter {
    case getClassrooms
    case getClassroomDetails(id: String)
    case createClassroom(parameters: ClassroomData)
    case updateClassroom(id: String, parameters: ClassroomData)
    case deleteClassroom(id: String)
    
    var baseUrl: String { Utils.currentEnvironment.baseURL }
    
    var path: String {
        switch self {
        case .getClassrooms:
            return "/classrooms"
        case let .getClassroomDetails(id):
            return "/classrooms/\(id)"
        case .createClassroom:
            return "/classrooms"
        case let .updateClassroom(id, _):
            return "/classrooms/\(id)"
        case let .deleteClassroom(id):
            return "/classrooms/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getClassrooms, .getClassroomDetails:
            return .get
        case .createClassroom:
            return .post
        case .updateClassroom:
            return .put
        case .deleteClassroom:
            return .delete
        }
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var apiKey: String? { Utils.currentEnvironment.apiKey }
    
    var parameters: Encodable? {
        switch self {
        case .getClassrooms, .getClassroomDetails, .deleteClassroom:
            return nil
        case let .createClassroom(parameters), let .updateClassroom(_, parameters):
            return parameters
        }
    }
}
