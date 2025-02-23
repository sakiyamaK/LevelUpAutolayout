/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/01_kangaekata_02#greenview%E3%81%8Cblueview%E3%81%AE%E4%BD%8D%E7%BD%AE%E3%81%A7%E6%AD%A2%E3%81%BE%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B
 まで
 */

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
    // あくまで位置や高さを知るために貼っているだけだから実務では色はつけなくていいよ
    private let guideHeaderImageView: UIView = .make(backgroundColor: .systemBlue)
    private let guideTabView: UIView = .make(backgroundColor: .systemGreen)
    private let guideCollectionView: UIView = .make(backgroundColor: .systemRed)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGuideUI()
        setupGuideConstraint()
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

    func setupGuideConstraint() {
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
