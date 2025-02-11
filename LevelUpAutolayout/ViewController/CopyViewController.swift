//
//  CopyViewController.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

// コピペ用のテンプレ

import UIKit

class CopyViewController: UIViewController {

    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentsView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
    }
}

private extension CopyViewController {
    func setupScrollView() {
        self.view.addSubview(scrollView)
        // viewのsafeAreaとsubViewの四隅を揃える
        self.view.fillSafeArea(subView: scrollView)

        scrollView.addSubview(contentsView)
        // scrollViewのContentlayoutGuideとsubViewの四隅を揃える
        scrollView.fillContentLayoutGuide(subView: contentsView)

        // contentsViewの横幅をScrollViewのframeLayoutGuideの横幅に合わせる
        // contentsViewの高さをScrollViewのframeLayoutGuideの高さの2倍にする
        NSLayoutConstraint.activate([
            contentsView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentsView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 2)
        ])
    }
}

import SwiftUI
#Preview {
    CopyViewController()
}
