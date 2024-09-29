struct ResultsRequest: NetworkRequest {
    var endpoint: String?
    
    init(date: String, transport: String, fromCode: String, toCode: String) {
        self.endpoint = "https://api.rasp.yandex.net/v3.0/search/?format=json&from=\(fromCode)&to=\(toCode)&lang=ru_RU&date=\(date)"
        
        if transport != "any" {
            self.endpoint?.append("&transport_types=\(transport)")
        }
    }
}
