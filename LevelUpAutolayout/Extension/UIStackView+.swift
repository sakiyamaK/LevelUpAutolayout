//
//  UIStackView+.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

extension UIStackView {
    // Selfとすることで継承したクラスで呼ぶとそのクラスとして呼ばれる
    static func make(axis: NSLayoutConstraint.Axis, backgroundColor: UIColor? = nil) -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = axis
        view.backgroundColor = backgroundColor
        return view
    }

}
