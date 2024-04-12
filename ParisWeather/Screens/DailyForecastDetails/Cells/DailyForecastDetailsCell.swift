//
//  DailyForecastDetailsCell.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit

final class DailyForecastDetailsCell: UITableViewCell {
    private let detailsView: ForecastDetailsView = {
        let viewModel = ForecastDetailsViewModel()
        return ForecastDetailsView(viewModel: viewModel)
    }()
    
    var viewModel: DailyForecastDetailsCellModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            detailsView.viewModel.update(forecastData: viewModel.data)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DailyForecastDetailsCell {
    func setupLayout() {
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            detailsView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            detailsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
