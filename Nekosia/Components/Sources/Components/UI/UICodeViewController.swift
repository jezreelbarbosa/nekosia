import UIKit

open class UICodeViewController<Presenter, View: UIView>: UIViewController {
    // Properties

    public var presenter: Presenter
    public private(set) lazy var rootView = View()

    // Lifecycle

    public init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) { nil }

    open override func loadView() {
        view = rootView
    }
}
