//
//  FlightsRemoteRepository.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation

final class FlightsRemoteRepository: FlightsRepositoryProtocol {
    private let apiManager: APIManagerProtocol
    private let parser: DataParserProtocol
    
    init(apiManager: APIManagerProtocol = WildberriesAPIManager(),
         parser: DataParserProtocol = DataParser()) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func fetchFlightsList() async throws -> [Flight] {
        let data = try await apiManager.perform(FlightsRequest.getFlights)
        let result: FlightsContainerDTO = try parser.parse(data: data)
        let flights = result.data.map { $0.toDomain() }
        
        return flights
    }
}
