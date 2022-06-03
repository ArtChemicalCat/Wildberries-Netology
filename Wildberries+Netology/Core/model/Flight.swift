//
//  Flight.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

struct Flight {
    let startCity: String
    let endCity: String
    let startDate: Date
    let endDate: Date
    let price: Int
    let searchToken: String
    var isLiked: Bool
}

extension Flight: Equatable {}
