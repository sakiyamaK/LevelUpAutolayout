/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/01_kangaekata_01#blueview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
 まで
 */

import UIKit

class Sample02ViewController: UIViewController {

    private let scrollView = UIScrollView.make()

    private let contentsView = UIView.make()

    private let redView = UIView.make(backgroundColor: .systemRed)
    private let greenView = UIView.make(backgroundColor: .systemGreen)
    private let blueView = UIView.make(backgroundColor: .systemBlue)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupBlueView()
        setupScrollView()
        setupRedView()
        setupGreenView()
    }
}

private extension Sample02ViewController {
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

    func setupRedView() {
        contentsView.addSubview(redView)


        // 中心のy座標をcontentsViewの中心のy座標*0.5(中心から1/4上にずらす)にする
        /*

         なぜか
         redView.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor, multiplier: 0.5)
         がない
         もっと汎用的なNSLayoutConstraintクラスのインスタンス生成で書く
         */

        let centerYConstraint = NSLayoutConstraint(item: redView,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: contentsView,
                                                   attribute: .centerY,
                                                   multiplier: 0.5,
                                                   constant: 0)
        NSLayoutConstraint.activate([
            // 高さを100にする
            redView.heightAnchor.constraint(equalToConstant: 100),
            // 横をcontentsViewの0.8倍にする
            redView.widthAnchor.constraint(equalTo: contentsView.widthAnchor, multiplier: 0.8),
            // 中心のX座標をcontentsViewの中心のX座標にする
            redView.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor),
            centerYConstraint
        ])
    }

    func setupGreenView() {
        // あくまで大元のviewの上にgreenViewを置く
        view.addSubview(greenView)

        NSLayoutConstraint.activate([
            // 高さを80にする
            greenView.heightAnchor.constraint(equalToConstant: 80),
            // 幅を高さと同じにする(aspect ratio 1:1)
            greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor),
            // redViewのセンターと合わせる
            greenView.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            greenView.centerYAnchor.constraint(equalTo: redView.centerYAnchor),
        ])
    }

    func setupBlueView() {
        // あくまで大元のviewの上にgreenViewを置く
        view.addSubview(blueView)

        NSLayoutConstraint.activate([
            // 高さを100にする
            blueView.heightAnchor.constraint(equalToConstant: 100),
            // 左右をviewに揃える
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // 上をviewのsafeAreaに揃える
            blueView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }

}

import SwiftUI
#Preview {
    Sample02ViewController()
}
