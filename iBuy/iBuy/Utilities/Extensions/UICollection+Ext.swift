//
//  UICollection+Ext.swift
//  iBuy
//
//  Created by Baran Baran on 21.09.2024.
//

import Foundation

// MARK: - Collection Extension
extension Collection {
    /// Safely accesses an element at the specified index.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
