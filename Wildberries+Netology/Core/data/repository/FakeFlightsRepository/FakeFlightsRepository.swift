//
//  FakeFlightsRepository.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

final class FakeFlightsRepository: FlightsRepositoryProtocol {
    func fetchFlightsList() async throws -> [Flight] {
        sleep(2)
        let flights: [Flight] = [
            .init(startCity: "Москва",
                  endCity: "Санкт-Петербург",
                  startDate: Date(),
                  endDate: Date().addingTimeInterval(720000),
                  price: 3400,
                  searchToken: "MOW1406SVX2206Y100",
                  isLiked: false)
        ]
        
        return flights
    }
}
