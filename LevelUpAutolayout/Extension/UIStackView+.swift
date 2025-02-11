//
//  UIStackView+.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

extension UIStackView {
    // Selfとすることで継承したクラスで呼ぶとそのクラスとして呼ばれる
    static func makeStack() -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }
}
