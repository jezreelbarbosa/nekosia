import Foundation

public enum APIError: Error {
    case urlError
    case requestError(Data?, URLResponse?, Error)
    case unknowError(Data?, URLResponse?, Error?)
    case clientError(Data, HTTPURLResponse)
    case serverError(Data, HTTPURLResponse)
    case decodingError(Data, HTTPURLResponse, Error)
}
