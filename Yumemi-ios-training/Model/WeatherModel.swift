//
//  WeatherModel.swift
//  Yumemi-ios-training
//
//  Created by 坂本龍哉 on 2021/04/16.
//

import Foundation
import YumemiWeather

protocol WeatherModelDelegate : AnyObject {
    func weatherModel(_ weatherModel: WeatherModel, didReturnWeather weather: weatherState)
    
    func weatherModel(_ weatherModel: WeatherModel, didReturnError error: Error)

}

class WeatherModel {
    weak var delegate: WeatherModelDelegate?
    
    func fetchJsonWeather(area: String) {
        do {
            let jsonWeather = try YumemiWeather.fetchWeather(area)
            guard let jsonData = jsonWeather.data(using: .utf8) else { return }
            let resultWeather = try JSONDecoder().decode(weatherState.self, from: jsonData)
            delegate?.weatherModel(self, didReturnWeather: resultWeather)
        } catch YumemiWeatherError.unknownError{
            delegate?.weatherModel(self, didReturnError: YumemiWeatherError.unknownError)
        } catch YumemiWeatherError.invalidParameterError {
            delegate?.weatherModel(self, didReturnError: YumemiWeatherError.invalidParameterError)
        } catch {
            print("others")
        }
    }
}

