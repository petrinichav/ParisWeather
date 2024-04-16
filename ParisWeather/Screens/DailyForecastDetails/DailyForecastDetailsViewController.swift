//
//  DailyForecastDetailsViewController.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 12/04/2024.
//

import UIKit
import RxSwift

final class DailyForecastDetailsViewController: UIViewController {
    private let viewModel: DailyForecastDetailsViewModel
    private let bag = DisposeBag()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .veepeePurple
        tableView.register(DailyForecastDetailsCell.self, forCellReuseIdentifier: DailyForecastDetailsCell.reusableIdentifier)
        tableView.accessibilityIdentifier = "DailyForecast"
        return tableView
    }()
    
    init(model: DailyForecastDetailsViewModel) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        setupTableView()
    }
}

// MARK: - Private - Setup Layout
private extension DailyForecastDetailsViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        Observable.just(viewModel.dailyForecast.data)
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: DailyForecastDetailsCell.reusableIdentifier,
                    cellType: DailyForecastDetailsCell.self
            )
            ) { _, element, cell in
                let cellViewModel = DailyForecastDetailsCellModel(data: element)
                cell.viewModel = cellViewModel
            }
            .disposed(by: bag)
    }
}
