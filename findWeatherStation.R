findWeatherStation <- function(dataFrame, zipcodeColumn) {
  require(rvest)
  require(magrittr)
  require(plyr)

  #   Function that takes a dataframe and column in the dataframe that contains zipcodes (input of form dataFrame$column)
  #   and returns two new columns:
  #   1. WeatherStation = column of closest weather station name to zipcode
  #   2. IsAirport = column with value 'id' if weather station is not airport and 'airportCode' if weather station is airport
  #                   This is necessary for input into the weatherData package.

  #----- Create empty columns
  dataFrame$WeatherStation <- rep("", nrow(dataFrame))
  dataFrame$IsAirport <- rep("", nrow(dataFrame))
  
  for (i in 1:nrow(dataFrame)) {
    #----- Scrapes wunderground for closest weather station to zip
    weather_station <- read_html(paste('https://www.wunderground.com/cgi-bin/findweather/getForecast?query=', zipcodeColumn[i], sep = ""))
    
    weather_station %>%
      html_nodes(xpath = '//*[@id="station-label"]/a') %>%
      html_attrs() -> weather_station_attr
    weather_station_char <- unlist(weather_station_attr)
    
    #----- cleans output from scrape, depending on if its a personal weather station or airport
    if (grepl('personal-weather-station', weather_station_char) == TRUE) {
      dataFrame$WeatherStation[i] <- sub('^.*=([A-Z0-9]+)#.*', '\\1', weather_station_char)
      dataFrame$IsAirport[i] <- 'id'
    }
    else if (grepl('airport', weather_station_char) == TRUE) {
      dataFrame$WeatherStation[i] <- sub('^.*/airport/([A-Z0-9]+).*', '\\1', weather_station_char)
      dataFrame$IsAirport[i] <- 'airportCode'
    }
    else {
    }
  }
  return(dataFrame)
}




  
  
