//
//  NetworkManager.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 10.07.2024.
//

import Foundation

enum CustomError: Error {
    case error
    case noData
    case urlNotValidate
    case decodingError
    case encodingEror
}

enum Api {
    enum Method {
        case get
        case post(request: Encodable)
        case put(request: Encodable)

        var rawValue: String {
            switch self {
            case .get:        return "GET"
            case .post:       return "POST"
            case .put:        return "PUT"
            }
        }
    }

    case points
    case otp(request: Encodable)
    case auth(request: Encodable)
    case catalog
    case cancel(request: Encodable)

    var endpoint: String {
        switch self {
        case .otp:        return "auth/otp"
        case .auth:       return "users/signin"
        case .catalog:    return "pizza/catalog"
        case .cancel:     return "pizza/orders/cancel"
        case .points:     return "delivery/points"
        }
    }

    var method: Method {
        switch self {
        case .otp(let request):                return .post(request: request)
        case .auth(let request):            return .post(request: request)
        case .catalog:                        return .get
        case .cancel(let request):            return .put(request: request)
        case .points:                       return .get
        }
    }

    var needsAuthorized: Bool {
        switch self {
        case .cancel:    return true
        default:        return false
        }
    }
}

final class NetworkManager {
    private let baseUrlString = "https://shift-backend.onrender.com/"


    func fetch<T: Decodable>(api: Api, resultType: T.Type, completion: @escaping (Result<T,CustomError>) -> Void) {
        let urlString = baseUrlString + api.endpoint

        guard let url = URL(string: urlString) else {
            completion(.failure(.urlNotValidate))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        modifyRequest(urlRequest: &urlRequest, api: api)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.error))
                return
            }

            guard let data else {
                completion(.failure(.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }

    private func modifyRequest(urlRequest: inout URLRequest, api: Api) {
        switch api {
        case .otp(let request), .auth(let request), .cancel(let request):
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let jsonData = try JSONEncoder().encode(request)
                urlRequest.httpBody = jsonData
            } catch {
                return
            }

            if api.needsAuthorized {
                let token = UserDefaults.standard.string(forKey: "token")
                guard let token else { return }
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        case .catalog, .points:
            break
        }
    }
}

