//
//  ViewController.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import UIKit
import RxSwift

final class WeatherForecastViewController: UIViewController {
    private let viewModel: WeatherForecastViewModel
    private let bag = DisposeBag()
    
    // MARK: - Subviews
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .veepeePurple
        tableView.register(WeatherForecastCell.self, forCellReuseIdentifier: WeatherForecastCell.reusableIdentifier)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        refreshControl.accessibilityIdentifier = "RefreshControl"
        return refreshControl
    }()
    
    private let overlayView: OverlayView = {
        OverlayView(frame: .zero)
    }()
    
    @objc private func onRefresh() {
        viewModel.fetchWeatherForcast()
        refreshControl.endRefreshing()
    }
    
    init(model: WeatherForecastViewModel) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "5 day forecast in Paris"
        view.backgroundColor = .white
        
        setupTableView()
        setupOverlay()
        
        overlayView.show()
        viewModel.fetchWeatherForcast()
    }
}

// MARK: - Setup Layout
private extension WeatherForecastViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = refreshControl
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        viewModel.forecast
            .compactMap { $0 }
            .do(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.overlayView.hide()
                }
            }, onError: { [weak self] error in
                DispatchQueue.main.async {
                    self?.overlayView.hide()
                    self?.showFetchForecastError()
                }
            })
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: WeatherForecastCell.reusableIdentifier,
                    cellType: WeatherForecastCell.self
                )
            ) { _, element, cell in
                let cellViewModel = WeatherForecastCellModel(dailyForecast: element)
                cell.viewModel = cellViewModel
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(DailyForecast.self)
            .compactMap({ dailyForecast in
                return .dailyForecastDetail(dailyForecast)
            })
            .bind(to: viewModel.navigation)
            .disposed(by: bag)
    }
    
    func setupOverlay() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.alpha = 0
        
        view.addSubview(overlayView)
        NSLayoutConstraint.activate([
            overlayView.leftAnchor.constraint(equalTo: view.leftAnchor),
            overlayView.rightAnchor.constraint(equalTo: view.rightAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

private extension WeatherForecastViewController {
    func showFetchForecastError() {
        let alert = UIAlertController(
            title: "Error",
            message: "Sorry, we were not able to fetch data. Please, try again later",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
