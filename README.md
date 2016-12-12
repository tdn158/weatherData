# weatherData
Adds new 'findWeatherStation' function to R package weatherData. 

The weatherData package makes it very easy to integrate open source weather data into
predictive models, but it can only lookup weather by closest weather station. Many
times people don't have this data readily available. This function allows the user
to find the closest weather station to a given zipcode, which provides more functionality
to this package.

User inputs a dataframe with a column of zipcodes and the function returns 
the original dataframe with two new columns -- WeatherStation and 
isAirport. 


