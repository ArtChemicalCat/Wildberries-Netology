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
    //MARK: - Properties
    @Published var flights = Array<Flight>()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let flightsRepository: FlightsRepository
    
    //MARK: - Initialiser
    init(flightsRepository: FlightsRepository) {
        self.flightsRepository = flightsRepository
    }
    
    func loadFlightsList() {
        isLoading = true
        Task {
            do {
                flights = try await flightsRepository.fetchFlightsList()
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
