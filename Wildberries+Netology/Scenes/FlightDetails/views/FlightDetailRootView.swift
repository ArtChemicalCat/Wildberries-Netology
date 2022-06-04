//
//  FlightDetailRootView.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import UIKit
import Combine

final class FlightDetailRootView: UIView {
    //MARK: - Views
    private let departureCityLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title1)
        return view
    }()
    
    private let arrivalCityLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title1)
        return view
    }()
    
    private let departureDateLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private let returnDateLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    private let bookFlightButton: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.contentEdgeInsets = UIEdgeInsets(top: 14, left: 25, bottom: 14, right: 25)
        view.backgroundColor = Color.magenta
        return view
    }()
    
    lazy var likeIcon: UIImageView = {
        let view = UIImageView()
        view.tintColor = Color.purplish
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeFlight))
        view.addGestureRecognizer(tap)
        view.image = UIImage(systemName: "heart")
        return view
    }()
    
    private let arrowsStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        
        return view
    }()
    
    //MARK: - Properties
    var viewModel: FlightDetailViewModel!
    private var subscriptions = Array<AnyCancellable>()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStack()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bind(to: viewModel)
    }
    
    //MARK: - Metods
    private func layout() {
        backgroundColor = Color.gray1
        
        [departureCityLabel, arrowsStack, arrivalCityLabel, likeIcon, bookFlightButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            departureCityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            departureCityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            arrowsStack.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 18),
            arrowsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            arrivalCityLabel.topAnchor.constraint(equalTo: arrowsStack.bottomAnchor, constant: 18),
            arrivalCityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            likeIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            likeIcon.topAnchor.constraint(equalTo: arrivalCityLabel.bottomAnchor,constant: 18),
            likeIcon.widthAnchor.constraint(equalToConstant: 40),
            likeIcon.heightAnchor.constraint(equalTo: likeIcon.widthAnchor),
            
            bookFlightButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            bookFlightButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureStack() {
        let downArrow = UIImageView()
        let upArrow = UIImageView()
        downArrow.image = UIImage(systemName: "arrow.down")
        downArrow.tintColor = Color.magenta
        upArrow.image = UIImage(systemName: "arrow.up")
        upArrow.tintColor = Color.magenta
        [departureDateLabel, downArrow, upArrow, returnDateLabel].forEach {
            arrowsStack.addArrangedSubview($0)
        }
    }
    
    private func bind(to viewModel: FlightDetailViewModel) {
        viewModel.$flight
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] flight in
                arrivalCityLabel.text = flight.endCity
                departureCityLabel.text = flight.startCity
                departureDateLabel.text = flight.startDate.toString()
                returnDateLabel.text = flight.endDate.toString()
                likeIcon.image = flight.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                bookFlightButton.setTitle("К БРОНИРОВАНИЮ \(flight.price) ₽", for: .normal)
            }
            .store(in: &subscriptions)
    }
    
    //MARK: - Action
    @objc private func likeFlight() {
        viewModel.flight.isLiked.toggle()
        viewModel.likeButtonAction()
    }
}
