import Foundation

struct DeliveryOrderResponse: Decodable {
    let success: Bool
    let reason: String
    let status: Int
    let cancellable: Bool
}
