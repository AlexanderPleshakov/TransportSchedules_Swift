struct Station {
    let code: String
    let stationType: String
    let transportType: String
    let title: String
    let countryName: String
    let regionName: String
    let settlementName: String
    
    var fullDescription: String {
        [settlementName, regionName, countryName].filter { name in
            !name.isEmpty
        }.joined(separator: ", ")
    }
}
