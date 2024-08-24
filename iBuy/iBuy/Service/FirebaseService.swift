//
//  FirebaseService.swift
//  iBuy
//
//  Created by Baran Baran on 23.08.2024.
//
import Foundation
import FirebaseFirestore

final class FirebaseService {
    
    static let shared = FirebaseService()
    private init() {}
    
    func fetchFeatures(completion: @escaping (Result<[FeatureResponse], Error>) -> Void) {
        let db = Firestore.firestore() // Firestore veritabanını başlatıyoruz.
        
        db.collection("iBuy") // `iBuy` koleksiyonuna erişiyoruz.
            .document("P09zzkenN8uMcybcGcxH") // Belirtilen belge ID'sine erişiyoruz.
            .collection("features") // Belgedeki `features` alt koleksiyonuna erişiyoruz.
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    // Hata varsa, completion kapanış fonksiyonuna hata ile birlikte dönüyoruz.
                    completion(.failure(error))
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    // Eğer dökümanlar yoksa, bir hata dönüyoruz.
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found."])
                    completion(.failure(error))
                    return
                }
                
                var features: [FeatureResponse] = [] // Özellikleri depolayacağımız bir dizi oluşturuyoruz.
                
                for document in documents {
                    let data = document.data()
                    
                    // Belgeden `name` ve `url` verilerini alıyoruz ve bunları `FeatureResponse` nesnesine dönüştürüyoruz.
                    if let title = data["name"] as? String, // Firestore'daki `name` alanını `String` türünde alıyoruz.
                       let imageUrl = data["url"] as? String { // Firestore'daki `url` alanını `String` türünde alıyoruz.
                        // Alınan verileri kullanarak bir `FeatureResponse` nesnesi oluşturuyoruz.
                        let feature = FeatureResponse(title: title, imageUrl: imageUrl)
                        features.append(feature) // Özellikler dizisine ekliyoruz.
                    }
                }
                
                // Özellikler dizisini başarıyla döndürmek için completion kapanış fonksiyonunu çağırıyoruz.
                completion(.success(features))
            }
    }
}
