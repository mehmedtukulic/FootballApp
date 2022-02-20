//
//  ApiRestClient.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

protocol FootballAPIProtocol {
    func submitRequest<R:Decodable>(footballRequest: FootballRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ())
}

class APIClient: FootballAPIProtocol {
    func submitRequest<R>(footballRequest: FootballRequest, success: @escaping (R) -> Void, failure: @escaping (String) -> ()) where R : Decodable {
        // create url
        guard let url = URL(string: footballRequest.url) else { return }
        
        // create request
        var request = URLRequest(url: url)
        
        // add body parameters
        if let parameters = footballRequest.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                failure("Body not decodable")
            }
        } else {
            request.httpBody = nil
        }
        
        // set headers
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        request.allHTTPHeaderFields = footballRequest.headers as? [String: String]
        
        // set method
        request.httpMethod = footballRequest.method.rawValue
        let session = URLSession(configuration: .default)
      
        let task = session.dataTask(with: request) { data, response, error in
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
