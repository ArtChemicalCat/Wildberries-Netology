//
//  FlightDetailViewModel.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation

final class FlightDetailViewModel {
    @Published var flight: Flight
    
    let likeButtonAction: () -> Void
    
    init(flight: Flight, likeButtonAction: @escaping () -> Void) {
        self.flight = flight
        self.likeButtonAction = likeButtonAction
    }
}
