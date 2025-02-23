/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/04_twitter_03#%E3%83%98%E3%83%83%E3%83%80%E7%94%BB%E5%83%8F%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
  まで
*/

 import UIKit

 class Sample11ViewController: UIViewController {

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
     private let headerImageView: UIImageView = {
         let imageView = UIImageView.make(backgroundColor: .white)
         imageView.contentMode = .scaleAspectFit
         imageView.image = UIImage(systemName: "swift")
         imageView.tintColor = .systemOrange
         return imageView
     }()

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

 private extension Sample11ViewController {
     func setupUI() {

         self.view.addSubview(guideView)
         self.view.fill(subView: guideView)

         self.view.addSubview(mainScrollView)
         self.view.fillSafeArea(subView: mainScrollView)
         mainScrollView.addSubview(mainStackView)
         mainScrollView.fillContentLayoutGuide(subView: mainStackView)

         mainStackView.addArrangedSubview(headerStackView)

         setupHeaderView()

         mainStackView.addArrangedSubview(pageScrollView)

         pageScrollView.addSubview(pageStackView)
         pageScrollView.fillContentLayoutGuide(subView: pageStackView)

         collectionViews.forEach {
             pageStackView.addArrangedSubview($0)
         }

         // 大元のviewにheaderImageViewを足す
         self.view.addSubview(headerImageView)
     }

     func setupHeaderView() {
         headerStackView.addArrangedSubview(headerGuideImageView)
         headerStackView.addArrangedSubview(headerView)
     }

     func seutpConstraint() {

         var constraints: [NSLayoutConstraint] = [
            mainStackView.widthAnchor.constraint(
                equalTo: mainScrollView.frameLayoutGuide.widthAnchor
            ),
            pageScrollView.heightAnchor.constraint(
                equalTo: guideView.collectionView.heightAnchor
            )
         ] + [
            headerGuideImageView.heightAnchor.constraint(equalToConstant: 120)
         ] + [
            headerView.tabStackView.heightAnchor.constraint(equalTo: guideView.tabView.heightAnchor)
         ] + [
            headerImageView.widthAnchor.constraint(equalTo: headerGuideImageView.widthAnchor),
            headerImageView.heightAnchor.constraint(equalTo: headerGuideImageView.heightAnchor),
            headerImageView.centerXAnchor.constraint(equalTo: headerGuideImageView.centerXAnchor),
            headerImageView.centerYAnchor.constraint(equalTo: headerGuideImageView.centerYAnchor)
         ]

         // なぜかこうしないとエラーになった
         constraints.append(contentsOf: collectionViews.compactMap({ collectionView in
             [
                 collectionView.widthAnchor.constraint(
                     equalTo: pageScrollView.frameLayoutGuide.widthAnchor
                 ),
                 collectionView.heightAnchor.constraint(
                     equalTo: pageScrollView.heightAnchor
                 )
             ]
         }).flatMap({ $0 }))


         NSLayoutConstraint.activate(constraints)
     }
 }

 import SwiftUI
 #Preview {
     Sample11ViewController()
 }

