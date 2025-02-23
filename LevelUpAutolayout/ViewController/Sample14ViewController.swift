/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/04_twitter_03#%E3%83%98%E3%83%83%E3%83%80%E3%81%AE%E3%82%BF%E3%82%A4%E3%83%88%E3%83%AB%E3%83%A9%E3%83%99%E3%83%AB%E3%82%92%E3%82%B9%E3%82%AF%E3%83%AD%E3%83%BC%E3%83%AB%E3%81%AB%E5%90%88%E3%82%8F%E3%81%9B%E3%81%A6%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%82%8B
  まで
*/

 import UIKit

 class Sample14ViewController: UIViewController {

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

     private let headerLabelContainerView: UIView = {
         let view = UIView.make()
         // headerLabelがこのviewの外にいったら非表示にするためにclipする
         view.clipsToBounds = true
         return view
     }()
     private let headerLabel: UILabel = {
         let label = UILabel.make(backgroundColor: .clear)
         label.font = .systemFont(ofSize: 17, weight: .medium)
         label.textColor = .label
         label.textAlignment = .center
         label.numberOfLines = 0
         label.text = "あなたの名前@namae"
         return label
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

 private extension Sample14ViewController {
     func setupUI() {

         self.view.addSubview(guideView)
         self.view.fillSafeArea(subView: guideView)

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

         self.view.addSubview(headerImageView)

         setupHeaderLabel()
     }

     func setupHeaderView() {
         headerStackView.addArrangedSubview(headerGuideImageView)
         headerStackView.addArrangedSubview(headerView)
     }

     func setupHeaderLabel() {
         self.view.addSubview(headerLabelContainerView)
         headerLabelContainerView.addSubview(headerLabel)
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
            headerImageView.centerYAnchor.constraint(equalTo: headerGuideImageView.centerYAnchor).priority(.defaultHigh),
            headerImageView.bottomAnchor
                .constraint(greaterThanOrEqualTo: guideView.headerImageView.bottomAnchor)
         ]

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

         setupHeaderLabelConstraint()
     }

     func setupHeaderLabelConstraint() {
         guideView.headerImageView.fill(subView: headerLabelContainerView)
         NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerLabelContainerView.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerLabelContainerView.centerYAnchor).priority(.defaultHigh),
            // headerLabelがheaderViewのnameLabelより常に下にくるようにする
            headerLabel.topAnchor.constraint(greaterThanOrEqualTo: headerView.nameLabel.topAnchor)

         ])
     }

 }

 import SwiftUI
 #Preview {
     Sample14ViewController()
 }

