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
        let vc = ActualFlightsViewController(viewModel: viewModel)
        vc.makeFlightDetailVC = makeFlightDetailViewController(_:)
        
        return vc
    }
    
    func makeFlightDetailViewController(_ viewModel: FlightDetailViewModel) -> FlightDetailViewController {
        FlightDetailViewController(viewModel: viewModel)
    }
}
