//
//  SectionType.swift
//  iBuy
//
//  Created by Baran Baran on 31.08.2024.
//

import Foundation

// MARK: - SectionType Enum
 enum SectionType: Int, CaseIterable {
    case featured = 0
    case category = 1
    case products = 2
    
    var sectionTitle: String {
        switch self {
        case .featured:
            return "Featured"
        case .category:
            return "Category"
        case .products:
            return "Products"
        }
    }
}
