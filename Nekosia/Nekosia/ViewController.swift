import UIKit
import NekosiaAPI
import Components

class ViewController: UIViewController {

    let nekosiaAPI: NekosiaAPIServicing = NekosiaAPI.shared

    override func viewDidLoad() {
        nekosiaAPI.fetchImages(category: "catgirl", query: [
            .count(10),
            .rating(.questionable)
        ]) {
            switch $0 {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }

        Task {
            do {
                let model = try await nekosiaAPI.fetchShadowImages(query: [
                    .additionalTags(["jk"]),
                    .blacklistedTags(["catgirl", "autumn"]),
                    .rating(.safe),
                    .session("id"),
                    .count(3),
                    .id("12345"),
                ])
                print(model)
            } catch let error {
                print(error)
            }
        }
    }
}
