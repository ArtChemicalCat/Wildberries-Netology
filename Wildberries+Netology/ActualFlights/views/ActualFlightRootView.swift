//
//  ActualFlightRootView.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 03.06.2022.
//

import UIKit
import Combine

final class ActualFlightRootView: UIView {
    //MARK: - Views
    private lazy var actualFlightsList: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(ActualFlightCell.self, forCellReuseIdentifier: ActualFlightCell.id)
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()

    //MARK: - ViewModel
    var viewModel: ActualFlightsViewModel!
    
    //MARK: - PrivateProperties
    private var subscriptions = Array<AnyCancellable>()
    
    //MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Metods
    func bind(to viewModel: ActualFlightsViewModel) {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] loading in
                loadingIndicator.startAnimating()
            }
            .store(in: &subscriptions)
        
        viewModel.$flights
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] flights in
                loadingIndicator.stopAnimating()
                actualFlightsList.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        [loadingIndicator, actualFlightsList].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            actualFlightsList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            actualFlightsList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            actualFlightsList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            actualFlightsList.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension ActualFlightRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActualFlightCell.id, for: indexPath) as! ActualFlightCell
        let flight = viewModel.flights[indexPath.row]
        cell.flight = flight
        cell.onLikeButtonPressed = { [unowned self] in
            viewModel.flights[indexPath.row].isLiked.toggle()
            tableView.reloadData()
        }
        return cell
    }
}
