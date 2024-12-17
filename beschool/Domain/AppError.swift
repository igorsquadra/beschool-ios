//
//  AppError.swift
//  beschool
//
//  Created by Igor Squadra on 17/12/24.
//

import Foundation

enum AppError: LocalizedError, Error {
    case networkError(message: String, actions: [AlertAction]?)
    case invalidData
    case signInError(String)
    case genericError
    case customError(title: String, message: String, actions: [AlertAction]?, debugDescription: String?)
    
    // MARK: - Initialize from NetworkError
    init(networkError: NetworkError) {
        switch networkError {
        case .invalidURL:
            self = .networkError(message: "L'URL fornito non è valido.", actions: nil)
        case .requestFormatError:
            self = .networkError(message: "Errore di formattazione della richiesta.", actions: nil)
        case .encodingError:
            self = .networkError(message: "Impossibile codificare i dati della richiesta.", actions: nil)
        case let .responseError(statusCode):
            let message = statusCode != nil
            ? "Errore del server. Codice di stato: \(statusCode!)."
            : "Errore del server. Risposta non valida."
            self = .networkError(message: message, actions: nil)
        case .noData:
            self = .invalidData
        case .decodingError:
            self = .networkError(message: "Impossibile decodificare i dati ricevuti.", actions: nil)
        case let .unknownError(description):
            self = .customError(title: "Errore sconosciuto",
                                message: description,
                                actions: nil,
                                debugDescription: description)
        }
    }
    
    // MARK: - User-friendly Title and Message
    var userTitle: String {
        switch self {
        case .networkError:
            return "Errore di Connessione"
        case .invalidData:
            return "Dati Invalidi"
        case .signInError:
            return "Errore di Accesso"
        case .genericError:
            return "Errore Generico"
        case let .customError(title, _, _, _):
            return title
        }
    }
    
    var userMessage: String {
        switch self {
        case let .networkError(message, _):
            return message
        case .invalidData:
            return "I dati ricevuti non sono validi. Riprova."
        case .signInError:
            return "C'è stato un problema con l'accesso. Verifica le credenziali."
        case .genericError:
            return "Si è verificato un errore sconosciuto. Riprova più tardi."
        case let .customError(_, message, _, _):
            return message
        }
    }
    
    // Debugging Description
    var errorDescription: String? {
        switch self {
        case let .networkError(message, _):
            return "Network Error: \(message)"
        case .invalidData:
            return "Invalid Data Error: I dati ricevuti non sono validi."
        case let .signInError(message):
            return "Sign In Error: \(message)"
        case .genericError:
            return "Generic Error: Si è verificato un errore sconosciuto."
        case let .customError(_, _, _, debugDescription):
            return debugDescription
        }
    }
}
