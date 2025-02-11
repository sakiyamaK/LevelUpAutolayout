//
//  Sample05ViewController.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//

import UIKit

class Sample05ViewController: UIViewController {

    private let guideStackView: UIStackView = .makeStack()

    private let guideHeaderImageView: UIImageView = .make(backgroundColor: .systemBlue)

    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)

    private let guideCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()

    private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)

    private let mainStackView: UIStackView = .makeStack()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGUideConstraint()
        setupUI()
        seutpConstraint()
    }
}

private extension Sample05ViewController {
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
            // ヘッダの最小の高さになる
            guideHeaderImageView.heightAnchor.constraint(equalToConstant: 60),
            guideTabView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    func setupUI() {
        self.view.addSubview(mainScrollView)
        self.view.fillSafeArea(subView: mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainScrollView.fillContentLayoutGuide(subView: mainStackView)
    }

    func seutpConstraint() {
        // 今はmainStackViewの高さを決める要素がないから仮でmainScrollView.frameLayoutGuideと同じ高さにしている
        // mainStackViewの中で組まれるレイアウトの高さを優先したいため、この制約のpriorityは1にする
        // priorityはなぜか初期化パラメータじゃないからめんどくさい..
        let mainStackViewHeightConstraint = mainStackView.heightAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.heightAnchor)
        mainStackViewHeightConstraint.priority = .init(rawValue: 1)

        NSLayoutConstraint.activate([
            mainStackView.widthAnchor.constraint(equalTo: mainScrollView.frameLayoutGuide.widthAnchor),
            mainStackViewHeightConstraint
        ])
    }

}

import SwiftUI
#Preview {
    Sample05ViewController()
}
