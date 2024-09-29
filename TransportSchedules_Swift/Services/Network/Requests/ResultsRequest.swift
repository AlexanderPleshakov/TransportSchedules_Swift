struct ResultsRequest: NetworkRequest {
    var endpoint: String?
    
    init() {
        self.endpoint = "https://api.rasp.yandex.net/v3.0/search/?format=json&from=s9600213&to=s9623299&lang=ru_RU&date=2024-09-30"
    }
}
