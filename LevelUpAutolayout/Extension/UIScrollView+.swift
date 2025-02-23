import UIKit

extension UIScrollView {
    static func make(isPagingEnabled: Bool, backgroundColor: UIColor? = nil) -> Self {
        let view = Self.make(backgroundColor: .systemRed)
        view.isPagingEnabled = isPagingEnabled
        return view
    }

    func fillContentLayoutGuide(subView: UIView) {
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor)
        ])
    }
}
