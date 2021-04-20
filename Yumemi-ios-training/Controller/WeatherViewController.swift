//
//  ViewController.swift
//  Yumemi-ios-training
//
//  Created by 坂本龍哉 on 2021/04/16.
//

import UIKit


class WeatherViewController: UIViewController {
    private var weatherModel: WeatherModel? {
        didSet {
            registerModel()
        }
    }
    
    private(set) var weatherView: WeatherView = WeatherView()
    
    override func loadView() {
        view = weatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherModel = WeatherModel()
        weatherModel?.delegate = self
    }

    private func registerModel() {
        weatherView.reloadButton.addTarget(self,
                                           action: #selector(onReloadButtonTapped),
                                           for: .touchUpInside)
    }
    
    @objc private func onReloadButtonTapped() {
        let area:String = """
{
       "area": "tokyo",
       "date": "2020-04-01T12:00:00+09:00"
    }
"""
        weatherModel?.fetchJsonWeather(area: area)
    }
    
}

extension WeatherViewController : WeatherModelDelegate {
    
    func configureImage(weather: String, color: UIColor, max: String, min: String) {
        weatherView.weatherImageView.image = UIImage(named: weather)
        weatherView.weatherImageView.tintColor = color
        weatherView.highestTemperatureLabel.text = max
        weatherView.minimumTemperatureLabel.text = min
    }
    
    func weatherModel(_ weatherModel: WeatherModel, didReturnWeather weather: weatherState) {
        switch weather.weather {
        case "sunny":
            configureImage(weather: weather.weather, color: .red, max: String(weather.max_temp), min: String(weather.min_temp))
        case "cloudy":
            configureImage(weather: weather.weather, color: .gray, max: String(weather.max_temp), min: String(weather.min_temp))
        case "rainy":
            configureImage(weather: weather.weather, color: .blue, max: String(weather.max_temp), min: String(weather.min_temp))

        default:
            print("other")
        }
    }
    
    func weatherModel(_ weatherModel: WeatherModel, didReturnError error: Error) {
        let alert = UIAlertController(title: "\(error)エラー",
                                      message: "天気予報を取得できませんでした",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
                                        NSLog("The \"OK\" alert occured.\nエラー内容→\(error)")
                                        }))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}
