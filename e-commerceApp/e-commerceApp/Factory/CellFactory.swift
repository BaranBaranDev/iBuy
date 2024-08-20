//
//  CellFactory.swift
//  e-commerceApp
//
//  Created by Baran Baran on 20.08.2024.
//

import UIKit

struct CellFactory {
    
    static func build(_ collectionView: UICollectionView, _ indexPath: IndexPath, reuseIdentifier: String, collectionCell: UICollectionViewCell.Type) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? collectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
