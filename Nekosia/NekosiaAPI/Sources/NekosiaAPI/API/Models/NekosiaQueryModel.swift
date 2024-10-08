import Foundation

public struct NekosiaQueryModel: Encodable, Equatable {
    public let count: Int
    public let session: String?
    public let id: String?
    public let additionalTags: [String]?
    public let blacklistedTags: [String]?
    public let rating: Rating?

    var parameters: [String: String] {
        var parameters: [String: String] = [:]
        let additionalTags = additionalTags?.joined(separator: ",")
        let blacklistedTags = blacklistedTags?.joined(separator: ",")
        parameters["session"] = session
        parameters["id"] = id
        parameters["count"] = String(count)
        parameters["additionalTags"] = additionalTags
        parameters["blacklistedTags"] = blacklistedTags
        parameters["rating"] = rating?.rawValue
        return parameters
    }

    public enum Rating: String, Encodable, Equatable {
        case safe
        case questionable
        case nsfw
    }
}
