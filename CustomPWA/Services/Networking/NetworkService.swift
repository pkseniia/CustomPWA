//
//  NetworkService.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit

typealias EmptyBlock = () -> Void
typealias FetchImageCompletion = (_ image: UIImage?) -> Void

protocol NetworkServiceProtocol {
    
    func getImageForApp(by id: String, completion: @escaping FetchImageCompletion)
    var isHostReachable: Bool { get }
}

final class NetworkService: NSObject {
    
    enum RequestManagerError: LocalizedError {
        case invalidURL
        case emptyData
        case parseError
    }
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let session: URLSession
    
    override init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        session = URLSession(configuration: sessionConfig)
    }
    
    func createRequest(apiMethod: CustomPWAAPI) -> URLRequest? {
        return createRequest(apiMethod: apiMethod, body: apiMethod.body)
    }
    
    private func createRequest(apiMethod: CustomPWAAPI, body: Data?) -> URLRequest? {
        guard
            let _ = apiMethod.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = apiMethod.url else {
                fatalError("Bad URL")
        }
        var request = URLRequest(url: url)
        request.httpBody = body
        request.httpMethod = apiMethod.httpMethod

        let headers = apiMethod.headers
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func performDataTask<ResponseType: Decodable>(request: URLRequest, completion: @escaping (ResponseType?, Error?) -> Void) {
        session.dataTask(with: request) { data, _, error in
            do {
                if let error = error {
                    throw error
                }
                guard let data = data else { throw RequestManagerError.emptyData }
                let result = try JSONDecoder().decode(ResponseType.self, from: data)
                completion(result, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
    private func performDataTask(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension NetworkService: NetworkServiceProtocol {

    var isHostReachable: Bool {
        return Reachability.isConnectedToNetwork()
    }

    func getImageForApp(by id: String, completion: @escaping FetchImageCompletion) {
        guard let request = createRequest(apiMethod: .itunesApp(model: ItunesAppInput(id: id))) else {
            completion(nil)
            return
        }
        
        performDataTask(request: request) { [weak self] (result: ItunesAppEntityResults?, error: Error?) in
            if let result = result,
               let imageURLString = result.results.first?.artworkUrl60,
               let url = URL(string: imageURLString) {
                self?.performDataTask(from: url) { data, response, error in
                        guard let data = data, error == nil else { return completion(nil) }
                        DispatchQueue.main.async() {
                            completion(UIImage(data: data))
                        }
                    }
            } else {
                completion(nil)
            }
        }
    }
}
