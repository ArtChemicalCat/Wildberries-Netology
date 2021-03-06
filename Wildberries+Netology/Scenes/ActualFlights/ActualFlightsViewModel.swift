//
//  ActualFlightsViewModel.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

final class ActualFlightsViewModel {
    //MARK: - Properties
    @Published var flights = Array<Flight>()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let flightsRepository: FlightsRepositoryProtocol
    
    //MARK: - Initialiser
    init(flightsRepository: FlightsRepositoryProtocol) {
        self.flightsRepository = flightsRepository
    }
    
    //MARK: - Metods
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
