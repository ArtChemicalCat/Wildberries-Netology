//
//  FlightDetailViewController.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import UIKit

final class FlightDetailViewController: UIViewController {
    var viewModel: FlightDetailViewModel!
    
    override func loadView() {
        let rootView = FlightDetailRootView(frame: .zero)
        rootView.viewModel = viewModel
        view = rootView
        navigationController?.navigationBar.tintColor = Color.magenta
    }
}
