//
//  RequestProtocol.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 03.06.2022.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    
    var headers: [String: String] { get }
    
    var queryItems: [String: String?] { get }
    
    var requestType: RequestType { get }
}

extension RequestProtocol {
    var host: String {
        "travel.wildberries.ru"
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var queryItems: [String: String?] {
        [:]
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems.map {
                .init(name: $0, value: $1)
            }
        }
        
        guard let url = components.url else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        return urlRequest
    }
}
