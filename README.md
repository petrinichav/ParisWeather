# ParisWeather

I choosed MVVM+C arch for the app because MVVM is best choice to use full power of RxSwift.
The app does not use SwiftUI because Combine is more suitable for SwiftUI app.

We have to use main coordinator for navigation in MVVM+C but i did not implement it for app from 2 screens.

Screens:
1. WeatherForecastViewController - 5 day forecast (shows main info for each day weather forecast. Total is 5 day = 5 items in the table. Forecast was combine by the day.)

2. DailyForecastDetailsViewController - forecast details, has data about weather with timeinterval 3 hours.


I used RxSwift to setup bidning ViewModel->View, Networking->ViewModel.

