import ArchitectLibrary
import NekosiaAPI
import UIKit

final class ImagesListViewController: UICodeViewController<ImagesListView> {

    let nekosiaAPI: NekosiaAPIServicing = NekosiaAPI.shared
    var images: [ImageItemDisplayModel] = []
    let itemsPerLine: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.collectionView.dataSource = self
        rootView.collectionView.delegate = self

        title = "Catgirl"
        Task {
            images = try await nekosiaAPI.fetchImages(
                category: "catgirl",
                query: [.count(48)]
            ).images.map({ ImageItemDisplayModel(model: $0) })

            executeInMainThread { [self] in
                rootView.collectionView.reloadData()
            }
        }
    }
}

extension ImagesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ImageListCVCell.self, for: indexPath)
        let model = images[indexPath.item]
        cell.display(model: model)
        return cell
    }
}

extension ImagesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / itemsPerLine
        return CGSize(width: width, height: width)
    }
}

extension ImagesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = images[indexPath.item]
        let controller = ImageDetailsViewController(model: model)
        navigationController?.pushViewController(controller, animated: true)
    }
}
