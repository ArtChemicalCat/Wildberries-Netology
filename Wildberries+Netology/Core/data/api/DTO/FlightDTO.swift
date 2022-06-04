//
//  FlightsDTO.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation

struct FlightsDTO: Decodable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
    
    func toDomain() -> Flight {
        return Flight(startCity: startCity,
                      endCity: endCity,
                      startDate: startDate.toDate(),
                      endDate: endDate.toDate(),
                      price: price,
                      searchToken: searchToken,
                      isLiked: false)
    }
}

struct FlightsContainerDTO: Decodable {
    let data: [FlightsDTO]
}
