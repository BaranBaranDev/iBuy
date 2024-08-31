//
//  Category.swift
//  iBuy
//
//  Created by Baran Baran on 31.08.2024.
//

import Foundation

// MARK: - Category Enum
enum Category {
    case macbook
    case iphone
    case accessories
    case visionPro
    case watches
    
    var name: String {
        switch self {
        case .macbook: return "MacBook"
        case .iphone: return "iPhone"
        case .accessories: return "Accessories"
        case .visionPro: return "Vision Pro"
        case .watches: return "Watches"
        }
    }
    
    var iconName: String {
        switch self {
        case .macbook: return "macbook"
        case .iphone: return "iphone"
        case .accessories: return "airpodspro.chargingcase.wireless"
        case .visionPro: return "visionpro"
        case .watches: return "applewatch"
        }
    }
    
    static let allCategories: [Category] = [.macbook, .iphone, .visionPro, .watches, .accessories]
    
}
