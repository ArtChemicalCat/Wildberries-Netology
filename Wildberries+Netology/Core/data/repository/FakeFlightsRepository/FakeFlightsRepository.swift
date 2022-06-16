//
//  FakeFlightsRepository.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

final class FakeFlightsRepository: FlightsRepositoryProtocol {
    func fetchFlightsList() async throws -> [Flight] {
        await withCheckedContinuation { continuation in
            sleep(2)
            let flights: [Flight] = [
                .init(startCity: "Москва",
                      endCity: "Санкт-Петербург",
                      startDate: Date(),
                      endDate: Date().addingTimeInterval(720000),
                      price: 3400,
                      searchToken: "MOW1406SVX2206Y100",
                      isLiked: false),
                .init(startCity: "Москва",
                      endCity: "Самара",
                      startDate: Date(),
                      endDate: Date().addingTimeInterval(960000),
                      price: 3400,
                      searchToken: "MOW1KJNX2206Y100",
                      isLiked: false),
                .init(startCity: "Москва",
                      endCity: "Екатеринбург",
                      startDate: Date(),
                      endDate: Date().addingTimeInterval(457000),
                      price: 3400,
                      searchToken: "MOW1406NJD2206Y100",
                      isLiked: false),
                .init(startCity: "Москва",
                      endCity: "Казань",
                      startDate: Date(),
                      endDate: Date().addingTimeInterval(1220000),
                      price: 3400,
                      searchToken: "MOW1406LJNVJKNVK7Y100",
                      isLiked: false)
            ]
            
            continuation.resume(returning: flights)
        }
        
    }
}
