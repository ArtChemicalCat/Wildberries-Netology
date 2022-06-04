//
//  FlightsRequest.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 03.06.2022.
//

import Foundation

enum FlightsRequest: RequestProtocol {
    case getFlights
    
    var path: String {
        "/statistics/v1/cheap"
    }
        
    var requestType: RequestType {
        .GET
    }

}
