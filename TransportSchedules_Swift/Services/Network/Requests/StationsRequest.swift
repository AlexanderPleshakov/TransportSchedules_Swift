//
//  StationsRequest.swift
//  TransportSchedules_Swift
//
//  Created by Александр Плешаков on 28.09.2024.
//

import Foundation

struct StationsRequest: NetworkRequest {
    var endpoint: String?
    
    init() {
        self.endpoint = "https://api.rasp.yandex.net/v3.0/stations_list/?lang=ru_RU&format=json"
    }
}
