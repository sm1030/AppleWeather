# AppleWeather
This is a SwiftUI clone of Apple's Weather app. I try to keep it identical to the original Apple app, but there are few differences, because of two reasons: 
1. I do not have access to the same Weather data as Apple. So, I could not get any weather map related data, so I use single point temperature instead. My weather data source is https://weather.visualcrossing.com/ by Visual Crossing Weather. 
2. I do not have same clouds images, so I had to use mine.
3. Some advanced SwiftUI views are not customisable enough to get same result as in original app, so I had to build it from scratch using basic SwiftUI views 

All SwiftUI previews and UnitTests use local mock data. You can enforce the app to use mock data if it will be unable to get weather data from weather.visualcrossing.com website. Then the app will ask you if you prefer to use local mock data instead. Click that button and enjoy the offline session 😀
