import ArchitectLibrary
import NekosiaAPI
import UIKit

final class ImageDetailsViewController: UICodeViewController<ImageDetailsView> {

    let nekosiaAPI: NekosiaAPIServicing = NekosiaAPI.shared
    let model: ImageItemDisplayModel

    init(model: ImageItemDisplayModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        title = "Image details"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        rootView.display(model: model)
    }
}
