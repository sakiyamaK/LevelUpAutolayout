/*
 Sample07ViewControllerと同じく

 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/02_twitter_01#uicollectionview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
 までだが、コードが煩雑になってきたのでGuide部分を別クラスに分ける
 */

import UIKit

class Sample08ViewController: UIViewController {

    // guideたちをGuideViewにする
    private let guideView: GuideView = .make()

    private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)
    private let mainStackView: UIStackView = .make(axis: .vertical)

    private let headerStackView: UIStackView = .make(axis: .vertical, backgroundColor: .systemYellow)

    private let pageScrollView: UIScrollView = UIScrollView.make(
        isPagingEnabled: true,
        backgroundColor: .systemRed
    )
    private let pageStackView: UIStackView = .make(axis: .horizontal)

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
        setupUI()
        seutpConstraint()
    }
}

private extension Sample08ViewController {
    func setupUI() {

        self.view.addSubview(guideView)
        self.view.fillSafeArea(subView: guideView)

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
                headerStackView.heightAnchor.constraint(
                    equalToConstant: 300
                ),
                pageScrollView.heightAnchor.constraint(
                    equalTo: guideView.collectionView.heightAnchor
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
    Sample08ViewController()
}
