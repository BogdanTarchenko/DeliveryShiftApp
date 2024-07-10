//
//  DeliveryPointsResponse.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 10.07.2024.
//

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
