//
//  Sample07ViewController.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/11.
//


import UIKit

class Sample07ViewController: UIViewController {

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

    private let headerStackView: UIStackView = {
        let view = UIStackView.makeStack()
        view.backgroundColor = .systemYellow
        return view
    }()

    private let pageScrollView: UIScrollView = {
        let view = UIScrollView.make(backgroundColor: .systemRed)
        view.isPagingEnabled = true
        return view
    }()

    private let pageStackView: UIStackView = {
        let view = UIStackView.makeStack()
        view.axis = .horizontal
        return view
    }()

    private let collectionViews: [UICollectionView] = {
        // 背景色にする色の数だけcollectionViewを用意する
        [UIColor.systemTeal, UIColor.systemOrange, UIColor.systemPink, UIColor.systemBrown].compactMap({ color in
            let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))
            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            return view
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGUideConstraint()
        setupUI()
        seutpConstraint()
    }
}

private extension Sample07ViewController {
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

        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(pageScrollView)

        pageScrollView.addSubview(pageStackView)
        pageScrollView.fillContentLayoutGuide(subView: pageStackView)

        collectionViews.forEach {
            pageStackView.addArrangedSubview($0)
        }
    }

    func seutpConstraint() {

        // 今はmainStackViewの高さを決める要素がないから仮でmainScrollView.frameLayoutGuideと同じ高さにしている
        // mainStackViewの中で組まれるレイアウトの高さを優先したいため、この制約のpriorityは1にする
        // priorityはなぜか初期化パラメータじゃないからめんどくさい..
//      mainScrollView.frameLayoutGuide.heightAnchor)
//      mainStackViewHeightConstraint.priority = .init(rawValue: 1)

        NSLayoutConstraint.activate(
            [
                // mainStackViewの幅と高さをmainScrollViewのスクロール領域にする
                mainStackView.widthAnchor.constraint(
                    equalTo: mainScrollView.frameLayoutGuide.widthAnchor
                ),
                //mainStackViewの高さは中の要素で決まるため、本来はこれはもういらない
                mainStackView.heightAnchor.constraint(
                    equalTo: mainScrollView.frameLayoutGuide.heightAnchor
                ).priority(.init(rawValue: 1)),

                // ヘッダの最大の高さを決める
                headerStackView.heightAnchor.constraint(
                    equalToConstant: 300
                ),

                // 縦にスクロールしてヘッダが縮んだ後のcollectionViewの高さ = guideCollectionViewの高さ
                pageScrollView.heightAnchor.constraint(
                    equalTo: guideCollectionView.heightAnchor
                )
            ] +
            collectionViews.compactMap({ collectionView in
                [
                    collectionView.widthAnchor.constraint(
                        equalTo: pageScrollView.frameLayoutGuide.widthAnchor
                    ),
                    collectionView.heightAnchor.constraint(
                        equalTo: pageScrollView.heightAnchor
                    )
                ]
            }).flatMap({ $0 })
        )
    }
}

import SwiftUI
#Preview {
    Sample07ViewController()
}

#Preview {
    Sample04ViewController()
}
