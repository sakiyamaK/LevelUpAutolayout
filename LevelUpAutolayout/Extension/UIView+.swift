import UIKit

extension UIView {
    func fill(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func fillSafeArea(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])        
    }

    // Selfとすることで継承したクラスで呼ぶとそのクラスとして呼ばれる
    static func make(backgroundColor: UIColor? = nil) -> Self {
        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        return view
    }
}
