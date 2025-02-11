import UIKit

extension UIScrollView {
      func fillContentLayoutGuide(subView: UIView) {
        NSLayoutConstraint.activate([
          subView.topAnchor.constraint(equalTo: self.contentLayoutGuide.topAnchor),
          subView.bottomAnchor.constraint(equalTo: self.contentLayoutGuide.bottomAnchor),
          subView.leadingAnchor.constraint(equalTo: self.contentLayoutGuide.leadingAnchor),
          subView.trailingAnchor.constraint(equalTo: self.contentLayoutGuide.trailingAnchor)
        ])
    }
}