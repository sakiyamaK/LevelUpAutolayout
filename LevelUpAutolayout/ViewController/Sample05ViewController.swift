/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/02_twitter_01#mainscrollview%E3%81%A8mainstackview
 まで
 */

import UIKit

class Sample05ViewController: UIViewController {

    private let guideStackView: UIStackView = .make(axis: .vertical)
    private let guideHeaderImageView: UIView = .make(backgroundColor: .systemBlue)
    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)
    private let guideCollectionView: UIView = .make(backgroundColor: .systemRed)

    private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)
    private let mainStackView: UIStackView = .make(axis: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGuideConstraint()
        setupUI()
        seutpConstraint()
    }
}

private extension Sample05ViewController {
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
