//
//  UICollectionView+.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/23.
//

import UIKit

extension UICollectionView {
    static func make(layout: UICollectionViewLayout, backgroundColor: UIColor? = nil) -> Self {
        let view = self.init(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        return view
    }
}
