//
//  DIContainer.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import Foundation

final class DIContainer {
    func makeActualFlightsViewController() -> ActualFlightsViewController {
        let viewModel = ActualFlightsViewModel(flightsRepository: FakeFlightsRepository())
        let vc = ActualFlightsViewController()
        vc.viewModel = viewModel
        
        return vc
    }
}
