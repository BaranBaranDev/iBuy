//
//  ServiceError.swift
//  iBuy
//
//  Created by Baran Baran on 26.08.2024.
//

import Foundation

enum ServiceError: Error {
    case noDocuments
    case decodingError(Error)
    case firebaseError(Error)
    
    var localizedDescription: String {
        switch self {
        case .noDocuments:
            return "No documents found."
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .firebaseError(let error):
            return "Firebase error: \(error.localizedDescription)"
        }
    }
}
