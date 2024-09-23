import Foundation

public struct NekosiaModel: Decodable, Equatable {
    public let success: Bool
    public let status: Int
    public let count: Int
    public let images: [ImageItemModel]
}

public struct ImageItemModel: Decodable, Equatable {
    public let id: String
    public let colors: ColorModel
    public let image: ImageModel
    public let metadata: MetadataModel
    public let category: String
    public let tags: [String]
    public let rating: String
    public let anime: AnimeModel
    public let source: SourceModel
    public let attribution: AttributionModel
}

public struct ColorModel: Decodable, Equatable {
    public let main: String
    public let palette: [String]
}

public struct ImageModel: Decodable, Equatable {
    public let original: ImageURLModel
    public let compressed: ImageURLModel
}

public struct ImageURLModel: Decodable, Equatable {
    public let url: URL
    public let `extension`: String
}

public struct MetadataModel: Decodable, Equatable {
    public let original: MetadataDataModel
    public let compressed: MetadataDataModel
}

public struct MetadataDataModel: Decodable, Equatable {
    public let width: Int
    public let height: Int
    public let size: Int
    public let `extension`: String
}

public struct AnimeModel: Decodable, Equatable {
    public let title: String?
    public let character: String?
}

public struct SourceModel: Decodable, Equatable {
    public let url: URL?
    public let direct: URL?
}

public struct AttributionModel: Decodable, Equatable {
    public let artist: ArtistModel
    public let copyright: String?
}

public struct ArtistModel: Decodable, Equatable {
    public let username: String?
    public let profile: URL?
}
