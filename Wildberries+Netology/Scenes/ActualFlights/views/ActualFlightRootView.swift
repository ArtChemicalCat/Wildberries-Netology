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
        view.delegate = self
        view.register(ActualFlightCell.self, forCellReuseIdentifier: ActualFlightCell.id)
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    private let internetConnectionLostImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wifi.slash")
        view.contentMode = .scaleAspectFill
        view.tintColor = Color.gray4
        view.isHidden = true
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
                if loading {
                    loadingIndicator.startAnimating()
                } else {
                    loadingIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
        
        viewModel.$flights
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] flights in
                actualFlightsList.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    func toggleInternetConnectionImageAppearance() {
        internetConnectionLostImage.isHidden.toggle()
    }
    
    private func layout() {
        backgroundColor = Color.gray1
        [internetConnectionLostImage, actualFlightsList, loadingIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            internetConnectionLostImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            internetConnectionLostImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            internetConnectionLostImage.widthAnchor.constraint(equalToConstant: 150),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            actualFlightsList.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            actualFlightsList.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            actualFlightsList.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            actualFlightsList.bottomAnchor.constraint(equalTo: bottomAnchor),
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

extension ActualFlightRootView: UITableViewDelegate {
    
}
