//
//  DataParser.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class DataParser: DataParserProtocol {
    private var decoder = JSONDecoder()
    
    func parse<T: Decodable>(data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
