//
//  CacheManager.swift
//  iBuy
//
//  Created by Baran Baran on 22.09.2024.
//

import UIKit

// MARK: - CacheManagerProtocol
protocol CacheManagerProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    func clearCache(includeDisk: Bool)
    func compressImage(_ image: UIImage, toSize size: CGSize) -> UIImage?
}

// MARK: - CacheManager Class
final class CacheManager {
    
    // Singleton instance
    static let shared = CacheManager()
    
    // NSCache and background queue
    private let imageCache = NSCache<NSString, UIImage>()
    private let ioQueue = DispatchQueue(label: "com.ibuy.cacheManager", qos: .background)
    
    // Private initializer for Singleton
    private init() {
        imageCache.countLimit = 20
        imageCache.totalCostLimit = 50 * 1024 * 1024
    }
}

// MARK: - CacheManager: CacheManagerProtocol
extension CacheManager: CacheManagerProtocol {
    // MARK:  Image Caching
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = url.absoluteString as NSString
        
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        ioQueue.async { [weak self] in
            guard let self = self else { return }

            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { completion(image) }
        }
    }
    
    // MARK:  Disk Cache
    func clearCache(includeDisk: Bool = false) {
            imageCache.removeAllObjects()
            
            if includeDisk {
                ioQueue.async {
                    let fileManager = FileManager.default
                    if let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
                        do {
                            let files = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
                            for file in files {
                                try fileManager.removeItem(at: file)
                            }
                        } catch {
                            print("\(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    
    
    // MARK: Image Compression
    func compressImage(_ image: UIImage,toSize size: CGSize) -> UIImage? {
            let renderer = UIGraphicsImageRenderer(size: size)
            return renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: size))
            }
        }
}
