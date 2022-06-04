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
        view.textColor = .systemGray
        return view
    }()
        
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .callout)
        view.textColor = Color.magenta
        return view
    }()
    
    lazy var likeIcon: UIImageView = {
        let view = UIImageView()
        view.tintColor = Color.purplish
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
            
            cityLabel.text = "\(flight.startCity) → \(flight.endCity)"
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
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    private func configureCell() {
        contentView.layer.cornerRadius = 8
        selectionStyle = .none
        contentView.backgroundColor = .white
        backgroundColor = .clear
        
        [cityLabel, dateLabel, priceLabel, likeIcon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            
            likeIcon.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            likeIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Actions
    @objc private func likeFlight() {
        onLikeButtonPressed()
    }
}
