import Foundation

public protocol NekosiaAPIServicing {
    func fetchImages(category: String, completion: @escaping NekosiaAPI.ImagesCompletion) -> URLSessionDataTask?
    func fetchImages(category: String, query: NekosiaQueryModel?, completion: @escaping NekosiaAPI.ImagesCompletion) -> URLSessionDataTask?
    func fetchShadowImages(query: NekosiaQueryModel?, completion: @escaping NekosiaAPI.ImagesCompletion) -> URLSessionDataTask?
    func fetchById(_ id: String, completion: @escaping NekosiaAPI.ImageCompletion) -> URLSessionDataTask?
}

public final class NekosiaAPI: ServiceAPI, NekosiaAPIServicing {
    public typealias ImagesCompletion = (Result<NekosiaAPIModel, APIError>) -> Void
    public typealias ImageCompletion = (Result<ImageItemModel, APIError>) -> Void

    // Lifecycle

    public override init(dispacher: Dispatching = Dispatcher(), jsonDecoder: JSONDecoder = JSONDecoder()) {
        super.init(dispacher: dispacher, jsonDecoder: jsonDecoder)
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // Override

    @discardableResult
    public override func makeRequest<T: Decodable>(endpoint: Endpointing, completion: @escaping ServiceAPICompletion<T>) -> URLSessionDataTask? {
        dispacher.call(endpoint: endpoint) { [weak jsonDecoder] result in
            guard let jsonDecoder = jsonDecoder else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let statusModel = try jsonDecoder.decode(NekosiaStatusModel.self, from: data)
                    if statusModel.success {
                        let model = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(model))
                    } else {
                        completion(.failure(.apiMessageError(statusModel)))
                    }
                } catch let error {
                    completion(.failure(.decodingError(data, response, error)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // Functions

    @discardableResult
    public func fetchImages(category: String, completion: @escaping ImagesCompletion) -> URLSessionDataTask? {
        return fetchImages(category: category, query: nil, completion: completion)
    }

    @discardableResult
    public func fetchImages(category: String, query: NekosiaQueryModel?, completion: @escaping ImagesCompletion) -> URLSessionDataTask? {
        let endpoint = NekosiaEndpoint(
            path: "/images/\(category)",
            parameters: query?.parameters
        )
        return makeRequest(endpoint: endpoint, completion: completion)
    }

    @discardableResult
    public func fetchShadowImages(query: NekosiaQueryModel?, completion: @escaping ImagesCompletion) -> URLSessionDataTask? {
        return fetchImages(category: "shadow", query: query, completion: completion)
    }

    @discardableResult
    public func fetchById(_ id: String, completion: @escaping ImageCompletion) -> URLSessionDataTask? {
        let endpoint = NekosiaEndpoint(path: "/getImageById/\(id)")
        return makeRequest(endpoint: endpoint, completion: completion)
    }
}
