/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/02_twitter_01#uicollectionview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
 まで
 */


import UIKit

class Sample07ViewController: UIViewController {

    private let guideStackView: UIStackView = .make(axis: .vertical)
    private let guideHeaderImageView: UIView = .make(backgroundColor: .systemBlue)
    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)
    private let guideCollectionView: UIView = .make(backgroundColor: .systemRed)

    private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)
    private let mainStackView: UIStackView = .make(axis: .vertical)

    private let headerStackView: UIStackView = .make(axis: .vertical, backgroundColor: .systemYellow)
    private let pageScrollView: UIScrollView = UIScrollView.make(
        isPagingEnabled: true,
        backgroundColor: .systemRed
    )
    private let pageStackView: UIStackView = .make(axis: .horizontal)

    // 背景色にする色の数だけcollectionViewを用意する
    private let collectionViews: [UICollectionView] = [UIColor.systemTeal, UIColor.systemOrange, UIColor.systemPink, UIColor.systemBrown].compactMap({ color in

            let layout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain))

            let view = UICollectionView(frame: .zero, collectionViewLayout: layout )
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            return view
        })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGuideConstraint()
        setupUI()
        seutpConstraint()
    }
}

private extension Sample07ViewController {
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

        collectionViews.forEach {
            pageStackView.addArrangedSubview($0)
        }

    }

    func seutpConstraint() {

        NSLayoutConstraint.activate(
            [
                mainStackView.widthAnchor.constraint(
                    equalTo: mainScrollView.frameLayoutGuide.widthAnchor
                ),
//                mainStackView.heightAnchor.constraint(
//                    equalTo: mainScrollView.frameLayoutGuide.heightAnchor
//                ).priority(.init(rawValue: 1)),

                headerStackView.heightAnchor.constraint(
                    equalToConstant: 300
                ),
//                pageStackView.widthAnchor.constraint(
//                    equalTo: pageScrollView.frameLayoutGuide.widthAnchor,
//                    multiplier: 4
//                ).priority(
//                    .init(rawValue: 1)
//                ),
                pageScrollView.heightAnchor.constraint(
                    equalTo: guideCollectionView.heightAnchor
                )
            ] +
            // collectionViewの配列に対してひとつずつ制約を貼って一次元配列にする
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
