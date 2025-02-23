/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/02_twitter_01#headerstackview%E3%81%A8pagescrollview%E3%81%A8pagestackview
 まで
 */


import UIKit

class Sample06ViewController: UIViewController {

    private let guideStackView: UIStackView = .make(axis: .vertical)
    private let guideHeaderImageView: UIView = .make(backgroundColor: .systemBlue)
    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)
    private let guideCollectionView: UIView = .make(backgroundColor: .systemRed)

    private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)
    private let mainStackView: UIStackView = .make(axis: .vertical)

    private let headerStackView: UIStackView = .make(axis: .vertical, backgroundColor: .systemYellow)

    private let pageScrollView: UIScrollView = {
        let view = UIScrollView.make(backgroundColor: .systemRed)
        view.isPagingEnabled = true
        return view
    }()

    private let pageStackView: UIStackView = .make(axis: .horizontal)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGuideConstraint()
        setupUI()
        seutpConstraint()
    }
}

private extension Sample06ViewController {
    func setupGuideUI() {
        self.view.addSubview(guideStackView)
        self.view.fillSafeArea(subView: guideStackView)

        guideStackView.addArrangedSubview(guideHeaderImageView)
        guideStackView.addArrangedSubview(guideTabView)
        guideStackView.addArrangedSubview(guideCollectionView)
    }

    func setupGuideConstraint() {
        NSLayoutConstraint.activate([
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
    }

    func seutpConstraint() {

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
                // 本来はpageStackViewにaddArrangedSubviewされるViewの横幅で決まる
                // まだ未設定なので仮でpageScrollViewの4倍にする
                pageStackView.widthAnchor.constraint(
                    equalTo: pageScrollView.frameLayoutGuide.widthAnchor,
                    multiplier: 4
                ).priority(
                    .init(rawValue: 1)
                ),
                // 縦にスクロールしてヘッダが縮んだ後のcollectionViewの高さ = guideCollectionViewの高さ
                pageScrollView.heightAnchor.constraint(
                    equalTo: guideCollectionView.heightAnchor
                )
            ]
        )
    }

}

import SwiftUI
#Preview {
    Sample06ViewController()
}
