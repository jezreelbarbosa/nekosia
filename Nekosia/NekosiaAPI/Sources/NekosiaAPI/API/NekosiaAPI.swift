import Foundation

public protocol NekosiaAPIServicing {
    func fetchImages(category: String, completion: @escaping NekosiaAPI.ImagesCompletion)
    func fetchImages(category: String, query: NekosiaQueryModel?, completion: @escaping NekosiaAPI.ImagesCompletion)
}

public final class NekosiaAPI: ServiceAPI, NekosiaAPIServicing {
    public typealias ImagesCompletion = (Result<NekosiaModel, APIError>) -> Void

    // Lifecycle

    public override init(dispacher: Dispatching = Dispatcher(), jsonDecoder: JSONDecoder = JSONDecoder()) {
        super.init(dispacher: dispacher, jsonDecoder: jsonDecoder)
    }

    // Functions
    public func fetchImages(category: String, completion: @escaping ImagesCompletion) {
        fetchImages(category: category, query: nil, completion: completion)
    }

    public func fetchImages(category: String, query: NekosiaQueryModel?, completion: @escaping ImagesCompletion) {
        let endpoint = NekosiaEndpoint(
            path: "/images/\(category)",
            parameters: query?.parameters
        )
        makeRequest(endpoint: endpoint, completion: completion)
    }
}
