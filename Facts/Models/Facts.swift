
import Foundation

// MARK: - Feed
struct FactsResponse: Codable {
    let title: String?
    let rows: [Fact]?
}

// MARK: - Row
struct Fact: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
