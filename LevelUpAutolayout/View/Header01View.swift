/*
 https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/03_twitter_02#headermainmarginview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
 まで
 */

import UIKit

class Header01View: UIView {

    // 宣言的に書きたいために、最近Delegateパターンをこうしてstructで用意することが多い
    struct Delegate {
        var tapEditButton: () -> Void = {}
    }

    var delegate: Delegate? = nil

    static func make(delegate: Delegate) -> Header01View {
        let view = Header01View.make()
        view.delegate = delegate
        return view
    }

    let iconView = UIImageView.make(backgroundColor: .systemGray)
    // weak selfをするためにlazyじゃないとダメ
    lazy var button: UIButton = {[weak self] in
        var config = UIButton.Configuration.plain()
        config.title = "変更"
        let button = UIButton(configuration: config, primaryAction: .init(handler: {[weak self] _ in
            self!.delegate?.tapEditButton()
        }))
        return button
    }()

    let nameLabel = {
        let label = UILabel()
        label.text = "あなたの名前@namae"
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        return label
    }()

    let infoLabel = {
        let label = UILabel()
        label.text = Array(repeating: "ヘッダの情報でええす", count: 10).joined(separator: "")
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let mainStackView: UIStackView = .make(axis: .vertical)
        /*
         stackviewの中にマージンを入れたければこの2行を用意する

         https://zenn.dev/sakiyamak/books/1cc7cffd69b476a81984/viewer/03_twitter_02#headermainmarginview%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
         だとHeaderMarginViewを用意しているがいらなかった...
         この設定を知らなかったから...
         */
        mainStackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        mainStackView.isLayoutMarginsRelativeArrangement = true

        mainStackView.spacing = 10
        self.addSubview(mainStackView)
        self.fill(subView: mainStackView)

        let hStack: UIStackView = .make(axis: .horizontal)
        hStack.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        hStack.isLayoutMarginsRelativeArrangement = true
        hStack.alignment = .top

        mainStackView.addArrangedSubview(hStack)

        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(UIView.make())
        hStack.addArrangedSubview(button)

        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(infoLabel)
    }

    func setupConstraint() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 36),
            iconView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}


#Preview {
    {
        let view = Header01View.make()
        let vc = UIViewController()
        vc.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            view.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 300).priority(.init(1))
        ])

        return vc
    }()
}
