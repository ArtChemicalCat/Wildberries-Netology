//
//  ActualFlightsViewController.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import UIKit
import Combine

final class ActualFlightsViewController: UIViewController {
    //MARK: - Properties
    private let viewModel: ActualFlightsViewModel
    var makeFlightDetailVC: ((FlightDetailViewModel) -> FlightDetailViewController)!
    
    private var subscriptions = Array<AnyCancellable>()

    private var rootView: ActualFlightRootView { view as! ActualFlightRootView }
    
    //MARK: - LifeCicle
    init(viewModel: ActualFlightsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Актуальные авиаперелеты"
        observeErrors()
        viewModel.loadFlightsList()
    }
    
    override func loadView() {
        let rootView = ActualFlightRootView(frame: .zero)
        rootView.viewModel = viewModel
        rootView.viewInteractionResponder = self
        rootView.bind(to: viewModel)
        view = rootView
    }
    
    //MARK: - Metods
    private func observeErrors() {
        viewModel.$errorMessage
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] errorMessage in
                guard let errorMessage = errorMessage else { return }
                presentError(errorMessage: errorMessage)
                viewModel.isLoading = false
                rootView.toggleInternetConnectionImageAppearance()
            }
            .store(in: &subscriptions)
    }
    
    private func presentError(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}

//MARK: - ActualFlightViewInteractionResponder
extension ActualFlightsViewController: ActualFlightViewInteractionResponder {
    func didSelectFlight(_ flight: Flight) {
        let flightDetailViewModel = FlightDetailViewModel(flight: flight) { [weak self] in
            guard let self = self else { return }
            guard let index = self.viewModel.flights.firstIndex(of: flight) else { return }
            self.viewModel.flights[index].isLiked.toggle()
        }
        let flightDetailVC = makeFlightDetailVC(flightDetailViewModel)
        
        navigationController?.pushViewController(flightDetailVC, animated: true)
    }
}
