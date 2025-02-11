//
//  Sample04ViewController.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

/*
 ヘッダが縮んだ後のレイアウトの高さを求めるためのView
 実際に表示されるわけではない
 */

class Sample04ViewController: UIViewController {

    private let guideStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()

    private let guideHeaderImageView: UIImageView = .make(backgroundColor: .systemBlue)

    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)

    private let guideCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGUideConstraint()
    }
}

private extension Sample04ViewController {
    func setupGuideUI() {
        self.view.addSubview(guideStackView)
        // viewのsafeAreaとsubViewの四隅を揃える
        self.view.fillSafeArea(subView: guideStackView)

        // stackviewに各viewを並べる
        guideStackView.addArrangedSubview(guideHeaderImageView)
        guideStackView.addArrangedSubview(guideTabView)
        guideStackView.addArrangedSubview(guideCollectionView)
    }

    func setupGUideConstraint() {
        //guideHeaderImageViewとguideTabViewの高さを決める
        /*
         stackviewが画面全体の制約があるため
         残った余白が高さの制約がないguideCollectionViewとなる
         */
        NSLayoutConstraint.activate([
            guideHeaderImageView.heightAnchor.constraint(equalToConstant: 60),
            guideTabView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

}

import SwiftUI
#Preview {
    Sample04ViewController()
}
