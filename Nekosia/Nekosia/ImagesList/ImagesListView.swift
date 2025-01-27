import ArchitectLibrary
import Stevia
import UIKit

final class ImagesListView: UICodeView {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    lazy var flowLayout = UICollectionViewFlowLayout()

    override func initSubviews() {
        subviews(collectionView)
        collectionView.fillContainer()
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.register(ImageListCVCell.self)

        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
}
