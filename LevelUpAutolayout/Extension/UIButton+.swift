//
//  UIButton+.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/23.
//

import UIKit

extension UIButton {
    static func make(title: String, tapAction: @escaping (() -> Void)) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = title
        let button = UIButton(configuration: config, primaryAction: .init(handler: { _ in
            tapAction()
        }))
        return button
    }
}
