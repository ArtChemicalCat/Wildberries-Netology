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
    var viewModel: ActualFlightsViewModel!
    private var rootView: ActualFlightRootView {
        view as! ActualFlightRootView
    }
    
    private var subscriptions = Array<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Актуальные авиаперелеты"
        observeErrors()
        viewModel.loadFlightsList()
    }
    
    override func loadView() {
        let rootView = ActualFlightRootView(frame: .zero)
        rootView.viewModel = viewModel
        rootView.bind(to: viewModel)
        view = rootView
    }
    
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
