import ArchitectLibrary
import NekosiaAPI
import UIKit

class ImageItemDisplayModel {
    let idName: NSNotification.Name

    let width: CGFloat
    let height: CGFloat
    let ratio: CGFloat

    let color: UIColor?
    private(set) var image: UIImage?

    init(model: NekosiaImageItemModel) {
        self.idName = NSNotification.Name(model.id)

        self.width = CGFloat(model.metadata.compressed.width)
        self.height = CGFloat(model.metadata.compressed.height)
        self.ratio = width / height

        self.color = UIColor(string: model.colors.main)
        UIImageView.downloadImage(from: model.image.compressed.url) { [self] image in
            self.image = image
            NotificationCenter.default.post(name: idName, object: nil)
        }
    }
}
