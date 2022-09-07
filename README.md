# AppleWeather
This is a SwiftUI clone of Apple's Weather app. I try to keep it identical to the original Apple app, but there are few differences, because of two reasons: 
1. I do not have access to the same Weather data as Apple. So, I could not get any weather map related data, so I use single point temperature instead. My weather data source is https://weather.visualcrossing.com/ by Visual Crossing Weather. 
2. Another challenge was to use SwiftUI exclusively without calling any UIKit framework classes. For example City List page Search Bar (placeholder text) could not be colored into proper colours inside standard SwiftUI NavigationView control, so I had to build my own custom page with SwiftUI 

All SwiftUI previews and UnitTests use local mock data. You can enforce the app to use mock data if it will be unable to get weather data from weather.visualcrossing.com website. Then the app will ask you if you prefer to use local mock data instead. Click that button and enjoy the offline session 😀
