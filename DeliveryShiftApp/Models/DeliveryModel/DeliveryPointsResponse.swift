import Foundation

struct DeliveryPointsResponse: Decodable {
    let success: Bool
    let reason: String?
    let points: [Point]
}

struct Point: Decodable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
}
