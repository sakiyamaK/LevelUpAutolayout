
/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/01_kangaekata_01#redview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
 まで
 */

import UIKit

class Sample01ViewController: UIViewController {

    private let scrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentsView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let redView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupRedView()
    }
}

private extension Sample01ViewController {
    func setupScrollView() {

        self.view.addSubview(scrollView)
        // viewのsafeAreaとsubViewの四隅を揃える
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])


        scrollView.addSubview(contentsView)
        // scrollViewのContentlayoutGuideとsubViewの四隅を揃える
        NSLayoutConstraint.activate([
            contentsView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            contentsView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            contentsView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            contentsView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor)
        ])

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
}


import SwiftUI
#Preview {
    Sample01ViewController()
}
