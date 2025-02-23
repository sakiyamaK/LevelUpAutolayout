//
//  Header02View.swift
//  LevelUpAutolayout
//
//  Created by sakiyamaK on 2025/02/23.
//


import UIKit

class Header02View: UIView {

    // Delegateのパターンをボタンの数だけ増やす
    struct Delegate {
        var tapEditButton: () -> Void = {}
        var tapTweet: () -> Void = {}
        var tapReply: () -> Void = {}
        var tapMedia: () -> Void = {}
        var tapLike: () -> Void = {}
    }

    var delegate: Delegate? = nil

    static func make(delegate: Delegate) -> Header02View {
        let view = Header02View.make()
        view.delegate = delegate
        return view
    }

    let iconView = UIImageView.make(backgroundColor: .systemGray)
    lazy var button: UIButton = .make(title: "変更", tapAction: {[weak self] in
        self!.delegate?.tapEditButton()
    })

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

    // タブを並べるstackview
    let tabStackView: UIStackView = {
        let stackView = UIStackView.make(axis: .horizontal)
        stackView.distribution = .fillEqually
        return stackView
    }()
    // タブとして配置するボタンたち
    lazy var tabButtons: [UIButton] = [
        UIButton.make(title: "ツイート", tapAction: {[weak self] in
            self!.delegate?.tapEditButton()
        }),
        UIButton.make(title: "ツイートと返信", tapAction: {[weak self] in
            self!.delegate?.tapReply()
        }),
        UIButton.make(title: "メディア", tapAction: {[weak self] in
            self!.delegate?.tapMedia()
        }),
        UIButton.make(title: "いいね", tapAction: {[weak self] in
            self!.delegate?.tapLike()
        })
    ]

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

        //タブのレイアウト
        mainStackView.addArrangedSubview(tabStackView)
        tabButtons.forEach {
            tabStackView.addArrangedSubview($0)
        }
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
        let view = Header02View.make()
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
