//
//  ActualFlightsViewModel.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

enum ActualFlightsView {
    case loadingFlights
    case showingFlights([Flight])
    case presentingErrorMessage(Error)
}

final class ActualFlightsViewModel {
    //MARK: - Published properties
    @Published var view: ActualFlightsView = .loadingFlights
    
    private let flightsRepository: FlightsRepository
    
    init(flightsRepository: FlightsRepository) {
        self.flightsRepository = flightsRepository
    }
    
    func loadFlightsList() {
        view = .loadingFlights
        Task {
            do {
                let flights = try await flightsRepository.fetchFlightsList()
                view = .showingFlights(flights)
            } catch {
                view = .presentingErrorMessage(error)
            }
            
        }
    }
}
