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
        weatherModel?.returnRandomWeather()
    }

}

extension WeatherViewController : WeatherModelDelegate {
    func weatherModel(_ weatherModel: WeatherModel, didReturnWeather weather: String) {
        if weather == "sunny" {
            weatherView.weatherImageView.image = UIImage(named: weather)
            weatherView.weatherImageView.tintColor = .red
        } else if weather == "cloudy" {
            weatherView.weatherImageView.image = UIImage(named: weather)
            weatherView.weatherImageView.tintColor = .gray
        } else {
            weatherView.weatherImageView.image = UIImage(named: weather)
            weatherView.weatherImageView.tintColor = .blue
        }
    }
}
