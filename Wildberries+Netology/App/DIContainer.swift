//
//  DIContainer.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

final class DIContainer {
    private let flightRemoteRepository = FlightsRemoteRepository()
    
    func makeActualFlightsViewController() -> ActualFlightsViewController {
        let viewModel = ActualFlightsViewModel(flightsRepository: flightRemoteRepository)
        let vc = ActualFlightsViewController()
        vc.makeFlightDetailVC = makeFlightDetailViewController(_:)
        vc.viewModel = viewModel
        
        return vc
    }
    
    func makeFlightDetailViewController(_ viewModel: FlightDetailViewModel) -> FlightDetailViewController {
        let vc = FlightDetailViewController()
        vc.viewModel = viewModel
        
        return vc
    }
}
