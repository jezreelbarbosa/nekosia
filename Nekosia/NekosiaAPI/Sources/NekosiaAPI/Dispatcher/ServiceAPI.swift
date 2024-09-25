import Foundation

public typealias ServiceAPICompletion<T: Decodable> = (Result<T, APIError>) -> Void

open class ServiceAPI {
    // Properties

    public let dispacher: Dispatching
    public let jsonDecoder: JSONDecoder

    // Lifecycle

    public init(dispacher: Dispatching, jsonDecoder: JSONDecoder) {
        self.dispacher = dispacher
        self.jsonDecoder = jsonDecoder
    }

    // Functions

    @discardableResult
    open func makeRequest<T>(endpoint: Endpointing, completion: @escaping ServiceAPICompletion<T>) -> URLSessionDataTask? {
        dispacher.call(endpoint: endpoint) { [weak jsonDecoder] result in
            guard let jsonDecoder = jsonDecoder else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let model = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch let error {
                    completion(.failure(.decodingError(data, response, error)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
