//
//  ActualFlightCell.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 31.05.2022.
//

import UIKit

final class ActualFlightCell: UITableViewCell {
    //MARK: - Views
    private let cityLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
        
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        
        return view
    }()
        
    private let priceLabel: UILabel = {
        let view = UILabel()
        
        return view
    }()
    
    lazy var likeIcon: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeFlight))
        view.addGestureRecognizer(tap)
        view.image = UIImage(systemName: "heart")
        return view
    }()

    //MARK: - Properties
    static var id: String { String(describing: self) }
    
    var onLikeButtonPressed: (() -> Void)!
    
    var flight: Flight? {
        didSet {
            guard let flight = flight else { return }
            
            cityLabel.text = "\(flight.startCity) - \(flight.endCity)"
            dateLabel.text = "\(flight.startDate.toString()) - \(flight.endDate.toString())"
            likeIcon.image = flight.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            priceLabel.text = "\(flight.price) руб"
        }
    }
    
    
    //MARK: - Initialisers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Metods
    private func configureCell() {
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGray3.cgColor
        selectionStyle = .none
        
        [cityLabel, dateLabel, priceLabel, likeIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            likeIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            likeIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: likeIcon.leadingAnchor, constant: -12)
        ])
    }
    
    //MARK: - Actions
    @objc private func likeFlight() {
        onLikeButtonPressed()
    }
}
