# ParisWeather

I choosed MVVM+C arch for the app because MVVM is best choice to use full power of RxSwift.
The app does not use SwiftUI because Combine is more suitable for SwiftUI app.

We have to use main coordinator for navigation in MVVM+C but i did not implement it for app from 2 screens.

Screens:
1. WeatherForecastViewController - 5 day forecast (shows main info for each day weather forecast. Total is 5 day = 5 items in the table. Forecast was combine by the day.)
![Simulator Screenshot - iPhone 15 Pro - 2024-04-13 at 00 23 28](https://github.com/petrinichav/ParisWeather/assets/1233085/1e0e6e85-f5ab-43fd-a822-1e8ca3389866)

2. DailyForecastDetailsViewController - forecast details, has data about weather with timeinterval 3 hours.
![Simulator Screenshot - iPhone 15 Pro - 2024-04-11 at 23 29 39](https://github.com/petrinichav/ParisWeather/assets/1233085/a3ef98c9-eed4-44a9-a685-e6f326cbdbec)


I used RxSwift to setup bidning ViewModel->View, Networking->ViewModel.

