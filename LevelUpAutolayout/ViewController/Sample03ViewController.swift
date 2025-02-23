/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/01_kangaekata_02#greenview%E3%81%8Cblueview%E3%81%AE%E4%BD%8D%E7%BD%AE%E3%81%A7%E6%AD%A2%E3%81%BE%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B
 まで
 */

import UIKit

class Sample03ViewController: UIViewController {

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

        setupSubConstraint()
    }
}

private extension Sample03ViewController {
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

        // センターYをredViewのセンターYと合わせて優先度をdefaultLow(250)まで下げる
        let centerYConstrait = greenView.centerYAnchor.constraint(equalTo: redView.centerYAnchor)
        centerYConstrait.priority = .defaultLow

        NSLayoutConstraint.activate([
            // 高さを80にする
            greenView.heightAnchor.constraint(equalToConstant: 80),
            // 幅を高さと同じにする(aspect ratio 1:1)
            greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor),
            // センターXをredViewのセンターXと合わせる
            greenView.centerXAnchor.constraint(equalTo: redView.centerXAnchor),
            centerYConstrait
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

    func setupSubConstraint() {

        // greenViewの上辺(Y座標)がblueViewの上辺(Y座標)以上にする
        // UIKitでは下に行くほどy座標が高くなる
        // つまりスクロールしてもgreenViewがblueViewより上にくることはない
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(greaterThanOrEqualTo: blueView.topAnchor),
        ])

    }

}

import SwiftUI
#Preview {
    Sample03ViewController()
}
