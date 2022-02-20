//
//  ApiParameters.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import Foundation

protocol FootballRequest {
    var url: String { get }
    var headers: JSON{ get }
    var parameters: JSON? { get }
    var method: HTTPMethod { get }
}

public typealias JSON = [String: Any]

enum HTTPMethod: String{
    case GET
    case POST
    case PUT
    case DELETE
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json; charset=UTF-8"
}


