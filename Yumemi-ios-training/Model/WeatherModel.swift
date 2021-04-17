//
//  WeatherModel.swift
//  Yumemi-ios-training
//
//  Created by 坂本龍哉 on 2021/04/16.
//

import Foundation
import YumemiWeather

protocol WeatherModelDelegate : AnyObject {
    func weatherModel(_ weatherModel: WeatherModel, didReturnWeather weather: String)
}

class WeatherModel {
    weak var delegate: WeatherModelDelegate?
    
     func returnRandomWeather() {
        let randomWeather = YumemiWeather.fetchWeather()
        delegate?.weatherModel(self, didReturnWeather: randomWeather)
    }
}
