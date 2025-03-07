import ArchitectLibrary
import NekosiaAPI
import UIKit

class ImageItemDisplayModel {
    let idName: NSNotification.Name

    let width: CGFloat
    let height: CGFloat
    let ratio: CGFloat

    let category: String
    let rating: String
    let source: String?
    let imageURL: String

    let copyright: String?
    let username: String?
    let profileURL: String?

    let tags: [String]
    let mainColor: UIColor?
    let colors: [UIColor]

    private(set) var image: UIImage?

    init(model: NekosiaImageItemModel) {
        self.idName = NSNotification.Name(model.id)

        self.width = CGFloat(model.metadata.compressed.width)
        self.height = CGFloat(model.metadata.compressed.height)
        self.ratio = width / height

        self.category = model.category
        switch model.rating {
        case let .string(rating):
            self.rating = rating
        case let .model(model):
            self.rating = model.rating
        }
        self.source = model.source.url?.absoluteString
        self.imageURL = model.image.original.url.absoluteString

        self.copyright = model.attribution.copyright
        self.username = model.attribution.artist.username
        self.profileURL = model.attribution.artist.profile?.absoluteString

        self.tags = model.tags
        self.mainColor = UIColor(string: model.colors.main)
        self.colors = model.colors.palette.compactMap(\.uiColor)

        UIImageView.downloadImage(from: model.image.compressed.url) { [self] image in
            self.image = image
            NotificationCenter.default.post(name: idName, object: nil)
        }
    }
}
