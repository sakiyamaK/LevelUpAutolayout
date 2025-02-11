//
//  NSLayoutConstraint+.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

extension NSLayoutConstraint {

    @discardableResult
    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
