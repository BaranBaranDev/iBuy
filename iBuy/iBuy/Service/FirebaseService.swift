//
//  FirebaseService.swift
//  iBuy
//
//  Created by Baran Baran on 23.08.2024.
//

import FirebaseFirestore


// MARK: - ServiceProtocol
protocol ServiceProtocol {
    func fetchData<T: Decodable>(collectionName: String, completion: @escaping (Result<[T], ServiceError>) -> Void)
}




// MARK: - FirebaseService Class
final class FirebaseService {
    
     //MARK: Dependencies
    private let db: Firestore

    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }
    
}

// MARK: - FirebaseService:  ServiceProtocol
extension FirebaseService: ServiceProtocol {
    func fetchData<T: Decodable>(collectionName: String, completion: @escaping (Result<[T], ServiceError>) -> Void) {
        db.collection(FirebaseConstants.collectionName)
            .document(FirebaseConstants.documentID)
            .collection(collectionName)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion(.failure(.noDocuments))
                    return
                }
                
                do {
                    let data = try documents.compactMap { document -> T? in
                        return try document.data(as: T.self)
                    }
                    completion(.success(data))
                } catch let error {
                    completion(.failure(.decodingError(error)))
                }
            }
    }
}
