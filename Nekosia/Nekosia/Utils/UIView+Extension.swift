import Stevia
import UIKit

extension UIView {
    @discardableResult
    public func fillHorizontalMarginGuide(from view: UIView) -> Self {
        self.Leading == view.layoutMarginsGuide.Leading
        self.Trailing == view.layoutMarginsGuide.Trailing
        return self
    }
}
