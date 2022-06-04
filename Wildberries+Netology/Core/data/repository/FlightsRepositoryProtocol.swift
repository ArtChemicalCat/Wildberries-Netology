//
//  FlightsRepositoryProtocol.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

protocol FlightsRepositoryProtocol {
    func fetchFlightsList() async throws -> [Flight]
}
