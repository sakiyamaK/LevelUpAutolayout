//
//  GuideView.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/12.
//

import UIKit

class GuideView: UIView {

    let stackView: UIStackView = .make(axis: .vertical)
    let headerImageView: UIView = .make(backgroundColor: .systemBlue)
    let tabView: UIView = .make(backgroundColor: .systemGreen)
    let collectionView: UIView = .make(backgroundColor: .systemRed)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(stackView)
        // viewのsubViewの四隅を揃える
        self.fill(subView: stackView)

        // stackviewに各viewを並べる
        stackView.addArrangedSubview(headerImageView)
        stackView.addArrangedSubview(tabView)
        stackView.addArrangedSubview(collectionView)
    }

    func setupConstraint() {
        //headerImageViewとtabViewの高さを決める
        /*
         stackviewが画面全体の制約があるため
         残った余白が高さの制約がないguideCollectionViewとなる
         */
        NSLayoutConstraint.activate([
            // ヘッダの最小の高さになる
            headerImageView.heightAnchor.constraint(equalToConstant: 60),
            tabView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

#Preview {
    GuideView.make()
}
