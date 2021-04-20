//
//  WeatherState.swift
//  Yumemi-ios-training
//
//  Created by 坂本龍哉 on 2021/04/20.
//

import Foundation

struct weatherState : Codable {
    var weather: String
    var max_temp: Int
    var min_temp: Int
    var date: String
}
