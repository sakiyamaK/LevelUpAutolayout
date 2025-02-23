/*
  https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/03_twitter_02#headermainmarginview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
  まで
*/

 import UIKit

 class Sample10ViewController: UIViewController {

     private let guideView: GuideView = .make()

     private let mainScrollView: UIScrollView = .make(backgroundColor: .systemBackground)
     private let mainStackView: UIStackView = .make(axis: .vertical)

     private let headerStackView: UIStackView = .make(axis: .vertical)
     private let headerGuideImageView: UIView = .make(backgroundColor: .systemGray3)
     private let headerView: Header02View = .make(delegate: .init(tapEditButton: {
         print("編集ボタンを押したよ")
     }, tapTweet: {
         print("ツイートボタンを押したよ")
     }, tapReply: {
         print("リプライボタンを押したよ")
     }, tapMedia: {
         print("メディアボタンを押したよ")
     }, tapLike: {
         print("いいねボタンを押したよ")
     }))

     private let pageScrollView: UIScrollView = UIScrollView.make(
         isPagingEnabled: true,
         backgroundColor: .systemRed
     )
     private let pageStackView: UIStackView = .make(axis: .horizontal)

     private let collectionViews: [UICollectionView] = {
         [UIColor.systemTeal, UIColor.systemOrange, UIColor.systemPink, UIColor.systemBrown].compactMap({ color in
                 .make(
                     layout: UICollectionViewCompositionalLayout.list(using: .init(appearance: .plain)),
                     backgroundColor: color
                 )
         })
     }()

     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
         setupUI()
         seutpConstraint()
     }
 }

 private extension Sample10ViewController {
     func setupUI() {

         self.view.addSubview(guideView)
         self.view.fillSafeArea(subView: guideView)

         self.view.addSubview(mainScrollView)
         self.view.fillSafeArea(subView: mainScrollView)
         mainScrollView.addSubview(mainStackView)
         mainScrollView.fillContentLayoutGuide(subView: mainStackView)

         mainStackView.addArrangedSubview(headerStackView)

         //ヘッダの構造を別メソッドで用意
         setupHeaderView()

         mainStackView.addArrangedSubview(pageScrollView)

         pageScrollView.addSubview(pageStackView)
         pageScrollView.fillContentLayoutGuide(subView: pageStackView)

         collectionViews.forEach {
             pageStackView.addArrangedSubview($0)
         }
     }

     func setupHeaderView() {
         headerStackView.addArrangedSubview(headerGuideImageView)
         headerStackView.addArrangedSubview(headerView)
     }

     func seutpConstraint() {

         NSLayoutConstraint.activate(
             [
                 mainStackView.widthAnchor.constraint(
                     equalTo: mainScrollView.frameLayoutGuide.widthAnchor
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
             }).flatMap({ $0 }) + [
                 // ヘッダのガイドの高さを決める
                 headerGuideImageView.heightAnchor.constraint(equalToConstant: 180)
             ] + [
                // ヘッダのタブの高さをガイドの高さに合わせる
                headerView.tabStackView.heightAnchor.constraint(equalTo: guideView.tabView.heightAnchor)
             ]
         )
     }
 }

 import SwiftUI
 #Preview {
     Sample10ViewController()
 }

