//
//  WeatherForecastViewModel.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 09/04/2024.
//

import Foundation
import RxSwift

final class WeatherForecastViewModel: ViewModel {
    private let networkingClient: NetworkingClientable
    private let bag = DisposeBag()
    private let _forecast = BehaviorSubject<[DailyForecast]?>(value: nil)
    
    let navigation = PublishSubject<NavigationDestination>()
        
    var forecast: Observable<[DailyForecast]?> {
        return _forecast.asObservable()
    }
    
    init(networkingClient: NetworkingClientable) {
        self.networkingClient = networkingClient
    }
    
    func fetchWeatherForcast() {
        do {
            let data = FiveDayForecastRequest()
            let observable: Observable<FiveDayForecastResponse> = try Request.fiveFaysForecast(data).send(networkingClient)
            observable.observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] response in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    formatter.locale = Locale.current
                    formatter.timeZone = TimeZone.current

                    let dailyForecasts = response.list.reduce(into: [DailyForecast]()) { (result, forecast) in
                        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
                        let day = formatter.string(from: date)
                        
                        // If the last DayForecast in the array has the same day, append the forecast to its data
                        if let last = result.last, last.day == day {
                            result[result.count - 1].data.append(forecast)
                        } else {
                            // Otherwise, create a new DayForecast and append it to the array
                            result.append(DailyForecast(day: day, data: [forecast]))
                        }
                    }
                    self?._forecast.onNext(dailyForecasts)
                }, onError: { [weak self] error in
                    print("Fetch forecast error \(error)")
                    self?._forecast.onError(error)
                }).disposed(by: bag)
        } catch let error {
            print("Request creation error \(error)")
            self._forecast.onError(error)
        }
    }
}
