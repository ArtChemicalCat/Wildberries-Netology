//
//  FlightDetailViewController.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import UIKit

final class FlightDetailViewController: UIViewController {
    private let viewModel: FlightDetailViewModel
    
    init(viewModel: FlightDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let rootView = FlightDetailRootView(frame: .zero)
        rootView.viewModel = viewModel
        view = rootView
        navigationController?.navigationBar.tintColor = Color.magenta
    }
}
