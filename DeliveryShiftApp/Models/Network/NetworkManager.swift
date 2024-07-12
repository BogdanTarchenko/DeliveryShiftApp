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
    case types
    case calc(request: Encodable)
    case order(request: Encodable)
    
    var endpoint: String {
        switch self {
        case .points:     return "delivery/points"
        case .types:      return "delivery/package/types"
        case .calc:       return "delivery/calc"
        case .order:      return "delivery/order"
        }
    }
    
    var method: Method {
        switch self {
        case .points:                       return .get
        case .types:                        return .get
        case .calc(let request):            return .post(request: request)
        case .order(let request):           return .post(request: request)
        }
    }
    
    var needsAuthorized: Bool {
        switch self {
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
        case .calc(let request), .order(let request):
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
        case .points, .types:
            break
        }
    }
}

