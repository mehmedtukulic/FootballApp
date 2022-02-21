//
//  ApiRestClient.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

protocol APIProtocol {
    func makeRequest<R:Decodable>(_ request: APIRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ())
}

class APIClient: APIProtocol {
    func makeRequest<R>(_ request: APIRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ()) where R : Decodable {
        // create url
        guard let url = URL(string: request.url) else { return }
        
        // create request
        var urlRequest = URLRequest(url: url)
        
        // add body parameters
        if let parameters = request.parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                failure("Body not decodable")
            }
        } else {
            urlRequest.httpBody = nil
        }
        
        // set headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.allHTTPHeaderFields = request.headers as? [String: String]
        
        // set method
        urlRequest.httpMethod = request.method.rawValue
        let session = URLSession(configuration: .default)
      
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure("no data")
                }
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    failure(error.localizedDescription)
                }
            } else {
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(R.self, from: data)
                    DispatchQueue.main.async {
                        success(object)
                    }
                } catch (let error){
                    DispatchQueue.main.async {
                        failure(error.localizedDescription)
                    }
                }
            }
        }

        task.resume()
    }
}
