import ArchitectLibrary
import NekosiaAPI
import Stevia
import UIKit

final class ImageListCVCell: UICodeCollectionViewCell {
    // Properties

    var model: ImageItemDisplayModel?

    // Views

    let nImageView = UIImageView()
    let loadingView = UIActivityIndicatorView()

    private var imageObserver: NSObjectProtocol?

    // Lifecycle

    override func initSubviews() {
        contentView.subviews(nImageView)
    }

    override func initLayout() {
        nImageView.fillContainer(padding: 4)
    }

    override func initStyle() {
        nImageView.style { s in
            s.contentMode = .scaleAspectFill
            s.clipsToBounds = true
        }
    }

    func display(model: ImageItemDisplayModel) {
        self.model = model
        imageObserver = NotificationCenter.default.addObserver(
            forName: model.idName, object: nil, queue: .main
        ) { [weak self] _ in
            self?.nImageView.image = self?.model?.image
        }
        nImageView.image = model.image
        backgroundColor = model.color
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        if let imageObserver = imageObserver {
            NotificationCenter.default.removeObserver(imageObserver)
        }
    }
}
